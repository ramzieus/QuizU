import 'package:path/path.dart';
import 'package:quizu/models/score.dart';
import 'package:sqflite/sqflite.dart';

String databaseName = "quizu.db";

Future<Database> getDatabase() async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, databaseName);

  final Future<Database> database = openDatabase(
    path,
    version: 1,
    onCreate: (db, version) async {
      await db.execute(
          '''CREATE TABLE scores(id INTEGER PRIMARY KEY, date TEXT, score TEXT);''');
    },
  );
  return database;
}

createScore(int score) async {
  Database database = await getDatabase();
  String date = DateTime.now().toString();
  await database.insert('scores', {'date': date, 'score': '$score'});
  database.close();
}

getAllScores() async {
  List<Score> scores = [];
  Database database = await getDatabase();
  List<Map> list =
      await database.rawQuery('SELECT * FROM scores ORDER BY "ID" DESC');
  for (var element in list) {
    Score score = Score.fromJson(element as Map<String, dynamic>);
    scores.add(score);
  }
  database.close();
  return scores;
}

resetDb() async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, databaseName);
  databaseFactory.deleteDatabase(path);
}
