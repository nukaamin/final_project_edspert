import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:apps_education/constants/setting_Reusable.dart';
import 'package:apps_education/helpers/preference_helper.dart';
import 'package:apps_education/models/email_user.dart';
import 'package:apps_education/view/login_page.dart';
import 'package:apps_education/view/main/profile/edit_profile.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  DataUser? user;
  getUserData() async {
    final data = await PreferenceHelper().getUserData();
    user = data;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Akun Saya"),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () async {
              final result = await Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return EditProfilePage();
              }));
              print("result");
              print(result);
              if (result == true) {
                getUserData();
              }
            },
            child: const Text(
              "Edit",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: user == null
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    top: 28,
                    bottom: 60,
                    right: 15,
                    left: 15,
                  ),
                  decoration: BoxDecoration(
                    color: Setting_Reusable.color.primary,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(9),
                      bottomRight: Radius.circular(9),
                    ),
                  ),
                  child: Row(children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user!.userName!,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            user!.userAsalSekolah!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Image.asset(
                      Setting_Reusable.asset.imgUser,
                      width: 50,
                      height: 50,
                    ),
                  ]),
                ),
                // SizedBox(height: 15),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 7, color: Colors.black.withOpacity(0.25))
                    ],
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 18, horizontal: 13),
                  padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 13),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Identitas Diri"),
                      const SizedBox(height: 15),
                      Text(
                        "Name Lengkap",
                        style: TextStyle(
                          color: Setting_Reusable.color.greySubtitleHome,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        user!.userName!,
                        style: const TextStyle(
                          // color: Setting_Reusable.color.greySubtitleHome,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        "Email",
                        style: TextStyle(
                          color: Setting_Reusable.color.greySubtitleHome,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        user!.userEmail!,
                        style: const TextStyle(
                          // color: Setting_Reusable.color.greySubtitleHome,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        "Jenis Kelamin",
                        style: TextStyle(
                          color: Setting_Reusable.color.greySubtitleHome,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        user!.userGender!,
                        style: const TextStyle(
                          // color: Setting_Reusable.color.greySubtitleHome,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        "Kelas",
                        style: TextStyle(
                          color: Setting_Reusable.color.greySubtitleHome,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        user?.jenjang != null ? "10" : "undefined",
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        "Asal Sekolah",
                        style: TextStyle(
                          color: Setting_Reusable.color.greySubtitleHome,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        user!.userAsalSekolah!,
                        style: const TextStyle(
                          // color: Setting_Reusable.color.greySubtitleHome,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    if (kIsWeb) {
                      await GoogleSignIn(
                              clientId:
                                  "604293972193-n678jbsfgjp9416d8nnibndjtumviia8.apps.googleusercontent.com")
                          .signOut();
                    } else {
                      await GoogleSignIn().signOut();
                    }
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        LoginPage.route, (route) => false);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 13),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 7,
                            color: Colors.black.withOpacity(0.25))
                      ],
                    ),
                    child: Row(children: const [
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.red,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Keluar",
                        style: TextStyle(
                          color: Colors.red,
                          // fontSize: 12,
                        ),
                      ),
                    ]),
                  ),
                )
              ],
            ),
    );
  }
}
