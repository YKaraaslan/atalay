import 'package:flutter/cupertino.dart';

class SocialViewModel extends ChangeNotifier {
  late int currentIndex = 0;

  void setPage(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
