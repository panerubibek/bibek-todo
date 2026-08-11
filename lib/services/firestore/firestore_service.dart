import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TaskService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String get uid => FirebaseAuth.instance.currentUser!.uid;

  CollectionReference<Map<String, dynamic>> get _taskCollection =>
      _firestore.collection('users').doc(uid).collection('tasks');
    
  Future<void> addTask(String title, String description) async {
    await _taskCollection.add({
      'title': title,
      'description': description,
      'completed': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getTasks() {
    return _taskCollection
        .orderBy('createdAt', descending: false)
        .snapshots();
  }

  Future<void> updateTask(
    String taskId,
    bool completed,
  ) async {
    await _taskCollection.doc(taskId).update({
      'completed': completed,
    });
  }

  Future<void> deleteTask(String taskId) async {
    await _taskCollection.doc(taskId).delete();
  }
}