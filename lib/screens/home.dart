import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool auth = false;

  final gsi = GoogleSignIn();

  handleSignIn(GoogleSignInAccount? account) {
    if (account != null) {
      print('Account: ${account.toString()}');
      setState(() {
        auth = true;
      });
    } else {
      setState(() {
        auth = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    gsi.onCurrentUserChanged.listen((account) => handleSignIn(account));
    gsi.signInSilently().then((account) => handleSignIn(account));
  }

  Widget buildUnauthScreen() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.amber, Colors.purple],
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Fluttergram",
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
            GestureDetector(
              onTap: () {
                gsi.signIn();
              },
              child: Container(
                width: MediaQuery.of(context).size.width * .9,
                height: 60,
                decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/google-login.png'))),
              ),
            )
          ],
        ),
      ),
    );
  }

  buildAuthScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: ElevatedButton(
            onPressed: () {
              gsi.signOut();
            },
            child: Text('Logout')),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: auth ? buildAuthScreen() : buildUnauthScreen(),
    );
  }
}
