import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rewint/configs/themes/app_colors.dart';
import 'package:rewint/models/alphabet_model.dart';
import 'package:rewint/widgets/botnavbar.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class WordSpellScreen extends StatefulWidget {
  const WordSpellScreen({Key? key}) : super(key: key);
  static const String routeName = '/word-spell';

  @override
  State<WordSpellScreen> createState() => _WordSpellScreenState();
}

class _WordSpellScreenState extends State<WordSpellScreen> {
  FirebaseFirestore users = FirebaseFirestore.instance;
  User? currUser = FirebaseAuth.instance.currentUser;
  List<AlphabetModel> words = [
    AlphabetModel(title: 'Berlari', answer: 'berlari', isDone: false),
    AlphabetModel(title: 'Makan', answer: 'makan', isDone: false),
    AlphabetModel(title: 'Minum', answer: 'minum', isDone: false),
    AlphabetModel(title: 'Tidur', answer: 'tidur', isDone: false),
    AlphabetModel(title: 'Mandi', answer: 'mandi', isDone: false),
    AlphabetModel(title: 'Mobil', answer: 'mobil', isDone: false),
  ];
  List<AlphabetModel> alphabets = [
    AlphabetModel(title: 'A', answer: 'A', isDone: false),
    AlphabetModel(title: 'B', answer: 'B', isDone: false),
    AlphabetModel(title: 'C', answer: 'C', isDone: false),
    AlphabetModel(title: 'D', answer: 'D', isDone: false),
    AlphabetModel(title: 'E', answer: 'E', isDone: false),
    AlphabetModel(title: 'F', answer: 'F', isDone: false),
    AlphabetModel(title: 'G', answer: 'G', isDone: false),
    AlphabetModel(title: 'H', answer: 'H', isDone: false),
    AlphabetModel(title: 'I', answer: 'I', isDone: false),
    AlphabetModel(title: 'J', answer: 'J', isDone: false),
    AlphabetModel(title: 'K', answer: 'K', isDone: false),
    AlphabetModel(title: 'L', answer: 'L', isDone: false),
    AlphabetModel(title: 'M', answer: 'M', isDone: false),
    AlphabetModel(title: 'N', answer: 'N', isDone: false),
    AlphabetModel(title: 'O', answer: 'O', isDone: false),
    AlphabetModel(title: 'P', answer: 'P', isDone: false),
    AlphabetModel(title: 'Q', answer: 'Q', isDone: false),
    AlphabetModel(title: 'R', answer: 'R', isDone: false),
    AlphabetModel(title: 'S', answer: 'S', isDone: false),
    AlphabetModel(title: 'T', answer: 'T', isDone: false),
    AlphabetModel(title: 'U', answer: 'U', isDone: false),
    AlphabetModel(title: 'V', answer: 'V', isDone: false),
    AlphabetModel(title: 'W', answer: 'W', isDone: false),
    AlphabetModel(title: 'X', answer: 'X', isDone: false),
    AlphabetModel(title: 'Y', answer: 'Y', isDone: false),
    AlphabetModel(title: 'Z', answer: 'Z', isDone: false),
  ];
  int _index = 0;
  bool isWords = false;

  final SpeechToText speech = SpeechToText();
  String lastStatus = '';
  String _currentLocaleId = '';
  String lastWords = '';
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  double level = 0.0;

  FlutterTts? flutterTts;

  Future<void> disposeSpeech() async {
    await speech.stop();
    await speech.cancel();
    print('MASUK DISPOSE INI');
  }

  Future<void> initTts() async {
    flutterTts = FlutterTts();
    await _setAwaitOptions();
    await _getDefaultEngine();
  }

  Future<void> _getDefaultEngine() async {
    var engine = await flutterTts!.getDefaultEngine;
    if (engine != null) {
      // ignore: avoid_print
      print(engine);
    }
  }

