import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../config.dart';
import '../../../constants/firestore_constants.dart';
import '../../../model/firebase_user_model.dart';
import '../../../model/login_model.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();
  GetConnect getConnect = GetConnect();
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  late BeautyUser _user;
  //Login
  var passwordController = TextEditingController();
  var userIdController = TextEditingController();

  Future<String> loginApp() async {
    Login login = Login(
        password: passwordController.text, userName: userIdController.text);

    final response = await getConnect.post('${Server.baseUrl}/api/login', {
      "password": 'qaz1234',
      "userName": 'test112@aaaa.com'
    }, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    print(response.request!.bodyBytes);

    print(response.statusCode);
    print(response.body);
    var token = response.body['token'];
    print(token);
    return token;
  }

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser != null) {
      print('name = ${googleUser.displayName}');
      print('email = ${googleUser.email}');
      print('id = ${googleUser.id}');
      BeautyUser user = BeautyUser(
          id: googleUser.id,
          email: googleUser.email,
          nickName: googleUser.displayName ?? 'Beauty',
          profile: googleUser.photoUrl ?? '');
      final QuerySnapshot result = await firebaseFirestore
          .collection(FirestoreConstants.pathUserCollection)
          .where('id', isEqualTo: user.id)
          .get();
      final List<DocumentSnapshot> documents = result.docs;
      DocumentSnapshot documentSnapshot = documents[0];
      user = BeautyUser.fromDocument(documentSnapshot);
    }
  }

  setUser(BeautyUser user) {
    _user = user;
  }
}
