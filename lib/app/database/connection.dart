import 'package:cuidapet/app/database/migrations/migrations_v2.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:cuidapet/app/database/migrations/migrations_v1.dart';
import 'package:synchronized/synchronized.dart';

class Connection {
  static const VERSION = 2;
  static const DATABASE_NAME = 'cuidapet_sqlite';
  
  Database _db;
  final _lock = Lock();
  static Connection _instance;

  Connection._();

  factory Connection() {
    _instance ??= Connection._();
    return _instance;
  }

  Future<Database> get instance async => await _openConnection();

  Future<Database> _openConnection() async {
    print(await getDatabasesPath());
    if (_db == null) {
      await _lock.synchronized(() async {
        if (_db == null) {
          var databasesPath = await getDatabasesPath();
          var path = join(databasesPath, DATABASE_NAME);
          _db = await openDatabase(
            path,
            version: VERSION,
            onConfigure: _onConfigure,
            onCreate: _onCreate,
            onUpgrade: _onUpgrade,
          );
        }
      });
    }

    return _db;
  }

  void closeConnection() {
    _db?.close();
    _db = null;
  }

  void _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  void _onCreate(Database db, int version) {
    var batch = db.batch();
    createV1(batch);
    createV2(batch);
    batch.commit();
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    var batch = db.batch();
    print(oldVersion);
    if(oldVersion < 2) {
      updateV2(batch);
    }

    batch.commit();
  }
}
