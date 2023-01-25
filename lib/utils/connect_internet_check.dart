import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityChangeNotifier {
  final Connectivity _connectivity = Connectivity();

  Future<bool> checkConnectivity() async {
    bool isInternetOn = false;
    ConnectivityResult connectivityResult =
        await (_connectivity.checkConnectivity());
    var connectInternet = getConnectionValue(connectivityResult);
    if (connectInternet != 'None') {
      isInternetOn = true;
    }
    return isInternetOn;
  }

  // Method to convert the connectivity to a string value
  String getConnectionValue(ConnectivityResult result) {
    String status = '';
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        status = result.toString();
        break;
      case ConnectivityResult.none:
        status = 'None';
        break;
      default:
        status = 'None';
        break;
    }
    return status;
  }
}
