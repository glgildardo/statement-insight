import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'report_pdf_generator.dart';

class LocalReportPdfGenerator implements ReportPdfGenerator {
  @override
  Future<List<int>> generate({
    required DateTime periodStart,
    required DateTime periodEnd,
    required double totalSpent,
    required double totalIncome,
    required double net,
    required Map<String, double> categoryBreakdown,
    required List<String> topExpenses,
  }) async {
    final document = pw.Document();
    final currency = NumberFormat.currency(locale: 'es_GT', symbol: 'Q');
    final date = DateFormat('dd/MM/yyyy');

    document.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => <pw.Widget>[
          pw.Text(
            'Reporte Financiero',
            style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 8),
          pw.Text(
            'Periodo: ${date.format(periodStart)} - ${date.format(periodEnd)}',
          ),
          pw.SizedBox(height: 16),
          pw.Text('Gasto total: ${currency.format(totalSpent)}'),
          pw.Text('Ingreso total: ${currency.format(totalIncome)}'),
          pw.Text('Balance neto: ${currency.format(net)}'),
          pw.SizedBox(height: 16),
          pw.Text(
            'Desglose por categoria',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 8),
          pw.TableHelper.fromTextArray(
            headers: const <String>['Categoria', 'Total'],
            data: categoryBreakdown.entries
                .map(
                  (entry) => <String>[
                    entry.key,
                    currency.format(entry.value),
                  ],
                )
                .toList(),
          ),
          pw.SizedBox(height: 16),
          pw.Text(
            'Top gastos',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 8),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: topExpenses
                .map((item) => pw.Padding(
                      padding: const pw.EdgeInsets.only(bottom: 4),
                      child: pw.Text('- $item'),
                    ))
                .toList(),
          ),
        ],
      ),
    );

    return document.save();
  }
}
