import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotel_hunter/Models/AppConstants.dart';
import 'package:hotel_hunter/Models/postingObject.dart';
import 'package:hotel_hunter/Screens/ViewWorkerPostingPage.dart';
import 'package:hotel_hunter/Screens/viewPostingPage.dart';
import 'package:hotel_hunter/Views/gridWidgets.dart';

class ExplorePage extends StatefulWidget {

 static const String routeName = '/explorePageRoute';
  const ExplorePage({super.key});

  @override
 _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {

  final TextEditingController _controller = TextEditingController();
  Stream _stream = FirebaseFirestore.instance.collection('postings').snapshots();
  String _searchType = "";  

  bool _isNameSelected = false;
  bool _isCitySelected = false;
  bool _isTypeSelected = false;

  void _searchByField()
  {
    if(_searchType.isEmpty)
    {
      _stream = FirebaseFirestore.instance.collection('postings').snapshots();
    }else{
      String text = _controller.text;
      _stream = FirebaseFirestore.instance.collection('postings').where(_searchType, isEqualTo: text).snapshots();
    }
    setState(() {
      
    });
  }

  void _pressSearchByButton(String searchType, bool isNameSelected, bool isCitySelected, bool isTypeSelected){
    _searchType = searchType;
    _isNameSelected = isNameSelected;
    _isCitySelected = isCitySelected;
    _isTypeSelected = isTypeSelected;

    setState(() {
      
    });
  }

  @override
  void initState() {
    print('initState, I am a worker: ${AppConstants.currentUser!.isWorker!}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
        padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10.0),
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
                  ),
                  controller: _controller,
                  onEditingComplete: (){
                    _searchByField();
                  },
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height/9,
                child: Row(
                  children: <Widget>[
                      MaterialButton(
                      onPressed: (){
                        _pressSearchByButton("name", true, false, false);
                      },
                      child: Text("Name"),
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                       color: _isNameSelected? AppConstants.highlightColor: AppConstants.backgroundColor,),

                      MaterialButton(
                      onPressed: (){
                        _pressSearchByButton("city", false, true, false);
                      },
                      child: Text("City"),
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                       color: _isCitySelected? AppConstants.highlightColor: AppConstants.backgroundColor,

                      ),
                       MaterialButton(
                      onPressed: (){
                        _pressSearchByButton("type", false, false, true);
                      },
                      child: Text("Type"),
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                       color: _isTypeSelected? AppConstants.highlightColor: AppConstants.backgroundColor,

                       ),
                      MaterialButton(
                      onPressed: (){
                        _pressSearchByButton("", false, false, false);
                      },
                      child: Text("Clear"),
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                       color: AppConstants.backgroundColor,)
                  ],
                ),
              ),
              StreamBuilder(
                stream: _stream,
              
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
                          print('I am a worker: ${AppConstants.currentUser!.isWorker!}');
                          Navigator.push(
                            context,
                          MaterialPageRoute(
                            builder: (context) => (AppConstants.currentUser!.isWorker!)?viewWorkersPostingPage( posting:  currentPosting):ViewPostingPage(posting: currentPosting), //2nd viewPostingPage
                            //builder: (context) => ViewPostingPage(posting: currentPosting),
                          ) 
                            );
                         
                        },
                        highlightColor: AppConstants.highlightColor,
                        child: PostingGridTile(
                          posting: currentPosting,
                        ),
                        ),
                    );
                  }
                  );
                  }
                },
               
              )
            ],
            ),
        )
    );
  }
}



