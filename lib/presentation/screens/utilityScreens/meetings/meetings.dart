import 'package:fablearner_app/exports/presentation_exports.dart';
import 'package:fablearner_app/exports/common_exports.dart';

class Meetings extends StatefulWidget {
  const Meetings({Key? key}) : super(key: key);

  @override
  _MeetingsState createState() => _MeetingsState();
}

class _MeetingsState extends State<Meetings> {
  bool _isLoading = true;
  late WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Meetings',
        centerTitle: false,
        showBackButton: true,
        onBackButtonPressed: () {
          Get.back();
        },
      ),
      backgroundColor: secondaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            WebView(
              initialUrl: 'https://fablearner.online/Meetings/',
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: (_) {
                setState(() {
                  _isLoading = false;
                });
              },
              onWebViewCreated: (controller) {
                _webViewController = controller;
              },
            ),
            if (_isLoading) const SpinKitThreeBounceAnimation(),
          ],
        ),
      ),
    );
  }
}
