import 'dart:convert';

import 'package:launder_app/models/user.dart';
import 'package:launder_app/utils/local_storage/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalStorage {
  Future<void> save(TokenUser token) async {
    await LaunderLocalStorage().save('token_user', jsonEncode(token.toJson()));
  }

  Future<void> remove() async {
    await LaunderLocalStorage().remove('token_user');
  }

  Future<TokenUser?> get() async {
    final token = await LaunderLocalStorage().read<String>('token_user');

    if (token == null) {
      return null;
    }

    return TokenUser.fromJson(jsonDecode(token));
  }

  Future<bool> isLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('token_user');
  }
}