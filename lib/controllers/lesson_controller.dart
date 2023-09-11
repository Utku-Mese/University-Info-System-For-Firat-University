import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_uni/models/lesson_model.dart';

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
}
