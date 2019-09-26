import 'dart:convert';

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

  AutoRefreshingAuthClient _httpClient;

  @override
  Future<i.AuthCredentials> signIn() async {
    final oauthFlow = await _createBrowserFlow(_clientId, scopes);
    _httpClient = await oauthFlow.clientViaUserConsent();

    final credentials = AuthCredentials(
      accessToken: _httpClient.credentials.accessToken.data,
      idToken: _httpClient.credentials.idToken,
    );

    return credentials;
  }

  @override
  Future<i.GoogleAccount> getCurrentUser() async {
    final response =
        await _httpClient.get('https://www.googleapis.com/oauth2/v2/userinfo');
    final Map<String, dynamic> jsonBody = json.decode(response.body);

    print(jsonBody.toString());

    return i.GoogleAccount(
      id: jsonBody['id'],
      email: jsonBody['email'],
      displayName: jsonBody['name'],
      photoUrl: jsonBody['picture'],
    );
  }
}

class AuthCredentials implements i.AuthCredentials {
  AuthCredentials({this.accessToken, this.idToken});

  final String accessToken;
  final String idToken;
}
