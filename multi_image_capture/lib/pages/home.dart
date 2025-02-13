
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:multi_image_capture_demo/pages/camera.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> capturedImages = [];

  void _openCamera() async {
    final List<String>? images = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CameraScreen()),
    );
    if (images != null) {
      setState(() {
        capturedImages = images;
      });
    }
  }

  void removeImage(int index) {
    setState(() {
      capturedImages.removeAt(index);
    });
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.withOpacity(0.9),
        onPressed: _openCamera,
        child: const Icon(Icons.camera_alt,color: Colors.black,),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                capturedImages.clear();
              });
            },
            icon: const Icon(Icons.delete_forever, color: Colors.white),
          ),
        ],
        leading: IconButton(onPressed: (){}, icon: const Icon(Icons.home)),title: const Text('Multi Image Capture'),centerTitle: true,),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Center(
                  child: capturedImages.isNotEmpty ?
                        StaggeredGrid.count(
                          crossAxisCount: 4,
                          mainAxisSpacing: 1,
                          crossAxisSpacing: 1,
                          children: List.generate(
                            capturedImages.length,
                            (index) {
                                final pattern = [
                                        const QuiltedGridTile(2, 2),
                                        const QuiltedGridTile(1, 1),
                                        const QuiltedGridTile(1, 1),
                                        const QuiltedGridTile(1, 2),
                                      ];
                
                              final imagePath = capturedImages[index];
                
                              return StaggeredGridTile.count(
                                crossAxisCellCount: pattern[index % pattern.length].crossAxisCount,
                                mainAxisCellCount: pattern[index % pattern.length].mainAxisCount,
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(0),
                                      child: Image.file(
                                        File(imagePath),
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),
                                    ),
                                    Positioned(
                                      right: -12,
                                      top: -12,
                                      child: IconButton(
                                        onPressed: () {
                                          removeImage(index);
                                        },
                                        icon: Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(.7),
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                            size: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ): const SizedBox()
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
