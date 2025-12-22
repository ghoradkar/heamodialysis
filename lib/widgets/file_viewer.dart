import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ImageViewer extends StatelessWidget {
  final String fileUrl;
  final String patientName;

  const ImageViewer(
      {super.key, required this.fileUrl, required this.patientName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          patientName,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      // body: fileUrl.toLowerCase().endsWith('.pdf')
      //     ? PdfViewer(fileUrl: fileUrl)
      //     : ImageView(imageUrl: fileUrl),
      body: Image.network(fileUrl),
    );
  }
}

class FileViewer extends StatefulWidget {
  final String fileUrl;
  final String patientName;

  const FileViewer({
    super.key,
    required this.fileUrl,
    required this.patientName,
  });

  @override
  State<FileViewer> createState() => _FileViewerState();
}

class _FileViewerState extends State<FileViewer> {
  late WebViewController _webViewController;
  bool isLoading = true;

  bool get isPdf =>
      widget.fileUrl.toLowerCase().endsWith('.pdf') ||
          widget.fileUrl.contains('report.php');

  bool get isDynamicPdf => widget.fileUrl.contains('report.php');

  @override
  void initState() {
    super.initState();
    if (isDynamicPdf) {
      _webViewController = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageFinished: (String url) {
              setState(() {
                isLoading = false;
              });
            },
            onPageStarted: (String url) {
              setState(() {
                isLoading = true;
              });
            },
          ),
        )
        ..loadRequest(Uri.parse(widget.fileUrl));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: Get.back,
        ),
        title: Text(
          widget.patientName,
          style: const TextStyle(color: Colors.black, fontSize: 18),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Stack(
        children: [
          if (isDynamicPdf)
            WebViewWidget(controller: _webViewController)
          else if (isPdf)
            SfPdfViewer.network(widget.fileUrl)
          else
            Image.network(
              widget.fileUrl,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Text(
                    "Unable to load file",
                    style: TextStyle(color: Colors.red),
                  ),
                );
              },
            ),
          if (isLoading && isDynamicPdf)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
