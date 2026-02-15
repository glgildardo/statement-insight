import 'dart:io';

class PdfImportPolicy {
  static const int maxBytes = 5 * 1024 * 1024;

  bool isAllowed(File file) {
    return file.lengthSync() <= maxBytes;
  }
}
