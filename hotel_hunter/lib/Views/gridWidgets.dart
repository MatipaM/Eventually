import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:hotel_hunter/Models/AppConstants.dart';
import 'package:hotel_hunter/Models/postingObject.dart';


class PostingGridTile extends StatefulWidget{

  final Posting? posting;

  const PostingGridTile({Key? key, this.posting}): super(key: key);

  @override
  _PostingGridTileState createState() => _PostingGridTileState();
}

class _PostingGridTileState extends State<PostingGridTile>{

  Posting? _posting;

@override void initState() {
    _posting = widget.posting;
    _posting!.getFirstImageFromStorage().whenComplete(() => {
      setState((){
      }),
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            
            // AspectRatio(
            //   aspectRatio: 4/3,
              //child: 
              SizedBox(
                 height: 300,
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: _posting!.displayImages!.isEmpty?Container():ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                  
                      child: Image(
                         image: _posting!.displayImages!.first,
                        ),
                    
                  ),
                ),
              ),
            //),
              AutoSizeText('${_posting!.type} - ${_posting!.city}, ${_posting!.country}}',
              //AutoSizeText('',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),),
              // AutoSizeText(_posting!.name!,
              const AutoSizeText("",
                style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),),
              Text('R ${_posting!.price} per night',
               //Text('R  per night',
              style: const TextStyle(
                fontSize: 12
              ),),
              const SizedBox(height: 15.0),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                RatingBar.builder(
                 initialRating: 3,
                 minRating: 1,
                 direction: Axis.horizontal,
                 allowHalfRating: true,
                 itemCount: 5,
                 itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                 itemBuilder: (context, _) => const Icon(
                   Icons.star,
                   color: AppConstants.accentColor,
                 ),
                 itemSize: 25.0,
                 onRatingUpdate: 
                 (rating) {
                   print(_posting!.getCurrentRating());
                   
                 },
                  ),
              ],
            ),
          ),
        ),
          ],
      ),
    );
  }

}


class TripsGridTile extends StatefulWidget{

  final Booking booking;
  const TripsGridTile({required this.booking, Key? key}): super(key: key);

  @override
  _TripsGridTileState createState() => _TripsGridTileState();
}

class _TripsGridTileState extends State<TripsGridTile>{

  Booking? _booking;

  @override
  void initState()
  {
    _booking = widget.booking;
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Material(
      borderRadius: BorderRadius.circular(15),
      color: AppConstants.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          
              // AspectRatio(
              //   aspectRatio: 4/3,
                //child: 
                SizedBox(
                   height: 100,
                  width:200,
         
                    child: Padding(
                      padding: const EdgeInsets.only(left:70.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image(
                          image:_booking!.posting!.displayImages!.first,
                          
                          ),
                      
                    ),
                  ),
                ),
              //),
                AutoSizeText(_booking!.posting!.name!,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),),
                AutoSizeText(
                '${_booking!.posting!.city!} ${_booking!.posting!.country!}',
                  style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),),
                Text('R${_booking!.posting!.price!}'),
                Text('${_booking!.dates!.first} - ',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                )),
                 Text('${_booking!.dates!.first}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                )),
            ],
         ),
      ),
    );
  }

}