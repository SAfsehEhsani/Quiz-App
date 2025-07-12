import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBService {
  static Database? _db;

  // Open or create the database
  static Future<Database> getDatabase() async {
    if (_db != null) return _db!;
    String path = join(await getDatabasesPath(), 'quiz.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE scores(id INTEGER PRIMARY KEY AUTOINCREMENT, score INTEGER)',
        );
      },
    );
    return _db!;
  }

  // Insert a score into the database
  static Future<void> insertScore(int score) async {
    final db = await getDatabase();
    await db.insert(
      'scores',
      {'score': score},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get all scores from the database, ordered by latest
  static Future<List<int>> getScores() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(
      'scores',
      orderBy: 'id DESC',
    );

    return List.generate(maps.length, (i) => maps[i]['score'] as int);
  }
}

