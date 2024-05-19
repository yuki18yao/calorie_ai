import 'package:calorie_ai/providers/camera_provider.dart';
import 'package:calorie_ai/screens/tabs_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
//import 'package:path/path.dart';
import 'package:provider/provider.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: const Color.fromARGB(255, 63, 0, 131),
  ),
  // textTheme: GoogleFonts.oswaldTextTheme(),
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

// Obtain a list of the available cameras on the device.
final cameras = await availableCameras();

// Get a specific camera from the list of available cameras.
final firstCamera = cameras.first;

  runApp(
    ChangeNotifierProvider(
      create: (context) => CameraProvider()..setFirstCamera(firstCamera),
      child: const MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home:const TabsScreen() ,
    );
  }
}