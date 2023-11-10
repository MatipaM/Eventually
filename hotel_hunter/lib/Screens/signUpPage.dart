import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotel_hunter/Models/AppConstants.dart';
import 'package:hotel_hunter/Screens/explorePage.dart';
import 'package:hotel_hunter/Screens/guestHomePage.dart';
import 'package:hotel_hunter/Views/textWidgets.dart';
import 'package:image_picker/image_picker.dart';

class SignUpPage extends StatefulWidget {

  static const String routeName = '/signUpPageRoute';
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();


  File? _imageFile;
  void _chooseImage() async{
    var imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(imageFile!=null){
      _imageFile = File(imageFile.path);
      setState(() {
        
      });
    }
  }

  void _signUp(){

    if(!_formKey.currentState!.validate() || _imageFile==null){return;}

    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: AppConstants.currentUser!.email!, 
      password: AppConstants.currentUser!.password!).then((firebaseUser){ 
        String userID = firebaseUser.user!.uid;
        AppConstants.currentUser!.id = userID;
        AppConstants.currentUser!.firstName = _firstNameController.text;
        AppConstants.currentUser!.lastName = _lastNameController.text;
        AppConstants.currentUser!.city = _cityController.text;
        AppConstants.currentUser!.country = _countryController.text;
        AppConstants.currentUser!.bio = _bioController.text;
        AppConstants.currentUser!.addUserToFirestore().whenComplete((){
          File imageFile = File('assets/images/defaultAvatar.png');
          AppConstants.currentUser!.addImageToFirestore(_imageFile!).whenComplete((){
             FirebaseAuth.instance.signInWithEmailAndPassword(
              email: AppConstants.currentUser!.email!,
              password: AppConstants.currentUser!.password!,
            ).whenComplete((){
            Navigator.pushNamed(context, guestHomePage.routeName);
            });
          });
            
        });
  });
    

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
              
                Form(
                  key: _formKey,
                  child: Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 35.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'First Name'),
                          style: const TextStyle(
                  fontSize: 25,
                  
                ),
                controller: _firstNameController,
                validator: (text){
                  if(text!.isEmpty){
                    return "Please enter a first name";
                  }
                  return null;
                },
                textCapitalization: TextCapitalization.words,
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
                controller: _lastNameController,
                    validator: (text){
                  if(text!.isEmpty){
                    return "Please enter a last name";
                  }
                  return null;
                },
                 textCapitalization: TextCapitalization.words,
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
                controller: _cityController,
                    validator: (text){
                  if(text!.isEmpty){
                    return "Please enter a valid city";
                  }
                  return null;
                },
                 textCapitalization: TextCapitalization.words,
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
                controller: _countryController,
                    validator: (text){
                  if(text!.isEmpty){
                    return "Please enter a valid country";
                  }
                  return null;
                },
                 textCapitalization: TextCapitalization.words,
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
                controller: _bioController,
                    ),
                    
                  )
                ]),
                ),
                 Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 0.0),
                  child: MaterialButton(
                  onPressed: _chooseImage,
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: MediaQuery.of(context).size.width/15,
                    child: (_imageFile==null)?Icon(Icons.add, color: Colors.white,): CircleAvatar(
                    backgroundImage: FileImage(_imageFile!),
                    radius: MediaQuery.of(context).size.width/10.5,
                    ),
                  ),
                ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 40.0),
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



