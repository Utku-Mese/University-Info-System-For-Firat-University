import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/lesson_model.dart';

class LessonController {
  List<Lesson> parseLessons(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Lesson>((json) => Lesson.fromJson(json)).toList();
  }

  Future<List<Lesson>> fetchLessons() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.34:8000/api/lessons'));

    if (response.statusCode == 200) {
      return parseLessons(response.body);
    } else {
      throw Exception('API request failed: ${response.statusCode}');
    }
  }

  Future<Lesson> createLesson(Lesson lesson) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.34:8000/api/lessons'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(lesson.toJson()),
    );

    if (response.statusCode == 201) {
      return Lesson.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('API request failed: ${response.statusCode}');
    }
  }

  Future<void> updateLesson(Lesson lesson, int lessonId) async {
    final response = await http.put(
      Uri.parse('http://192.168.1.34:8000/api/lessons/$lessonId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(lesson.toJson()),
    );
    if (response.statusCode == 200) {
      debugPrint('ders başarıyla güncellendi.');
    } else {
      throw Exception('API request failed: ${response.statusCode}');
    }
  }

  Future<void> deleteLesson(int lessonId) async {
    final response = await http.delete(
      Uri.parse('http://192.168.1.34:8000/api/Lessons/$lessonId'),
    );

    if (response.statusCode == 200) {
      debugPrint('lesson başarıyla silindi.');
    } else {
      throw Exception(
          'lesson silme işlemi başarısız oldu: ${response.statusCode}');
    }
  }
}
