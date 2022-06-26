import 'package:flutter/material.dart';
import 'package:apps_education/constants/setting_Reusable.dart';
import 'package:apps_education/component/button.dart';
import 'package:apps_education/helpers/preference_helper.dart';
import 'package:apps_education/helpers/email_user.dart';
import 'package:apps_education/models/network_response.dart';
import 'package:apps_education/models/email_user.dart';
import 'package:apps_education/repository/api_auth.dart';
import 'package:apps_education/view/main_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static const String route = "register_page";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

enum Gender { lakiLaki, perempuan }

class _RegisterPageState extends State<RegisterPage> {
  String gender = "Laki-laki";
  List<String> classSlta = ["10", "11", "12"];
  String selectedClass = "10";

  final emailController = TextEditingController();
  final schoolNameController = TextEditingController();
  final fullNameController = TextEditingController();

  onTapGender(Gender inputGender) {
    if (inputGender == Gender.lakiLaki) {
      gender = "Laki-laki";
    } else {
      gender = "Perempuan";
    }
    setState(() {});
  }

  initDataUser() {
    emailController.text = UserEmail.getUserEmail()!;
    fullNameController.text = UserEmail.getUserDisplayName()!;
  }

  @override
  void initState() {
    super.initState();
    initDataUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Setting_Reusable.color.backgroundRegister,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 20),
        child: AppBar(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25.0),
                  bottomRight: Radius.circular(25.0))),
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            "Yuk isi data diri!",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w700, fontSize: 18),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: ButtonLogin(
          backgroundColor: Setting_Reusable.color.primary,
          borderColor: Setting_Reusable.color.primary,
          onTap: () async {
            final json = {
              "email": emailController.text,
              "nama_lengkap": fullNameController.text,
              "nama_sekolah": schoolNameController.text,
              "jenjang": selectedClass,
              "gender": gender,
              "foto": UserEmail.getUserPhotoUrl(),
            };
            print(json);
            final result = await AuthApi().postRegister(json);
            if (result.status == Status.success) {
              final registerResult = EmailUser.fromJson(result.data!);
              print(EmailUser.fromJson(result.data!));
              if (registerResult.status == 1) {
                await PreferenceHelper().setUserData(registerResult.data!);
                Navigator.of(context).pushNamedAndRemoveUntil(
                    MainPage.route, (context) => false);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(registerResult.message!),
                  ),
                );
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Terjadi kesalahan, silahkan ulangi kembali"),
                ),
              );
            }
          },
          radius: null,
          child: Text(
            Setting_Reusable.strings.daftar,
            style: const TextStyle(
                color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
      )),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          RegisterTextField(
            title: "Email",
            hintText: "Email Anda",
            controller: emailController,
          ),
          RegisterTextField(
            title: "Nama Lengkap",
            hintText: "Nama Lengkap Anda",
            controller: fullNameController,
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary:
                            gender.toLowerCase() == "Laki-laki".toLowerCase()
                                ? Setting_Reusable.color.primary
                                : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                              width: 1,
                              color: Setting_Reusable.color.greyBorder),
                        )),
                    onPressed: () {
                      onTapGender(Gender.lakiLaki);
                    },
                    child: Text(
                      "Laki-laki",
                      style: TextStyle(
                        fontSize: 14,
                        color: gender.toLowerCase() == "Laki-laki".toLowerCase()
                            ? Colors.white
                            : Color(0xff282828),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: gender == "Perempuan"
                          ? Setting_Reusable.color.primary
                          : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                            width: 1, color: Setting_Reusable.color.greyBorder),
                      )),
                  onPressed: () {
                    onTapGender(Gender.perempuan);
                  },
                  child: Text(
                    "Perempuan",
                    style: TextStyle(
                      fontSize: 14,
                      color: gender == "Perempuan"
                          ? Colors.white
                          : Color(0xff282828),
                    ),
                  ),
                ),
              ))
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Kelas",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              border: Border.all(color: Setting_Reusable.color.greyBorder),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                  value: selectedClass,
                  items: classSlta
                      .map(
                        (e) => DropdownMenuItem<String>(
                          child: Text(e),
                          value: e,
                        ),
                      )
                      .toList(),
                  onChanged: (String? val) {
                    selectedClass = val!;
                    setState(() {});
                  }),
            ),
          ),
          SizedBox(height: 5),
          RegisterTextField(
            title: "Nama Sekolah",
            hintText: "Nama Sekolah Anda",
            controller: schoolNameController,
          )
        ]),
      )),
    );
  }
}
