import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotel_hunter/Models/AppConstants.dart';
import 'package:hotel_hunter/Screens/guestHomePage.dart';
import 'package:hotel_hunter/Screens/signUpPage.dart';
import 'package:hotel_hunter/Models/UserObjects.dart';


class LoginPage extends StatefulWidget {

  static const String routeName = '/loginPageRoute';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

final _formKey = GlobalKey<FormState>();

final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

void _signUp(){
  Navigator.pushNamed(context, SignUpPage.routeName);
}

_login() {

  if(_formKey.currentState!.validate()){
    
    String email = _emailController.text;
    String password = _passwordController.text;

    FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email,
    password: password,
  ).then((firebaseUser){
    String userID = firebaseUser.user!.uid;
    AppConstants.currentUser = UserObj(id:userID);
    AppConstants.currentUser!.getUserInfoFromFireStore().whenComplete(() => AppConstants.currentUser!.getImageFromStorage().whenComplete(() => Navigator.pushNamed(context, guestHomePage.routeName)

      )
    );
  });
    
  }
}

  

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 50, 50, 0),
          child: Column(
        
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // CircleAvatar(
              //   backgroundImage: AssetImage("Logo1.png"),
              // ),
               const Image(image: AssetImage("assets/images/Logo1.png")),
              //Text('Welcome to ${AppConstants.appName}!', 
              const Text('Welcome to the Event Finder!',    
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                
              ),
              textAlign: TextAlign.center,
              ),
            
              Form(
                key: _formKey,
                child: Column(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 35.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Email'),
                        style: const TextStyle(
                fontSize: 25,
                
              ),
              validator: (text){
                if(!text!.contains('@')){
                  return 'Please enter a valid email';
                }
                return null;
              },
              controller: _emailController,
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

              obscureText: true,

                  validator: (text){
                if(text!.length<6){
                  return 'Password must be atleast 6 characters';
                }
                return null;
              },
              controller: _passwordController,
                  ),


                  
                  
                )
              ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: MaterialButton(
                  onPressed: (){ _login();},
                  color: AppConstants.primaryColor,
                   height: MediaQuery.of(context).size.height/15,
                  minWidth: double.infinity,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: const Text('Login',
                  style: TextStyle(
                     fontWeight: FontWeight.bold,
                    fontSize: 25,
                  )),

              ),
              ),
                 
                 Padding(
                   padding: const EdgeInsets.only(top: 20.0),
                   child: MaterialButton(
                                 onPressed: (){
                                  _signUp();
                                  },
                                 color: Colors.grey,
                                 height: MediaQuery.of(context).size.height/15,
                                 minWidth: double.infinity,
                                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                 child: const Text('Sign Up',
                                 style: TextStyle(
                                   fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                 )),
                                 ),
                 )
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}



