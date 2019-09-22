import 'package:googleapis_auth/auth_browser.dart';

import 'interface.dart' as i;

typedef Future<BrowserOAuth2Flow> CreateBrowserFlow(
    ClientId clientId, List<String> scopes);

GoogleSignIn setupGoogleSignIn({
  List<String> scopes,
  String webClientId,
  String webSecret,
}) {
  return GoogleSignIn._(scopes, ClientId(webClientId, webSecret));
}

class GoogleSignIn implements i.GoogleSignIn {
  GoogleSignIn._(this.scopes, this._clientId,
      [this._createBrowserFlow = createImplicitBrowserFlow]);

  @override
  final List<String> scopes;

  final ClientId _clientId;
  final CreateBrowserFlow _createBrowserFlow;

  @override
  Future<i.AuthCredentials> signIn() async {
    final oauthFlow = await _createBrowserFlow(_clientId, scopes);
    final accessCredentials =
        await oauthFlow.obtainAccessCredentialsViaUserConsent();

    return AuthCredentials(
      accessToken: accessCredentials.accessToken.data,
      idToken: accessCredentials.idToken,
    );
  }
}

class AuthCredentials implements i.AuthCredentials {
  AuthCredentials({this.accessToken, this.idToken});

  final String accessToken;
  final String idToken;
}
