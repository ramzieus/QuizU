class QuizModel {
  String question;
  String a;
  String b;
  String c;
  String d;
  String correct;

  QuizModel.fromJson(Map<String, dynamic> data)
      : question = data['Question'],
        a = data['a'],
        b = data['b'],
        c = data['c'],
        d = data['d'],
        correct = data['correct'];
}
