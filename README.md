# Screen Recorder Proof-of-Concept

This demo app demonstrates some screen recording capabilities on iOS for next generation of "KIX sharing" project. It allows users to record their screen activities and save them as video files locally in the app.

## High Level requirements

The new app will be branded as "KIX". The app is built to demonstrate the following requirements:

Create an sample app that will do the following tasks:

- App should have a button to record a screen share
- App should record the video for current share
- App should rename / overwrite default Broadcast message to KixApp sharing
- App should ask for option to mute /un-mute audio

Clarifications received during the call:

- iOS only
- System-wide screen recording
- Local storage of recorded video
- No need to upload anywhere
- Local playback is desirable
- Available packages do not satisfy the requirement to mute/un-mute audio, so custom implementation is needed
- No UI styling to implement
- Minimal architecture patterns
- Quality of code

## Architecture

The app is built according to MVVM architecture pattern recommended by google [https://docs.flutter.dev/app-architecture](https://docs.flutter.dev/app-architecture)
