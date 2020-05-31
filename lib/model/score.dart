class Score {
  int id;
  String nameUser;
  String categories;
  int score;

  Score({this.id, this.nameUser, this.categories, this.score});

  Score.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameUser = json['nameUser'];
    categories = json['categories'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nameUser'] = this.nameUser;
    data['categories'] = this.categories;
    data['score'] = this.score;
    return data;
  }
}
