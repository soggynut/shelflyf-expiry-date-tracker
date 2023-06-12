import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'product_name_screen.dart';

import 'package:intl/intl.dart';

//import 'package:intl/intl.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  bool _isPermissionGranted = false;

  late final Future<void> _future;
  CameraController? _cameraController;

  final textRecognizer = TextRecognizer();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _future = _requestCameraPermission();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopCamera();
    textRecognizer.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      _stopCamera();
    } else if (state == AppLifecycleState.resumed &&
        _cameraController != null &&
        _cameraController!.value.isInitialized) {
      _startCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        return Stack(
          children: [
            if (_isPermissionGranted)
              FutureBuilder<List<CameraDescription>>(
                future: availableCameras(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _initCameraController(snapshot.data!);

                    return Center(child: CameraPreview(_cameraController!));
                  } else {
                    return const LinearProgressIndicator();
                  }
                },
              ),
            Scaffold(
              backgroundColor: _isPermissionGranted ? Colors.transparent : null,
              body: _isPermissionGranted
                  ? Column(
                      children: [
                        Expanded(
                          child: Container(),
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Center(
                            child: IconButton(
                              onPressed: _scanImage,
                              icon:
                                  const Icon(Icons.camera, color: Colors.white),
                              iconSize: 48.0,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: Container(
                        padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                        child: const Text(
                          'Camera permission denied',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
              floatingActionButton: FloatingActionButton(
                onPressed: _toggleFlash,
                child: Icon(Icons.flash_on),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
            ),
          ],
        );
      },
    );
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    _isPermissionGranted = status == PermissionStatus.granted;
  }

  void _startCamera() {
    if (_cameraController != null) {
      _cameraSelected(_cameraController!.description);
    }
  }

  void _stopCamera() {
    if (_cameraController != null) {
      _cameraController?.dispose();
    }
  }

  void _initCameraController(List<CameraDescription> cameras) {
    if (_cameraController != null) {
      return;
    }

    // Select the first rear camera.
    CameraDescription? camera;
    for (var i = 0; i < cameras.length; i++) {
      final CameraDescription current = cameras[i];
      if (current.lensDirection == CameraLensDirection.back) {
        camera = current;
        break;
      }
    }

    if (camera != null) {
      _cameraSelected(camera);
    }
  }

  Future<void> _cameraSelected(CameraDescription camera) async {
    _cameraController = CameraController(
      camera,
      ResolutionPreset.max,
      enableAudio: false,
    );

    await _cameraController!.initialize();
    await _cameraController!.setFlashMode(FlashMode.off);

    if (!mounted) {
      return;
    }
    setState(() {});
  }

  Future<void> _scanImage() async {
    if (_cameraController == null) return;

    try {
      final pictureFile = await _cameraController!.takePicture();

      final file = File(pictureFile.path);

      final inputImage = InputImage.fromFile(file);
      final recognizedText = await textRecognizer.processImage(inputImage);
      // Process the extracted text as needed

      // Store the extracted date in a variable or pass it to the ProductNameScreen
      String extractedDate = _extractDateFromText(recognizedText);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ProductNameScreen(
            expirationDate: extractedDate,
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred when scanning text'),
        ),
      );
    }
  }

  String _extractDateFromText(RecognizedText recognizedText) {
    String extractedText =
        recognizedText.text.replaceAll(RegExp(r'[\r\n]+'), ' ');
    print(extractedText);

    List<RegExp> dateRegexList = [
      RegExp(
          r'(\b\d{1,2}(?:st|nd|rd|th)?\s+[A-Z]{3}\s+\d{4}\b|\b\d{1,2}/\d{4}\b|\b\d{1,2}-\d{1,2}-\d{4}\b)',
          caseSensitive: false),
      RegExp(
          r'([A-Z][a-z]{2} \d{1,2}, \d{4}|\d{4}-\d{2}-\d{2}|\d{1,2} [A-Z][a-z]{2} \d{4})',
          caseSensitive: false),
      RegExp(
          r'([A-Z][a-z]{3,8} \d{1,2}, \d{4}|\d{2}\d{2}\d{2}|\d{4}\d{2}\d{2}|\d{2}-\d{2}-\d{2})',
          caseSensitive: false),
      RegExp(
          r'(\d{2} [A-Z][a-z]{3,8} \d{4}|[A-Z][a-z]{3,8} \d{2}, \d{4}|\d{1,2}/\d{1,2}/\d{4}|\d{2}/\d{2}/\d{4}|\d{2}\.\d{2}\.\d{4})',
          caseSensitive: false),
    ];

    List<String> extractedDates = [];

    for (RegExp dateRegex in dateRegexList) {
      Iterable<Match> matches = dateRegex.allMatches(extractedText);

      for (Match match in matches) {
        String extractedDate = match.group(1)!;
        String normalizedDate = normalizeDateString(extractedDate);
        extractedDates.add(normalizedDate);
      }
    }

    print(extractedDates);

    if (extractedDates.isNotEmpty) {
      try {
        DateTime? highestDate = extractedDates
            .map((dateString) {
              if (dateString.isNotEmpty) {
                return DateFormat('dd-MM-yyyy').parse(dateString);
              } else {
                return null;
              }
            })
            .where((date) => date != null)
            .reduce((a, b) => a!.isAfter(b!) ? a : b);

        if (highestDate != null) {
          String highestDateString =
              DateFormat('dd-MM-yyyy').format(highestDate);
          print('Highest Date: $highestDateString');
          return highestDateString;
        } else {
          print('No valid dates found.');
        }
      } catch (e) {
        if (e is FormatException) {
          print('Error occurred during date parsing: ${e.message}');
        } else {
          print('Error occurred: $e');
        }
      }
    } else {
      print('No dates found.');
    }

    return '';
  }

  String normalizeDateString(String input) {
    // Define the regular expression pattern to match the format "31st May 2024"
    RegExp dateRegex = RegExp(r'(\d{1,2})(st|nd|rd|th)?\s+(\w+)\s+(\d{4})');

    // Check if the input matches the desired format
    if (dateRegex.hasMatch(input)) {
      // Extract day, month, and year from the input using the regular expression
      Match? match = dateRegex.firstMatch(input);
      if (match != null) {
        int day = int.parse(match.group(1)!);
        String month = match.group(3)!;
        int year = int.parse(match.group(4)!);

        // Map the month name to its corresponding number representation
        Map<String, int> monthMapping = {
          'Jan': 1,
          'Feb': 2,
          'Mar': 3,
          'Apr': 4,
          'May': 5,
          'Jun': 6,
          'Jul': 7,
          'Aug': 8,
          'Sep': 9,
          'Oct': 10,
          'Nov': 11,
          'Dec': 12,
        };
        int monthNumber = monthMapping[month] ?? 1;

        // Construct the normalized date string in the format "DD-MM-YYYY"
        String normalizedDate =
            '$day-${monthNumber.toString().padLeft(2, '0')}-$year';

        return normalizedDate;
      }
    } else {
      try {
        // Try parsing the input using different date formats
        List<DateFormat> dateFormats = [
          DateFormat('MM/yyyy'),
          DateFormat('dd-MM-yyyy'),
          DateFormat('MMM d, yyyy'), // Example: "May 1, 2023"
          DateFormat('yyyy-MM-dd'), // Example: "2023-05-01"
          DateFormat('d MMM yyyy'), // Example: "1 May 2023"
          DateFormat('MMMM d, yyyy'), // Example: "May 1, 2023"
          DateFormat('yyMMdd'), // Example: "230501"
          DateFormat('yyyyMMdd'), // Example: "20230501"
          DateFormat('MM-dd-yy'), // Example: "05-01-23"
          DateFormat('EEE, MMM d, ' 'yy'), // Example: "Fri, May 1, '23"
          DateFormat('dd MMMM yyyy'), // Example: "01 May 2023"
          DateFormat('MMMM dd, yyyy'), // Example: "May 01, 2023"
          DateFormat('d/M/yyyy'), // Example: "1/5/2023"
          DateFormat('dd/MM/yyyy'), // Example: "01/05/2023"
          DateFormat('MM.dd.yyyy'), // Example: "05.01.2023"
        ];

        for (DateFormat format in dateFormats) {
          try {
            DateTime dateTime = format.parseLoose(input);
            // Format the parsed date as "dd-MM-yyyy"
            return DateFormat('dd-MM-yyyy').format(dateTime);
          } catch (e) {
            // Parsing failed for the current format, continue to the next one
          }
        }
      } catch (e) {
        // Return an empty string if an exception occurs during parsing attempts
        return '';
      }
    }
    return '';
  }

  void _toggleFlash() async {
    if (_cameraController == null) return;

    try {
      final bool isFlashOn =
          _cameraController!.value.flashMode == FlashMode.torch;
      await _cameraController!
          .setFlashMode(isFlashOn ? FlashMode.off : FlashMode.torch);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred when toggling flash mode'),
        ),
      );
    }
  }
}
