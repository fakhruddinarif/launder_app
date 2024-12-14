import 'dart:convert';

import 'package:launder_app/models/user.dart';
import 'package:launder_app/utils/http/http_client.dart';
import 'package:launder_app/utils/local_storage/auth_local_storage.dart';

class UserService {
  Future<User> register(RegisterUserRequest request) async {
    try {
      final response = await LaunderHttpClient.post('register', request.toJson());
      final data = json.decode(response.body);
      if (response.statusCode == 201) {
        return User.fromJson(data['data']);
      } else {
        throw Exception(data['message']);
      }
    }
    catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<TokenUser> login(LoginUserRequest request) async {
    try {
      final response = await LaunderHttpClient.post('login', request.toJson());
      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        await AuthLocalStorage().save(TokenUser.fromJson(data['data']));
        return TokenUser.fromJson(data['data']);
      } else {
        throw Exception(data['message']);
      }
    }
    catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<User> get() async {
    try {
      final response = await LaunderHttpClient.get('user');
      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        return User.fromJson(data['data']);
      } else {
        throw Exception(data['message']);
      }
    }
    catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<User> update(UpdateUserRequest request) async {
    try {
      final response = await LaunderHttpClient.patch('user', request.toJson());
      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        return User.fromJson(data['data']);
      } else {
        throw Exception(data['message']);
      }
    }
    catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> changePassword(ChangePasswordRequest request) async {
    try {
      final response = await LaunderHttpClient.patch('user/password', request.toJson());
      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(data['message']);
      }
    }
    catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> logout() async {
    try {
      final response = await LaunderHttpClient.delete('user');
      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        await AuthLocalStorage().remove();
        return true;
      } else {
        throw Exception(data['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}