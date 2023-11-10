import 'package:flutter/material.dart';
import 'package:hotel_hunter/Models/AppConstants.dart';
import 'package:hotel_hunter/Screens/WorkersAppliedPage.dart';
import 'package:hotel_hunter/Screens/accountPage.dart';
import 'package:hotel_hunter/Screens/inboxPage.dart';
import 'package:hotel_hunter/Screens/savedPage.dart';
import 'package:hotel_hunter/Screens/tripsPage.dart';
import 'package:hotel_hunter/Views/textWidgets.dart';
import 'explorePage.dart';

class workersHomePage extends StatefulWidget {

  static const String routeName = 'workersHomePageRoute';
  const workersHomePage({super.key});

  @override
  State<workersHomePage> createState() => _workersHomePageState();
}

class _workersHomePageState extends State<workersHomePage> {

  int _selectedIndex = 0;
  final List<String> _pageTitles = [
    'Explore',
    'Applied',
    'Inbox',
    'Profile',
  ];

  final List<Widget> _pages = [
    const ExplorePage(),
    const AppliedPage(),
    const InboxPage(),
    const AccountPage(),
    
  ];

  BottomNavigationBarItem _buildNavigationItem(int index, IconData iconData, String text){
    return BottomNavigationBarItem(
      icon: Icon(iconData, color: AppConstants.highlightColor,),
      activeIcon: Icon(iconData, color: AppConstants.accentColor,),
      label: 
        text, 
      );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: AppBarText(text: _pageTitles[_selectedIndex]),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          setState((){
            _selectedIndex = index;
          });
        },
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          _buildNavigationItem(0, Icons.search, _pageTitles[0]),
          _buildNavigationItem(1, Icons.favorite_border, _pageTitles[1]),
          _buildNavigationItem(2, Icons.hotel, _pageTitles[2]),
          _buildNavigationItem(3, Icons.person_outline, _pageTitles[3]),
        ],
        ),
 // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}



