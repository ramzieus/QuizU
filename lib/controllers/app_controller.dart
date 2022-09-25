import 'package:dio/dio.dart';
import 'package:quizu/db/database.dart';
import 'package:quizu/models/quiz.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Controller {
  static BaseOptions options = BaseOptions(
    baseUrl: 'https://quizu.okoul.com',
    connectTimeout: 5000,
    receiveTimeout: 3000,
    validateStatus: (_) => true,
  );
  static Dio dio = Dio(options);

  Future<bool> checkToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    dio.options.headers = {'Authorization': 'Bearer $token'};
    Response response = await dio.get('/Token');
    return response.data["success"];
  }

  Future<Map> login({required String otp, required String mobile}) async {
    final prefs = await SharedPreferences.getInstance();
    dio.options.headers['Authorization'] = null;
    Response response =
        await dio.post('/Login', data: {"OTP": otp, "mobile": mobile});
    if (response.data['success']) {
      prefs.setString('token', response.data['token']);
    }
    return response.data;
  }

  logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    resetDb();
  }

  setName({required String name}) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    dio.options.headers = {'Authorization': 'Bearer $token'};
    dio.post('/Name', data: {"name": name});
  }

  getLeaderboard() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    dio.options.headers = {'Authorization': 'Bearer $token'};
    try {
      Response response = await dio.get('/TopScores');
      return response;
    } catch (e) {
      return false;
    }
  }

  getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    dio.options.headers = {'Authorization': 'Bearer $token'};
    try {
      Response response = await dio.get('/UserInfo');
      return response;
    } catch (e) {
      return false;
    }
  }

  getQuestions() async {
    List<QuizModel> quizzes = [];
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    dio.options.headers = {'Authorization': 'Bearer $token'};
    Response response = await dio.get('/Questions');
    response.data.forEach((item) {
      QuizModel quiz = QuizModel.fromJson(item);
      quizzes.add(quiz);
    });
    return quizzes;
  }

  setScore(int score) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    dio.options.headers = {'Authorization': 'Bearer $token'};
    dio.post('/Score', data: {"score": "$score"});
    createScore(score);
  }
}
