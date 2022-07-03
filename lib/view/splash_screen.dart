import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:latsol/constants/reusable.dart';
import 'package:latsol/helpers/user_email.dart';
import 'package:latsol/models/network_response.dart';
import 'package:latsol/models/user_by_email.dart';
import 'package:latsol/repository/auth_api.dart';
import 'package:latsol/view/login_page.dart';
import 'package:latsol/view/main/latihan_soal/home_page.dart';
import 'package:latsol/view/main_page.dart';
import 'package:latsol/view/register_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const String route = "spash_screen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 5), () async {
      final user = UserEmail.getUserEmail();

      if (user != null) {
        final dataUser = await AuthApi().getUserByEmail();
        if (dataUser.status == Status.success) {
          final data = UserByEmail.fromJson(dataUser.data!);
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
      backgroundColor: R.colors.primary,
      body: Center(
        child: Image.asset(
          R.assets.icSplash,
          width: MediaQuery.of(context).size.width * 0.5,
        ),
      ),
    );
  }
}
