import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class ImageToPdfConverter {
  static Future<File> convert(File imageFile, {String? outputFileName}) async {
    final Uint8List imageBytes = await imageFile.readAsBytes();

    final PdfDocument document = PdfDocument();
    final PdfPage page = document.pages.add();
    final PdfBitmap image = PdfBitmap(imageBytes);

    final Size pageSize = page.getClientSize();
    double drawWidth = pageSize.width;
    double drawHeight = drawWidth * image.height / image.width;
    if (drawHeight > pageSize.height) {
      drawHeight = pageSize.height;
      drawWidth = drawHeight * image.width / image.height;
    }
    final double offsetX = (pageSize.width - drawWidth) / 2;
    final double offsetY = (pageSize.height - drawHeight) / 2;

    page.graphics.drawImage(
      image,
      Rect.fromLTWH(offsetX, offsetY, drawWidth, drawHeight),
    );

    final List<int> pdfBytes = await document.save();
    document.dispose();

    final Directory tempDir = await getTemporaryDirectory();
    final String fileName =
        outputFileName ?? 'HD_Chart_${DateTime.now().millisecondsSinceEpoch}.pdf';
    final File pdfFile = File('${tempDir.path}/$fileName');
    return pdfFile.writeAsBytes(pdfBytes, flush: true);
  }
}
