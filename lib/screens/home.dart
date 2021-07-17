import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool auth = true;
  int pageIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
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
                "Flutter Social Media",
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
            GestureDetector(
              onTap: () {
                print("I was tapped.");
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

  Scaffold buildAuthScreen() {
    // return RaisedButton(child: Text('Logout'), onPressed: logout);
    return Scaffold(
      appBar: AppBar(
        title: Text('Fluttergram'),
      ),
      body: PageView(
        children: <Widget>[Text('Timeline'), Text('Upload'), Text('Search'), Text('Notifications'), Text('Profile')],
        controller: pageController,
        onPageChanged: (int pageIndex) {
          setState(() {
            this.pageIndex = pageIndex;
          });
        },
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (pageIndex) {
          pageController.animateToPage(
            pageIndex,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.amber,
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home_filled),
          ),
          BottomNavigationBarItem(
            label: 'Search',
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            label: 'Upload',
            icon: Icon(
              Icons.upload,
              size: 35.0,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Notifications',
            icon: Icon(Icons.notifications),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.account_circle),
          ),
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
