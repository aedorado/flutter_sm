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
  int pageIndex = 0;
  late PageController pageController;

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
    gsi.signInSilently().then((account) => handleSignIn(account));
    pageController = PageController(initialPage: this.pageIndex);
    gsi.onCurrentUserChanged.listen((account) => handleSignIn(account));
  }

  Widget buildUnauthScreen() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Theme.of(context).primaryColor, Theme.of(context).accentColor],
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
      appBar: AppBar(
        title: Text('Flutter Gram'),
      ),
      body: PageView(
        controller: pageController,
        children: [
          Text('Timeline'),
          Text('Search'),
          Text('Post'),
          Text('Notifications'),
          Text('Profile'),
        ],
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: this.pageIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: (index) {
          setState(() {
            this.pageIndex = index;
          });
          pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Timeline'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.photo_camera,
                size: 32,
              ),
              label: 'Upload'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Profile'),
        ],
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
