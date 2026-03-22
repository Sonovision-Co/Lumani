import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:lumani/core/sources/video_source.dart';
import 'package:provider/provider.dart';
import 'package:lumani/app_theme.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  ScanScreenState createState() => ScanScreenState();
}

class ScanScreenState extends State<ScanScreen>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  bool _isScanComplete = false;

  @override
  void initState() {
    super.initState();
    final videoSource = Provider.of<VideoSource>(context, listen: false);
    videoSource.initialize().then((_) {
      if (mounted) {
        videoSource.start();
      }
    });

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _progressAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_progressController);

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Start scan simulation immediately
    // Delay slightly to allow UI to build
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _progressController.forward().whenComplete(() {
          if (mounted) {
            setState(() {
              _isScanComplete = true;
            });
            videoSource.stop();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _progressController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VideoSource>(
      builder: (context, videoSource, child) {
        final isInitialized = videoSource.value?.isInitialized ?? false;

        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: _isScanComplete
                ? _buildSuccessView(context)
                : _buildScanningView(context, videoSource, isInitialized),
          ),
        );
      },
    );
  }

  Widget _buildScanningView(
      BuildContext context, VideoSource videoSource, bool isInitialized) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Pulsing Cone with Camera
        AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _pulseAnimation.value,
              child: child,
            );
          },
          child: Container(
            width: 300,
            height: 300,
            decoration: const BoxDecoration(
              // Gradient backup if camera fails or loads
              gradient: RadialGradient(
                center: Alignment(0, 1),
                radius: 1.2,
                colors: [Color(0xFF333333), Colors.black],
                stops: [0.0, 0.6],
              ),
            ),
            child: ClipPath(
              clipper: UltrasoundConeClipper(),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Camera Feed
                  if (isInitialized)
                    ImageFiltered(
                      imageFilter: ui.ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                      child: ColorFiltered(
                        colorFilter: const ColorFilter.mode(
                          Colors.grey,
                          BlendMode.saturation,
                        ),
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: SizedBox(
                            width: videoSource.value.previewSize?.width ?? 100,
                            height: videoSource.value.previewSize?.height ?? 100,
                            child: videoSource.buildPreview(),
                          ),
                        ),
                      ),
                    )
                  else
                    Container(color: Colors.grey[900]),
                  
                  // Gradient Overlay to darken edges like the mock
                  Container(
                    decoration: const BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment(0, 0.8),
                        radius: 0.8,
                        colors: [Colors.transparent, Colors.black87],
                        stops: [0.5, 1.0],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 32),

        // Text
        Text(
          'Scanning...',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Please hold the Lumani probe steady.',
          style:
              Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey[400]),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 32),

        // Progress Bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Container(
            height: 4,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(2),
            ),
            child: AnimatedBuilder(
              animation: _progressAnimation,
              builder: (context, child) {
                return FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: _progressAnimation.value,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.primary,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessView(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check,
              size: 80,
              color: AppTheme.success,
            ),
            const SizedBox(height: 24),
            Text(
              'Scan Complete',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              'Your scan data has been securely uploaded to Dr. Smith\'s portal.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[400], fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Return to Dashboard'),
            ),
          ],
        ),
      ),
    );
  }
}

class UltrasoundConeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    // Triangle/Cone shape from bottom center
    // Mock uses polygon(50% 100%, 0 0, 100% 0);
    // Which is an inverted triangle (wide top, point bottom).
    // Wait, mock says: `clip-path: polygon(50% 100%, 0 0, 100% 0);`
    // 50% 100% is bottom center.
    // 0 0 is top left.
    // 100% 0 is top right.
    // So it's an inverted triangle.
    
    path.moveTo(0, 0); // Top Left
    path.lineTo(size.width, 0); // Top Right
    path.lineTo(size.width / 2, size.height); // Bottom Center
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
