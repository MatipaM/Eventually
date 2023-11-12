import 'dart:io';

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
      final String imagePath = "userImages/$id/profile_pic.jpg"; //check id correct, output
      print("imagePath from getImage " +imagePath);
      final imageData = await FirebaseStorage.instance.ref().child(imagePath).getData(1024*1024);
      displayImage = MemoryImage(imageData!); 
      print("display image: ${displayImage}");
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

  @override
  String toString()
  {
    return '$id, $firstName $lastName';
  }
}

class UserObj extends Contact{

DocumentSnapshot? snapshot;
  String? email;
  String? bio;
  String? city;
  String? country;
  bool? isHost;
  bool? isGuest;
  bool? isWorker;
  bool? isCurrentlyHosting;
  bool? isCurrentlyWorking;
  String? password;

  List<Booking>? bookings;
  List<Posting>? jobPostings;
  List<Review>? reviews;
  List<Conversation>? conversations;
  List<Posting>? savedPostings;
  List<Posting>? myPostings;
    List<Posting>? myJobPostings = [];

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
    myJobPostings = [];

  }

  Future<void> getUserInfoFromFireStore() async{
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(id).get();
      this.snapshot = snapshot;
      firstName= snapshot['firstName'] ?? "";
      lastName= snapshot['lastName'] ?? "";
      email = snapshot['email'] ?? "";
      bio = snapshot['bio'] ?? "";
      city = snapshot['city'] ?? "";
      country = snapshot['country'] ?? "";
      // isHost = snapshot['isHost'] ?? false;
      // isGuest = snapshot['isGuest'] ?? false;
      // isWorker = snapshot['isWorker'] ?? false;
  }

  Future<void> getPersonalInfoFromFirestore() async {
      await getUserInfoFromFireStore();
      await getImageFromStorage();
      //List<String> conversationIDs = List<String>.from(snapshot['conversationIDs']) ?? [];
      await getMyPostingsFromFirestore(); 
      await getSavedPostingsFromFirestore(); 
      await getAllBookingsFromFireStore();  
}

  Future<void> getMyPostingsFromFirestore() async{
        myPostings = [];
      List<String> myPostingIDs = List<String>.from(snapshot!['myPostingIDs']) ?? [];
       for(var postingID in myPostingIDs) {                                                                          
        Posting newPosting = Posting(id: postingID);
        await newPosting.getPostingInfoFromFireStore();
        await newPosting.getAllBookingsFromFireStore();
        await newPosting.getAllImagesFromStorage();
        myPostings!.add(newPosting);
       }
       print('my postings from firestore function: ${myPostings!.length}');
       print('from firestore function: ${myPostingIDs.length}');

  } 

    Future<void> getMyJobPostingsFromFirestore() async{
        jobPostings = [];
      List<String> myJobPostingIDs = List<String>.from(snapshot!['myJobPostingIDs']) ?? [];
       for(var postingID in myJobPostingIDs) {                                                                          
        Posting newPosting = Posting(id: postingID);
        await newPosting.getPostingInfoFromFireStore();
        await newPosting.getAllBookingsFromFireStore();
        await newPosting.getAllImagesFromStorage();
        jobPostings!.add(newPosting);
       }

        getAppliedJobs();
       print('my postings from firestore function: ${myPostings!.length}');
       print('from firestore function: ${myJobPostingIDs.length}');
  } 

  List<Posting> getAppliedJobs()
{
  List<Posting> appliedJobs = [];

  for (var posting in jobPostings!) { //this line needs to be updated
    for(var date in posting.jobDates!){
       if(date!.compareTo(DateTime.now()) > 0){
      appliedJobs.add(posting);
        } 
      }
   }
  return appliedJobs;
}

  Future<void> getSavedPostingsFromFirestore() async{
      List<String> savedPostingIDs = List<String>.from(snapshot!['savedPostingIDs']) ?? [];
      savedPostings = [];
      for(var postingID in savedPostingIDs) {
        Posting newPosting = Posting(id: postingID);
        await newPosting.getPostingInfoFromFireStore();
        await newPosting.getFirstImageFromStorage();
        savedPostings!.add(newPosting);
       }
  } 

  Future<void> addUserToFirestore() async{
    Map<String, dynamic> data = {
      "bio": bio,
      "city": city,
      "country": country,
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      // "isHost": false,
      // "isGuest": true,
      // "isWorker": false,
      "myPostingIDs":[],
      "savedPostingIDs":[],
    };
    await FirebaseFirestore.instance.doc('users/$id').set(data);
  }

    Future<void> updateUserInFirestore() async{
    Map<String, dynamic> data = {
      "bio": bio,
      "city": city,
      "country": country,
      "firstName": firstName,
      "lastName": lastName,
    };
    await FirebaseFirestore.instance.doc('users/$id').update(data);
  }

  Future<void> addImageToFirestore(File imageFile) async{
    Reference ref = FirebaseStorage.instance.ref().child('userImages/$id/profile_pic.jpg');
    await ref.putFile(imageFile); //.onComplete
    displayImage = MemoryImage(imageFile.readAsBytesSync());
  }

  // void changeCurrentlyHosting(bool isHosting)
  // {
  //   isCurrentlyHosting = isHosting;
  //   changeCurrentlyWorking(false);
  // }

  //   void changeCurrentlyWorking(bool isWorking)
  // {
  //   isCurrentlyWorking = isWorking;
  //   changeCurrentlyHosting(false);
  // }

  // Future<void> becomeHost() async
  // {
  //   Map<String, dynamic> data = {
  //     'isHost': true,
  //   };
  //   isHost = true;
  //   await FirebaseFirestore.instance.doc('users/$id').update(data);
  //   // changeCurrentlyHosting(true);
  //   // changeCurrentlyWorking(false);
  // }

  // Future<void> becomeWorker() async{
  //   Map<String, dynamic> data = {
  //     'isWorker': true,
  //   };
  //   isHost = false;
  //   await FirebaseFirestore.instance.doc('users/$id').update(data);
  //   // changeCurrentlyHosting(false);
  //   // changeCurrentlyWorking(true);
  // }

  String getFullName()
  {
    return "${firstName!} ${lastName!}"; 
  }

  Future<void> addPostingToMyPostings(Posting posting) async{
   
    myPostings!.add(posting);
    List<String> myPostingIDs = [];
    for (var posting in myPostings!) {
      myPostingIDs.add(posting.id!);
    }
    FirebaseFirestore.instance.doc('users/$id').update({
      'myPostingIDs':myPostingIDs,
    });

  }

    Future<void> addJobApplicationsToMyJobs(Posting posting) async{
   
    myJobPostings!.add(posting);
    List<String> myPostingIDs = [];
    for (var posting in myJobPostings!) {
      myPostingIDs.add(posting.id!);
    }
    FirebaseFirestore.instance.doc('users/$id').update({
      'myJobPostingIDs':myPostingIDs,
    });

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

  Future<void> addBookingToFirestore(Booking booking) async
  {
    Map<String, dynamic> data = {
      'dates': booking.dates,
      'postingID': booking.posting!.id,
      'job': booking.job!=""?booking.job:""
    };
    await FirebaseFirestore.instance.doc('postings/$id/bookings/${booking.id}').set(data);
    bookings!.add(booking);
    await addBookingConversation(booking);
  }

  Future<void> addBookingConversation(Booking booking) async
  {
    Conversation conversation = Conversation();
    await conversation.addConversationToFirestore(booking.posting!.host!);
    String text = "Hi, My name is ${AppConstants.currentUser!.firstName} and I have just booked ${booking.posting!.name} from ${booking.dates!.first} to ${booking.dates!.last}. If you have any questions feel free to contact me, otherwise I look forward to the event!";
  } 

  Future<void> addApplicationConversation(Booking booking) async
  {
    Conversation conversation = Conversation();
    await conversation.addConversationToFirestore(booking.posting!.host!);
    String text = "Hi, My name is ${AppConstants.currentUser!.firstName} and I am applying for a position as a ${booking.job} for ${booking.posting!.name} event for ${booking.jobDate} on ${booking.jobDate}.";
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

Future<void> addSavedPosting(Posting posting)
async {
  print('attempting to save posting');
  for(var savedPosting in savedPostings!)
  {
    if(savedPosting.id == posting.id)
    {
        return;
    }
  }

  savedPostings!.add(posting);
  List<String> savedPostingIDs = [];
  for (var savedPosting in savedPostings!) {
  savedPostingIDs.add(savedPosting.id!);
  }
  await FirebaseFirestore.instance.doc('users/$id').update({
    'savedPostingIDs': savedPostingIDs,
  });

  print('posting saved, saved postings: ${savedPostings!.length}');

}

Future<void> removeSavedPosting(Posting posting) async{
  for(int i=0; i< savedPostings!.length; i++)
  {
    if(savedPostings![i].id==posting.id)
    {
      savedPostings!.removeAt(i);
      break;
    }
  }

  List<String> savedPostingIDs = [];
  for (var savedPosting in savedPostings!) {
  savedPostingIDs.add(savedPosting.id!);
  }
  await FirebaseFirestore.instance.doc('users/$id').update({
    'savedPostingIDs': savedPostingIDs,
  });

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
