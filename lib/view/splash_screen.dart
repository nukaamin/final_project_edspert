import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:apps_education/constants/setting_Reusable.dart';
import 'package:apps_education/helpers/email_user.dart';
import 'package:apps_education/models/network_response.dart';
import 'package:apps_education/models/email_user.dart';
import 'package:apps_education/repository/api_auth.dart';
import 'package:apps_education/view/login_page.dart';
import 'package:apps_education/view/main/practice/home.dart';
import 'package:apps_education/view/main_page.dart';
import 'package:apps_education/view/register_page.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const String route = "spash_screen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () async {
      final user = UserEmail.getUserEmail();

      if (user != null) {
        final dataUser = await AuthApi().getUserByEmail();
        if (dataUser.status == Status.success) {
          final data = EmailUser.fromJson(dataUser.data!);
          if (data.status == 1) {
            Navigator.of(context).pushReplacementNamed(MainPage.route);
          } else {
            Navigator.of(context).pushReplacementNamed(RegisterPage.route);
          }
        }
      } else {
        Navigator.of(context).pushReplacementNamed(LoginPage.route);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Setting_Reusable.color.primary,
      body: Center(
        child: Image.asset(
          Setting_Reusable.asset.icSplash,
          width: MediaQuery.of(context).size.width * 0.5,
        ),
      ),
    );
  }
}
 