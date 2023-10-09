import 'package:flutter/material.dart';
import 'package:hotel_hunter/Models/AppConstants.dart';
import 'package:hotel_hunter/Screens/accountPage.dart';
import 'package:hotel_hunter/Screens/bookingsPage.dart';
import 'package:hotel_hunter/Screens/inboxPage.dart';
import 'package:hotel_hunter/Screens/myPostingsPage.dart';
import 'package:hotel_hunter/Views/textWidgets.dart';


class HostHomePage extends StatefulWidget {

  static const String routeName = 'hostHomePageRoute';
  const HostHomePage({super.key});

  @override
  State<HostHomePage> createState() => _hostHomePageState();
}

class _hostHomePageState extends State<HostHomePage> {

  int _selectedIndex = 3;
  final List<String> _pageTitles = [
    'MyBookings',
    'My Postings',
    'Inbox',
    'Profile',
  ];

  final List<Widget> _pages = [
    const BookingsPage(),
    const MyPostingsPage(),
    const InboxPage(),
    const AccountPage(),
    
  ];

  BottomNavigationBarItem _buildNavigationItem(int index, IconData iconData, String text){
    return BottomNavigationBarItem(
      icon: Icon(iconData, color: AppConstants.highlightColor,),
      activeIcon: Icon(iconData, color: AppConstants.accentColor,),
      label: 
        text,
       // automaticallyApplyLeading: false,
       //centreTitle: true,
      //   style: TextStyle(
      //     color: _selectedIndex == index?AppConstants.selectedIconColor : AppConstants.nonSelectedIconColor,
        
      // ),
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
          _buildNavigationItem(0, Icons.calendar_today, _pageTitles[0]),
          _buildNavigationItem(1, Icons.home, _pageTitles[1]),
          _buildNavigationItem(2, Icons.message, _pageTitles[2]),
          _buildNavigationItem(3, Icons.person_outline, _pageTitles[3]),
        ],
        ),
 // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}



