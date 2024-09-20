import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/Model/user.dart';

class ProfileService {
  static const String baseUrl = ''; // Ganti dengan URL API

  Future<User> fetchProfile(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/profile'),
      headers: {'Authorization': 'Bearer $token'},
    );
    
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load profile');
    }
  }

  Future<void> updateProfile(String token, Map<String, String> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/profile'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update profile');
    }
  }
}
