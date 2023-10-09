import 'package:flutter/material.dart';
import 'package:hotel_hunter/Models/UserObjects.dart';

class AppConstants{
  static const String appName = "Event.Ualy";
  static const String googleMapsAPIKey = "AIzaSyAGLOWueKhIv8GJAv6N8f9qu7UUl5vHFww";

  static const Color selectedIconColor = Colors.deepOrange;
  static const Color nonSelectedIconColor = Colors.black;

  //core colours
static const Color primaryColor = Color.fromARGB(255, 81, 118, 100);
static const Color secondaryColor = Color.fromARGB(255, 214, 229, 227);
static const Color highlightColor = Color.fromARGB(255, 159, 216, 203);
static const Color backgroundColor = Color.fromARGB(255, 222, 229, 236);
static const Color accentColor = Color.fromARGB(255, 4, 51, 25);
// static UserObj? currentUser; 
static UserObj? currentUser = UserObj(); 

static bool isHosting = false;
static bool isWorking = false;

  static final Map<int, String> monthDict ={
    1: "January",
    2: "February",
    3: "March",
    4: "April",
    5: "May",
    6: "June",
    7: "July",
    8: "August",
    9: "September",
    10: "October",
    11: "November",
    12: "December",
  };

  static final Map<int, int> daysInMonths ={
    1: 31,
    2: DateTime.now().year%4==0?29: 28,
    3: 31,
    4: 30,
    5: 31,
    6: 30,
    7: 31,
    8: 31,
    9: 30,
    10: 31,
    11: 30,
    12: 31,
  };
}