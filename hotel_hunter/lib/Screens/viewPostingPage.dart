import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hotel_hunter/Models/AppConstants.dart';
import 'package:hotel_hunter/Models/postingObject.dart';
import 'package:hotel_hunter/Models/reviewObjects.dart';
import 'package:hotel_hunter/Screens/BookPostingPage.dart';
import 'package:hotel_hunter/Screens/viewProfilePage.dart';
import 'package:hotel_hunter/Views/formWidgets.dart';
import 'package:hotel_hunter/Views/listWidgets.dart';
import 'package:hotel_hunter/Views/textWidgets.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ViewPostingPage extends StatefulWidget {

  static const String routeName = '/viewPostingPage';
  final Posting posting;

  const ViewPostingPage({required this.posting, super.key});

  @override
  State<ViewPostingPage> createState() => _ViewPostingPageState();
}

class _ViewPostingPageState extends State<ViewPostingPage> {

  Posting _posting = Posting();
  //Posting! _posting;

  final LatLng _centerLatLong = const LatLng(
    25.7479,28.2293 
  );

  //  Completer<GoogleMapController>? _completer;
  Completer<GoogleMapController> _completer = Completer();

  // void _calculateLatAndLong(){
  // Geolocator().placemarkFromAddress(_posting!.getFullAddress()).then((placemarks){
  //   placemarks.forEach((placemark){
  //     setState((){
  //       _centerLatLong = LatLng(
  //         placemark.position.latitude,
  //         placemark.position.longitude
  //       );
  //     });
  //   });
  // });
  // }

  @override
  void initState(){
   // this._posting = widget.posting;
   
   _posting = widget.posting;
   
    _completer = Completer();
    //_calculateLatAndLong();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const AppBarText(text: 'Posting Information'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save, color: Colors.white),
            onPressed: (){},
            )
        ]
        ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1/0.5,
                child: PageView.builder(
                  itemCount: _posting.displayImages!.length,
       
                  itemBuilder: (context, index){
                    MemoryImage currentImage =  _posting.displayImages![index];
                     return ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                       child: Image(
                        image: currentImage,
                        fit: BoxFit.fill,
                       
                        
                        ),
                     );
                  },
                  )
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                child: Column(children: <Widget>[
                   Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(      
                            width: MediaQuery.of(context).size.width/1.75,
                            child: AutoSizeText(
                              _posting.name!,
                      
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30.0,
                            ),
                            maxFontSize: 30.0,
                            minFontSize: 25.0,
                            maxLines: 2,),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Text(_posting.type!,
                            style: const TextStyle(
                              fontSize: 20.0,
                            ),),
                          ),
                        ],),
                        Column(
                        children: <Widget>[
                          MaterialButton(
                            //borderRadius: BorderRadius
                            color: AppConstants.secondaryColor,
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context)=> BookPostingPage(
                                    posting: _posting,
                                  )
                                  )
                              );
                         
                            },
                            child: const Text(
                              'Book Now',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            )),
                          Text('R${_posting.price}',
                          style: const TextStyle(
                            fontSize: 15.0,
                          ),),
                        ],)
                    ],
                   ),
                   
                ],)
                ),
             
              Padding(
                
                padding: const EdgeInsets.fromLTRB(30,  25.0, 20, 25),
                
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      
                      width: MediaQuery.of(context).size.width/1.75,
                      child: AutoSizeText(
                         _posting.description!,
                         
                      style: const TextStyle(
                    
                      ),
                      minFontSize: 25,
                      maxFontSize: 35,
                      maxLines: 5,
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        CircleAvatar(
                          radius: MediaQuery.of(context).size.width/19,
                          backgroundColor: Colors.black,
                          child: GestureDetector(

                            onTap: (){
                              MaterialPageRoute(
                        builder: (context) => ViewProfilePage(
                          contact: _posting.host,
                      
                        ),
                      ); 
                            },
                              child: InkResponse(
                            onTap: () {
                              Navigator.push(
                                          context,
                                        MaterialPageRoute(
                                          builder: (context) => ViewProfilePage(
                                            contact:  _posting.host,
                                          ),
                                        ) 
                                        );
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.black,
                              radius: MediaQuery.of(context).size.width/20,
                              child: CircleAvatar(
                                backgroundImage:  _posting.host!.displayImage,
                                radius: MediaQuery.of(context).size.width/15,
                              ),
                            ),
                          ),
                            
                          )
                 
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            _posting.host!.fullName!, //.getFullName()
                        
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              ListView(
                shrinkWrap: true,
                children: <Widget>[
                  // PostingInfoTile(
                  //   icon: Icon(Icons.home),
                  //   category: 
                  //   _posting!.type!,
                  
                  //   categoryInfo: 
                  //   _posting.getVolunteers(),
                  
                    
                  // ),
                  
         
                  // PostingInfoTile(
                  //   icon: Icon(Icons.wc),
                  //   category: 'Workers',
                  //   categoryInfo: 
                  //   _posting.getWorkersText(),
                  // ),
                           PostingInfoTile(
                    icon: const Icon(Icons.hotel),
                    category: 'Facilities',
                    categoryInfo: 
                    _posting.getFacilitiesText(),
                    
                  ),
                ],
              ),
              const Text(''),
              const Text('Features/Line Up',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize:25.0,
              )),
              Padding(
                padding: const EdgeInsets.only(top: 25.0, bottom: 25),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  childAspectRatio: 4/1,
                  children:List.generate(
                    _posting.amenities!.length, 
                    
                  (index){
                    String currentAmenity = 
                    _posting.amenities![index];
                    return Text(
                      
                     currentAmenity,
                      style: const TextStyle(
                        fontSize: 20.0,
                      ),
                    );
                  })
                  ),
              ),

              const Text('The Location',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              )),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, bottom: 25),
                    child: Text( 
                      _posting.getFullAddress(),
                      
                                style: const TextStyle(
                                  fontSize: 20,
                                )),
                  ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height/3,
                  child: GoogleMap(
                    onMapCreated: (controller){
                        _completer.complete(controller);
                    },
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: _centerLatLong,
                      zoom: 14,
                      ),
                      markers: <Marker>{
                        Marker(
                          markerId: MarkerId('${_posting.name} Hey Neighbour Location'),
                          position: _centerLatLong,
                          icon: BitmapDescriptor.defaultMarker,
                          )
                      },
                  ),
                ),
              ),
              const Text('Reviews',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize:25, 
              ),),
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: ReviewForm(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ListView.builder(
                  itemCount: 
                  _posting.reviews!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index){
                    Review currentReview = 
                    _posting.reviews![index]; 
                    Review();
                    return Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: ReviewListTile(review: currentReview,),
                    );
                  }))
            ],
          )
        ),
      )// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


class PostingInfoTile extends StatelessWidget{

  final Icon icon;
  final String category; //make not required
  final String categoryInfo;

  const PostingInfoTile({Key? key, required this.icon, required this.category, required this.categoryInfo}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
    
      title: Text(category,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
      )),
      subtitle: Text(categoryInfo,
      style: const TextStyle(
        fontSize: 20,
      ))
    );
  }

}