  Future<void> _setAwaitOptions() async {
    await flutterTts!.awaitSpeakCompletion(true);
  }

  Future<void> _speak(String text) async {
    await flutterTts!.setLanguage('id');
    await flutterTts!.setSpeechRate(0);
    await flutterTts!.setVolume(1);
    await flutterTts!.speak(text);
  }

  Future<void> initSpeechState() async {
    try {
      var hasSpeech = await speech.initialize(
        onStatus: statusListener,
        debugLogging: true,
      );

      if (hasSpeech) {
        print('MASUK HASSPEECH');
        // Get the list of languages installed on the supporting platform so they
        // can be displayed in the UI for selection by the user.

        var systemLocale = await speech.systemLocale();
        _currentLocaleId = 'in_ID';
        // _currentLocaleId = systemLocale?.localeId ?? '';
      } else {
        print('GAK MASUK');
      }
      if (!mounted) return;

      setState(() {});
    } catch (e) {
      setState(() {});
    }
  }

  Future<void> startListening() async {
    lastWords = '';
    // Note that `listenFor` is the maximum, not the minimun, on some
    // systems recognition will be stopped before this value is reached.
    // Similarly `pauseFor` is a maximum not a minimum and may be ignored
    // on some devices.
    await speech.listen(
        onResult: resultListener,
        listenFor: const Duration(seconds: 30),
        pauseFor: const Duration(seconds: 5),
        partialResults: true,
        localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        listenMode: ListenMode.confirmation);
    setState(() {});
  }

