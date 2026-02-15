import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/localization/app_strings.dart';
import '../../app/providers.dart';
import '../../core/models/app_error.dart';
import '../../core/pdf/pdf_import_policy.dart';
import '../../core/pdf/local_pdf_text_extractor.dart';
import '../../core/pdf/pdf_text_extractor.dart';
import 'import_state.dart';

final importControllerProvider =
    NotifierProvider<ImportController, ImportState>(ImportController.new);

final pdfTextExtractorProvider = Provider<PdfTextExtractor>((ref) {
  return LocalPdfTextExtractor();
});

class ImportController extends Notifier<ImportState> {
  @override
  ImportState build() => const ImportState.initial();

  Future<void> importStatement(File file) async {
    state = state.copyWith(
      status: ImportStatus.loading,
      messageEs: null,
      error: null,
    );

    try {
      if (!PdfImportPolicy().isAllowed(file)) {
        throw const _ImportException(
          code: 'file_too_large',
          messageEs: AppStrings.fileTooLarge,
        );
      }

      final extractor = ref.read(pdfTextExtractorProvider);
      final text = await extractor.extractText(file);
      final parser = ref.read(bankParserRegistryProvider).parserForText(text);
      final parsed = parser.parse(text);
      final categorizer = ref.read(transactionCategorizerProvider);
      final categorized = parsed.copyWith(
        transactions: parsed.transactions.map((item) {
          final result = categorizer.categorize(item.description);
          return item.copyWith(
            category: result.category,
            confidence: result.confidence,
          );
        }).toList(),
      );
      await ref
          .read(statementRepositoryProvider)
          .saveParsedStatement(categorized);

      state = state.copyWith(
        status: ImportStatus.success,
        messageEs: AppStrings.importSuccess,
      );
    } on _ImportException catch (error) {
      state = state.copyWith(
        status: ImportStatus.failure,
        messageEs: error.messageEs,
        error: AppError(code: error.code, messageEs: error.messageEs),
      );
    } catch (error) {
      state = state.copyWith(
        status: ImportStatus.failure,
        messageEs: AppStrings.parserError,
        error: AppError(
          code: 'import_failure',
          messageEs: AppStrings.parserError,
        ),
      );
    }
  }
}

class _ImportException implements Exception {
  const _ImportException({required this.code, required this.messageEs});

  final String code;
  final String messageEs;
}
