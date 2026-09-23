import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class SslPinningClient {
  static Future<http.Client> create() async {
    HttpClient client = HttpClient(
      context: SecurityContext(withTrustedRoots: true),
    );

    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) {
          if (host == 'api.themoviedb.org') {
            return true;
          }
          return false;
        };
    return IOClient(client);
  }
}
