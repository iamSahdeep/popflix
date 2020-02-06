import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';

class NetworkHandlerPM extends ChangeNotifier {
  NetworkHandlerPM() {
    firstCheck();
    Connectivity().onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.none) {
        isConnected = false;
      } else
        isConnected = true;
      notifyListeners();
    });
  }

  bool isConnected = false;

  void firstCheck() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      isConnected = false;
    } else
      isConnected = true;

    notifyListeners();
  }
}
