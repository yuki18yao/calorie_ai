import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraProvider with ChangeNotifier {
  CameraDescription? _firstCamera;

  CameraDescription? get firstCamera => _firstCamera;

  void setFirstCamera(CameraDescription camera) {
    _firstCamera = camera;
    notifyListeners();
  }
}
