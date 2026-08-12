import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class CustomViewer extends StatelessWidget {
  final String fileUrl; // Single file URL or path (image or PDF)


  const CustomViewer({super.key, required this.fileUrl});

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
        title:  const Text(
          "View File",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: fileUrl.toLowerCase().endsWith('.pdf')
          ? PdfViewer(fileUrl: fileUrl)
          : ImageView(imageUrl: fileUrl),

    );
  }
}

class ImageView extends StatefulWidget {
  final String imageUrl;

  const ImageView({super.key, required this.imageUrl});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  bool hasInternet = true;

  @override
  void initState() {
    checkInternetAndLoadData();
    super.initState();
  }

  checkInternetAndLoadData() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) ||
          connectivityResult.contains(ConnectivityResult.wifi));
    });
  }

  @override
  Widget build(BuildContext context) {
    return hasInternet || File(widget.imageUrl).existsSync()
        ? PhotoViewGallery.builder(
      itemCount: 1,
      builder: (context, index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: File(widget.imageUrl).existsSync()
              ? FileImage(File(widget.imageUrl))
              : NetworkImage(widget.imageUrl) as ImageProvider,
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 2,
        );
      },
      scrollPhysics: const BouncingScrollPhysics(),
      backgroundDecoration: const BoxDecoration(
        color: Colors.black,
      ),
      pageController: PageController(),
    ).paddingSymmetric(vertical: 10, horizontal: 10)
        : InternetIssue(onRetryPressed: () {
      checkInternetAndLoadData();
    }, );
  }
}

class PdfViewer extends StatefulWidget {
  final String fileUrl;

  const PdfViewer({super.key, required this.fileUrl});

  @override
  PdfViewerState createState() => PdfViewerState();
}

class PdfViewerState extends State<PdfViewer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: File(widget.fileUrl).existsSync()
              ? SfPdfViewer.file(File(widget.fileUrl))
              : SfPdfViewer.network(widget.fileUrl),
        ),
      ],
    );
  }
}
