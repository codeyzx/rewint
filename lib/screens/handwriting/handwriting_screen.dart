import 'package:flutter/material.dart' hide Ink;
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mlkit_digital_ink_recognition/google_mlkit_digital_ink_recognition.dart';
import 'package:rewint/widgets/handwriting/activity_indicator.dart';

class HandwritingScreen extends StatefulWidget {
  const HandwritingScreen({Key? key}) : super(key: key);

  static const String routeName = '/handwriting';

  @override
  _HandwritingScreenState createState() => _HandwritingScreenState();
}

class _HandwritingScreenState extends State<HandwritingScreen> {
  final DigitalInkRecognizerModelManager _modelManager =
      DigitalInkRecognizerModelManager();
  final String _language = 'en-US';
  late final DigitalInkRecognizer _digitalInkRecognizer =
      DigitalInkRecognizer(languageCode: _language);
  final Ink _ink = Ink();
  List<StrokePoint> _points = [];
  String _recognizedText = '';

  @override
  void dispose() {
    _digitalInkRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Digital Ink Recognition')),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onPanStart: (DragStartDetails details) {
                  _ink.strokes.add(Stroke());
                },
                onPanUpdate: (DragUpdateDetails details) {
                  setState(() {
                    final RenderObject? object = context.findRenderObject();
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
            if (_recognizedText.isNotEmpty)
              Text(
                'Candidates: $_recognizedText',
                style: const TextStyle(fontSize: 23),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    child: Text(
                      'Read Text',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                      ),
                    ),
                    onPressed: _recogniseText,
                  ),
                  ElevatedButton(
                    child: Text(
                      'Clear Pad',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                      ),
                    ),
                    onPressed: _clearPad,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    child: Text(
                      'Check Model',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                      ),
                    ),
                    onPressed: _isModelDownloaded,
                  ),
                  ElevatedButton(
                    child: Text(
                      'Download',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                      ),
                    ),
                    onPressed: _downloadModel,
                  ),
                  ElevatedButton(
                    child: Text(
                      'Delete',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                      ),
                    ),
                    onPressed: _deleteModel,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
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

  Future<void> _isModelDownloaded() async {
    Toast().show(
        'Checking if model is downloaded...',
        _modelManager
            .isModelDownloaded(_language)
            .then((value) => value ? 'downloaded' : 'not downloaded'),
        context,
        this);
  }

  Future<void> _deleteModel() async {
    Toast().show(
        'Deleting model...',
        _modelManager
            .deleteModel(_language)
            .then((value) => value ? 'success' : 'failed'),
        context,
        this);
  }

  Future<void> _downloadModel() async {
    Toast().show(
        'Downloading model...',
        _modelManager
            .downloadModel(_language)
            .then((value) => value ? 'success' : 'failed'),
        context,
        this);
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
        if (temp == 1) {
          _recognizedText += candidate.text;
        }
        temp++;
      }
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
    Navigator.pop(context);
  }
}

class Signature extends CustomPainter {
  Ink ink;

  Signature({required this.ink});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4.0;

    for (final stroke in ink.strokes) {
      for (int i = 0; i < stroke.points.length - 1; i++) {
        final p1 = stroke.points[i];
        final p2 = stroke.points[i + 1];
        canvas.drawLine(Offset(p1.x.toDouble(), p1.y.toDouble()),
            Offset(p2.x.toDouble(), p2.y.toDouble()), paint);
      }
    }
  }

  @override
  bool shouldRepaint(Signature oldDelegate) => true;
}
