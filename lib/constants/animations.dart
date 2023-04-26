import 'package:fablearner_app/exports/common_exports.dart';
import 'package:fablearner_app/exports/presentation_exports.dart';

class SpinKitThreeBounceAnimation extends StatelessWidget {

  const SpinKitThreeBounceAnimation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SpinKitThreeBounce(
      color: primaryColor,
      size: 50.0,
    );
  }
}
