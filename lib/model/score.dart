class Score {
  int id;
  String nameUser;
  String categories;
  int score;
  String date;
  int totalAnswer;
  int totalQuestion;

  Score(
      {this.id,
        this.nameUser,
        this.categories,
        this.score,
        this.date,
        this.totalAnswer,
        this.totalQuestion});

  Score.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameUser = json['nameUser'];
    categories = json['categories'];
    score = json['score'];
    date = json['date'];
    totalAnswer = json['totalAnswer'];
    totalQuestion = json['totalQuestion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nameUser'] = this.nameUser;
    data['categories'] = this.categories;
    data['score'] = this.score;
    data['date'] = this.date;
    data['totalAnswer'] = this.totalAnswer;
    data['totalQuestion'] = this.totalQuestion;
    return data;
  }
}