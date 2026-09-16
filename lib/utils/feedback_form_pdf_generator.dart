import 'dart:typed_data';
import 'dart:ui';

import 'package:syncfusion_flutter_pdf/pdf.dart';

class _FeedbackQuestion {
  final String text;
  final List<String> options;

  const _FeedbackQuestion(this.text, this.options);
}

/// Builds the fixed patient-feedback questionnaire as a PDF (same 5
/// questions on every form - this isn't per-patient data beyond the
/// Name/Date line). Only builds the bytes - saving is done via
/// FilePicker.saveFile's native "Save As" dialog (see
/// FeedbackFormController.downloadPdf), not a silently-chosen directory,
/// so the file ends up somewhere the user can actually find it again.
class FeedbackFormPdfGenerator {
  static const List<_FeedbackQuestion> _questions = [
    _FeedbackQuestion(
      '1. How would you rate the overall quality of care you received during your visit?',
      ['Excellent', 'Good', 'Fair', 'Poor'],
    ),
    _FeedbackQuestion(
      '2. Were the hospital facilities clean and well-maintained?',
      ['Yes, they were very clean', 'Mostly clean', 'Somewhat clean', 'Not clean at all'],
    ),
    _FeedbackQuestion(
      '3. How satisfied were you with the communication from the medical staff regarding your treatment plan?',
      ['Very satisfied', 'Satisfied', 'Neutral', 'Dissatisfied'],
    ),
    _FeedbackQuestion(
      '4. Did you feel that your concerns and questions were addressed by the hospital staff?',
      ['Yes, completely', 'Somewhat', 'Not really', 'Not at all'],
    ),
    _FeedbackQuestion(
      '5. How likely are you to recommend this hospital to others?',
      ['Very Likely', 'Likely', 'Unlikely', 'Very Unlikely'],
    ),
  ];

  static Future<Uint8List> generateBytes() async {
    final PdfDocument document = PdfDocument();
    final PdfPage page = document.pages.add();
    final PdfGraphics graphics = page.graphics;
    final Size pageSize = page.getClientSize();

    final PdfFont questionFont =
        PdfStandardFont(PdfFontFamily.helvetica, 11, style: PdfFontStyle.bold);
    final PdfFont optionFont = PdfStandardFont(PdfFontFamily.helvetica, 10);
    final PdfPen linePen = PdfPen(PdfColor(200, 60, 60));
    final PdfPen circlePen = PdfPen(PdfColor(60, 60, 60));

    double y = 0;

    // Name / Date line.
    graphics.drawString('Name', optionFont, bounds: Rect.fromLTWH(0, y, 40, 16));
    graphics.drawLine(linePen, Offset(45, y + 14), Offset(260, y + 14));
    graphics.drawString('Date', optionFont,
        bounds: Rect.fromLTWH(280, y, 35, 16));
    graphics.drawLine(linePen, Offset(320, y + 14), Offset(pageSize.width, y + 14));
    y += 34;

    for (final question in _questions) {
      final Size questionSize = questionFont.measureString(question.text,
          layoutArea: Size(pageSize.width, double.infinity));
      graphics.drawString(question.text, questionFont,
          bounds: Rect.fromLTWH(0, y, pageSize.width, questionSize.height));
      y += questionSize.height + 4;

      for (final option in question.options) {
        graphics.drawEllipse(Rect.fromLTWH(4, y + 3, 6, 6), pen: circlePen);
        graphics.drawString(option, optionFont,
            bounds: Rect.fromLTWH(16, y, pageSize.width - 16, 14));
        y += 16;
      }
      y += 6;
    }

    final List<int> pdfBytes = await document.save();
    document.dispose();
    return Uint8List.fromList(pdfBytes);
  }
}
