import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_hunter/Models/UserObjects.dart';

class Review{
  Contact? contact;
  String? text;
  double? rating;
  DateTime? dateTime;

  // Review();

  void createReview(Contact contact, String text, double rating, DateTime dateTime){
    this.contact = contact;
    this.text = text;
    this.rating = rating;
    this.dateTime = dateTime;
  }

  void getReviewInfoFromFirestore(DocumentSnapshot snapshot){
    Timestamp timestamp = snapshot['dateTime']??Timestamp.now();
    dateTime = timestamp.toDate();

    String fullName = snapshot['name']??"";
    rating = snapshot['rating'??2.5];
    text = snapshot['text']??"";
    String contactID = snapshot['userID']??"";
    
    _loadContactInfo(contactID, fullName);
  }

    void _loadContactInfo(String id, String fullName){
     String firstName="";
    String lastName = "";
    firstName = fullName.split(" ")[0];
    lastName = fullName.split(" ")[1];
    contact = Contact(id: id, firstName: firstName, lastName: lastName);

  }

}