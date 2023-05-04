import 'package:fablearner_app/exports/presentation_exports.dart';
import 'package:fablearner_app/exports/common_exports.dart';
import 'package:fablearner_app/exports/business_exports.dart';

class HelpDesk extends StatefulWidget {
  const HelpDesk({Key? key}) : super(key: key);

  @override
  HelpDeskState createState() => HelpDeskState();
}

class HelpDeskState extends State<HelpDesk> {
  bool _isLoading = true;
  late WebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            WebView(
              initialUrl: ApiConfig.helpDeskUrl,
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: (_) {
                setState(() {
                  _isLoading = false;
                });
              },
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
            ),
            if (_isLoading) const LoadingAnimation(),
          ],
        ),
      ),
    );
  }
}
