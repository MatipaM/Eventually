import 'package:flutter/material.dart';
import 'package:hotel_hunter/Models/AppConstants.dart';
import 'package:hotel_hunter/Screens/CreatePostingPage.dart';
import 'package:hotel_hunter/Views/listWidgets.dart';


class MyPostingsPage extends StatefulWidget {

  const MyPostingsPage({super.key});

  @override
  _MyPostingsPageState createState() => _MyPostingsPageState();
}

class _MyPostingsPageState extends State<MyPostingsPage> {

    // @override
    // void initState()
    // {
    //   AppConstants.currentUser!.getMyPostingsFromFirestore();
    //   super.initState();
    // }


  @override
  Widget build(BuildContext context) {
                    print('build: ${AppConstants.currentUser!.myPostings!.length}');

    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
       child: FutureBuilder(
               future: AppConstants.currentUser!.getMyPostingsFromFirestore(),
              
                builder: (context, snapshots){

                  if(snapshots.connectionState == ConnectionState.waiting){
                      print('myPostingLoaded false: ${AppConstants.currentUser!.myPostings!.length}');
                      return Center(child: CircularProgressIndicator());
                  }
                   else{
                    print('myPostingLoaded true: ${AppConstants.currentUser!.myPostings!.length}');
                   return ListView.builder(
        itemCount: AppConstants.currentUser!.myPostings!.length+1,
        itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.fromLTRB(25.0, 0, 25, 25),
            child: MaterialButton(
                  onPressed: (){
                  
                      print('${AppConstants.currentUser!} and ${index == AppConstants.currentUser!.myPostings!.length} and index is $index and ${AppConstants.currentUser!.myPostings![0].id} ');
                  Navigator.push(context, 
                  MaterialPageRoute(
                    builder: (context) => CreatePostingPage(
                      posting: (index == AppConstants.currentUser!.myPostings!.length)?null: AppConstants.currentUser!.myPostings![index], //AppConstants.currentUser!.myPostings![0] instead of null

                    ),));  
                             
                  
                    },
        
                 
              child: Container(
            
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 2.0,
                    
                    ),
                    
                    borderRadius: BorderRadius.circular(5.0)),
                child: 
                (index == AppConstants.currentUser!.myPostings!.length)?
                const CreatePostingListTile(): 
                MyPostingListTile(
                  posting: AppConstants.currentUser!.myPostings![index],
                )
              ),
            ),
          );
        
        },
                   
                   
      );
                   
                   
      
                  
                  }
                
                  
                },
  
               
              )
              
    );  
  }
}



