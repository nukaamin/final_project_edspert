import 'package:apps_education/constants/setting_Reusable.dart';
import 'package:apps_education/models/email_user.dart';
import 'package:apps_education/repository/api_auth.dart';
import 'package:apps_education/view/main_page.dart';
import 'package:apps_education/view/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:apps_education/component/button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:apps_education/helpers/preference_helper.dart';

import '../models/network_response.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const String route = "login_screen";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<UserCredential> signInWithGoogle() async {
    if (kIsWeb) {
      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      googleProvider
          .addScope('https://www.googleapis.com/auth/contacts.readonly');
      googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithPopup(googleProvider);
    } else {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Setting_Reusable.color.backgroundLogin,
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                Setting_Reusable.strings.login,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 20),
            Image.asset(Setting_Reusable.asset.imgLogin),
            const SizedBox(
              height: 35,
            ),
            Text(
              Setting_Reusable.strings.welcome,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(Setting_Reusable.strings.loginDescription,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins().copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Setting_Reusable.color.greySubtitle)),
            const Spacer(),
            ButtonLogin(
              backgroundColor: Colors.white,
              borderColor: Setting_Reusable.color.primary,
              onTap: () async {
                await signInWithGoogle();

                final user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  final dataUser = await AuthApi().getUserByEmail();
                  if (dataUser.status == Status.success) {
                    final data = EmailUser.fromJson(dataUser.data!);
                    if (data.status == 1) {
                      await PreferenceHelper().setUserData(data.data!);
                      Navigator.of(context).pushNamed(MainPage.route);
                    } else {
                      Navigator.of(context).pushNamed(RegisterPage.route);
                    }
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Gagal Masuk"),
                    duration: Duration(seconds: 2),
                  ));
                }
              },
              radius: null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(Setting_Reusable.asset.icGoogle),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    Setting_Reusable.strings.loginWithGoogle,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Setting_Reusable.color.blackLogin),
                  )
                ],
              ),
            ),
            ButtonLogin(
                onTap: () async {
                  await signInWithGoogle();

                  final user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    final dataUser = await AuthApi().getUserByEmail();
                    if (dataUser.status == Status.success) {
                      final data = EmailUser.fromJson(dataUser.data!);
                      if (data.status == 1) {
                        await PreferenceHelper().setUserData(data.data!);
                        Navigator.of(context).pushNamed(MainPage.route);
                      } else {
                        Navigator.of(context).pushNamed(RegisterPage.route);
                      }
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Gagal Masuk"),
                      duration: Duration(seconds: 2),
                    ));
                  }
                },
                backgroundColor: Colors.black,
                borderColor: Colors.black,
                radius: null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(Setting_Reusable.asset.icAple),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      Setting_Reusable.strings.loginWithApple,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.white),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
