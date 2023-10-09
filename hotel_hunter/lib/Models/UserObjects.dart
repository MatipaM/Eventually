import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hotel_hunter/Models/AppConstants.dart';
import 'package:hotel_hunter/Models/messagingObjects.dart';
import 'package:hotel_hunter/Models/postingObject.dart';
import 'package:hotel_hunter/Models/reviewObjects.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Contact{
  String? id;
  String? firstName;
  String? lastName;
  String? fullName;

  MemoryImage? displayImage;
  

  Contact({this.id="",this.firstName="", this.lastName="", this.displayImage} );

  Future<void> getContactInfoFromFireStore() async{
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(id).get();
      firstName= snapshot['firstName'];
      lastName= snapshot['lastName'];
  }

  Future<MemoryImage> getImageFromStorage() async{
    if(displayImage!=null){
      return displayImage!;
    }else{
      final String imagePath = "userImages/$id/progile_pic.jpeg";
      final imageData = await FirebaseStorage.instance.ref().child(imagePath).getData(1024*1024);
      displayImage = MemoryImage(imageData!);
      return displayImage!;
    }
  }

  UserObj? createUserFromContact()
  {
    return UserObj(
      id: id!,
      firstName: firstName!,
      lastName: lastName!,
      );
  }
}

class UserObj extends Contact{

  String? email;
  String? bio;
  String? city;
  String? country;
  bool? isHost;
  bool? isGuest;
  bool? isWorker;
  bool? isCurrentlyHosting;
  bool? isCurrentlyWorking;

  List<Booking>? bookings;
  List<Review>? reviews;
  List<Conversation>? conversations;
  List<Posting>? savedPostings;
  List<Posting>? myPostings;

  UserObj({String id="",String firstName="", String lastName="", MemoryImage? displayImage, this.email="", this.bio="", this.city="", this.country=""}):
  
    super(firstName: firstName, lastName: lastName, displayImage: displayImage, id:id){
    isHost = false;
    isGuest = false;
    isWorker = false;
    isCurrentlyHosting = false;
    isCurrentlyWorking = false;
    bookings = [];
    reviews = [];
    conversations = [];
    savedPostings = [];
    myPostings = [];

  }

  Future<void> getUserInfoFromFireStore() async{
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(id).get();
      firstName= snapshot['firstName'] ?? "";
      lastName= snapshot['lastName'] ?? "";
      email = snapshot['email'] ?? "";
      bio = snapshot['bio'] ?? "";
      city = snapshot['city'] ?? "";
      country = snapshot['country'] ?? "";
      isHost = snapshot['isHost'] ?? false;
      isGuest = snapshot['isGuest'] ?? false;
      isWorker = snapshot['isWorker'] ?? false;
      List<String> conversationIDs = List<String>.from(snapshot['conversationIDs']) ?? [];
      List<String> myPostingIDs = List<String>.from(snapshot['myPostingIDs']) ?? [];
      List<String> savedPostingIDs = List<String>.from(snapshot['savedPostingIDs']) ?? [];
  }

  void changeCurrentlyHosting(bool isHosting)
  {
    isCurrentlyHosting = isCurrentlyHosting;
    changeCurrentlyWorking(false);
  }

    void changeCurrentlyWorking(bool isWorking)
  {
    isCurrentlyWorking = isCurrentlyWorking;
    changeCurrentlyHosting(false);
  }

  void becomeHost()
  {
    isHost = true;
    changeCurrentlyHosting(true);
    changeCurrentlyWorking(false);
  }

  void becomeWorker(){
    isHost = false;
    changeCurrentlyHosting(false);
    changeCurrentlyWorking(true);
  }

  String getFullName()
  {
    return "${firstName!} ${lastName!}"; 
  }

  Contact createContactFromUser()
  {
    return Contact(
      id: id,
      firstName: firstName,
      lastName: lastName,
      displayImage: displayImage,
      );
  }

  Future<void> getAllBookingsFromFireStore() async{
  bookings = [];
  QuerySnapshot snapshots = await FirebaseFirestore.instance.collection('users/$id/bookings').get(); //initally getDocuments()
  for(var snapshot in snapshots.docs){
    Booking newBooking = Booking();
    await newBooking.getBookingInfoFromFirestoreFromUser(createContactFromUser(), snapshot);
    bookings!.add(newBooking);

  }
}

  void makeNewBooking(Booking booking)
  {
    bookings!.add(booking);
  }

  List<DateTime> getAllBookedDates(){
    List<DateTime> allBookedDates = [];
    for (var posting in myPostings!) { 
      for (var booking in posting.bookings!) {
        allBookedDates.addAll(booking.dates!);
       }
    }
    return allBookedDates;
  }

void addSavedPosting(Posting posting)
{
  savedPostings!.add(posting);
}

void removeSavedPosting(Posting posting){
  for(int i=0; i< savedPostings!.length; i++)
  {
    if(savedPostings![i].name==posting.name)
    {
      savedPostings!.removeAt(i);
    }
  }
}

List<Booking> getPreviousTrips(){
  List<Booking> previousTrips = [];

  for (var booking in bookings!) {
    if(booking.dates!.last.compareTo(DateTime.now()) <= 0){
      previousTrips.add(booking);
    }
   }

  return previousTrips;
}

List<Booking> getUpcomingTrips(){
  List<Booking> upcomingTrips = [];

  for (var booking in bookings!) {
    if(booking.dates!.last.compareTo(DateTime.now()) > 0){
      upcomingTrips.add(booking);
    } 
   }

  return upcomingTrips;
}

double getCurrentRating(){
  if(reviews!.isEmpty)
  {
    return 4;
  }

  double rating = 0;
  for (var review in reviews!) {
    rating+= review.rating!;
   }
   rating/=reviews!.length;
  return rating;
}


  void postNewReview(String text, double rating,)
  {
    Review newReview = Review();
    newReview.createReview(
      AppConstants.currentUser!.createContactFromUser(), text, rating, DateTime.now());
    reviews!.add(newReview);
  }
  
}
