import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' hide Ink;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_digital_ink_recognition/google_mlkit_digital_ink_recognition.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rewint/configs/themes/app_colors.dart';
import 'package:rewint/models/alphabet_model.dart';
import 'package:rewint/screens/handwriting/handwriting_screen.dart';
import 'package:rewint/widgets/botnavbar.dart';

class AlphabetScreen extends StatefulWidget {
  const AlphabetScreen({Key? key}) : super(key: key);

  static const String routeName = '/alphabet-uppercase';

  @override
  State<AlphabetScreen> createState() => AlphabetScreenState();
}

class AlphabetScreenState extends State<AlphabetScreen> {
  List<AlphabetModel> alphabets = [
    AlphabetModel(title: 'A', answer: 'A', isDone: false),
    AlphabetModel(title: 'B', answer: 'B', isDone: false),
    AlphabetModel(title: 'C', answer: 'c', isDone: false),
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
    AlphabetModel(title: 'O', answer: 'o', isDone: false),
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
    AlphabetModel(title: 'Z', answer: 'z', isDone: false),
  ];
  int _alphabetIndex = 0;
  bool isUpperCase = true;

  List<AlphabetModel> words = [
    AlphabetModel(title: 'Berlari', answer: 'Berlari', isDone: false),
    AlphabetModel(title: 'Makan', answer: 'Makan', isDone: false),
    AlphabetModel(title: 'Minum', answer: 'Minum', isDone: false),
    AlphabetModel(title: 'Tidur', answer: 'Tidur', isDone: false),
    AlphabetModel(title: 'Mandi', answer: 'Mandi', isDone: false),
    AlphabetModel(title: 'Mobil', answer: 'Mobil', isDone: false),
  ];
  int _wordsIndex = 0;
  bool isWords = false;

  FlutterTts? flutterTts;

  final DigitalInkRecognizerModelManager _modelManager =
      DigitalInkRecognizerModelManager();
  final String _language = 'id';
  late final DigitalInkRecognizer _digitalInkRecognizer =
      DigitalInkRecognizer(languageCode: _language);
  final Ink _ink = Ink();
  List<StrokePoint> _points = [];
  String _recognizedText = '';

  _speak(String text) async {
    await flutterTts!.setLanguage('id');
    await flutterTts!.setSpeechRate(0);
    await flutterTts!.setVolume(1);
    await flutterTts!.speak(text);
  }

  Future _getDefaultEngine() async {
    var engine = await flutterTts!.getDefaultEngine;
    if (engine != null) {
      // ignore: avoid_print
      print(engine);
    }
  }

  Future _setAwaitOptions() async {
    await flutterTts!.awaitSpeakCompletion(true);
  }

  void initTts() async {
    flutterTts = FlutterTts();
    await _setAwaitOptions();
    await _getDefaultEngine();
  }

  @override
  void initState() {
    super.initState();
    isWords = Get.arguments['isWords'];
    isUpperCase = Get.arguments['isUpperCase'];
    initTts();
  }

