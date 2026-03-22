import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'package:lumani/core/sources/video_source.dart';

// TODO: Implement image filtering in a separate isolate.
// import 'package:lumani/utils/image_filter.dart';

class CameraSource extends VideoSource {
  CameraController? _controller;
  Future<void>? _initFuture;
  bool _isStreaming = false;
  bool _noCameraAvailable = false;

  @override
  Future<void> initialize() {
    _initFuture ??= _initializeInternal();
    return _initFuture!;
  }

  Future<void> _initializeInternal() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        _noCameraAvailable = true;
        notifyListeners();
        return;
      }

      final firstCamera = cameras.first;

      _controller = CameraController(
        firstCamera,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await _controller!.initialize();
      notifyListeners();
    } catch (e) {
      debugPrint('Error initializing camera: $e');
      _noCameraAvailable = true;
      notifyListeners();
    }
  }

  @override
  Future<void> start() async {
    if (_noCameraAvailable || _controller == null) return;
    
    if (!_controller!.value.isInitialized) {
      // Should not happen if initialize() was awaited, but safety check
      return;
    }

    if (!_controller!.value.isStreamingImages) {
      await _controller!.startImageStream((image) {
        // No-op for now. In the future, this is where we would process the image.
      });
      _isStreaming = true;
      notifyListeners();
    }
  }

  @override
  Future<void> stop() async {
    if (_noCameraAvailable || _controller == null) return;

    if (_controller!.value.isStreamingImages) {
      await _controller!.stopImageStream();
      _isStreaming = false;
      notifyListeners();
    }
  }

  @override
  Widget buildPreview() {
    if (_noCameraAvailable) {
      return const Center(
        child: Text(
          "Camera not available (Simulator)",
          style: TextStyle(color: Colors.white),
        ),
      );
    }
    if (_controller == null || !_controller!.value.isInitialized) {
       return const Center(child: CircularProgressIndicator());
    }
    return CameraPreview(_controller!);
  }

  @override
  dynamic get value {
    if (_noCameraAvailable) {
      return const CameraValue(
        isInitialized: true,
        errorDescription: null,
        previewSize: Size(100, 100),
        isRecordingVideo: false,
        isTakingPicture: false,
        isStreamingImages: false,
        isRecordingPaused: false,
        flashMode: FlashMode.off,
        exposureMode: ExposureMode.auto,
        focusMode: FocusMode.auto,
        exposurePointSupported: false,
        focusPointSupported: false,
        deviceOrientation: DeviceOrientation.portraitUp,
        lockedCaptureOrientation: DeviceOrientation.portraitUp,
        recordingOrientation: DeviceOrientation.portraitUp,
        isPreviewPaused: false,
        previewPauseOrientation: DeviceOrientation.portraitUp,
        description: CameraDescription(
          name: "Simulator Camera",
          lensDirection: CameraLensDirection.back,
          sensorOrientation: 0,
        ),
      );
    }
    // Return a default uninitialized value if controller is null
    return _controller?.value ?? const CameraValue.uninitialized(CameraDescription(
          name: "Pending",
          lensDirection: CameraLensDirection.back,
          sensorOrientation: 0,
        ));
  }
  
  @override
  bool get isStreaming => _isStreaming;


  @override
  void dispose() {
    if (!_noCameraAvailable) {
      _controller?.dispose();
    }
    super.dispose();
  }
}
