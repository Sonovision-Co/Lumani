import 'package:flutter/material.dart';
import 'package:lumani/core/sources/video_source.dart';

// TODO: Implement this class using the manufacturer's SDK.
class ProbeSource extends VideoSource {
  @override
  Future<void> initialize() async {
    // TODO: Initialize the probe using the manufacturer's SDK.
    await Future.delayed(const Duration(seconds: 1)); // Simulate initialization.
    // print('Probe initialized');
  }

  @override
  Future<void> start() async {
    // TODO: Start the video stream from the probe.
    // print('Probe stream started');
  }

  @override
  Future<void> stop() async {
    // TODO: Stop the video stream from the probe.
    // print('Probe stream stopped');
  }

  @override
  void dispose() {
    // TODO: Dispose of any resources used by the probe.
    super.dispose();
  }

  @override
  bool get isStreaming => false; // TODO: Implement this.

  @override
  dynamic get value => null; // TODO: Implement this.

  @override
  Widget buildPreview() {
    return const Center(child: Text("Probe Not Implemented"));
  }
}
