import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recruitment_test_website/core/base/state.dart';

class RecruitmentSessionsNotifier extends Notifier<BaseState> {
  late final FirebaseFirestore db;

  @override
  BaseState build() {
    db = FirebaseFirestore.instance;
    return const BaseState();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllOpenings() {
    return db.collection('recruitment_sessions').snapshots();
  }
}
