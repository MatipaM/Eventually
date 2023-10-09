 import 'package:flutter/material.dart';
import 'package:hotel_hunter/Models/AppConstants.dart';
import 'package:hotel_hunter/Screens/loginPage.dart';
import 'package:hotel_hunter/Screens/personalInfo.dart';
import 'package:hotel_hunter/Screens/viewProfilePage.dart';
import 'package:auto_size_text/auto_size_text.dart';

class AccountPage extends StatefulWidget {

  const AccountPage({super.key});

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  //final String _hostingTitle = 'To Host Dashboard';

    List<Widget> hostStatus = <Widget>[
  const Text('I am a Guest'),
  const Text('I am a Host'),
  const Text('I am a Worker'),
  
];

  final List<bool> _selectedHost = <bool>[true, false, false];

  void _logout(){
    Navigator.pushNamed(context, LoginPage.routeName);
  }

  // void _changeHosting()
  // {

 
  //   if(AppConstants.currentUser!.isCurrentlyHosting!)
  //   {
  //     AppConstants.currentUser!.isCurrentlyHosting = false;
  //      Navigator.pushNamed(
  //     context, 
  //     guestHomePage.routeName,);
  //   }
  //   else{
  //     AppConstants.currentUser!.isCurrentlyHosting = true;
  //      Navigator.pushNamed(
  //     context, 
  //     HostHomePage.routeName,);
  //   }

  // }

  

  @override
  void initState()
  {
    // if(AppConstants.currentUser!.isCurrentlyHosting!)
    // {
    //   _hostingTitle = 'To Guest Dashboard';
    // }else{
    //   _hostingTitle = 'To Host Dashboard';
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 15,25,0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                MaterialButton(
                  onPressed: (){
                     Navigator.push(
                        context,
                      MaterialPageRoute(
                        builder: (context) => ViewProfilePage(
                          contact:  AppConstants.currentUser?.createContactFromUser(),
                        ),
                      ) 
                       );
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: MediaQuery.of(context).size.width/9.5,
                    child: CircleAvatar(
                    backgroundImage: AppConstants.currentUser!.displayImage,
                    radius: MediaQuery.of(context).size.width/10,
                    ),
                  ),
                ),
                   
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(AppConstants.currentUser!.fullName!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25, 
                    ),
                  ),
                  AutoSizeText(AppConstants.currentUser!.email!,
                  style: const TextStyle(
                    fontSize: 25, 
                    ),
                  ),
                ],
              ),
            ),
               ],
            ),
          ),
          ListView(
            shrinkWrap: true,
            children: <Widget>[
                ElevatedButton(
                     style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      
                    ),
                      backgroundColor: AppConstants.secondaryColor,
                      //foregroundColor: const Color.fromARGB(255, 0, 34, 2),
                  ),
                  //color: AppConstants.backgroundColor,
                
                  //height: MediaQuery.of(context).size.height/8.0,
                  
                  onPressed: (){
                    Navigator.pushNamed(context, PersonalInfoPage.routeName);

                  },
                  child: const AccountPageListTile(text: 'Peronal Information', iconData: Icons.person,),
                  ),
                //  Padding(
                //      padding: const EdgeInsets.only(top: 10.0),
                    //  child: ElevatedButton(
                      
                    //   style: ElevatedButton.styleFrom(
     
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(20),
                        
                    //   ),
                    //     backgroundColor: AppConstants.secondaryColor,
                    //   ),
                    //                  onPressed: (){_changeHosting();},
                    //                  child: AccountPageListTile(text: _hostingTitle, iconData: Icons.house,),
                    //                  ),


                   //),
                   Padding(
                     padding: const EdgeInsets.only(top: 10.0),
                     child: ElevatedButton(
                                     style: ElevatedButton.styleFrom(
                                      //onPrimary: AppConstants.accentColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        
                        
                      ),
                        backgroundColor: AppConstants.secondaryColor,
                                     ),
                                     onPressed: (){
                      _logout();
                                     },
                                     child: const AccountPageListTile(text: 'Logout',
                                     iconData: Icons.directions_run_rounded,),
                                     ),
                   )
            ],
          ),
        ],
        )
    );
  }
}

class AccountPageListTile extends StatelessWidget{

final String text;
final IconData iconData;

const AccountPageListTile({Key? key, required this.text, required this.iconData}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0.0),
      leading: Text(
        text,
        style: const TextStyle(fontSize: 25.0,
        fontWeight: FontWeight.normal,
        ),
      ),
      trailing: Icon(
        iconData,
        size: 30.0,
        ),
      );
  }

}



