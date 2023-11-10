import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hotel_hunter/Models/AppConstants.dart';

class ReviewForm extends StatefulWidget{

  const ReviewForm({Key? key}): super(key: key);

  
  @override
  _ReviewFormState createState()=> _ReviewFormState();
  
  
}

class _ReviewFormState extends State<ReviewForm>{
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black
          )
        ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Form(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Enter review text',
                      ),
                      maxLines: 3,
                      style: const TextStyle(
                        fontSize: 20.0,
                      ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: RatingBar.builder(
                    initialRating: 2.5,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: AppConstants.accentColor,
                    ),
                    onRatingUpdate: 
                    (rating) {
                      print(rating);
                    },
                                  ),
                  ),
                MaterialButton(onPressed: (){},
                color: AppConstants.secondaryColor,
                
                child: const Text('Submit',),)
                ],
              ),)
          ],),
      )
    );
  }

}