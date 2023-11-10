import 'package:flutter/material.dart';
import 'package:hotel_hunter/Views/textWidgets.dart';

class ChooseEventsPage extends StatefulWidget {

  static const String routeName = '/signUpPageRoute';
  const ChooseEventsPage({super.key});

  @override
  State<ChooseEventsPage> createState() => _ChooseEventsPageState();
}

class _ChooseEventsPageState extends State<ChooseEventsPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const AppBarText(text: 'Choose Interesting Events'),
        ),
      body: const Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(50, 50, 50, 0),
            child: Column(
          
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('Please select atleast 5 events you are interested in',    
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  
                ),
                textAlign: TextAlign.center,
                ),
              

              ],
              
              
            ),
            
          ),
          
        ),
        
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}



