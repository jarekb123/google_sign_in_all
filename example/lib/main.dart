import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_sign_in_all/google_sign_in_all.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final signIn = useMemoized(
      () => setupGoogleSignIn(
        scopes: [
          'https://www.googleapis.com/auth/userinfo.email',
          'https://www.googleapis.com/auth/userinfo.profile',
        ],
        webClientId: 'webClientId',
        webSecret: 'webSecret',
      ),
    );

    final accessToken = useState('');
    final username = useState('');

    final onSignIn = () async {
      final credentials = await signIn.signIn();
      final user = await signIn.getCurrentUser();

      accessToken.value = credentials.accessToken;
      username.value = user.displayName;
    };

    return Scaffold(
      body: Column(
        children: <Widget>[
          Text('Access Token: ${accessToken.value}'),
          Text('Username: ${username.value}'),
          RaisedButton(
            child: Text('Sign In'),
            onPressed: onSignIn,
          )
        ],
      ),
    );
  }
}
