import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final String text;

  const ResultScreen(
      {Key? key, required this.text, required String expirationDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final expirationDate = _extractExpirationDate(text);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Result'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Scanned Text:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            const Text(
              'Expiration Date:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              expirationDate != null
                  ? expirationDate
                  : 'No Expiration Date Found',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  String? _extractExpirationDate(String text) {
    final RegExp datePatternNumeric =
        RegExp(r"\b(\d{1,2})\s*/\s*(\d{1,2})\s*/\s*(\d{2,4})\b");
    final RegExp datePatternWord =
        RegExp(r"\b(\d{1,2})\s+(\w{3})\s+(\d{2,4})\b", caseSensitive: false);
    final matchesNumeric = datePatternNumeric.allMatches(text);
    final matchesWord = datePatternWord.allMatches(text);

    String? expirationDate;

    // Process numeric date matches
    for (final match in matchesNumeric) {
      final day = match.group(1);
      final month = match.group(2);
      final year = match.group(3);
      final date = '$day/$month/$year';
      if (_isExpirationDate(date)) {
        expirationDate = date;
        break;
      }
    }

    // Process word date matches
    if (expirationDate == null) {
      for (final match in matchesWord) {
        final day = match.group(1);
        final month = match.group(2);
        final year = match.group(3);
        final monthNumber = _getMonthNumber(month!);
        if (monthNumber != null) {
          final date = '$day/$monthNumber/$year';
          if (_isExpirationDate(date)) {
            expirationDate = date;
            break;
          }
        }
      }
    }
    if (expirationDate == null) {
      // Process "Valid Up To" date matches
      final RegExp validUpToPattern = RegExp(
          r"\bValid Up To(?:\s*|:\s*)\b(\d{1,2})(?:\s*/\s*| )(\d{1,2})(?:\s*/\s*| )(\d{2,4})\b");
      final validUpToMatch = validUpToPattern.firstMatch(text);
      if (validUpToMatch != null) {
        final day = validUpToMatch.group(1);
        final month = validUpToMatch.group(2);
        final year = validUpToMatch.group(3);
        expirationDate = '$day/$month/$year';
      }
    }

    if (expirationDate == null) {
      // Process "Best Before" date matches
      final RegExp bestBeforePattern = RegExp(
          r"\bBest Before(?:\s*|:\s*)\b(\d{1,2})(?:\s*/\s*| )(\d{1,2})(?:\s*/\s*| )(\d{2,4})\b");
      final bestBeforeMatch = bestBeforePattern.firstMatch(text);
      if (bestBeforeMatch != null) {
        final day = bestBeforeMatch.group(1);
        final month = bestBeforeMatch.group(2);
        final year = bestBeforeMatch.group(3);
        expirationDate = '$day/$month/$year';
      }
    }

    return expirationDate;
  }

  int? _getMonthNumber(String month) {
    switch (month.toLowerCase()) {
      case 'jan':
        return 1;
      case 'feb':
        return 2;
      case 'mar':
        return 3;
      case 'apr':
        return 4;
      case 'may':
        return 5;
      case 'jun':
        return 6;
      case 'jul':
        return 7;
      case 'aug':
        return 8;
      case 'sep':
        return 9;
      case 'oct':
        return 10;
      case 'nov':
        return 11;
      case 'dec':
        return 12;
      default:
        return null;
    }
  }

  bool _isExpirationDate(String? date) {
    // Implement your logic here to determine if the given date is an expiration date.
    // You can compare it with the current date or apply any other custom validation.
    // Return true if it is an expiration date, otherwise false.
    // Example logic:
    // DateTime currentDate = DateTime.now();
    // DateTime parsedDate = DateTime.parse(date);
    // return parsedDate.isAfter(currentDate);
    return date !=
        null; // Placeholder logic, consider implementing your own logic.
  }
}
