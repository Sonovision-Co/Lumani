import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lumani/core/sources/camera_source.dart';
import 'package:lumani/core/sources/video_source.dart';
import 'package:lumani/features/activation/activation_screen.dart';
import 'package:lumani/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VideoSource>(
      create: (_) => CameraSource(),
      child: MaterialApp(
        title: 'Lumani',
        theme: AppTheme.lightTheme,
        home: const ActivationScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
