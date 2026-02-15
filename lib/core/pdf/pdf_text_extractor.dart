import 'dart:io';

abstract class PdfTextExtractor {
  Future<String> extractText(File file);
}
