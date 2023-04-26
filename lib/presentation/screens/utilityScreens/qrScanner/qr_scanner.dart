import 'package:fablearner_app/exports/common_exports.dart';
import 'package:fablearner_app/exports/presentation_exports.dart';

class QrScanner extends StatelessWidget {
  final String token;

  const QrScanner({Key? key, required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QrScannerController>(
      init: QrScannerController(
        token: token,
      ),
      builder: (controller) {
        return Scaffold(
          backgroundColor: secondaryColor,
          body: Column(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Stack(
                  children: [
                    QRView(
                      key: controller.qrKey,
                      onQRViewCreated: controller.onQRViewCreated,
                      overlay: QrScannerOverlayShape(
                        borderColor: primaryColor,
                        borderRadius: 10,
                        borderLength: 30,
                        borderWidth: 10,
                        cutOutSize: 300,
                      ),
                    ),
                    if (controller.scanning)
                      const Center(
                        child: SpinKitThreeBounceAnimation(),
                      ),
                    if (controller.error.isNotEmpty)
                      Center(
                        child: Text(
                          controller.error,
                          style: AppStyles.errorTextStyle,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
