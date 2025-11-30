import 'package:studententrymobileapp/model/student_model_class.dart';
import 'package:studententrymobileapp/main.dart';
import 'package:flutter/material.dart';

class StudentInfoMainPage extends StatefulWidget {
  const StudentInfoMainPage({super.key});

  @override
  State<StudentInfoMainPage> createState() => _StudentInfoMainPageState();
}

class _StudentInfoMainPageState extends State<StudentInfoMainPage> {
  // List<Map<dynamic, dynamic>> list = [
  //   {
  //     'rollNo': 10,
  //     'name': 'Pavan',
  //     'mobileNo': 8805900568,
  //     'emailId': 'pavan.pawar@gmail.com',
  //   },
  //   {
  //     'rollNo': 10,
  //     'name': 'Pavan',
  //     'mobileNo': 8805900568,
  //     'emailId': 'pavan.pawar@gmail.com',
  //   },
  //   {
  //     'rollNo': 10,
  //     'name': 'Pavan',
  //     'mobileNo': 8805900568,
  //     'emailId': 'pavan.pawar@gmail.com',
  //   },
  //   {
  //     'rollNo': 10,
  //     'name': 'Pavan',
  //     'mobileNo': 8805900568,
  //     'emailId': 'pavan.pawar@gmail.com',
  //   },
  // ];
  List<StudentModelClass> allStudents = [];
  final TextEditingController rollNoController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  @override
  void initState() {
    super.initState();
    readDataFromDatabse();
  }

  @override
  void dispose() {
    super.dispose();
    rollNoController.dispose();
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 50),
            appBarWidget(),
            SizedBox(height: 15),
            listViewWidget(),
          ],
        ),
      ),
    );
  }

  Widget appBarWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(width: 40),
        Container(
          height: 40,
          width: 180,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(244, 67, 54, 0.8),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
            child: Text(
              'Student Info',
              style: TextStyle(fontSize: 15, letterSpacing: -0.27, height: 0),
            ),
          ),
        ),
        addButtonwidget(),
      ],
    );
  }

  Widget listViewWidget() {
    if (allStudents.isEmpty) {
      return SizedBox(
        height: MediaQuery.sizeOf(context).height - 140,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'No student List available for this moment.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, letterSpacing: -0.27, height: 0),
              ),
            ),
            SizedBox(height: 25),
            CircularProgressIndicator(color: Colors.red),
          ],
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        height: MediaQuery.sizeOf(context).height - 140,
        child: ListView.separated(
          padding: EdgeInsets.zero,
          physics: ClampingScrollPhysics(),
          // itemCount: list.length,
          itemCount: allStudents.length,
          itemBuilder: (context, index) {
            return Container(
              height: 210,
              width: 200,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromRGBO(158, 158, 158, 0.5),
              ),
              child: studentCardwidget(index),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 15);
          },
        ),
      );
    }
  }

  Widget studentCardwidget(int index) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              // 'Student Roll No      : ${list[index]['rollNo']}',
              'Student Roll No      : ${allStudents[index].rollNo}',
              style: TextStyle(fontSize: 15, letterSpacing: -0.27, height: 0),
            ),
          ],
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Text(
              // 'Student Name        : ${list[index]['name']}',
              'Student Name        : ${allStudents[index].name}',
              style: TextStyle(fontSize: 15, letterSpacing: -0.27, height: 0),
            ),
          ],
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Text(
              // 'Student Mobile No : ${list[index]['mobileNo']}',
              'Student Mobile No : ${allStudents[index].mobileNo}',
              style: TextStyle(fontSize: 15, letterSpacing: -0.27, height: 0),
            ),
          ],
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Text(
              // 'Student Email Id     : ${list[index]['emailId']}',
              'Student Email Id     : ${allStudents[index].emailId}',
              style: TextStyle(fontSize: 15, letterSpacing: -0.27, height: 0),
            ),
          ],
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [editButttonWidget(index), deleteButttonWidget(index)],
        ),
      ],
    );
  }

  Widget addButtonwidget() {
    return InkWell(
      onTap: () {
        rollNoController.text = ''.toString();
        nameController.text = ''.toString();
        mobileController.text = ''.toString();
        emailController.text = ''.toString();
        showDialogWithAddFunctionality();
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.green,
        ),
        child: Icon(Icons.add, size: 22),
      ),
    );
  }

  Widget editButttonWidget(int index) {
    return InkWell(
      onTap: () {
        rollNoController.text = allStudents[index].rollNo.toString();
        nameController.text = allStudents[index].name.toString();
        mobileController.text = allStudents[index].mobileNo.toString();
        emailController.text = allStudents[index].emailId.toString();
        _showUpdateStudentDialog(allStudents[index]);
      },
      child: Container(
        width: 120,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.blue,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Edit',
              style: TextStyle(fontSize: 15, letterSpacing: -0.27, height: 0),
            ),
            Icon(Icons.edit),
          ],
        ),
      ),
    );
  }

  Widget deleteButttonWidget(int index) {
    return InkWell(
      onTap: () {
        deleteStudentEntry(index);
      },
      child: Container(
        width: 120,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.red,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Delete',
              style: TextStyle(fontSize: 15, letterSpacing: -0.27, height: 0),
            ),
            Icon(Icons.clear),
          ],
        ),
      ),
    );
  }

  void readDataFromDatabse() async {
    allStudents = await db.getAllStudents();
    setState(() {});
  }

  void updateStudentEntry(int index) async {
    await db.updateStudent(
      StudentModelClass(
        rollNo: allStudents[index].rollNo,
        name: allStudents[index].name,
        mobileNo: allStudents[index].mobileNo,
        emailId: allStudents[index].emailId,
      ),
    );
    if (mounted) {
      readDataFromDatabse();
    }
  }

  void deleteStudentEntry(int index) async {
    await db.deleteStudent(allStudents[index].rollNo);
    if (mounted) {
      readDataFromDatabse();
    }
  }

  void showDialogWithAddFunctionality() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Student"),
          content: SizedBox(
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: rollNoController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Roll No'),
                ),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: mobileController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(labelText: 'Mobile No'),
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                if (rollNoController.text.isEmpty ||
                    nameController.text.isEmpty ||
                    mobileController.text.isEmpty ||
                    emailController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("All fields are required")),
                  );
                  return;
                }

                StudentModelClass student = StudentModelClass(
                  rollNo: int.parse(rollNoController.text),
                  name: nameController.text,
                  mobileNo: int.parse(mobileController.text),
                  emailId: emailController.text,
                );

                await db.insertStudent(student);
                if (mounted) {
                  Navigator.pop(context);
                  readDataFromDatabse(); // refresh UI method
                }
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void _showUpdateStudentDialog(StudentModelClass student) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Update Student"),
          content: SizedBox(
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  enabled: false, // Roll No cannot be changed
                  controller: rollNoController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Roll No'),
                ),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: mobileController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(labelText: 'Mobile No'),
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                if (nameController.text.isEmpty ||
                    mobileController.text.isEmpty ||
                    emailController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("All fields except Roll No are required"),
                    ),
                  );
                  return;
                }

                StudentModelClass updatedStudent = StudentModelClass(
                  rollNo: student.rollNo, // Keep original roll no
                  name: nameController.text,
                  mobileNo: int.parse(mobileController.text),
                  emailId: emailController.text,
                );

                await db.updateStudent(updatedStudent);

                if (mounted) {
                  Navigator.pop(context);
                  readDataFromDatabse(); // refresh UI method
                }
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }
}
