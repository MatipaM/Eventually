import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hotel_hunter/Models/AppConstants.dart';
import 'package:hotel_hunter/Screens/BookPostingPage.dart';
import 'package:hotel_hunter/Screens/ViewWorkerPostingPage.dart';
import 'package:hotel_hunter/Screens/conversationPage.dart';
import 'package:hotel_hunter/Screens/explorePage.dart';
import 'package:hotel_hunter/Screens/guestHomePage.dart';
import 'package:hotel_hunter/Screens/hostHomePage.dart';
import 'package:hotel_hunter/Screens/loginPage.dart';
import 'package:hotel_hunter/Screens/personalInfo.dart';
import 'package:hotel_hunter/Screens/signUpPage.dart';
import 'package:hotel_hunter/Screens/CreatePostingPage.dart';
import 'package:hotel_hunter/Screens/workersHomePage.dart';

import 'package:firebase_core/firebase_core.dart';

 void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

    
    //options: DefaultFirebaseOptions.currentPlatform,
    options: const FirebaseOptions(  
      apiKey: "AIzaSyD6aXcPCJA0cZrRQTjehxhNQwSZb95b9ao",
  databaseURL: "https://eventually-183fb-default-rtdb.firebaseio.com",
  projectId: "eventually-183fb",
  messagingSenderId: "732313027588",
  appId: "1:732313027588:web:932fa4236ad909a3a86151",
  storageBucket: "eventually-183fb.appspot.com",
)
  );
  runApp(const MyApp());
} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppConstants.primaryColor),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
      routes:{
        LoginPage.routeName:(context)=>const LoginPage(),
        SignUpPage.routeName:(context)=>const SignUpPage(),
        guestHomePage.routeName: (context) => const guestHomePage(),
        PersonalInfoPage.routeName: (context) =>  const PersonalInfoPage(),
        //ViewProfilePage.routeName: (context)=> ViewProfilePage(),
        // ViewPostingPage.routeName: (context) => ViewPostingPage(),
        BookPostingPage.routeName: (context) => const BookPostingPage(),
        ConversationPage.routeName: (context) => const ConversationPage(),
        HostHomePage.routeName: (context) => const HostHomePage(),
        CreatePostingPage.routeName: (context) => const CreatePostingPage(),
        workersHomePage.routeName: (context) => const workersHomePage(),
        ExplorePage.routeName: (context) => const ExplorePage(),
        //TandCPage.routeName: (context) => TandCPage(),
      }
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState(){

    Timer(const Duration(seconds: 2), (){
      Navigator.pushNamed(context, LoginPage.routeName);
    });

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return const Scaffold(

      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          
          children: <Widget>[
            Icon(Icons.hotel,
            size:80,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text(AppConstants.appName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
               ),
               textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