  void resultListener(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });

    if (result.finalResult) {
      isWords
          ? lastWords.toLowerCase() == words[_index].answer
              ? currUser?.email?.isEmpty == null
                  ? AwesomeDialog(
                      context: context,
                      animType: AnimType.LEFTSLIDE,
                      headerAnimationLoop: false,
                      dialogType: DialogType.SUCCES,
                      showCloseIcon: true,
                      title: 'Yay! Ucapanmu Benar',
                      desc: 'no point (mohon login terlebih dahulu)',
                      btnOkOnPress: () {
                        debugPrint('OnClcik');
                      },
                      btnOkIcon: Icons.check_circle,
                      onDissmissCallback: (type) {
                        debugPrint('Dialog Dissmiss from callback $type');
                        setState(() {
                          words[_index].isDone = true;
                          _index = ++_index;
                        });
                      },
                    ).show()
                  : AwesomeDialog(
                      context: context,
                      animType: AnimType.LEFTSLIDE,
                      headerAnimationLoop: false,
                      dialogType: DialogType.SUCCES,
                      showCloseIcon: true,
                      title: 'Yay! Ucapanmu Benar',
                      desc: 'point +10',
                      btnOkOnPress: () {
                        debugPrint('OnClcik');
                      },
                      btnOkIcon: Icons.check_circle,
                      onDissmissCallback: (type) async {
                        await users
                            .collection('users')
                            .doc(currUser?.email)
                            .update({
                          'point': FieldValue.increment(10),
                        });
                        debugPrint('Dialog Dissmiss from callback $type');
                        setState(() {
                          words[_index].isDone = true;
                          _index = ++_index;
                        });
                      },
                    ).show()
              : AwesomeDialog(
                  context: context,
                  animType: AnimType.LEFTSLIDE,
                  headerAnimationLoop: false,
                  dialogType: DialogType.ERROR,
                  showCloseIcon: true,
                  title: '"${words[_index].title}" ya bukan "$lastWords"',
                  desc: 'coba lagi yuk!',
                  btnOkOnPress: () {
                    debugPrint('OnClcik');
                  },
                  btnOkIcon: Icons.check_circle,
                  onDissmissCallback: (type) {
                    debugPrint('Dialog Dissmiss from callback $type');
                  },
                ).show()
          : lastWords.toLowerCase() == alphabets[_index].answer.toLowerCase()
              ? currUser?.email?.isEmpty == null
                  ? AwesomeDialog(
                      context: context,
                      animType: AnimType.LEFTSLIDE,
                      headerAnimationLoop: false,
                      dialogType: DialogType.SUCCES,
                      showCloseIcon: true,
                      title: 'Yay! Ucapanmu Benar',
                      desc: 'no point (mohon login terlebih dahulu)',
                      btnOkOnPress: () {
                        debugPrint('OnClcik');
                      },
                      btnOkIcon: Icons.check_circle,
                      onDissmissCallback: (type) {
                        debugPrint('Dialog Dissmiss from callback $type');
                        setState(() {
                          alphabets[_index].isDone = true;
                          _index = ++_index;
                        });
                      },
                    ).show()
                  : AwesomeDialog(
                      context: context,
                      animType: AnimType.LEFTSLIDE,
                      headerAnimationLoop: false,
                      dialogType: DialogType.SUCCES,
                      showCloseIcon: true,
                      title: 'Yay! Ucapanmu Benar',
                      desc: 'point +10',
                      btnOkOnPress: () {
                        debugPrint('OnClcik');
                      },
                      btnOkIcon: Icons.check_circle,
                      onDissmissCallback: (type) async {
                        await users
                            .collection('users')
                            .doc(currUser?.email)
                            .update({
                          'point': FieldValue.increment(10),
                        });
                        debugPrint('Dialog Dissmiss from callback $type');
                        setState(() {
                          alphabets[_index].isDone = true;
                          _index = ++_index;
                        });
                      },
                    ).show()
              : AwesomeDialog(
                  context: context,
                  animType: AnimType.LEFTSLIDE,
                  headerAnimationLoop: false,
                  dialogType: DialogType.ERROR,
                  showCloseIcon: true,
                  title: '"${alphabets[_index].title}" ya bukan "$lastWords"',
                  desc: 'coba lagi yuk!',
                  btnOkOnPress: () {
                    debugPrint('OnClcik');
                  },
                  btnOkIcon: Icons.check_circle,
                  onDissmissCallback: (type) {
                    debugPrint('Dialog Dissmiss from callback $type');
                  },
                ).show();
    }
  }

  void statusListener(String status) {
    setState(() {
      lastStatus = status;
    });
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    // _logEvent('sound level $level: $minSoundLevel - $maxSoundLevel ');
    setState(() {
      this.level = level;
    });
  }

  @override
  void initState() {
    super.initState();
    initSpeechState();
    initTts();

    isWords = Get.arguments;
  }

  @override
  void dispose() {
    super.dispose();
    print('MASUK DISPOSE');
    disposeSpeech();
  }

  @override
  Widget build(BuildContext context) {
    return isWords
        ? Scaffold(
            backgroundColor: colorMain,
            body: Container(
              width: 1.sw,
              height: 1.sh,
              decoration: BoxDecoration(
                color: colorMain,
                image: const DecorationImage(
                  image: AssetImage('assets/images/question-bg.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 26.w,
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Container(
                          width: 35.w,
                          height: 35.h,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Center(
                            child: Icon(
                              Icons.arrow_back,
                              color: HexColor('#F24E1E'),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 65.w,
                      ),
                      Text(
                        'Belajar Kata',
                        style: pageTitle,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 34.h,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: 420.w,
                      height: 50.h,
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: words.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 16.w,
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    width: 50.w,
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                      color: words[index].isDone
                                          ? Colors.blue.withOpacity(0.51)
                                          : Colors.white.withOpacity(0.51),
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${index + 1}',
                                        style: questionNumber,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                  ),
                  SizedBox(
                    height: 101.h,
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 33.w, vertical: 33.h),
                      width: 156.w,
                      height: 156.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: InkWell(
                        onTap: () async {
                          await startListening();
                        },
                        child: Container(
                          width: 90.w,
                          height: 90.h,
                          decoration: BoxDecoration(
                            color: HexColor('#9D9DA4').withOpacity(0.50),
                            borderRadius: BorderRadius.circular(18.r),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: .26,
                                  spreadRadius: level * 1.5,
                                  color: Colors.black.withOpacity(.05))
                            ],
                          ),
                          child: Icon(
                            Icons.mic,
                            size: 80,
                            color: HexColor('#9D9DA4'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 55.h,
                  ),
                  Center(
                    child: Container(
                      width: 328.w,
                      height: 97.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.only(top: 7.h, left: 17.w, bottom: 12.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Petunjuk',
                              style: questionTxt,
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Container(
                              height: 2.h,
                              width: 85.w,
                              color: Colors.black,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              'Ucapkan kata "${words[_index].title}" !',
                              style: subquestionTxt,
                            ),
                            Text(
                              'Klik icon mic diatas untuk merekam suara.',
                              style: subquestionTxt,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 17.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.offAllNamed(BotNavBar.routeName);
                          },
                          child: Container(
                            width: 49.w,
                            height: 49.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Icon(
                              Icons.home,
                              color: Colors.black,
                              size: 35.sp,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await _speak(words[_index].title);
                          },
                          child: Container(
                            width: 49.w,
                            height: 49.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Icon(
                              Icons.volume_up,
                              color: Colors.black,
                              size: 35.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : Scaffold(
            backgroundColor: colorMain,
            body: Container(
              width: 1.sw,
              height: 1.sh,
              decoration: BoxDecoration(
                color: colorMain,
                image: const DecorationImage(
                  image: AssetImage('assets/images/question-bg.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 26.w,
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Container(
                          width: 35.w,
                          height: 35.h,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Center(
                            child: Icon(
                              Icons.arrow_back,
                              color: HexColor('#F24E1E'),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 65.w,
                      ),
                      Text(
                        'Belajar Mengeja',
                        style: pageTitle,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 34.h,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: 1750.w,
                      height: 50.h,
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: alphabets.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 16.w,
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    width: 50.w,
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                      color: alphabets[index].isDone
                                          ? Colors.blue.withOpacity(0.51)
                                          : Colors.white.withOpacity(0.51),
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Center(
                                      child: Text(
                                        alphabets[index].title,
                                        style: questionNumber,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                  ),
                  SizedBox(
                    height: 101.h,
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 33.w, vertical: 33.h),
                      width: 156.w,
                      height: 156.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: InkWell(
                        onTap: () async {
                          await startListening();
                        },
                        child: Container(
                          width: 90.w,
                          height: 90.h,
                          decoration: BoxDecoration(
                            color: HexColor('#9D9DA4').withOpacity(0.50),
                            borderRadius: BorderRadius.circular(18.r),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: .26,
                                  spreadRadius: level * 1.5,
                                  color: Colors.black.withOpacity(.05))
                            ],
                          ),
                          child: Icon(
                            Icons.mic,
                            size: 80,
                            color: HexColor('#9D9DA4'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 55.h,
                  ),
                  Center(
                    child: Container(
                      width: 328.w,
                      height: 97.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.only(top: 7.h, left: 17.w, bottom: 12.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Petunjuk',
                              style: questionTxt,
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Container(
                              height: 2.h,
                              width: 85.w,
                              color: Colors.black,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              'Ucapkan huruf "${alphabets[_index].title}" !',
                              style: subquestionTxt,
                            ),
                            Text(
                              'Klik icon mic diatas untuk merekam suara.',
                              style: subquestionTxt,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 17.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.offAllNamed(BotNavBar.routeName);
                          },
                          child: Container(
                            width: 49.w,
                            height: 49.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Icon(
                              Icons.home,
                              color: Colors.black,
                              size: 35.sp,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await _speak(alphabets[_index].title);
                          },
                          child: Container(
                            width: 49.w,
                            height: 49.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Icon(
                              Icons.volume_up,
                              color: Colors.black,
                              size: 35.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
