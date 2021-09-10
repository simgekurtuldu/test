import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  Future<void> addTestData(Map testData, String testId) async {
    await FirebaseFirestore.instance.collection('Test').doc(testId).set(testData).catchError((e) {
      print(e.toString());
    });
  }

  Future<void> addQuestionData(Map questionData, String testId) async {
    await FirebaseFirestore.instance.collection('Test').doc(testId).collection('QNA').add(questionData).catchError((e) {
      print(e);
    });
  }

  getTestsData() async {
    return await FirebaseFirestore.instance.collection('Test').snapshots();
  }

  getTestData(String testId) async {
    return await FirebaseFirestore.instance.collection('Test').doc(testId).collection('QNA').get();
  }
}
