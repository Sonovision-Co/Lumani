import 'package:flutter/widgets.dart';

abstract class VideoSource extends ChangeNotifier {
  Future<void> initialize();
  Future<void> start();
  Future<void> stop();
  @override
  void dispose();

  bool get isStreaming;
  dynamic get value;
  Widget buildPreview();
}
