import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hotel_hunter/Models/AppConstants.dart';
import 'package:hotel_hunter/Screens/guestHomePage.dart';
import 'package:hotel_hunter/Screens/workersHomePage.dart';
import 'package:hotel_hunter/Views/textWidgets.dart';
import 'package:hotel_hunter/Screens/hostHomePage.dart';
import 'package:image_picker/image_picker.dart';

class PersonalInfoPage extends StatefulWidget {

  static const String routeName = '/PersonalInfoPage';
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {

    final _formKey = GlobalKey<FormState>();
  TextEditingController? _firstNameController;
  TextEditingController? _lastNameController;
    TextEditingController? _emailController;
  TextEditingController? _cityController;
  TextEditingController? _countryController;
  TextEditingController? _bioController;
  TextEditingController? _passwordController;

  List<Widget> publicStatus = <Widget>[
  const Text('Public'),
  const Text('Private'),
];

    List<Widget> hostStatus = <Widget>[
  const Text('I am a Guest'),
  const Text('I am a Host'),
  const Text('I am a Worker'),
];

  List<bool> _selectedHost = <bool>[false, false, false];

  final List<bool> _selectedStatus = <bool>[false, true];
 

  void updateSelectedHost(){
    if(AppConstants.currentUser!.isHost == false && AppConstants.currentUser!.isWorker==false){
      _selectedHost = <bool>[true, false, false];
    }else if(AppConstants.currentUser!.isWorker == true){
          _selectedHost = <bool>[false, false, true];
    }else{
         _selectedHost = <bool>[false, true, false];
    }
  }

  void _changeHosting(index)
  {

    for(int i=0; i<hostStatus.length; i++)
    {
      if(_selectedHost[i]==true){
        switch(i){
          case 0:
          AppConstants.currentUser!.isHost = false;
          AppConstants.currentUser!.isWorker = false;
          print("I am a guest");
          Navigator.pushNamed(
              context, 
              guestHomePage.routeName,); //navigate to TandC page before moving onto homepages 
          break;
          case 1:
          AppConstants.currentUser!.isHost = true;
          AppConstants.currentUser!.isWorker  = false;
          print("I am a host");
           Navigator.pushNamed(
          context, 
          HostHomePage.routeName,);
          break;
          case 2:
            AppConstants.currentUser!.isHost = false;
          AppConstants.currentUser!.isWorker = true;
          print("I am a worker");
           Navigator.pushNamed( //Worker route page
          context, 
          workersHomePage.routeName,
          );
          break;
        }
      }
    }
  }

  File? _newImageFile;
  void _chooseImage() async{
    var imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(imageFile!=null){
      _newImageFile = File(imageFile.path);
      setState(() {
        
      });
    }
  }


  void _saveInfo(){
    if(!_formKey.currentState!.validate()){return;}
    AppConstants.currentUser!.firstName = _firstNameController!.text;
    AppConstants.currentUser!.lastName = _lastNameController!.text;
    AppConstants.currentUser!.city = _cityController!.text;
    AppConstants.currentUser!.country = _countryController!.text;
    AppConstants.currentUser!.bio = _bioController!.text;
    AppConstants.currentUser!.updateUserInFirestore().whenComplete((){
      if(_newImageFile!=null){
        AppConstants.currentUser!.addImageToFirestore(_newImageFile!).whenComplete((){
          Navigator.pushNamed(context, guestHomePage.routeName);
        });
      } else{
        Navigator.pushNamed(context, guestHomePage.routeName);
      }
    });


  @override
  void initState(){
    updateSelectedHost();

    _firstNameController = TextEditingController(
      text: AppConstants.currentUser!.firstName);

       _lastNameController = TextEditingController(
      text: AppConstants.currentUser!.email);

       _emailController = TextEditingController(
      text: AppConstants.currentUser!.email);

       _cityController = TextEditingController(
      text: AppConstants.currentUser!.city);

       _countryController = TextEditingController(
      text: AppConstants.currentUser!.country);

       _bioController = TextEditingController(
      text: AppConstants.currentUser!.bio);

      // _passwordController = TextEditingController(
      // text: AppConstants.currentUser!.password);

 
    super.initState();
  }
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const AppBarText(text: 'Personal Information'),
        actions: <Widget>[
          IconButton(
            icon:const Icon(Icons.save, color: Colors.black,),
          onPressed: _saveInfo, 
          ),

        ],
        ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(50, 50, 50, 0),
            child: Column(
          
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[

                   Padding(
                  padding: const EdgeInsets.only(bottom: 0.0),
                  child: MaterialButton(
                  onPressed: _chooseImage,
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: MediaQuery.of(context).size.width/10,
                    child: CircleAvatar(
                    backgroundImage: (_newImageFile!=null)? 
                    FileImage(_newImageFile!) as ImageProvider
                    :AppConstants.currentUser!.displayImage,
                    radius: MediaQuery.of(context).size.width/10.5,
                    ),
                  ),
                ),
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
                controller: _firstNameController,
                validator: (text){
                  if(text!.isEmpty){
                    return "Please enter a valid first name";
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
                    return "Please enter a valid first name";
                  }
                  return null;
                },
                 textCapitalization: TextCapitalization.words,
                    ),
                    
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 35.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email'),
                       
                          style: const TextStyle(
                  fontSize: 25,
                  
                ),
                controller: _emailController,
                 enabled: false,
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
                    return "Please enter a valid first name";
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
                    return "Please enter a valid first name";
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
                textCapitalization: TextCapitalization.sentences,
                    ),
                    
                  ),
                  const Text('Would you like your profile to be: ', style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  )),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ToggleButtons(
                  direction: Axis.horizontal,
                  onPressed: (int index) {
                    setState(() {
                      // The button that is tapped is set to true, and the others to false.
                      for (int i = 0; i < _selectedStatus.length; i++) {
                        _selectedStatus[i] = i == index;
                      }
                       
                    });
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  selectedBorderColor: AppConstants.accentColor,
                  selectedColor: AppConstants.accentColor,
                  fillColor: AppConstants.secondaryColor,
                  color: Colors.black,
                  constraints: const BoxConstraints(
                    minHeight: 40.0,
                    minWidth: 80.0,
                  ),
                  isSelected: _selectedStatus,
                  children: publicStatus,
                ),

              ),

               const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: ToggleButtons(
                  direction: Axis.horizontal,
                  onPressed: (int index) {
                    setState(() {
                      // The button that is tapped is set to true, and the others to false.
                      for (int i = 0; i < _selectedHost.length; i++) {
                        _selectedHost[i] = i == index;
                        _changeHosting(index);
                      }
                    });
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  selectedBorderColor: AppConstants.accentColor,
                  selectedColor: AppConstants.accentColor,
                  fillColor: AppConstants.secondaryColor,
                  color: Colors.black,
                  constraints: const BoxConstraints(
                    minHeight: 40.0,
                    minWidth: 150.0,
                  ),
                  isSelected: _selectedHost,
                  children: hostStatus,
                ),
              ),
                ]),
                ),
                   
             
                   
              ],
            ),
          ),

          
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}



