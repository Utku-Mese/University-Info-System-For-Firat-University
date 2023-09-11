import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_uni/models/instructor_model.dart';

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
}
