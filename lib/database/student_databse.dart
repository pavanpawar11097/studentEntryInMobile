import 'package:studententrymobileapp/model/student_model_class.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';

class StudentDatabase {
  static final StudentDatabase instance = StudentDatabase._init();
  static Database? _database;

  StudentDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('students.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    Directory directory = await getApplicationSupportDirectory();
    // String path = join(directory.path, 'students.db');
    final path = '${directory.path}/students.db';
    // final dbPath = await getDatabasesPath();
    // final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE students (
        rollNo INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        mobileNo INTEGER NOT NULL,
        emailId TEXT NOT NULL
      )
    ''');
  }

  // ---------- CRUD OPERATIONS ---------- //

  Future<int> insertStudent(StudentModelClass student) async {
    final db = await instance.database;
    return await db.insert(
      'students',
      student.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<StudentModelClass>> getAllStudents() async {
    final db = await instance.database;
    final result = await db.query('students');
    return result.map((json) => StudentModelClass.fromMap(json)).toList();
  }

  Future<StudentModelClass?> getStudentByRollNo(int rollNo) async {
    final db = await instance.database;
    final result = await db.query(
      'students',
      where: 'rollNo = ?',
      whereArgs: [rollNo],
    );

    if (result.isNotEmpty) {
      return StudentModelClass.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<int> updateStudent(StudentModelClass student) async {
    final db = await instance.database;

    return await db.update(
      'students',
      student.toMap(),
      where: 'rollNo = ?',
      whereArgs: [student.rollNo],
    );
  }

  Future<int> deleteStudent(int rollNo) async {
    final db = await instance.database;

    return await db.delete(
      'students',
      where: 'rollNo = ?',
      whereArgs: [rollNo],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
