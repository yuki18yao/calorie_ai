import 'package:calorie_ai/screens/estimation_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  ScanScreenState createState() => ScanScreenState();
}

class ScanScreenState extends State<ScanScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [CameraPreview(_controller), _buildCorners(),],
            ) ;
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            final image = await _controller.takePicture();

            if (!context.mounted) return;

            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EstimationScreen(
                  imagePath: image.path,
                ),
              ),
            );
          } catch (e) {
            print(e);
          }
        },
        
        backgroundColor: Theme.of(context).primaryColor,
        shape: const CircleBorder(
          side: BorderSide(
            color: Colors.white,
            width: 4,
          ),
        ),
        child: const Icon(Icons.camera_alt),
      ),
    );
  }

  Widget _buildCorners() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = 40.0;
        final borderWidth = 4.0;

        final double squareSize = constraints.maxWidth;
        final double topPosition = (constraints.maxHeight - squareSize) / 2;
        final double leftPosition = (constraints.maxWidth - squareSize) / 2;

        return Stack(
          children: [
            Positioned(
              top: topPosition,
              left: leftPosition,
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: borderWidth, color: Colors.orange),
                    left: BorderSide(width: borderWidth, color: Colors.orange),
                  ),
                ),
              ),
            ),
            Positioned(
              top: topPosition,
              right: leftPosition,
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: borderWidth, color: Colors.orange),
                    right: BorderSide(width: borderWidth, color: Colors.orange),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: topPosition,
              left: leftPosition,
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: borderWidth, color: Colors.orange),
                    left: BorderSide(width: borderWidth, color: Colors.orange),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: topPosition,
              right: leftPosition,
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: borderWidth, color: Colors.orange),
                    right: BorderSide(width: borderWidth, color: Colors.orange),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
