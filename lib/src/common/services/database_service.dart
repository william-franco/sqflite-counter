import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

abstract interface class DatabaseService {
  Future<Database> get database;

  Future<void> initDatabase();
}

class DatabaseServiceImpl implements DatabaseService {
  Database? _database;

  @override
  Future<void> initDatabase() async {
    if (_database != null) return;

    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "app_database.db");

    _database = await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  @override
  Future<Database> get database async {
    if (_database == null) {
      await initDatabase();
    }
    return _database!;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        value INTEGER NOT NULL,
        createdAt TEXT NOT NULL
      )
    ''');
  }
}
