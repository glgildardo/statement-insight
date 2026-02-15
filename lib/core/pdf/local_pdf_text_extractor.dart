import 'dart:io';

import 'package:syncfusion_flutter_pdf/pdf.dart' as sfpdf;

import 'pdf_text_extractor.dart';

class LocalPdfTextExtractor implements PdfTextExtractor {
  @override
  Future<String> extractText(File file) async {
    final bytes = await file.readAsBytes();
    final document = sfpdf.PdfDocument(inputBytes: bytes);
    try {
      final extractor = sfpdf.PdfTextExtractor(document);
      final text = extractor.extractText();
      if (text.trim().isEmpty) {
        throw const PdfExtractionException('empty_text');
      }
      return text;
    } finally {
      document.dispose();
    }
  }
}

class PdfExtractionException implements Exception {
  const PdfExtractionException(this.code);

  final String code;
}
