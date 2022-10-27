import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';

class BaseViewModel extends ChangeNotifier {
  late StreamSubscription<ConnectivityResult> subscription;
  late Widget child;
  late bool connected = true;
  late ConnectivityResult connectivityResult;

  void initStates() {
    isConnected();
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi || result == ConnectivityResult.ethernet) {
        connected = true;
      } else if (result == ConnectivityResult.none) {
        connected = false;
      }
      notifyListeners();
    });
  }

  Future isConnected() async {
    connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.ethernet) {
      connected = true;
    } else {
      connected = false;
    }
    notifyListeners();
  }
}
