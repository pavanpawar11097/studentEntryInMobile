import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:studententrymobileapp/student_databse.dart';
import 'package:studententrymobileapp/student_info_main_page.dart';
import 'package:studententrymobileapp/student_model_class.dart';

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const StudentInfoMainPage(),
    );
  }
}
