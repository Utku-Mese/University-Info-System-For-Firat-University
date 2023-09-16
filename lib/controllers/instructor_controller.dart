import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/instructor_model.dart';

class InstructorController {
  List<Instructor> parseInstructors(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Instructor>((json) => Instructor.fromJson(json)).toList();
  }

  Future<List<Instructor>> fetchInstructors() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.34:8000/api/instructors'));

    if (response.statusCode == 200) {
      //return parseInstructors(response.body);
      final instructors = parseInstructors(response.body);
      // isActive değeri 1 olan öğretim görevlilerini filtreler
      final activeInstructors =
          instructors.where((instructor) => instructor.isActive == 1).toList();
      return activeInstructors;
    } else {
      throw Exception('API request failed: ${response.statusCode}');
    }
  }

  Future<Instructor> createInstructor(Instructor instructor) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.34:8000/api/instructors'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(instructor.toJson()),
    );

    if (response.statusCode == 201) {
      return Instructor.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('API request failed: ${response.statusCode}');
    }
  }

  Future<void> deleteInstructor(int instructorId) async {
    final response = await http.delete(
      Uri.parse('http://192.168.1.34:8000/api/instructors/$instructorId'),
    );

    if (response.statusCode == 200) {
      debugPrint('instructors başarıyla silindi.');
    } else {
      throw Exception(
          'instructors silme işlemi başarısız oldu: ${response.statusCode}');
    }
  }
}
