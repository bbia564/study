import 'package:faker/faker.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:study_work/db_study_work/study_entity.dart';

class DBStudyWork extends GetxService {
  late Database dbBase;
  final faker = Faker();

  Future<DBStudyWork> init() async {
    await createStudyDB();
    return this;
  }

  createStudyDB() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'study.db');

    dbBase = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await createStudyTable(db);
          await _initData(db);
        });
  }

  createStudyTable(Database db) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS study (id INTEGER PRIMARY KEY, created_time TEXT, type INTEGER, title TEXT, end_time TEXT, color_index INTEGER, is_done INTEGER)');
  }

  _initData(Database db) async {
    await db.insert('study', {
      'created_time': DateTime.now().add(const Duration(minutes: 2)).toIso8601String(),
      'type': 0,
      'title': 'Work for...',
      'end_time': DateTime.now().add(const Duration(hours: 2)).toIso8601String(),
      'color_index': faker.randomGenerator.integer(5),
      'is_done': 0,
    });
    await db.insert('study', {
      'created_time': DateTime.now().add(const Duration(minutes: 2)).toIso8601String(),
      'type': 1,
      'title': 'Study for...',
      'end_time': DateTime.now().add(const Duration(hours: 3)).toIso8601String(),
      'color_index': faker.randomGenerator.integer(5),
      'is_done': 1,
    });

    await db.insert('study', {
      'created_time': DateTime.now().add(const Duration(minutes: 2)).toIso8601String(),
      'type': 0,
      'title': 'Work for...',
      'end_time': DateTime.now().add(const Duration(days: 2)).toIso8601String(),
      'color_index': faker.randomGenerator.integer(5),
      'is_done': 0,
    });
    await db.insert('study', {
      'created_time': DateTime.now().add(const Duration(minutes: 3)).toIso8601String(),
      'type': 1,
      'title': 'Study for...',
      'end_time': DateTime.now().add(const Duration(days: 3)).toIso8601String(),
      'color_index': faker.randomGenerator.integer(5),
      'is_done': 1,
    });

  }

  updateAlarm(StudyEntity entity) async {
    await dbBase.update(
        'study',
        {
          'type': entity.type,
          'title': entity.title,
          'end_time': entity.endTime.toIso8601String(),
          'color_index': entity.colorIndex,
          'is_done': entity.isDone,
        },
        where: 'id = ?',
        whereArgs: [entity.id]);
  }

  cleanAllData() async {
    await dbBase.delete('study');
  }

  Future<List<StudyEntity>> getAllData() async {
    var result = await dbBase.query('study', orderBy: 'created_time ASC');
    return result.map((e) => StudyEntity.fromJson(e)).toList();
  }
}
