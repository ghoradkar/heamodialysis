import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomWebview extends StatefulWidget {
  final String htmlText;

  const CustomWebview({super.key, required this.htmlText});

  @override
  State<CustomWebview> createState() => _CustomWebviewState();
}

class _CustomWebviewState extends State<CustomWebview> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    debugPrint("InitState: ${widget.htmlText}");

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (int progress) {},
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onHttpError: (HttpResponseError error) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          return NavigationDecision.navigate;
        },
      ));

    _loadHtml(widget.htmlText);
  }

  @override
  void didUpdateWidget(covariant CustomWebview oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.htmlText != widget.htmlText) {
      debugPrint("Updating WebView: ${widget.htmlText}");
      _loadHtml(widget.htmlText);
    }
  }

  void _loadHtml(String content) {
    try {
      // If content is UTF-8 encoded, decode it; otherwise use as-is
      String decodedContent = content;

      // Only decode if content looks like it's encoded (contains escape sequences)
      if (content.contains('\\u')) {
        try {
          decodedContent = json.decode('"$content"');
        } catch (e) {
          decodedContent = content;
        }
      }

      String htmlContent = _buildHtml(decodedContent);

      controller.loadRequest(Uri.dataFromString(
        htmlContent,
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8'),
      ));
    } catch (e) {
      debugPrint("Error loading HTML: $e");
    }
  }

  String _buildHtml(String content) {
    return '''
    <!DOCTYPE html>
    <html>
      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Devanagari&display=swap" rel="stylesheet">
        <style>
          * {
            margin: 0;
            padding: 0;
          }
          body {
            font-family: 'Noto Sans Devanagari', Arial, sans-serif;
            font-size: 14px;
             font-weight: 400;
             background-color: #f2f2f2; 
            line-height: 1.5;
            padding: 16px;
          }
          p { margin-bottom: 12px; }
          img { max-width: 100%; height: auto; }
        </style>
      </head>
      <body>
        $content
      </body>
    </html>
    ''';
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
      key: ValueKey(widget.htmlText),
      controller: controller,
    );
  }
}
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class CustomWebview extends StatefulWidget {
//   final String htmlText;
//
//   const CustomWebview({super.key, required this.htmlText});
//
//   @override
//   State<CustomWebview> createState() => _CustomWebviewState();
// }
//
// class _CustomWebviewState extends State<CustomWebview> {
//   late final WebViewController controller;
//
//   @override
//   void initState() {
//     super.initState();
//     debugPrint("InitState: ${widget.htmlText}");
//
//     controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setNavigationDelegate(NavigationDelegate(
//         onProgress: (int progress) {},
//         onPageStarted: (String url) {},
//         onPageFinished: (String url) {},
//         onHttpError: (HttpResponseError error) {},
//         onWebResourceError: (WebResourceError error) {},
//         onNavigationRequest: (NavigationRequest request) {
//           return NavigationDecision.navigate;
//         },
//       ));
//
//     _loadHtml(widget.htmlText);
//   }
//
//   @override
//   void didUpdateWidget(covariant CustomWebview oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.htmlText != widget.htmlText) {
//       debugPrint("Updating WebView: ${widget.htmlText}");
//       _loadHtml(widget.htmlText);
//     }
//   }
//
//   void _loadHtml(String content) {
//     String encodedContent = utf8.decode(content.runes.toList()); // Ensure UTF-8 decoding
//
//     controller.loadRequest(Uri.dataFromString(
//       _buildHtml(encodedContent),
//       mimeType: 'text/html',
//       encoding: Encoding.getByName('utf-8'),
//     ));
//   }
//
//
//   String _buildHtml(String content) {
//     debugPrint("Final HTML: $_buildHtml(content)"); // Check final HTML before loading
//
//     return '''
//     <html>
//       <head>
//         <meta charset="UTF-8">
//         <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Devanagari&display=swap" rel="stylesheet">
//         <style>
//           body {
//             font-family: 'Noto Sans Devanagari', Arial, sans-serif;
//             font-size: 18px;
//           }
//         </style>
//       </head>
//       <body>
//         $content
//       </body>
//     </html>
//   ''';
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return WebViewWidget(
//         key: ValueKey(widget.htmlText),
//         controller: controller);
//   }
// }
