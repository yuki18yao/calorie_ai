import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:calorie_ai/screens/estimation_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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

  String _response = '';
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void initState() {
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> analyzeImage(String imagePath) async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final url = Uri.parse('https://api.openai.com/v1/chat/completions');
    final bytes = File(imagePath).readAsBytesSync();
    final base64Image = base64Encode(bytes);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${dotenv.env['OPENAI_API_KEY']}',
        },
        body: json.encode(
          {
            'model': 'gpt-4o',
            // 'image': base64Image,
            'messages': [
              {
                'role': 'system',
                'content':
                    'You are a nutritionist who estimates calories from images. Analyze the images of the meals provided and estimate the calories.'
              },
              {
                'role': 'user',
                'content': [
                  {
                    "type": "text",
                    "text":
                        "Estimate the calories from the images of the above meals."
                  },
                  {
                    "type": "image_url",
                    "image_url": {
                      //"url": base64Image,
                      "url": "https://img.freepik.com/free-photo/tasty-burger-isolated-white-background-fresh-hamburger-fastfood-with-beef-cheese_90220-1063.jpg",
                      "detail": "high",
                    },
                  },
                  
                ],
              },
            ],
          },
        ),
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          _response = responseData['choices'][0]['message']['content'];
          print('Response from OpenAI API: ' + _response);
        });
      } else {
        setState(
          () {
            _errorMessage = 'Failed to get response: ${response.statusCode}';
          },
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                CameraPreview(_controller),
                _buildCorners(),
              ],
            );
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

            // Call the OpenAI API
            print(
                '---------------------- This is the print statement of the image path: ' +
                    image.path);

            await analyzeImage(image.path);

            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EstimationScreen(
                  imagePath: image.path,
                  message: _response,
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
                    bottom:
                        BorderSide(width: borderWidth, color: Colors.orange),
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
                    bottom:
                        BorderSide(width: borderWidth, color: Colors.orange),
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
