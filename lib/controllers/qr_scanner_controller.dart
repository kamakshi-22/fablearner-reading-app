import 'package:fablearner_app/exports/common_exports.dart';
import 'package:fablearner_app/exports/presentation_exports.dart';
import 'package:fablearner_app/presentation/screens/utilityScreens/qrScanner/qr_lesson_screen.dart';

class QrScannerController extends GetxController {
  
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR'); // GlobalKey for the QR view
  late QRViewController controller; // Create a QR view controller
  String error = ''; // Initialize a variable to store the error
  bool scanning =true; // Indicate if the scanner is currently scanning
  final String token; // Create a variable to store the token

  QrScannerController({
    required this.token, // Require the token parameter
  }); // Initialize the result variable

  @override
  void onClose() {
    controller.pauseCamera();
    controller.dispose(); // Dispose the controller when the view is closed
    scanning = true; // Reset the scanning variable
    super.onClose(); // Call the parent
  }

  void onQRViewCreated(QRViewController controller) async {
    controller.pauseCamera(); // Pause the camera when the QR view is created
    controller.resumeCamera(); // Resume the camera to start scanning
    this.controller =
        controller; // Set the controller variable to the created controller
    await scanningCode(controller);
  }

  Future<StreamSubscription<Barcode>> scanningCode(
      QRViewController controller) async {
    return controller.scannedDataStream.listen(
      (scanData) async {
        // Get the scanned result from the scanData object
        String scannedResult = scanData.code!;

        // Parse the JSON string into a Map
        Map<String, dynamic> data = {};
        try {
          data = json.decode(scannedResult);
        } catch (e) {
          error = 'Invalid QR Code';
        }

        // Check if the "id" key is present in the data
        if (!data.containsKey('id')) {
          error = 'Invalid ID';
          scanning = false;
          controller.pauseCamera();
          update(); // Update the UI to reflect the new state
          return;
        }

        // Access the value of the "id" key and print it
        int oldId = int.parse(data['id']);

        // Load the JSON file into a Map
        String jsonString =
            await rootBundle.loadString('assets/files/mappings.json');
        List<dynamic> mappings = json.decode(jsonString);

        // Find the new ID from the mappings list
        // If the old ID is not found, use the old ID as the new ID
        int newId = mappings.firstWhere(
          (m) => m['Old ID'] == oldId,
          orElse: () => {'New ID': oldId},
        )['New ID'];

        scanning = false; // Stop scanning when the ID is found
        update(); // Update the UI to reflect the new state
        
        // Navigate to the lesson details screen with the new ID and token
        Get.to(
          () => QRLessonScreen(
            lessonId: newId,
            token: token,
          ),
          duration: 800.milliseconds,
          transition: Transition.rightToLeft,
        );
      },
      onError: (exception) {
        controller.pauseCamera();
        error = exception;
        update(); // Update the UI to reflect the new state
      },
    );
  }
}
