import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class AttendanceRecordScreen extends StatefulWidget {
  const AttendanceRecordScreen({Key? key}) : super(key: key);

  @override
  _AttendanceRecordScreenState createState() => _AttendanceRecordScreenState();
}

class _AttendanceRecordScreenState extends State<AttendanceRecordScreen> {
  String? selectedCourse;
  List<String> courses = [];
  List<Map<String, dynamic>> attendanceRecords = [];

  final String studentID = FirebaseAuth.instance.currentUser?.uid ?? 'unknown';

  @override
  void initState() {
    super.initState();
    _loadCourses();
  }

  // Fetch all course names from Firestore
  Future<void> _loadCourses() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('courses').get();
      setState(() {
        courses = snapshot.docs.map((doc) => doc['name'] as String).toList();
      });
    } catch (e) {
      print('Error loading courses: $e');
    }
  }

  // Fetch attendance records for selected course and logged-in student
  Future<void> _loadAttendanceRecords() async {
    if (selectedCourse == null) return;

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('attendance')
          .where('studentID', isEqualTo: studentID)
          .where('courseID', isEqualTo: selectedCourse)
          .get();

      setState(() {
        attendanceRecords = snapshot.docs.map((doc) {
          return {
            'courseID': doc['courseID'],
            'timestamp': doc['timestamp'].toDate(),
            'status': doc['status'],
            'rssi': doc['rssi'],
          };
        }).toList();
      });
    } catch (e) {
      print('Error loading attendance records: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Records'),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Dropdown to select course
            DropdownButtonFormField<String>(
              value: selectedCourse,
              decoration: const InputDecoration(
                labelText: 'Select Course',
                border: OutlineInputBorder(),
              ),
              items: courses.map((course) {
                return DropdownMenuItem<String>(
                  value: course,
                  child: Text(course),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCourse = value;
                  attendanceRecords = [];
                });
                _loadAttendanceRecords();
              },
            ),
            const SizedBox(height: 30),

            // Display attendance records
            Expanded(
              child: attendanceRecords.isEmpty
                  ? const Center(child: Text('No attendance records available.'))
                  : ListView.builder(
                itemCount: attendanceRecords.length,
                itemBuilder: (context, index) {
                  final record = attendanceRecords[index];
                  String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(record['timestamp']);
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(record['courseID']),
                      subtitle: Text(
                        'Date: $formattedDate\nStatus: ${record['status']} - RSSI: ${record['rssi']}',
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}