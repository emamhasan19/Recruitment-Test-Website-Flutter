import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'quiz_data_source_impl.dart';

final quizDataSourceProvider = Provider<QuizDataSourceImpl>(
  (ref) {
    return QuizDataSourceImpl();
  },
);

abstract class QuizDataSource {
  Future<List<Map<String, dynamic>>> getQuestion();
}
