import 'package:fablearner_app/exports/business_exports.dart';
import 'package:fablearner_app/exports/presentation_exports.dart';
import 'package:fablearner_app/exports/common_exports.dart';

class MeetingsScreen extends StatefulWidget {
  const MeetingsScreen({Key? key}) : super(key: key);

  @override
  MeetingsScreenState createState() => MeetingsScreenState();
}

class MeetingsScreenState extends State<MeetingsScreen> {
  bool _isLoading = true;
  late WebViewController webViewController;

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
              initialUrl: ApiConfig.meetingsUrl,
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
