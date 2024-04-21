
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class webPages extends StatefulWidget {
  String url;
  webPages({Key? key,required this.url}) : super(key: key);

  @override
  State<webPages> createState() => _webPagesState();
}

class _webPagesState extends State<webPages> {
  @override
  Widget build(BuildContext context) {
    print("https://www.instamojo.com/@NAJARASTAYS/${widget.url}");
    return SafeArea(
      child: Scaffold(
          body: WebView(
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: "https://www.instamojo.com/@NAJARASTAYS/51a9593cdfd549eea60dc9bda4ad1891",
            onPageFinished: (url) {
              print("");
               Navigator.pop(context);
            },
          )
      ),
    );
  }
}
