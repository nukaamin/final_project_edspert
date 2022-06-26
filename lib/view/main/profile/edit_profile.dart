import 'package:flutter/material.dart';
import 'package:apps_education/constants/setting_Reusable.dart';
import 'package:apps_education/component/button.dart';
import 'package:apps_education/helpers/preference_helper.dart';
import 'package:apps_education/helpers/email_user.dart';
import 'package:apps_education/models/network_response.dart';
import 'package:apps_education/models/email_user.dart';
import 'package:apps_education/repository/api_auth.dart';
// import 'package:apps_education/view/login_page.dart';
// import 'package:apps_education/view/main_page.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);
  static String route = "register_page";
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

enum Gender { lakiLaki, perempuan }

class _EditProfilePageState extends State<EditProfilePage> {
  List<String> classSlta = ["10", "11", "12"];

  String gender = "Laki-laki";
  String selectedClass = "10";
  final emailController = TextEditingController();
  final schoolNameController = TextEditingController();
  final fullNameController = TextEditingController();

  onTapGender(Gender genderInput) {
    if (genderInput == Gender.lakiLaki) {
      gender = "Laki-laki";
    } else {
      gender = "Perempuan";
    }
    setState(() {});
  }

  initDataUser() async {
    emailController.text = UserEmail.getUserEmail()!;
    fullNameController.text = UserEmail.getUserDisplayName()!;
    final dataUser = await PreferenceHelper().getUserData();
    fullNameController.text = dataUser!.userName!;
    schoolNameController.text = dataUser.userAsalSekolah!;
    gender = dataUser.userGender!;
    selectedClass = dataUser.jenjang != null ? "10" : "undefined";
    print(gender);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initDataUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xfff0f3f5),
      appBar: AppBar(
        // shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.only(
        //         bottomLeft: Radius.circular(25.0),
        //         bottomRight: Radius.circular(25.0))),
        elevation: 0,
        // backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Edit Akun",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: ButtonLogin(
            radius: 8,
            onTap: () async {
              final json = {
                "email": emailController.text,
                "nama_lengkap": fullNameController.text,
                "nama_sekolah": schoolNameController.text,
                "kelas": selectedClass,
                "gender": gender,
                "foto": UserEmail.getUserPhotoUrl(),
              };
              print(json);
              final result = await AuthApi().postUpdateUSer(json);
              if (result.status == Status.success) {
                final registerResult = EmailUser.fromJson(result.data!);
                if (registerResult.status == 1) {
                  await PreferenceHelper().setUserData(registerResult.data!);
                  Navigator.pop(context, true);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(registerResult.message!),
                    ),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Terjadi kesalahan, silahkan ulangi kembali"),
                  ),
                );
              }
            },
            backgroundColor: Setting_Reusable.color.primary,
            borderColor: Setting_Reusable.color.primary,
            child: Text(
              Setting_Reusable.strings.perbaharuiAkun,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EditProfileTextField(
                controller: emailController,
                hintText: 'Email Anda',
                title: "Email",
                enabled: false,
              ),
              EditProfileTextField(
                hintText: 'Nama Lengkap Anda',
                title: "Nama Lengkap",
                controller: fullNameController,
              ),
              SizedBox(height: 5),
              Text(
                "Jenis Kelamin",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Setting_Reusable.color.greySubtitle),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                          ),
                        ),
                        onPressed: () {
                          onTapGender(Gender.lakiLaki);
                        },
                        child: Text(
                          "Laki-laki",
                          style: TextStyle(
                            fontSize: 14,
                            color: gender.toLowerCase() ==
                                    "Laki-laki".toLowerCase()
                                ? Colors.white
                                : Color(0xff282828),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: gender == "Perempuan"
                              ? Setting_Reusable.color.primary
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                                width: 1,
                                color: Setting_Reusable.color.greyBorder),
                          ),
                        ),
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
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Text(
                "Kelas",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Setting_Reusable.color.greySubtitle),
              ),
              SizedBox(height: 5),
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
              EditProfileTextField(
                hintText: 'Nama Sekolah',
                title: "Nama Sekolah",
                controller: schoolNameController,
              ),
              // Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class EditProfileTextField extends StatelessWidget {
  const EditProfileTextField({
    Key? key,
    required this.title,
    required this.hintText,
    this.controller,
    this.enabled = true,
  }) : super(key: key);
  final String title;
  final String hintText;
  final bool enabled;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Setting_Reusable.color.greySubtitle),
          ),
          SizedBox(height: 5),
          TextField(
            enabled: enabled,
            controller: controller,
            decoration: InputDecoration(
                // border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(
                  color: Setting_Reusable.color.greyHintText,
                )),
          ),
        ],
      ),
    );
  }
}
