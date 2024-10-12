part of 'quiz_data_source.dart';

class QuizDataSourceImpl extends QuizDataSource {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Future<List<Map<String, dynamic>>> getQuestion() async {
    List<Map<String, dynamic>> questionList = [];

    final querySnapshot = await db.collection('demo_questions').get();
    questionList = querySnapshot.docs.map((doc) => doc.data()).toList();

    return questionList;
  }
}
