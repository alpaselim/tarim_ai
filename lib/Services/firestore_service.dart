import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tarim_ai/Data/models/soil_analysis.dart';
import 'package:tarim_ai/Data/models/user_model.dart';
import 'package:tarim_ai/Services/snackbar_service.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireStoreService {
  static final FireStoreService _instance = FireStoreService._internal();

  factory FireStoreService() {
    return _instance;
  }

  FireStoreService._internal() {
    // initialization logic
  }
  User? currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  CollectionReference farmers =
      FirebaseFirestore.instance.collection('farmers');

  String? userId = FirebaseAuth.instance.currentUser?.uid;

  Future<List<String>> getImageUrlsFromGallery() async {
    try {
      // Firestore veritabanından fotoğraf URL'lerini al
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(currentUser
                  ?.uid) // Kullanıcıya göre belirli bir belgeyi hedefle
              .collection('gallery')
              .get();

      // Fotoğraf URL'lerini bir listeye ekle
      final List<String> imageUrls =
          querySnapshot.docs.map((doc) => doc.data()['url'] as String).toList();

      return imageUrls;
    } catch (e) {
      //  print('Error fetching image URLs from Firestore: $e');
      return []; // Boş bir liste döndürür
    }
  }

  Future<String> uploadImage(File imageFile) async {
    try {
      String imagePath = 'images/${DateTime.now()}.png'; // Yüklenecek yol
      Reference storageReference =
          FirebaseStorage.instance.ref().child(imagePath);
      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      // print('Resim yüklenirken hata oluştu: $e');
      return '';
    }
  }

  Future<String> uploadGalleryImage(File imageFile) async {
    try {
      String imagePath = 'gallery/${DateTime.now()}.png'; // Yüklenecek yol
      Reference storageReference =
          FirebaseStorage.instance.ref().child(imagePath);
      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      //   print('Resim yüklenirken hata oluştu: $e');
      return '';
    }
  }

  Future<void> addNewUser(UserModel userModel) async {
    await users.doc(userModel.uid).set({
      "name": userModel.name,
      "email": userModel.email,
      "password": userModel.password,
      "phoneNumber": userModel.phoneNumber,
      "uid": userModel.uid,
      "profilePicture": userModel.profilePicture,
      "status": userModel.status,
    }).then((value) {
      snackbarService.showSuccessSnackBar("Kullanıcı Eklendi");
    });
  }

  Future<void> addNewUserToDetail(UserModel userModel) async {
    await farmers.doc("turkey").collection("farmers").doc().set({
      "name": userModel.name,
      "email": userModel.email,
      "password": userModel.password
    }).then((value) {
      snackbarService.showSuccessSnackBar("Kullanıcı Eklendi");
    });
  }

  Future<void> addImageUrlToFirestore(String imageUrl) async {
    try {
      // Firestore veritabanı referansını alın
      final DocumentReference docRef = FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser?.uid)
          .collection('gallery')
          .doc();

      // Firebase Storage'dan alınan URL'yi Firestore'a ekle
      await docRef.set({'url': imageUrl});
      //  print('Image URL added to Firestore');
    } catch (e) {
      //  print('Error adding image URL to Firestore: $e');
    }
  }

  Future<void> addFieldToCurrentUser(SoilAnalysis field) async {
    if (currentUser?.uid != null) {
      // Doküman referansı alın
      DocumentReference docRef = FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser?.uid)
          .collection('fields')
          .doc();

      // Firestore'da yeni bir belge oluştur ve otomatik ID kullan
      await docRef.set(field.toJson()).then((value) async {
        // Burada docRef.id ile otomatik üretilen ID'yi alabilirsiniz
        // Şimdi, bu ID'yi kullanarak dokümanı güncelleyin
        await docRef.update({
          'fieldId':
              docRef.id, // fieldId alanını dokümanın kendi ID'si ile güncelle
        });

        snackbarService.showSuccessSnackBar("Tarla ve ID Eklendi");
      }).catchError((error) {
        snackbarService
            .showErrorSnackBar("Tarla Eklenirken Bir Hata Oluştu: $error");
      });
    } else {
      snackbarService.showErrorSnackBar("Kullanıcı bilgisi bulunamadı.");
    }
  }

  Future<void> deleteFieldFromCurrentUser(String fieldId) async {
    if (currentUser?.uid != null && fieldId.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('users') // Kullanıcılar koleksiyonuna erişim
          .doc(currentUser?.uid) // Mevcut kullanıcının ID'si ile belgeye erişim
          .collection('fields') // Kullanıcının tarlaları için alt koleksiyon
          .doc(fieldId) // Silinecek tarlanın ID'si
          .delete() // Belgeyi sil
          .then((value) {
        snackbarService.showSuccessSnackBar("Tarla başarıyla silindi");
      }).catchError((error) {
        snackbarService
            .showErrorSnackBar("Tarla silinirken bir hata oluştu: $error");
      });
    } else {
      // Kullanıcı oturum açmamışsa veya UID yoksa hata göster
      snackbarService.showErrorSnackBar(
          "Kullanıcı bilgisi bulunamadı veya tarla ID'si boş");
    }
  }

  // Belirli bir ID'ye göre kullanıcının tarlasının SoilAnalysis verisini al
  Future<SoilAnalysis?> getSoilAnalysisById(String fieldId) async {
    if (currentUser?.uid != null && fieldId.isNotEmpty) {
      try {
        // Belirli bir tarlanın belgesine erişim
        DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser?.uid)
            .collection('fields')
            .doc(fieldId)
            .get();

        // Belge mevcutsa ve veri içeriyorsa, SoilAnalysis nesnesine dönüştür
        if (docSnapshot.exists && docSnapshot.data() != null) {
          SoilAnalysis soilAnalysis =
              SoilAnalysis.fromJson(docSnapshot.data() as Map<String, dynamic>);
          return soilAnalysis;
        } else {
          snackbarService.showErrorSnackBar("Tarla bulunamadı.");
          return null;
        }
      } catch (e) {
        snackbarService
            .showErrorSnackBar("Tarla bilgisi alınırken bir hata oluştu: $e");
        return null;
      }
    } else {
      snackbarService.showErrorSnackBar(
          "Kullanıcı bilgisi bulunamadı veya tarla ID'si boş.");
      return null;
    }
  }

  Future<UserModel?> getCurrentUserModel() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser?.uid)
          .get();

      if (documentSnapshot.exists) {
        return UserModel.fromJson(
            documentSnapshot.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      //print('Hata: $e');
      return null;
    }
  }

  Future<void> editUserProfile(
      String newName, String newPhoneNumber, String imageUrl) async {
    try {
      // Mevcut kullanıcının UID'sini al

      if (userId != null) {
        DocumentReference userDocRef = users.doc(userId);

        await userDocRef.update({
          'name': newName,
          'phoneNumber': newPhoneNumber,
          'profilePicture': imageUrl
        });
        //  print('Kullanıcı adı güncellendi: $newName');
        //  print('Kullanıcı phone no güncellendi: $newPhoneNumber');
        //  print('Kullanıcı photosu güncellendi: $imageUrl');
      } else {
        // print('Kullanıcı kimliği yok');
      }
    } catch (e) {
      //print('Kullanıcı adını güncelleme başarısız: $e');
    }
  }
}

final FireStoreService fireStoreService = FireStoreService();
