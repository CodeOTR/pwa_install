import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:injectable/injectable.dart';
import '../models/user.dart';
import 'package:pwa_install/app/services.dart';
import 'package:stacked/stacked.dart';

@singleton
class UserService with ReactiveServiceMixin{

  User? user;

  String? get uid{
    return FirebaseAuth.instance.currentUser?.uid;
  }

  DocumentReference get userRef {
    return firebaseService.firestore.collection('users').doc(uid);
  }

  void setUser(User user){
    this.user = user;
    notifyListeners();
  }
}