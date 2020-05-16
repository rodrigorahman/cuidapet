import 'package:sqflite/sqflite.dart';

void createV1(Batch batch) {
  batch.execute('''
    CREATE TABLE address (
      id Integer primary key autoincrement,
      address varchar(1000) not null,
      latitude varchar(1000),
      longitude varchar(1000))
  ''');
}