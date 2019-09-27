import 'package:google_sign_in/google_sign_in.dart' as google;

import 'interface.dart' as i;

export 'interface.dart' show GoogleAccount;

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

  @override
  Future<i.GoogleAccount> getCurrentUser() {
    return Future.value(_googleSignIn.currentUser).then(_toGoogleAccount);
  }

  i.GoogleAccount _toGoogleAccount(
      google.GoogleSignInAccount googleSignInAccount) {
    return i.GoogleAccount(
      id: googleSignInAccount.id,
      email: googleSignInAccount.email,
      displayName: googleSignInAccount.displayName,
      photoUrl: googleSignInAccount.photoUrl,
    );
  }
}

class AuthCredentials implements i.AuthCredentials {
  AuthCredentials({this.accessToken, this.idToken});

  final String accessToken;
  final String idToken;
}
