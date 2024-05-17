import 'package:flutter/material.dart';
import 'package:tarim_ai/Data/app_constants.dart';
import 'package:tarim_ai/Services/firestore_service.dart';
import 'package:share_plus/share_plus.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  late Future<List<String>> _imageUrlsFuture;
  final List<String> selectedImages = [];
  bool isSelectionMode = false;

  @override
  void initState() {
    super.initState();
    _imageUrlsFuture = fireStoreService.getImageUrlsFromGallery();
  }

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
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
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

  Future<void> _deleteImage(String imageUrl) async {
    // Firestore'dan belgeyi silme işlemi
    // Burada imageUrl kullanarak ilgili belgeyi bulun ve silin
  }

  void _shareImage(String imageUrl) {
    // Paylaşma işlemi
    Share.share(imageUrl);
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
                  onPressed: () {
                    for (var imageUrl in selectedImages) {
                      _deleteImage(imageUrl);
                    }
                    setState(() {
                      selectedImages.clear();
                      isSelectionMode = false;
                    });
                  },
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
      body: FutureBuilder<List<String>>(
        future: _imageUrlsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<String> imageUrls = snapshot.data ?? [];
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
