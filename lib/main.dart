import 'package:calorie_ai/providers/camera_provider.dart';
import 'package:calorie_ai/screens/tabs_screen.dart';
import 'package:calorie_ai/theme.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
//import 'package:path/path.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

// Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

// Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  await dotenv.load(fileName: "assets/.env");

  runApp(ChangeNotifierProvider(
    create: (context) => CameraProvider()..setFirstCamera(firstCamera),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const TabsScreen(),
    );
  }
}
