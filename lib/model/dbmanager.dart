import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Student {
  int id;
  String name;
  String course;
  Student({required this.name, required this.course, required this.id});
  Map<String, dynamic> toMap() {
    return {'name': name, 'course': course};
  }
}

class DbStudentManager {
  Database? _database;

  Future openDb() async {
    _database ??= await openDatabase(
          join(await getDatabasesPath(), "student.db"),
          version: 1, onCreate: (Database db, int version) async {
        await db.execute(
            "CREATE TABLE student(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, course TEXT)");
      });
  }

  Future<int> insertStudent(Student student) async {
    await openDb();
    return await _database!.insert('student', student.toMap());
  }

  Future<List<Student>> getStudentList() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database!.query('student');
    return List.generate(
        maps.length,
            (index) => Student(
            id: maps[index]['id'],
            name: maps[index]['name'],
            course: maps[index]['course']));
  }

  Future<int> updateStudent(Student student) async {
    await openDb();
    return await _database!.update('student', student.toMap(),
        where: 'id=?', whereArgs: [student.id]);
  }

  Future<int> deleteStudent(int id) async {
    await openDb();
    return await _database!.delete('student', where: 'id=?', whereArgs: [id]);
  }
}
