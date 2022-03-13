import '../../../../core/service/service_path.dart';
import 'package:flutter/widgets.dart';

class SettingsViewModel extends ChangeNotifier {
  Future signOut(BuildContext context) async {
    await ServicePath.auth.signOut();
  }
}
