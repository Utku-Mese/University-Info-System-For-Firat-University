class Lesson {
  int? id;
  String? name;
  String? shortName;
  String? descriptions;
  int? grade;
  int? credit;
  int? obligation;
  String? instructor;

  Lesson(
      {this.id,
      this.name,
      this.shortName,
      this.descriptions,
      this.grade,
      this.credit,
      this.obligation,
      this.instructor});

  Lesson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortName = json['shortName'];
    descriptions = json['descriptions'];
    grade = json['grade'];
    credit = json['credit'];
    obligation = json['obligation'];
    instructor = json['instructor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['shortName'] = shortName;
    data['descriptions'] = descriptions;
    data['grade'] = grade;
    data['credit'] = credit;
    data['obligation'] = obligation;
    data['instructor'] = instructor;
    return data;
  }
}
