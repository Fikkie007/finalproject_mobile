import 'package:flutter/material.dart';
import 'package:my_first_app/providers/AuthProvider.dart';
import 'package:my_first_app/screens/categories.dart';
import 'package:my_first_app/screens/listEmploye.dart';
import 'package:my_first_app/screens/transactions.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  List<Widget> widgetOptions = [ListEmploye(), Transactions(), Categories()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Remula"),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                //
              },
            ),
          ],
          elevation: 0,
        ),
        body: SafeArea(child: widgetOptions.elementAt(selectedIndex)),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 4,
          child: BottomNavigationBar(
            backgroundColor: Theme.of(context).primaryColor.withAlpha(0),
            elevation: 0,
            type: BottomNavigationBarType.shifting,
            selectedIconTheme: IconThemeData(color: Colors.black),
            selectedItemColor: Colors.blue,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person_pin_rounded,
                    color: Colors.blue,
                  ),
                  label: 'List Service'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.account_balance_wallet,
                    color: Colors.blue,
                  ),
                  label: 'Transactions'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.category,
                    color: Colors.blue,
                  ),
                  label: 'Categories'),
            ],
            currentIndex: selectedIndex,
            onTap: onItemTapped,
          ),
        ),
      ),
    );
  }

  Future onLogoutClock() async {
    final AuthProvider provider =
        Provider.of<AuthProvider>(context, listen: false);
    await provider.logOut();
  }

  Future<void> onItemTapped(int index) async {
    setState(() {
      selectedIndex = index;
    });
  }
}
