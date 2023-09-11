class Student {
  int? id;
  String? name;
  String? surname;
  String? gender;
  String? department;
  String? grade;
  String? email;
  String? phoneNumber;
  String? adress;
  double? gpa;
  int? isActive;
  String? imageUrl;

  Student(
      {this.id,
      this.name,
      this.surname,
      this.gender,
      this.department,
      this.grade,
      this.email,
      this.phoneNumber,
      this.adress,
      this.gpa,
      this.isActive,
      this.imageUrl});

  Student.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    surname = json['surname'];
    gender = json['gender'];
    department = json['department'];
    grade = json['grade'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    adress = json['adress'];
    gpa = json['gpa'];
    isActive = json['isActive'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['surname'] = surname;
    data['gender'] = gender;
    data['department'] = department;
    data['grade'] = grade;
    data['phoneNumber'] = phoneNumber;
    data['adress'] = adress;
    data['gpa'] = gpa;
    data['isActive'] = isActive;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
