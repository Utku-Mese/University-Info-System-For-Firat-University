import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_uni/models/student_model.dart';

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
}
