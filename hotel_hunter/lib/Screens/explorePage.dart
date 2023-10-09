import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotel_hunter/Models/AppConstants.dart';
import 'package:hotel_hunter/Models/data.dart';
import 'package:hotel_hunter/Models/postingObject.dart';
import 'package:hotel_hunter/Screens/ViewWorkerPostingPage.dart';
import 'package:hotel_hunter/Screens/viewPostingPage.dart';
import 'package:hotel_hunter/Views/gridWidgets.dart';

class ExplorePage extends StatefulWidget {

  const ExplorePage({super.key});

  @override
 _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
        padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 50.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 2.0,
                      )
                      ),
                      contentPadding: EdgeInsets.all(5.0),
                    ),
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  )
                ),
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection('postings').snapshots(),
                builder: (context, snapshots){
                  switch(snapshots.connectionState){
                    case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                    default:
                    return  GridView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:snapshots.data!.docs.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:2 ,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 5/6), 
                  itemBuilder: (context, index){
                    DocumentSnapshot snapshot = snapshots.data!.docs[index];
                    Posting currentPosting = Posting(id: snapshot.id);
                    currentPosting.getPostingInfoFromSnapshot(snapshot);
                    return Material(
                      color: AppConstants.backgroundColor,
                      borderRadius: BorderRadius.circular(10),
                      child: InkResponse(
                        enableFeedback: true,
                        onTap: (){
                          Navigator.push(
                            context,
                          MaterialPageRoute(
                            builder: (context) => AppConstants.isWorking?viewWorkersPostingPage( posting:  currentPosting):ViewPostingPage(posting: currentPosting),
                          
                          ) 
                           );
                         
                        },
                        highlightColor: AppConstants.highlightColor,
                        child: PostingGridTile(
                          posting: currentPosting,
                        ),
                        ),
                    );
                  });
                  }
                },
               
              )
            ],
            ),
        )
    );
  }
}



