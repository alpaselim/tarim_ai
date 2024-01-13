import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tarim_ai/Data/models/user_model.dart';

class StreamService {
  static final StreamService _instance = StreamService._internal();

  // using a factory is important
  // because it promises to return _an_ object of this type
  // but it doesn't promise to make a new one.
  factory StreamService() {
    return _instance;
  }

  // This named constructor is the "real" constructor
  // It'll be called exactly once, by the static property assignment above
  // it's also private, so it can only be called in this class
  StreamService._internal() {
    // initialization logic
  }

// Create a CollectionReference called users that references the firestore collection
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  /// QuerySnapshot Streams
  /// call all users
  Stream<QuerySnapshot<UserModel>> callUsers() {
    var currentUsers = users
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (movie, _) => movie.toJson(),
        )
        .snapshots();
    return currentUsers;
  }
}

final StreamService streamService = StreamService();
