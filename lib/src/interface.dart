library google_sign_in_all;

abstract class GoogleSignIn {
  List<String> get scopes;

  Future<AuthCredentials> signIn();
  Future<GoogleAccount> getCurrentUser();
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

// copied from google_sign_in package
class GoogleAccount {
  GoogleAccount({this.id, this.email, this.displayName, this.photoUrl});

  /// The unique ID for the Google account.
  ///
  /// This is the preferred unique key to use for a user record.
  ///
  /// _Important_: Do not use this returned Google ID to communicate the
  /// currently signed in user to your backend server. Instead, send an ID token
  /// which can be securely validated on the server.
  /// `GoogleSignInAccount.authentication.idToken` provides such an ID token.
  final String id;

  /// The email address of the signed in user.
  ///
  /// Applications should not key users by email address since a Google
  /// account's email address can change. Use [id] as a key instead.
  ///
  /// _Important_: Do not use this returned email address to communicate the
  /// currently signed in user to your backend server. Instead, send an ID token
  /// which can be securely validated on the server.
  /// `GoogleSignInAccount.authentication.idToken` provides such an ID token.
  final String email;

  /// The display name of the signed in user.
  ///
  /// Not guaranteed to be present for all users, even when configured.
  final String displayName;

  /// The photo url of the signed in user if the user has a profile picture.
  ///
  /// Not guaranteed to be present for all users, even when configured.
  final String photoUrl;
}
