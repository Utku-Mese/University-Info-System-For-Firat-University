import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/student_model.dart';

class StudentController {
  List<Student> parseStudents(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Student>((json) => Student.fromJson(json)).toList();
  }

  Future<List<Student>> fetchStudents() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.34:8000/api/students'));

    if (response.statusCode == 200) {
      //return parseStudents(response.body);
      final students = parseStudents(response.body);
      // isActive değeri 1 olan öğrencileri filtreler
      final activeStudents =
          students.where((student) => student.isActive == 1).toList();
      return activeStudents;
    } else {
      throw Exception('API request failed: ${response.statusCode}');
    }
  }

  Future<Student> createStudent(Student student) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.34:8000/api/students'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          student.toJson()), // Öğrenci nesnesini JSON formatına çeviriyoruz
    );

    if (response.statusCode == 201) {
      // API tarafından oluşturulan öğrenci nesnesi döndürlebilir
      return Student.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('API request failed: ${response.statusCode}');
    }
  }

  Future<void> deleteStudent(int studentId) async {
    final response = await http.delete(
      Uri.parse('http://192.168.1.34:8000/api/students/$studentId'),
    );

    if (response.statusCode == 200) {
      debugPrint('Öğrenci başarıyla silindi.');
    } else {
      throw Exception(
          'Öğrenci silme işlemi başarısız oldu: ${response.statusCode}');
    }
  }
}
