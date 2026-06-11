import 'dart:io';

import 'package:flutter/services.dart';

/// Creates an [HttpClient] with SSL certificate pinning for api.themoviedb.org.
///
/// The certificate (PEM format) is loaded from the Flutter assets bundle and
/// added to a custom [SecurityContext] so that only the pinned server
/// certificate is trusted for TMDB API calls.
Future<HttpClient> createPinnedHttpClient() async {
  final sslCert = await rootBundle.load('assets/themoviedb.cer');
  final securityContext = SecurityContext(withTrustedRoots: false);
  securityContext.setTrustedCertificatesBytes(sslCert.buffer.asUint8List());

  final httpClient = HttpClient(context: securityContext)
    ..badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;

  return httpClient;
}
