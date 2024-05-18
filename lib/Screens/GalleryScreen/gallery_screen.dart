import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tarim_ai/Data/app_constants.dart';
import 'package:tarim_ai/Services/firestore_service.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tarim_ai/Services/stream_service.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final List<String> selectedImages = [];
  bool isSelectionMode = false;

  void _onImageTap(String imageUrl) {
    if (isSelectionMode) {
      setState(() {
        if (selectedImages.contains(imageUrl)) {
          selectedImages.remove(imageUrl);
          if (selectedImages.isEmpty) {
            isSelectionMode = false;
          }
        } else {
          selectedImages.add(imageUrl);
        }
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(imageUrl),
              ],
            ),
          );
        },
      );
    }
  }

  void _onImageLongPress(String imageUrl) {
    setState(() {
      isSelectionMode = true;
      if (selectedImages.contains(imageUrl)) {
        selectedImages.remove(imageUrl);
        if (selectedImages.isEmpty) {
          isSelectionMode = false;
        }
      } else {
        selectedImages.add(imageUrl);
      }
    });
  }

  void _shareImage(String imageUrl) {
    Share.share(imageUrl);
  }

  void _deleteSelectedImages() async {
    for (var imageUrl in selectedImages) {
      await fireStoreService.deleteImage(imageUrl);
    }
    setState(() {
      selectedImages.clear();
      isSelectionMode = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kGreenColor,
        title: const Text('Gallery'),
        actions: isSelectionMode
            ? [
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: _deleteSelectedImages,
                ),
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () {
                    for (var imageUrl in selectedImages) {
                      _shareImage(imageUrl);
                    }
                  },
                ),
              ]
            : null,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: streamService.getCurrentUserGallery(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<String> imageUrls = snapshot.data?.docs
                    .map((doc) => doc.data()['url'] as String)
                    .toList() ??
                [];
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                final imageUrl = imageUrls[index];
                final isSelected = selectedImages.contains(imageUrl);
                return GestureDetector(
                  onTap: () => _onImageTap(imageUrl),
                  onLongPress: () => _onImageLongPress(imageUrl),
                  child: Stack(
                    children: [
                      Image.network(imageUrl,
                          fit: BoxFit.cover, width: double.infinity),
                      if (isSelectionMode)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: kWhiteColor,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isSelected
                                  ? Icons.check_circle
                                  : Icons.radio_button_unchecked,
                              color: isSelected ? Colors.green : Colors.grey,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
