import 'dart:io';

class ConnectivityService {
  Future<bool> get isOnline async {
    try {
      var result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}