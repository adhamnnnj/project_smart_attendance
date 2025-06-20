import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // 🔹 1. Add Student Profile
  Future<void> addStudentProfile(String uid, String name, String email) async {
    await _db.collection('students').doc(uid).set({
      'name': name,
      'email': email,
    });
  }

  // 🔹 2. Add Beacon Data
  Future<void> addBeaconData(String uuid, String course, DateTime startTime, DateTime endTime) async {
    await _db.collection('beacons').doc(uuid).set({
      'course': course,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
    });
  }

  // 🔹 3. Add Attendance Record
  Future<void> addAttendanceRecord({
    required String studentUid,
    required String beaconUuid,
    required DateTime timestamp,
    required String status,
  }) async {
    await _db.collection('attendance').add({
      'studentUid': studentUid,
      'beaconUuid': beaconUuid,
      'timestamp': timestamp.toIso8601String(),
      'status': status,
    });
  }
}
