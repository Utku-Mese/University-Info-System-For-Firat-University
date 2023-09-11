class Instructor {
  int? id;
  String? name;
  String? surname;
  String? degree;
  String? gender;
  String? department;
  String? email;
  String? phoneNumber;
  String? adress;
  int? isActive;
  String? imageUrl;

  Instructor(
      {this.id,
      this.name,
      this.surname,
      this.degree,
      this.gender,
      this.department,
      this.email,
      this.phoneNumber,
      this.adress,
      this.isActive,
      this.imageUrl});

  Instructor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    surname = json['surname'];
    degree = json['degree'];
    gender = json['gender'];
    department = json['department'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    adress = json['adress'];
    isActive = json['isActive'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['surname'] = surname;
    data['degree'] = degree;
    data['gender'] = gender;
    data['department'] = department;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['adress'] = adress;
    data['isActive'] = isActive;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
