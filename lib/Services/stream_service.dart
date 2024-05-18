import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tarim_ai/Data/models/soil_analysis.dart';
import 'package:tarim_ai/Data/models/user_model.dart';

class StreamService {
  static final StreamService _instance = StreamService._internal();

  factory StreamService() {
    return _instance;
  }

  StreamService._internal() {
    // initialization logic
  }

// Create a CollectionReference called users that references the firestore collection
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  /*  Stream<List<String>> getImageUrlsStream() {
    
    try {
      // Firestore veritabanından fotoğraf URL'lerini dinamik olarak al
       String? currentUserUid = FirebaseAuth.instance.currentUser?.uid;
      return FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserUid) // Kullanıcıya göre belirli bir belgeyi hedefle
          .collection('gallery')
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => doc.data()['url'] as String).toList());
    } catch (e) {
      print('Error fetching image URLs from Firestore: $e');
      return Stream.value([]); // Boş bir liste döndürür
    }
  } */

  Stream<QuerySnapshot<Map<String, dynamic>>> getCurrentUserGallery() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('gallery')
        .snapshots();
  }

  Stream<DocumentSnapshot<UserModel>> getCurrentUser() {
    String? currentUserUid = FirebaseAuth.instance.currentUser?.uid;
    if (currentUserUid != null) {
      return users
          .doc(currentUserUid)
          .withConverter<UserModel>(
            fromFirestore: (snapshot, _) =>
                UserModel.fromJson(snapshot.data()!),
            toFirestore: (movie, _) => movie.toJson(),
          )
          .snapshots();
    } else {
      // Eğer mevcut kullanıcı UID'si yoksa, boş bir stream döndürürüz
      return const Stream.empty();
    }
  }

  Stream<QuerySnapshot<SoilAnalysis>> getCurrentUserFields() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth
            .instance.currentUser?.uid) // Mevcut kullanıcının UID'si
        .collection('fields') // Kullanıcının tarlaları için alt koleksiyon
        .withConverter<SoilAnalysis>(
          fromFirestore: (snapshot, _) =>
              SoilAnalysis.fromJson(snapshot.data()!),
          toFirestore: (field, _) => field.toJson(),
        )
        .snapshots();
  }
}

final StreamService streamService = StreamService();
