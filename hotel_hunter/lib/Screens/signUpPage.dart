import 'package:flutter/material.dart';
import 'package:hotel_hunter/Models/AppConstants.dart';
import 'package:hotel_hunter/Screens/guestHomePage.dart';
import 'package:hotel_hunter/Views/textWidgets.dart';

class SignUpPage extends StatefulWidget {

  static const String routeName = '/signUpPageRoute';
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  void _signUp(){
  Navigator.pushNamed(context, guestHomePage.routeName);
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const AppBarText(text: 'Sign Up'),
        ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(50, 50, 50, 0),
            child: Column(
          
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Text('Please enter the following information',    
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  
                ),
                textAlign: TextAlign.center,
                ),
              
                Form(child: Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 35.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'First Name'),
                          style: const TextStyle(
                  fontSize: 25,
                  
                ),
                    ),
                    
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: TextFormField(
                        decoration: const InputDecoration(
                        labelText: 'Last Name'),
                           style: const TextStyle(
                  fontSize: 25,
                  
                ),
                    ),
                    
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: TextFormField(
                        decoration: const InputDecoration(
                        labelText: 'Password'),
                           style: const TextStyle(
                  fontSize: 25,
                  
                ),
                    ),
                    
                  ),
                          Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: TextFormField(
                        decoration: const InputDecoration(
                        labelText: 'City'),
                           style: const TextStyle(
                  fontSize: 25,
                  
                ),
                    ),
                    
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: TextFormField(
                        decoration: const InputDecoration(
                        labelText: 'Country'),
                           style: const TextStyle(
                  fontSize: 25,
                  
                ),
                    ),
                    
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: TextFormField(
                        decoration: const InputDecoration(
                        labelText: 'Bio'),
                           style: const TextStyle(
                  fontSize: 25,
                  
                ),
                    ),
                    
                  )
                ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0, bottom: 40.0),
                  child: MaterialButton(
                    onPressed: (){_signUp();},
                    color: AppConstants.primaryColor,
                     height: MediaQuery.of(context).size.height/15,
                    minWidth: double.infinity,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: const Text('Submit',
                    style: TextStyle(
                       fontWeight: FontWeight.bold,
                      fontSize: 25,
                    )),
        
                ),
                ),
                   
              ],
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}



