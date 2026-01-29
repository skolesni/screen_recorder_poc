import Flutter
import UIKit
import ReplayKit
import AVKit

@main
@objc class AppDelegate: FlutterAppDelegate {

    private var methodChannel: FlutterMethodChannel?
    private let appGroupIdentifier: String = "group.com.kixapp.poc"

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        let controller = window?.rootViewController as! FlutterViewController

        // Setup Method Channel with minimal boilerplate
        methodChannel = FlutterMethodChannel(
            name: "com.kixapp.poc/recording",
            binaryMessenger: controller.binaryMessenger
        )
        methodChannel?.setMethodCallHandler(handleMethodCall)

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    // Standard method call handler that binds to statically wired platform methods
    // It would be more appropriate to implement the logic in a separate class, however,
    // the time frame for the POC is limited.
    private func handleMethodCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "startRecording":
            presentBroadcastPicker()
            result(nil)

        case "showRecording":
            // Auto-tap the picker to bring up the broadcast stop dialog.
            presentBroadcastPicker(autoTap: true)
            result(nil)

        case "getAppGroupPath":
            let path = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroupIdentifier)?.path
            result(path)

        case "playRecording":
            playRecording()
            result(nil)

        default:
            result(FlutterMethodNotImplemented)
        }
    }

    // This code was adapted from Apple's ReplayKit sample code.
    // The vendor documentation is here: https://developer.apple.com/documentation/ReplayKit
    // Folks discuss this feature here: https://stackoverflow.com/questions/54480680/use-replaykit-to-record-any-app-on-screen
    
    // Launches the ReplayKit system broadcast picker UI programmatically.
    // The user is expected to stop the broadcast manually via the system UI, however,
    // the implemented Stop button relaunches the picker if the user is lost and came back to the app
    // to stop the recording.
    private func presentBroadcastPicker(autoTap: Bool = false) {
        guard let rootView = window?.rootViewController?.view else { return }

        // Remove any previously added picker
        rootView.viewWithTag(9999)?.removeFromSuperview()

        let picker = RPSystemBroadcastPickerView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        picker.tag = 9999
        picker.preferredExtension = "com.fundsmith.mauitest.BroadcastExtension"
        picker.showsMicrophoneButton = true

        if autoTap {
            // For stopping a broadcast, programmatic trigger works since the extension is already selected.
            // Hide the picker and simulate a tap on its internal button.
            picker.frame = CGRect(x: -100, y: -100, width: 1, height: 1)
            rootView.addSubview(picker)
            for subview in picker.subviews {
                if let button = subview as? UIButton {
                    button.sendActions(for: .touchUpInside)
                    break
                }
            }
        } else {
            // For starting, the user must manually tap to select the BroadcastExtension.
            // Programmatic trigger bypasses preferredExtension and falls back to system recording.
            picker.center = rootView.center
            rootView.addSubview(picker)
        }
    }

    private func playRecording() {
        guard let containerURL = FileManager.default.containerURL(
            forSecurityApplicationGroupIdentifier: appGroupIdentifier
        ) else { return }

        let fileURL = containerURL.appendingPathComponent("Recording001.mp4")
        guard FileManager.default.fileExists(atPath: fileURL.path) else { return }

        let player = AVPlayer(url: fileURL)
        let playerVC = AVPlayerViewController()
        playerVC.player = player

        window?.rootViewController?.present(playerVC, animated: true) {
            player.play()
        }
    }
}
