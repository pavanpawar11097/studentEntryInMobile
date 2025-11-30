class StudentModelClass {
  final int rollNo;
  final String name;
  final int mobileNo;
  final String emailId;

  StudentModelClass({
    required this.rollNo,
    required this.name,
    required this.mobileNo,
    required this.emailId,
  });
 
  Map<String, dynamic> toMap() {
    return {
      'rollNo': rollNo,
      'name': name,
      'mobileNo': mobileNo,
      'emailId': emailId,
    };
  }

  factory StudentModelClass.fromMap(Map<String, dynamic> map) {
    return StudentModelClass(
      rollNo: map['rollNo'],
      name: map['name'],
      mobileNo: map['mobileNo'],
      emailId: map['emailId'],
    );
  }
}
