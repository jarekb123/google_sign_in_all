library google_sign_in_all;

abstract class GoogleSignIn {
  List<String> get scopes;

  Future<AuthCredentials> signIn();
}

abstract class AuthCredentials {
  String get accessToken;
  String get idToken;
}


GoogleSignIn setupGoogleSignIn({
  List<String> scopes,
  String webClientId,
  String webSecret,
}) {
  throw Exception('Unsupported environment');
}