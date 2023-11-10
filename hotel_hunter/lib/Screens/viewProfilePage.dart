import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotel_hunter/Models/AppConstants.dart';
import 'package:hotel_hunter/Models/reviewObjects.dart';
import 'package:hotel_hunter/Models/UserObjects.dart';
import 'package:hotel_hunter/Views/formWidgets.dart';
import 'package:hotel_hunter/Views/listWidgets.dart';
import 'package:hotel_hunter/Views/textWidgets.dart';
import 'package:auto_size_text/auto_size_text.dart';



class ViewProfilePage extends StatefulWidget {

  static const String routeName = '/viewProfilePageRoute';

  final Contact? contact;

  const ViewProfilePage({this.contact, super.key});

  @override
  State<ViewProfilePage> createState() => _ViewProfilePageState();
}

class _ViewProfilePageState extends State<ViewProfilePage> {

  UserObj? _user;

  @override
  void initState() {
    
    if(widget.contact!.id == AppConstants.currentUser!.id){ //was ==
      _user = AppConstants.currentUser;
      print("load current user");
    }else{
      
      _user = widget.contact!.createUserFromContact();
       print(widget.contact!.firstName);
      _user!.getUserInfoFromFireStore().whenComplete(() => ((){
      setState(() {
        
      });
      }));
    }

      _user!.getImageFromStorage().whenComplete((){
      setState(() {
          print('account page fetching image: ${_user!.displayImage}'); //unexpected null value
      });
       
      });
      super.initState();
     
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const AppBarText(text: 'View Profile'),
        ),
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(35, 50, 25, 25),
            child: Column(
          
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                   Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: <Widget>[
                // MaterialButton(
                //   onPressed: (){},
                //   child: 
                // ),
                   
                  SizedBox(
                    width: MediaQuery.of(context).size.width*3/5,
                    child: AutoSizeText('Hi, My name is ${_user!.firstName} ${_user!.lastName}',
                    style: const TextStyle(
                      fontSize: 30, 
                      ),
                      maxLines: 2,
                    ),
                  ),
          
        
            CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: MediaQuery.of(context).size.width/9.5,
                    child: CircleAvatar(
                    backgroundImage: _user!.displayImage,
                    radius: MediaQuery.of(context).size.width/10,
                    ),
                  ),
               ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.home),
                  Text('About Me:  ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  )),
                ],
              ),
              
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: AutoSizeText(_user!.bio!,
              style: const TextStyle(
                fontSize: 20.0,
              )),
            ),

            const Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 0.0),
                    child: Text('Location ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                        )),
                    
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: AutoSizeText('Lives in ${_user!.city}, ${_user!.country}',
                    style: const TextStyle(
                      fontSize: 20.0,
                    )),
                  ),
                ],
              ),
            ),
const Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.home),
                  Text('Reviews: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  )),
                ],
              ),
              
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: ReviewForm()
              ),
              
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: 
                StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('users/${_user!.id}/reviews').orderBy('dateTime', descending: true).snapshots(),
                  builder: (context, snapshots){
                    switch( snapshots.connectionState){
                      case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(),);
                      default:
                      return ListView.builder(
                    itemCount: snapshots.data!.docs.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index){
                      DocumentSnapshot snapshot = snapshots.data!.docs[index];
                      Review currentReview = Review();
                      currentReview.getReviewInfoFromFirestore(snapshot);
                      return Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: ReviewListTile( 
                          review: currentReview,
                        ),
                      );
                    });
                    }
                  },
                ), //.builder because we are dynamically loading list - number of items dependent on data
              ),
          

              ],
            ),
          ),
          
        ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}



