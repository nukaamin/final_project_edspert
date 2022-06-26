import 'dart:convert';

import 'package:apps_education/models/email_user.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PreferenceHelper {
  static String userData = "data_user";

  Future<SharedPreferences> sharePref() async {
    final sharePref = await SharedPreferences.getInstance();
    return sharePref;
  }

  Future _saveString(key, data) async {
    final _pref = await sharePref();
    await _pref.setString(key, data);
  }

  Future<String?> _getString(key) async {
    final _pref = await sharePref();
    return _pref.getString(
      key,
    );
  }

  setUserData(DataUser userDataModel) async {
    final json = userDataModel.toJson();
    final userDataString = jsonEncode(json);
    print("simpan");
    print(userDataString);
    await _saveString(userData, userDataString);
  }

  Future<DataUser?> getUserData() async {
    final user = await _getString(userData);
    print("data from pref user");
    print(user);
    final jsonUserData = jsonDecode(user!);
    final userDataModel = DataUser.fromJson(jsonUserData);
    return userDataModel;
  }
}

