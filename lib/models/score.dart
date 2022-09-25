class Score {
  String score;
  String date;

  Score.fromJson(Map<String, dynamic> data)
      : score = data["score"],
        date = data["date"];
}
