import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class AuthServices with ChangeNotifier {
  bool _isLoading = false;
  late String _errorMessage;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  FirebaseAuth firebaseAuth =FirebaseAuth.instance;
  Future register(String email, String password) async {
    setLoading(true);
    try {
      UserCredential authResult = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, 
        password: password);
        User? user = authResult.user;
      setLoading(false);
      return user;
    } on SocketException{
      setLoading(false);
      setMessage("No internet, Please connect to internet");
    } catch (message) {
      setLoading(false);
      print(message);
      setMessage(message);
    }
      notifyListeners();
  }

 Future login(String email, String password) async {
    try {
      setLoading(true);
      UserCredential authResult = await firebaseAuth.signInWithEmailAndPassword(email: email
      , password: password);
      User? user = authResult.user;
      setLoading(false);
      return user;
    } on SocketException{
      setLoading(false);
      setMessage("No internet, Please connect to internet");
    } catch (message) {
      setLoading(false);
      print(message);
      setMessage(message);
    }
      notifyListeners();
  }
 
  Future logout ()async {
    await firebaseAuth.signOut();
  }

  void setLoading(val) {
    _isLoading = val;
    notifyListeners();
  }
  void setMessage(message){

    notifyListeners();
  }

  Stream<User?> get user => 
  firebaseAuth.authStateChanges().map((event) => event);
}