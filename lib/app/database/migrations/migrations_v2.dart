import 'package:sqflite/sqflite.dart';

void createV2(Batch batch) {
  batch.execute('''
    alter TABLE address add 
      complemento varchar(1000)
  ''');
}


void updateV2(Batch batch) {
  batch.execute('''
    alter TABLE address add 
      complemento varchar(1000)
  ''');
}