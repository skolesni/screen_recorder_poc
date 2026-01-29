//
//  SampleHandler.swift
//  BroadcastExtension
//
//  Created by Stanislav Kolesnik on 28/01/2026.
//

import ReplayKit
import AVFoundation

class SampleHandler: RPBroadcastSampleHandler {

    private let appGroupIdentifier = "group.com.kixapp.poc"
    private let fileName = "Recording001.mp4"

    private var assetWriter: AVAssetWriter?
    private var videoInput: AVAssetWriterInput?
    private var sessionStarted = false
    private var containerURL: URL?

    // MARK: - Broadcast Lifecycle

    override func broadcastStarted(withSetupInfo setupInfo: [String: NSObject]?) {
        guard let url = FileManager.default.containerURL(
            forSecurityApplicationGroupIdentifier: appGroupIdentifier
        ) else {
            finishBroadcastWithError(makeError("App Group container not available."))
            return
        }

        // Ensure the App Group container directory exists
        try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)

        containerURL = url
    }

    override func broadcastPaused() {
        // Samples will stop being delivered.
    }

    override func broadcastResumed() {
        // Samples delivery will resume.
    }

    override func broadcastFinished() {
        guard let writer = assetWriter, writer.status == .writing else { return }

        videoInput?.markAsFinished()

        let semaphore = DispatchSemaphore(value: 0)
        writer.finishWriting {
            semaphore.signal()
        }
        semaphore.wait()

        // Copy from temp to App Group container
        if let containerURL = containerURL {
            let dest = containerURL.appendingPathComponent(fileName)
            try? FileManager.default.removeItem(at: dest)
            try? FileManager.default.copyItem(at: writer.outputURL, to: dest)
        }

        assetWriter = nil
        videoInput = nil
        sessionStarted = false
    }

    override func processSampleBuffer(_ sampleBuffer: CMSampleBuffer, with sampleBufferType: RPSampleBufferType) {
        guard sampleBufferType == .video else { return }

        // Lazily set up AVAssetWriter on the first video sample so we can read the actual dimensions.
        if assetWriter == nil {
            setupWriter(from: sampleBuffer)
        }

        guard let writer = assetWriter, writer.status == .writing else { return }
        guard let input = videoInput, input.isReadyForMoreMediaData else { return }

        if !sessionStarted {
            let timestamp = CMSampleBufferGetPresentationTimeStamp(sampleBuffer)
            writer.startSession(atSourceTime: timestamp)
            sessionStarted = true
        }

        input.append(sampleBuffer)
    }

    // MARK: - Private

    private func setupWriter(from sampleBuffer: CMSampleBuffer) {
        guard let containerURL = containerURL else { return }

        // AVAssetWriter cannot write directly to App Group containers on iOS 26+.
        // Write to the extension's temp directory, then copy on finish.
        let tempDir = FileManager.default.temporaryDirectory
        let outputURL = tempDir.appendingPathComponent(fileName)

        try? FileManager.default.removeItem(at: outputURL)
        try? FileManager.default.removeItem(at: containerURL.appendingPathComponent(fileName))

        guard let formatDesc = CMSampleBufferGetFormatDescription(sampleBuffer) else { return }
        let dimensions = CMVideoFormatDescriptionGetDimensions(formatDesc)

        do {
            let writer = try AVAssetWriter(outputURL: outputURL, fileType: .mp4)

            let videoSettings: [String: Any] = [
                AVVideoCodecKey: AVVideoCodecType.h264,
                AVVideoWidthKey: Int(dimensions.width),
                AVVideoHeightKey: Int(dimensions.height),
            ]

            let input = AVAssetWriterInput(mediaType: .video, outputSettings: videoSettings)
            input.expectsMediaDataInRealTime = true

            guard writer.canAdd(input) else { return }

            writer.add(input)
            writer.startWriting()

            assetWriter = writer
            videoInput = input
            sessionStarted = false
        } catch {
            // Silent failure acceptable for POC
        }
    }

    private func makeError(_ message: String) -> NSError {
        NSError(domain: "com.kixapp.poc.BroadcastExtension", code: 0, userInfo: [NSLocalizedDescriptionKey: message])
    }
}
