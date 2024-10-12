import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recruitment_test_website/core/services/routes/routes.dart';
import 'package:recruitment_test_website/core/theme/theme.dart';
import 'package:recruitment_test_website/core/utils/assets.dart';
import 'package:recruitment_test_website/core/widgets/primary_snackbar.dart';
import 'package:recruitment_test_website/features/recruitment_sessions/presentation/riverpods/recruitment_sessions_riverpod.dart';

class RecruitmentSessionsPage extends ConsumerStatefulWidget {
  const RecruitmentSessionsPage({super.key});

  @override
  ConsumerState<RecruitmentSessionsPage> createState() =>
      _RecruitmentSessionsPageState();
}

class _RecruitmentSessionsPageState
    extends ConsumerState<RecruitmentSessionsPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final notifier = ref.read(recruitmentSessionsProvider.notifier);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Scaffold(
          backgroundColor: UIColors.purple,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: size.height * .05),
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        Assets.recruitmentImage,
                        scale: 2,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * .05),
                  Container(
                    width: size.width,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'OPENINGS',
                            style: GoogleFonts.nunito(
                              color: UIColors.purple,
                              fontWeight: FontWeight.w800,
                              fontSize: size.height * .025,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        StreamBuilder(
                          stream: notifier.getAllOpenings(),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.waiting ||
                                snapshot.connectionState ==
                                    ConnectionState.none) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return Text(
                                'Error fetching data: ${snapshot.data}',
                              );
                            } else if (snapshot.hasData &&
                                snapshot.data?.docs.isEmpty == true) {
                              return const Center(
                                child: Text('No OPENINGS'),
                              );
                            } else {
                              final documents = snapshot.data?.docs;
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: documents?.length,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  DateTime startAt =
                                      documents[index]['starts_at'].toDate();
                                  DateTime endsAt =
                                      documents[index]['ends_at'].toDate();

                                  int durationInSeconds =
                                      endsAt.difference(startAt).inSeconds;
                                  bool isOnGoing = DateTime.now().isAfter(
                                          documents[index]['starts_at']
                                              .toDate()) &&
                                      DateTime.now().isBefore(
                                          documents[index]['ends_at'].toDate());

                                  bool isEnded = DateTime.now().isAfter(
                                      documents[index]['ends_at'].toDate());

                                  return Padding(
                                    padding: const EdgeInsets.only(top: 12.0),
                                    child: Container(
                                      width: size.width,
                                      padding: const EdgeInsets.all(16),
                                      margin: EdgeInsets.only(
                                        bottom: size.height * .01,
                                      ),
                                      decoration: BoxDecoration(
                                        color: UIColors.purpleLight
                                            .withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  documents[index]
                                                      ['session_name'],
                                                  style: GoogleFonts.nunito(
                                                    color: UIColors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        size.height * .025,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 5,
                                                ),
                                                SizedBox(
                                                  height: size.height * 0.01,
                                                ),
                                                Container(
                                                  width: 80,
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 4),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    border: Border.all(
                                                      color: isOnGoing
                                                          ? Colors.green
                                                          : isEnded
                                                              ? UIColors.red
                                                              : UIColors.gray,
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      isOnGoing
                                                          ? 'Ongoing'
                                                          : isEnded
                                                              ? 'Ended'
                                                              : 'Not Opened',
                                                      style: TextStyle(
                                                        color: isOnGoing
                                                            ? Colors.green
                                                            : isEnded
                                                                ? UIColors.red
                                                                : UIColors.gray,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              isOnGoing
                                                  ? _showExamPolicyDialog(
                                                      context,
                                                      durationInSeconds,
                                                      documents[index]
                                                          ['session_id'])
                                                  : isEnded
                                                      ? ShowSnackBarMessage
                                                          .showErrorSnackBar(
                                                          message:
                                                              'This session has ended',
                                                          context: context,
                                                        )
                                                      : ShowSnackBarMessage
                                                          .showErrorSnackBar(
                                                          message:
                                                              'This session has not been opened yet',
                                                          context: context,
                                                        );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              foregroundColor: UIColors.white,
                                              backgroundColor: UIColors.purple,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 12,
                                                horizontal: 16,
                                              ),
                                            ),
                                            child: const Text('Continue'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showExamPolicyDialog(
      BuildContext context, int durationInSeconds, String sessionId) {
    bool isChecked = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text(
                'Exam Policy:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width * 0.5,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Text(
                        '1. To start the exam, you must comply with the following conditions:\n\n'
                        '   - Share your screen during the entire duration of the exam. Please share the exam window only to start the exam\n'
                        '   - Turn on your video camera for monitoring purposes.\n\n'
                        '2. The exam will be automatically terminated under the following circumstances:\n\n'
                        '   - Any attempt to change tabs or navigate away from the exam.\n'
                        '   - If screen sharing is stopped during the exam.\n\n'
                        '3. Ensure a stable internet connection throughout the exam.',
                        style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Checkbox(
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value ?? false;
                              });
                            },
                          ),
                          const Text(
                            'I agree with the conditions',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    if (!isChecked) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Terms and Conditions'),
                            content: const Text(
                                'You need to accept the terms and policy to proceed.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Ok'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      final collectionRef =
                          FirebaseFirestore.instance.collection('leaderboard');

                      final querySnapshot = await collectionRef.get();

                      String userId = 'user${querySnapshot.docs.length + 1}';

                      FirebaseFirestore.instance
                          .collection('leaderboard')
                          .doc(userId)
                          .set({
                        'id': userId,
                        'mark': 0,
                        'session_id': sessionId
                      });

                      Navigator.of(context).pop();

                      Navigator.pushNamed(
                        context,
                        Routes.quiz,
                        arguments: {
                          'duration': durationInSeconds,
                          'sessionId': sessionId,
                          'userId': userId,
                        },
                      );
                    }
                  },
                  child: const Text(
                    'Ok',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

// void _showExamPolicyDialog(
  //     BuildContext context, int durationInSeconds, String sessionId) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text(
  //           'Exam Policy:',
  //           style: TextStyle(
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         content: SizedBox(
  //           height: MediaQuery.of(context).size.height * 0.6,
  //           width: MediaQuery.of(context).size.width * 0.5,
  //           child: const Text(
  //             '1. To start the exam, you must comply with the following conditions:\n\n'
  //             '   - Share your screen during the entire duration of the exam. Please share the exam window only to start the exam\n'
  //             '   - Turn on your video camera for monitoring purposes.\n\n'
  //             '2. The exam will be automatically terminated under the following circumstances:\n\n'
  //             '   - Any attempt to change tabs or navigate away from the exam.\n'
  //             '   - If screen sharing is stopped during the exam.\n\n'
  //             '3. Ensure a stable internet connection throughout the exam.',
  //             style: TextStyle(
  //               fontSize: 16,
  //               fontStyle: FontStyle.italic,
  //             ),
  //           ),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text(
  //               'Cancel',
  //               style: TextStyle(
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 16,
  //               ),
  //             ),
  //           ),
  //           TextButton(
  //             onPressed: () async {
  //               final collectionRef =
  //                   FirebaseFirestore.instance.collection('leaderboard');
  //
  //               final querySnapshot = await collectionRef.get();
  //
  //               String userId = 'user${querySnapshot.docs.length + 1}';
  //
  //               FirebaseFirestore.instance
  //                   .collection('leaderboard')
  //                   .doc(userId)
  //                   .set({'id': userId, 'mark': 0, 'session_id': sessionId});
  //
  //               Navigator.of(context).pop();
  //
  //               Navigator.pushNamed(
  //                 context,
  //                 Routes.quiz,
  //                 arguments: {
  //                   'duration': durationInSeconds,
  //                   'sessionId': sessionId,
  //                   'userId': userId,
  //                 },
  //               );
  //             },
  //             child: const Text(
  //               'Ok',
  //               style: TextStyle(
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 16,
  //               ),
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
