import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  final String name;

  const WebViewPage({super.key, required this.url, required this.name});

  @override
  WebViewPageState createState() => WebViewPageState();
}

class WebViewPageState extends State<WebViewPage> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          iconSize: 25,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(widget.name, style: const TextStyle(fontSize: 22)),
      ),
      body: Stack(
        children: [
          WebView(
            gestureNavigationEnabled: true,
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            onPageStarted: (progress) {
              setState(() {
                _isLoading = true;
              });
            },
            onPageFinished: (progress) {
              setState(() {
                _isLoading = false;
              });
            },
            onWebResourceError: (error) => Center(
              child: Text('Error: ${error.description}'),
            ),
          ),
          if (_isLoading)
            const Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            )),
        ],
      ),
    );
  }
}
