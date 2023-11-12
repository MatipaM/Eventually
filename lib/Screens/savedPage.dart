import 'package:flutter/material.dart';
import 'package:hotel_hunter/Models/AppConstants.dart';
import 'package:hotel_hunter/Models/data.dart';
import 'package:hotel_hunter/Models/postingObject.dart';
import 'package:hotel_hunter/Views/gridWidgets.dart';
import 'package:hotel_hunter/Screens/viewPostingPage.dart';


class SavedPage extends StatefulWidget {

  const SavedPage({super.key});

  @override
  _SavedPageState createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {

    List<Posting>? _postings;

      @override
  void initState(){
    _postings = PracticeData.postings;
      AppConstants.currentUser!.getSavedPostingsFromFirestore();
      setState(() {
        
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column( children: <Widget>[
        Text("Saved Events Page",
         style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),),
                       FutureBuilder(
               future: AppConstants.currentUser!.getSavedPostingsFromFirestore(),
               builder: (context, snapshots){

                  if(snapshots.connectionState == ConnectionState.waiting){
                    AppConstants.currentUser!.getSavedPostingsFromFirestore();
                      return const Center(child: CircularProgressIndicator());
                  }else{
                     AppConstants.currentUser!.getSavedPostingsFromFirestore();
                    print('saved postings: ${AppConstants.currentUser!.savedPostings!.length}');
                      return GridView.builder(
       
  
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: AppConstants.currentUser!.savedPostings!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:2 ,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 5/6), 
                itemBuilder: (context, index){

                  Posting currentPosting = AppConstants.currentUser!.savedPostings![index];
                  return Stack(
                    children: [
                      
                    InkResponse(
                    enableFeedback: true,
                    child: Material(
                      color: AppConstants.backgroundColor,
                      borderRadius: BorderRadius.circular(15),
                      child: PostingGridTile(
                        posting: currentPosting,),
                    ),
                    onTap: (){
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => ViewPostingPage(posting: currentPosting)
                        )
                      );
                    },
                    ),
                      
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Container(
                          width: 20,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white),
                          child: IconButton(
                            padding: const EdgeInsets.only(right: 20),
                            onPressed: () {
                              AppConstants.currentUser!.removeSavedPosting(currentPosting).whenComplete((){
                                setState(() {
                                  
                                });
                              });
                            },
                            icon: const Icon(Icons.clear,
                            color:Colors.black ,
                            ),),
                        ),
                      )
                    ]
                  );
                }
    );
                  }
            
          
               }
    )
      ],)
        //padding: const EdgeInsets.fromLTRB(25, 50, 25, 0),
       
           
    //addd Saved Postings text
           

              

    );
  }
}



