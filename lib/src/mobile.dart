import 'package:google_sign_in/google_sign_in.dart' as google;

import 'interface.dart' as i;

GoogleSignIn setupGoogleSignIn({
  List<String> scopes,
  String webClientId,
  String webSecret,
}) {
  return GoogleSignIn._(google.GoogleSignIn(scopes: scopes));
}

class GoogleSignIn implements i.GoogleSignIn {
  final google.GoogleSignIn _googleSignIn;

  GoogleSignIn._(this._googleSignIn);

  @override
  List<String> get scopes => _googleSignIn.scopes;

  @override
  Future<i.AuthCredentials> signIn() async {
    final googleSignInAccount = await _googleSignIn.signIn();
    final auth = await googleSignInAccount.authentication;

    return AuthCredentials(
      accessToken: auth.accessToken,
      idToken: auth.idToken,
    );
  }
}

class AuthCredentials implements i.AuthCredentials {
  AuthCredentials({this.accessToken, this.idToken});

  final String accessToken;
  final String idToken;
}