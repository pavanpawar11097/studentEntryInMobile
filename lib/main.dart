import 'package:studententrymobileapp/database/student_databse.dart';
import 'package:studententrymobileapp/screen_or_ui_pages/my_app.dart';
import 'package:flutter/material.dart';

final db = StudentDatabase.instance;

// void main() async {
//   final student = StudentModelClass(
//     rollNo: 101,
//     name: "Pavan",
//     mobileNo: 9876543210,
//     emailId: "test@gmail.com",
//   );

//   await db.insertStudent(student);

//   final allStudents = await db.getAllStudents();
//   print(allStudents);

//   final fetched = await db.getStudentByRollNo(101);
//   print(fetched?.name);

//   await db.updateStudent(
//     StudentModelClass(
//       rollNo: 101,
//       name: "Pavan Updated",
//       mobileNo: 9876543210,
//       emailId: "new@gmail.com",
//     ),
//   );

//   await db.deleteStudent(101);
// }

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // IMPORTANT: Initialize DB for Desktop
  // required for Windows/macOS/Linux
  // sqfliteFfiInit();
  // databaseFactory = databaseFactoryFfi;
  runApp(const MyApp());
}
