import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_uni/models/student_model.dart';

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  /* var _students = [];

  void getStudents() async {
    try {
      final response = await http.get(
        Uri.parse("http://192.168.1.34:8000/api/students"),
      );
      final jsonData = jsonDecode(response.body) as List;
      setState(() {
        _students = jsonData;
      });
    } catch (e) {
      print(e);
    }
  } */

  List<Student> parseStudents(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Student>((json) => Student.fromJson(json)).toList();
  }

  Future<List<Student>> fetchStudents() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.34:8000/api/students'));

    if (response.statusCode == 200) {
      // Başarılı bir yanıt geldi, verileri işleyip diziye çevirelim.
      return parseStudents(response.body);
    } else {
      // İstek başarısız oldu, hata mesajını işleyin veya kullanıcıya gösterin.
      throw Exception('API isteği başarısız: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getStudents();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Student>>(
      future: fetchStudents(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Veriler alınamadı: ${snapshot.error}');
        } else {
          final students = snapshot.data;
          return ListView.builder(
            itemCount: students?.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(students?[index].name ?? ''),
                subtitle: Text(students?[index].department ?? ''),
                // Diğer özellikleri de göstermek için ekleme yapabilirsiniz.
              );
            },
          );
        }
      },
    );

    /* RefreshIndicator(
      onRefresh: () async {
        getStudents();
      },
      child: ListView.builder(
        itemCount: _students.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(
              _students[index]['name'] + ' ' + _students[index]['surname']),
          subtitle: Text(_students[index]['email'] ?? 'No email'),
          leading: CircleAvatar(
            child: _students[index]['imageUrl'] == null
                ? Text(_students[index]['name'][0])
                : ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Image.network(_students[index]['imageUrl']),
                  ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
        padding: const EdgeInsets.only(bottom: 20.0),
      ),
    ); */
  }
}
