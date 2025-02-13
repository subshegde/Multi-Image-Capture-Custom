import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}
class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  List<String> capturedImages = [];
  late CameraDescription _camera;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  void _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        _camera = cameras.first;
        _controller = CameraController(_camera, ResolutionPreset.high);
        _initializeControllerFuture = _controller.initialize();
        setState(() {});
      }
    } catch (e) {
      print("Error initializing camera: $e");
    }
  }

  // Switch camera
  Future<void> _switchCamera() async {
    try {
      final cameras = await availableCameras();
      setState(() {
        _camera = _camera == cameras.first ? cameras.last : cameras.first;
      });
      _controller = CameraController(_camera, ResolutionPreset.high);
      _initializeControllerFuture = _controller.initialize();
    } catch (e) {
      print("Error switching camera: $e");
    }
  }

  // Capture image
  Future<void> _captureImage() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();
      setState(() {
        capturedImages.add(image.path);
      });
    } catch (e) {
      print("Error capturing image: $e");
    }
  }

  void _removeImage(int index) {
    setState(() {
      capturedImages.removeAt(index);
    });
  }

  void _onDone() {
    Navigator.pop(context, capturedImages);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_controller);
                } else {
                  return const Center(child: CircularProgressIndicator(color: Colors.grey));
                }
              },
            ),
            if (capturedImages.isNotEmpty)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: capturedImages.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.file(
                                  File(capturedImages[index]),
                                  width: 60,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: -15,
                              right: -15,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.remove_circle,
                                  color: Colors.red,
                                  size: 20,
                                ),
                                onPressed: () => _removeImage(index),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FloatingActionButton(
                      backgroundColor: Colors.black.withOpacity(0.9),
                      onPressed: _switchCamera,
                      child: const Icon(Icons.switch_camera,color: Colors.white,),
                    ),
                    FloatingActionButton(
                      backgroundColor: Colors.black.withOpacity(0.9),
                      onPressed: _captureImage,
                      child: const Icon(Icons.camera_alt,color: Colors.white,),
                    ),
                    FloatingActionButton(
                      backgroundColor: Colors.black.withOpacity(0.9),
                      onPressed: _onDone,
                      child: const Icon(Icons.check,color: Colors.white,),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
