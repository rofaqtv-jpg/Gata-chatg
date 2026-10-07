import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserModel> signUp({required String email, required String password, required String username}) async {
    final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    final user = UserModel(
      id: cred.user!.uid,
      email: email,
      username: username,
      displayName: username,
      createdAt: DateTime.now(),
    );
    await _firestore.collection('users').doc(user.id).set(user.toMap());
    return user;
  }

  Future<void> signIn(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() => _auth.signOut();
  Future<void> resetPassword(String email) => _auth.sendPasswordResetEmail(email: email);

  Future<UserModel?> getCurrentUserModel() async {
    final u = _auth.currentUser;
    if (u == null) return null;
    final doc = await _firestore.collection('users').doc(u.uid).get();
    if (!doc.exists) return null;
    return UserModel.fromFirestore(doc.data()!, doc.id);
  }
}
