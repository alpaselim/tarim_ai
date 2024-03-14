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

  Stream<QuerySnapshot<UserModel>> callUsers() {
    var currentUsers = users
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (movie, _) => movie.toJson(),
        )
        .snapshots();
    return currentUsers;
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