  @override
  void dispose() {
    _digitalInkRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore users = FirebaseFirestore.instance;
    User? currUser = FirebaseAuth.instance.currentUser;

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
                        'Pilih Mode!',
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
                    height: 22.h,
                  ),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      width: 328.w,
                      height: 292.h,
                      child: GestureDetector(
                        onPanStart: (DragStartDetails details) {
                          _ink.strokes.add(Stroke());
                        },
                        onPanUpdate: (DragUpdateDetails details) {
                          setState(() {
                            final RenderObject? object =
                                context.findRenderObject();
                            final localPosition = (object as RenderBox?)
                                ?.globalToLocal(details.localPosition);
                            if (localPosition != null) {
                              _points = List.from(_points)
                                ..add(StrokePoint(
                                  x: localPosition.dx,
                                  y: localPosition.dy,
                                  t: DateTime.now().millisecondsSinceEpoch,
                                ));
                            }
                            if (_ink.strokes.isNotEmpty) {
                              _ink.strokes.last.points = _points.toList();
                            }
                          });
                        },
                        onPanEnd: (DragEndDetails details) {
                          _points.clear();
                          setState(() {});
                        },
                        child: CustomPaint(
                          painter: Signature(ink: _ink),
                          size: Size.infinite,
                        ),
                      ),
                    ),
                  ),
                  // * CANVAS HERE
                  // Center(
                  //   child: Container(
                  //     width: 328.w,
                  //     height: 292.h,
                  //     decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.circular(10.r),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 22.h,
                  ),
                  Center(
                    child: Container(
                      width: 328.w,
                      height: 76.h,
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
                              'Tulis huruf "${words[_wordsIndex].title}" pada canvas diatas!',
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
                          onTap: () => Get.offAllNamed(BotNavBar.routeName),
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
                            final isDownloaded = await _isModelDownloaded();
                            isDownloaded
                                ? await _recogniseText()
                                : await _downloadModel();

                            print('RECOGNIZED TEXT : $_recognizedText');

                            _recognizedText == words[_wordsIndex].answer
                                ? currUser?.email?.isEmpty == null
                                    ? AwesomeDialog(
                                        context: context,
                                        animType: AnimType.LEFTSLIDE,
                                        headerAnimationLoop: false,
                                        dialogType: DialogType.SUCCES,
                                        showCloseIcon: true,
                                        title: 'Yay! Jawabanmu Benar',
                                        desc:
                                            'no point (mohon login terlebih dahulu)',
                                        btnOkOnPress: () {
                                          debugPrint('OnClcik');
                                        },
                                        btnOkIcon: Icons.check_circle,
                                        onDissmissCallback: (type) async {
                                          debugPrint(
                                              'Dialog Dissmiss from callback $type');
                                          setState(() {
                                            words[_wordsIndex].isDone = true;
                                            _wordsIndex = ++_wordsIndex;
                                          });
                                        },
                                      ).show()
                                    : AwesomeDialog(
                                        context: context,
                                        animType: AnimType.LEFTSLIDE,
                                        headerAnimationLoop: false,
                                        dialogType: DialogType.SUCCES,
                                        showCloseIcon: true,
                                        title: 'Yay! Jawabanmu Benar',
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

                                          debugPrint(
                                              'Dialog Dissmiss from callback $type');
                                          setState(() {
                                            words[_wordsIndex].isDone = true;
                                            _wordsIndex = ++_wordsIndex;
                                          });
                                        },
                                      ).show()
                                : AwesomeDialog(
                                    context: context,
                                    animType: AnimType.LEFTSLIDE,
                                    headerAnimationLoop: false,
                                    dialogType: DialogType.ERROR,
                                    showCloseIcon: true,
                                    title: ':( Jawabanmu Salah',
                                    desc: 'coba lagi yuk!',
                                    btnOkOnPress: () {
                                      debugPrint('OnClcik');
                                    },
                                    btnOkIcon: Icons.check_circle,
                                    onDissmissCallback: (type) {
                                      debugPrint(
                                          'Dialog Dissmiss from callback $type');
                                    },
                                  ).show();

                            _clearPad();
                          },
                          child: Container(
                            width: 202.w,
                            height: 49.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Center(
                              child: Text(
                                'Cek Jawaban',
                                style: subquestionTxt,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await _speak(words[_wordsIndex].title);
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
                        'Pilih Mode!',
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
                                        isUpperCase
                                            ? alphabets[index].title
                                            : alphabets[index]
                                                .title
                                                .toLowerCase(),
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
                    height: 22.h,
                  ),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      width: 328.w,
                      height: 292.h,
                      child: GestureDetector(
                        onPanStart: (DragStartDetails details) {
                          _ink.strokes.add(Stroke());
                        },
                        onPanUpdate: (DragUpdateDetails details) {
                          setState(() {
                            final RenderObject? object =
                                context.findRenderObject();
                            final localPosition = (object as RenderBox?)
                                ?.globalToLocal(details.localPosition);
                            if (localPosition != null) {
                              _points = List.from(_points)
                                ..add(StrokePoint(
                                  x: localPosition.dx,
                                  y: localPosition.dy,
                                  t: DateTime.now().millisecondsSinceEpoch,
                                ));
                            }
                            if (_ink.strokes.isNotEmpty) {
                              _ink.strokes.last.points = _points.toList();
                            }
                          });
                        },
                        onPanEnd: (DragEndDetails details) {
                          _points.clear();
                          setState(() {});
                        },
                        child: CustomPaint(
                          painter: Signature(ink: _ink),
                          size: Size.infinite,
                        ),
                      ),
                    ),
                  ),
                  // * CANVAS HERE
                  // Center(
                  //   child: Container(
                  //     width: 328.w,
                  //     height: 292.h,
                  //     decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.circular(10.r),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 22.h,
                  ),
                  Center(
                    child: Container(
                      width: 328.w,
                      height: 76.h,
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
                              'Tulis huruf "${isUpperCase ? alphabets[_alphabetIndex].title : alphabets[_alphabetIndex].title.toLowerCase()}" pada canvas diatas!',
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
                          onTap: () => Get.offAllNamed(BotNavBar.routeName),
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
                            final isDownloaded = await _isModelDownloaded();
                            isDownloaded
                                ? await _recogniseText()
                                : await _downloadModel();

                            print('RECOGNIZED TEXT : $_recognizedText');

                            _recognizedText ==
                                    (isUpperCase
                                        ? alphabets[_alphabetIndex].answer
                                        : alphabets[_alphabetIndex]
                                            .answer
                                            .toLowerCase())
                                ? currUser?.email?.isEmpty == null
                                    ? AwesomeDialog(
                                        context: context,
                                        animType: AnimType.LEFTSLIDE,
                                        headerAnimationLoop: false,
                                        dialogType: DialogType.SUCCES,
                                        showCloseIcon: true,
                                        title: 'Yay! Jawabanmu Benar',
                                        desc:
                                            'no point (mohon login terlebih dahulu)',
                                        btnOkOnPress: () {
                                          debugPrint('OnClcik');
                                        },
                                        btnOkIcon: Icons.check_circle,
                                        onDissmissCallback: (type) {
                                          debugPrint(
                                              'Dialog Dissmiss from callback $type');
                                          setState(() {
                                            alphabets[_alphabetIndex].isDone =
                                                true;
                                            _alphabetIndex = ++_alphabetIndex;
                                          });
                                        },
                                      ).show()
                                    : AwesomeDialog(
                                        context: context,
                                        animType: AnimType.LEFTSLIDE,
                                        headerAnimationLoop: false,
                                        dialogType: DialogType.SUCCES,
                                        showCloseIcon: true,
                                        title: 'Yay! Jawabanmu Benar',
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
                                          debugPrint(
                                              'Dialog Dissmiss from callback $type');
                                          setState(() {
                                            alphabets[_alphabetIndex].isDone =
                                                true;
                                            _alphabetIndex = ++_alphabetIndex;
                                          });
                                        },
                                      ).show()
                                : AwesomeDialog(
                                    context: context,
                                    animType: AnimType.LEFTSLIDE,
                                    headerAnimationLoop: false,
                                    dialogType: DialogType.ERROR,
                                    showCloseIcon: true,
                                    title: ':( Jawabanmu Salah',
                                    desc: 'coba lagi yuk!',
                                    btnOkOnPress: () {
                                      debugPrint('OnClcik');
                                    },
                                    btnOkIcon: Icons.check_circle,
                                    onDissmissCallback: (type) {
                                      debugPrint(
                                          'Dialog Dissmiss from callback $type');
                                    },
                                  ).show();

                            _clearPad();
                          },
                          child: Container(
                            width: 202.w,
                            height: 49.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Center(
                              child: Text(
                                'Cek Jawaban',
                                style: subquestionTxt,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await _speak(alphabets[_alphabetIndex].title);
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

  void _clearPad() {
    setState(() {
      _ink.strokes.clear();
      _points.clear();
      _recognizedText = '';
    });
  }

  Future<bool> _isModelDownloaded() async {
    return await _modelManager.isModelDownloaded(_language);
  }

  Future<void> _downloadModel() async {
    final isCompleted = await _modelManager.downloadModel(_language);

    if (isCompleted) {
      await _recogniseText();
    }
  }

  Future<void> _recogniseText() async {
    showDialog(
        context: context,
        builder: (context) => const AlertDialog(
              title: Text('Recognizing'),
            ),
        barrierDismissible: true);
    try {
      final candidates = await _digitalInkRecognizer.recognize(_ink);
      int temp = 0;
      _recognizedText = '';
      for (final candidate in candidates) {
        if (temp == 0) {
          _recognizedText += candidate.text;
        }
        temp++;
      }
      setState(() {});
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text(e.toString()),
      // ));
    }
    Navigator.pop(context);
  }
}
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/material.dart' hide Ink;
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:get/get.dart';
// import 'package:google_mlkit_digital_ink_recognition/google_mlkit_digital_ink_recognition.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:rewint/configs/themes/app_colors.dart';
// import 'package:rewint/screens/handwriting/handwriting_screen.dart';
// import 'package:rewint/screens/home/home_page.dart';
// import 'package:rewint/widgets/handwriting/activity_indicator.dart';
// // ignore_for_file: prefer_const_constructors

// class AlphabetUpperPage extends StatefulWidget {
//   const AlphabetUpperPage({Key? key}) : super(key: key);

//   static const String routeName = '/alphabet-uppercase';

//   @override
//   State<AlphabetUpperPage> createState() => _AlphabetUpperPageState();
// }

// class _AlphabetUpperPageState extends State<AlphabetUpperPage> {
//   FlutterTts? flutterTts;

//   final DigitalInkRecognizerModelManager _modelManager =
//       DigitalInkRecognizerModelManager();
//   final String _language = 'id';
//   late final DigitalInkRecognizer _digitalInkRecognizer =
//       DigitalInkRecognizer(languageCode: _language);
//   final Ink _ink = Ink();
//   List<StrokePoint> _points = [];
//   String _recognizedText = '';

//   _speak(String text) async {
//     await flutterTts!.setLanguage('id');
//     await flutterTts!.setSpeechRate(0);
//     await flutterTts!.setVolume(1);
//     await flutterTts!.speak(text);
//   }

//   Future _getDefaultEngine() async {
//     var engine = await flutterTts!.getDefaultEngine;
//     if (engine != null) {
//       // ignore: avoid_print
//       print(engine);
//     }
//   }

//   Future _setAwaitOptions() async {
//     await flutterTts!.awaitSpeakCompletion(true);
//   }

//   void initTts() async {
//     flutterTts = FlutterTts();
//     await _setAwaitOptions();
//     await _getDefaultEngine();
//   }

//   @override
//   void initState() {
//     super.initState();
//     initTts();
//   }

//   @override
//   void dispose() {
//     _digitalInkRecognizer.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: colorMain,
//       body: Container(
//         width: 1.sw,
//         height: 1.sh,
//         decoration: BoxDecoration(
//           color: colorMain,
//           image: DecorationImage(
//             image: AssetImage('assets/images/question-bg.png'),
//             fit: BoxFit.fill,
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               height: 26.w,
//             ),
//             Row(
//               children: [
//                 IconButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   icon: Container(
//                     width: 35.w,
//                     height: 35.h,
//                     decoration: BoxDecoration(
//                         shape: BoxShape.circle, color: Colors.white),
//                     child: Center(
//                       child: Icon(
//                         Icons.arrow_back,
//                         color: HexColor('#F24E1E'),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 65.w,
//                 ),
//                 Text(
//                   'Pilih Mode!',
//                   style: pageTitle,
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 34.h,
//             ),
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: SizedBox(
//                 width: 1000.w,
//                 height: 50.h,
//                 child: ListView.builder(
//                     physics: NeverScrollableScrollPhysics(),
//                     scrollDirection: Axis.horizontal,
//                     shrinkWrap: true,
//                     itemCount: 25,
//                     itemBuilder: (BuildContext context, int index) {
//                       return Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           SizedBox(
//                             width: 16.w,
//                           ),
//                           InkWell(
//                             onTap: () {},
//                             child: Container(
//                               width: 50.w,
//                               height: 50.h,
//                               decoration: BoxDecoration(
//                                 color: Colors.white.withOpacity(0.51),
//                                 borderRadius: BorderRadius.circular(12.r),
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   'A',
//                                   style: questionNumber,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                     }),
//               ),
//             ),
//             SizedBox(
//               height: 22.h,
//             ),
//             Center(
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10.r),
//                 ),
//                 width: 328.w,
//                 height: 292.h,
//                 child: GestureDetector(
//                   onPanStart: (DragStartDetails details) {
//                     _ink.strokes.add(Stroke());
//                   },
//                   onPanUpdate: (DragUpdateDetails details) {
//                     setState(() {
//                       final RenderObject? object = context.findRenderObject();
//                       final localPosition = (object as RenderBox?)
//                           ?.globalToLocal(details.localPosition);
//                       if (localPosition != null) {
//                         _points = List.from(_points)
//                           ..add(StrokePoint(
//                             x: localPosition.dx,
//                             y: localPosition.dy,
//                             t: DateTime.now().millisecondsSinceEpoch,
//                           ));
//                       }
//                       if (_ink.strokes.isNotEmpty) {
//                         _ink.strokes.last.points = _points.toList();
//                       }
//                     });
//                   },
//                   onPanEnd: (DragEndDetails details) {
//                     _points.clear();
//                     setState(() {});
//                   },
//                   child: CustomPaint(
//                     painter: Signature(ink: _ink),
//                     size: Size.infinite,
//                   ),
//                 ),
//               ),
//             ),
//             // * CANVAS HERE
//             // Center(
//             //   child: Container(
//             //     width: 328.w,
//             //     height: 292.h,
//             //     decoration: BoxDecoration(
//             //       color: Colors.white,
//             //       borderRadius: BorderRadius.circular(10.r),
//             //     ),
//             //   ),
//             // ),
//             SizedBox(
//               height: 22.h,
//             ),
//             Center(
//               child: Container(
//                 width: 328.w,
//                 height: 76.h,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10.r),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.only(top: 7.h, left: 17.w, bottom: 12.h),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Petunjuk',
//                         style: questionTxt,
//                       ),
//                       SizedBox(
//                         height: 2.h,
//                       ),
//                       Container(
//                         height: 2.h,
//                         width: 85.w,
//                         color: Colors.black,
//                       ),
//                       SizedBox(
//                         height: 10.h,
//                       ),
//                       Text(
//                         'Tulis huruf "A" pada canvas diatas!',
//                         style: subquestionTxt,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 17.h,
//             ),
//             Padding(
//               padding: EdgeInsets.only(left: 16.w, right: 16.w),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       Get.offAllNamed(BotNavBar.routeName);
//                       // Navigator.pushReplacement(
//                       //     context,
//                       //     MaterialPageRoute(
//                       //       builder: (context) =>
//                       //           HomePage(),
//                       //     ));
//                     },
//                     child: InkWell(
//                       onTap: () => Get.offAllNamed(BotNavBar.routeName),
//                       child: Container(
//                         width: 49.w,
//                         height: 49.h,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10.r),
//                         ),
//                         child: Icon(
//                           Icons.home,
//                           color: Colors.black,
//                           size: 35.sp,
//                         ),
//                       ),
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () async {
//                       final isDownloaded = await _isModelDownloaded();
//                       isDownloaded
//                           ? await _recogniseText()
//                           : await _downloadModel();

//                       _recognizedText == 'joni'
//                           ? AwesomeDialog(
//                               context: context,
//                               animType: AnimType.LEFTSLIDE,
//                               headerAnimationLoop: false,
//                               dialogType: DialogType.SUCCES,
//                               showCloseIcon: true,
//                               title: 'Yay! Jawabanmu Benar',
//                               desc: 'point +10',
//                               btnOkOnPress: () {
//                                 debugPrint('OnClcik');
//                               },
//                               btnOkIcon: Icons.check_circle,
//                               onDissmissCallback: (type) {
//                                 debugPrint(
//                                     'Dialog Dissmiss from callback $type');
//                               },
//                             ).show()
//                           : AwesomeDialog(,
//                               context: context,
//                               animType: AnimType.LEFTSLIDE,
//                               headerAnimationLoop: false,
//                               dialogType: DialogType.ERROR,
//                               showCloseIcon: true,
//                               title: ':( Jawabanmu Salah',
//                               desc: 'coba lagi yuk!',
//                               btnOkOnPress: () {
//                                 debugPrint('OnClcik');
//                               },
//                               btnOkIcon: Icons.check_circle,
//                               onDissmissCallback: (type) {
//                                 debugPrint(
//                                     'Dialog Dissmiss from callback $type');
//                               },
//                             ).show();

//                       _clearPad();
//                     },
//                     child: Container(
//                       width: 202.w,
//                       height: 49.h,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10.r),
//                       ),
//                       child: Center(
//                         child: Text(
//                           'Cek Jawaban',
//                           style: subquestionTxt,
//                         ),
//                       ),
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () async {
//                       await _speak('a');
//                     },
//                     child: Container(
//                       width: 49.w,
//                       height: 49.h,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10.r),
//                       ),
//                       child: Icon(
//                         Icons.volume_up,
//                         color: Colors.black,
//                         size: 35.sp,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _clearPad() {
//     setState(() {
//       _ink.strokes.clear();
//       _points.clear();
//       _recognizedText = '';
//     });
//   }

//   Future<bool> _isModelDownloaded() async {
//     return await _modelManager.isModelDownloaded(_language);
//   }

//   Future<void> _deleteModel() async {
//     Toast().show(
//         'Deleting model...',
//         _modelManager
//             .deleteModel(_language)
//             .then((value) => value ? 'success' : 'failed'),
//         context,
//         this);
//   }

//   Future<void> _downloadModel() async {
//     final isCompleted = await _modelManager.downloadModel(_language);

//     if (isCompleted) {
//       await _recogniseText();
//     }
//   }

//   Future<void> _recogniseText() async {
//     showDialog(
//         context: context,
//         builder: (context) => const AlertDialog(
//               title: Text('Recognizing'),
//             ),
//         barrierDismissible: true);
//     try {
//       final candidates = await _digitalInkRecognizer.recognize(_ink);
//       int temp = 0;
//       _recognizedText = '';
//       for (final candidate in candidates) {
//         if (temp == 1) {
//           _recognizedText += candidate.text;
//         }
//         temp++;
//       }
//       setState(() {});
//     } catch (e) {
//       // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       //   content: Text(e.toString()),
//       // ));
//     }
//     Navigator.pop(context);
//   }
// }
