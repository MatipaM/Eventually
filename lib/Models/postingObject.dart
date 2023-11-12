import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hotel_hunter/Models/AppConstants.dart';
import 'package:hotel_hunter/Models/UserObjects.dart';
import 'package:hotel_hunter/Models/reviewObjects.dart';

class Posting{

String? id;
String? name;
String? type;
double? price;
String? description;
String? address;
String? city;
String? country;
double? rating;

Contact? host;

List<String>? imageNames;
List<MemoryImage>? displayImages;
List<String>? amenities;
List<Booking>? bookings;
List<Booking>? jobBookings;
List<DateTime>? jobDates;
List<Review>? reviews;

Map<String, int>? workers;

Map<String, int> facilities = {};

Posting({this.id="",this.name="", this.type="", this.price=0, this.description="", this.address="", this.city="", this.country="", this.host, this.reviews}){
  imageNames=[];
  displayImages=[];
  amenities =[];
  workers={};
  facilities={};
  bookings = [];

  reviews = [];
  rating = 0;
}

  Future<void> getPostingInfoFromFireStore() async{
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('postings').doc(id).get();
    getPostingInfoFromSnapshot(snapshot);
  }

void getPostingInfoFromSnapshot(DocumentSnapshot snapshot){
    address = snapshot['address']??"";
    amenities = List<String>.from(snapshot['amenities']) ?? [];
    facilities = Map<String, int>.from(snapshot['facilities']) ?? {};
    workers = Map<String, int>.from(snapshot['workers']) ?? {};
    city = snapshot['city'] ?? "";
    country = snapshot['country'] ?? "";
    description = snapshot['description'] ?? "";

    String hostID = snapshot['hostID'] ?? "";
    host = Contact(id: hostID);

    imageNames = List<String>.from(snapshot['imageNames'])??[];
    name = snapshot['name'] ?? "";
    price = snapshot['price'].toDouble() ?? 0.0;
    rating = snapshot['rating'].toDouble() ?? 2.5;
    type = snapshot['type'] ?? "";
}

Future<void> addPostingInfoToFirestore() async{
   setImageNames();
  Map<String, dynamic> data={
    "address": address,
    "amenities": amenities,
    "facilities": facilities,
    "workers": workers,
    "city": city,
    "country": country,
    "description": description,
    "hostID": AppConstants.currentUser!.id,
    "imageNames": imageNames,
    "name": name,
    "price": price,
    "rating": 2.5,
    "type": type,
  };

  DocumentReference reference = await FirebaseFirestore.instance.collection('postings').add(data);
  print(reference.id);
  id = reference.id;
  AppConstants.currentUser!.addPostingToMyPostings(this);
}

Future<void> updatePostingInfoInFirestore() async{
     setImageNames();
  Map<String, dynamic> data={
    "address": address,
    "amenities": amenities,
    "facilities": facilities,
    "workers": workers,
    "city": city,
    "country": country,
    "description": description,
    "hostID": AppConstants.currentUser!.id, 
    "imageNames": imageNames,
    "name": name,
    "price": price,
    "rating": rating,
    "type": type,
  };
  await FirebaseFirestore.instance.doc('postings/$id').update(data);
}

  Future<MemoryImage> getFirstImageFromStorage() async{
    if(displayImages!.isNotEmpty){
      return displayImages!.first;
    }
    // final String imagePath = "postingImages/$id/${imageNames!.first}";
    final String imagePath = "postingImages/$id/${imageNames!.first}";
    final imageData = await FirebaseStorage.instance.ref().child(imagePath).getData(1024*1024);
    displayImages!.add(MemoryImage(imageData!));
    return displayImages!.first;
  }

  Future<List<MemoryImage>> getAllImagesFromStorage() async{

    displayImages = [];


    for(int i = 1; i<imageNames!.length; i++){
        final String imagePath = "postingImages/$id/${imageNames![i]}";
        final imageData = await FirebaseStorage.instance.ref().child(imagePath).getData(1024*1024);
        displayImages!.add(MemoryImage(imageData!));
    }

   return displayImages!;
  }

  void setImageNames(){
    imageNames = [];
    for(int i=0; i<displayImages!.length; i++){
      imageNames!.add("pic$i.jpg");
    }
  }

    Future<void> addImagesToFirestore() async{
      for(int i=0; i<displayImages!.length; i++){
        Reference ref = FirebaseStorage.instance.ref().child('postingImages/$id/${imageNames![i]}');
            await ref.putData(displayImages![i].bytes);

      }
  }

  Future<void> getHostFromFirestore() async{
    await host!.getContactInfoFromFireStore();
    await host!.getImageFromStorage();
  }

List<String>? getWorkersList(){ 
  List<String> workersList = [];
  workers!.forEach((val, num){
    if(num>0){
      workersList.add("$num $val");
    }
  }); 
  return workersList;
}

String getFullAddress()
{
  return "${address!}, ${city!}, ${country!}";
}

String? getAmenitiesString()
{
  if(amenities!.isEmpty){return "";}
  String amenitiesString = amenities.toString();
  return amenitiesString.substring(1, amenitiesString.length-1);
}

String getFacilitiesText()
{
  String text;

      if(facilities.isEmpty)
    {
      text = "No workers registered";
    }else{
      text = "";
    }

    facilities.forEach((key, value) => text+='$value $key, ');
    return text;
}


String getWorkersText()
{
  String numWorkersText;

    if(workers!.isEmpty)
    {
      numWorkersText = "No workers registered";
    }else{
      numWorkersText = "";
    }

    workers!.forEach((key, value) => numWorkersText+='$value $key, ');
  
   return numWorkersText;
}

String getAmenitiesText(){
  String text="";
  for(int i=0; i<amenities!.length; i++)
  {
    text+='${amenities![i]}, ';
  }
  return text;
}



Future<void> makeNewBooking(List<DateTime> dates) async
{

  Map<String, dynamic> bookingData ={
    'dates': dates,
    'name': '${AppConstants.currentUser!.firstName} ${AppConstants.currentUser!.firstName}',
    'userID': AppConstants.currentUser!.id,
  };

  DocumentReference reference = await FirebaseFirestore.instance.collection('postings/$id/bookings').add(bookingData);


  Booking newBooking = Booking();
  newBooking.createBooking(this, AppConstants.currentUser!.createContactFromUser(), dates);
  newBooking.id = reference.id;

  bookings!.add(newBooking);
  await AppConstants.currentUser!.addBookingToFirestore(newBooking);
}

Future<void> makeNewJobBooking(List<DateTime> dates, String job) async
{

  Map<String, dynamic> bookingData ={
    'jobDate': dates,
    'name': '${AppConstants.currentUser!.firstName} ${AppConstants.currentUser!.firstName}',
    'userID': AppConstants.currentUser!.id,
    'job': job,
  };

  DocumentReference reference = await FirebaseFirestore.instance.collection('postings/$id/jobApplications').add(bookingData);


  Booking newBooking = Booking();
  newBooking.createBooking(this, AppConstants.currentUser!.createContactFromUser(), dates);
  newBooking.id = reference.id;

  jobBookings!.add(newBooking);
  await AppConstants.currentUser!.addBookingToFirestore(newBooking);
  print("added booking to firestore");
}

Future<void> getAllBookingsFromFireStore() async{
  bookings = [];
  QuerySnapshot snapshots = await FirebaseFirestore.instance.collection('postings/$id/bookings').get(); //initally getDocuments()
  for(var snapshot in snapshots.docs){
    Booking newBooking = Booking();
    await newBooking.getBookingInfoFromFirestoreFromPosting(this, snapshot);
    bookings!.add(newBooking);

  }
}

List<DateTime> getAllBookedDates(){
  List<DateTime> dates=[];
  for (var booking in bookings!) {
      dates.addAll(booking.dates as Iterable<DateTime>);
    }
  return dates;
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


class Booking{

  String? id;
  Posting? posting;
  Contact? contact;
  List<DateTime>? dates;
  String? job;
  DateTime? jobDate;

  Booking(); 

  void createBooking(Posting posting, Contact contact, List<DateTime> dates)
  {
    this.posting = posting;
    this.contact = contact;
    this.dates = dates;
    this.dates!.sort();

  }

  // void CreateApplication(Posting posting, List<DateTime> dates, String job)
  // {
    
  // }

  Future<void> getBookingInfoFromFirestoreFromUser(Contact contact, DocumentSnapshot snapshot) async{
    this.contact = contact;
    List<Timestamp> timestamps = List<Timestamp>.from(snapshot['dates'])??[];
    dates =  [];//was string
    for (var timestamp in timestamps) {
      dates!.add(timestamp.toDate());
     }
    String postingID = snapshot['postingID'] ?? "";

    posting = Posting(id: postingID);
    await posting!.getPostingInfoFromFireStore();
    await posting!.getFirstImageFromStorage();
  }

    Future<void> getBookingInfoFromFirestoreFromPosting(Posting posting, DocumentSnapshot snapshot) async{
    this.posting = posting;
   List<Timestamp> timestamps = List<Timestamp>.from(snapshot['dates'])??[];
    dates =  [];//was string
    for (var timestamp in timestamps) {
      dates!.add(timestamp.toDate());
     }
    String contactID = snapshot['userID'] ?? "";
    String fullName = snapshot['name']??"";
   
    contact = Contact(id: contactID);
    await contact!.getContactInfoFromFireStore();
  }

  void _loadContactInfo(String id, String fullName){
     String firstName="";
    String lastName = "";
    firstName = fullName.split(" ")[0];
    lastName = fullName.split(" ")[1];
    contact = Contact(id: id, firstName: firstName, lastName: lastName);

  }

  String getFirstDate()
  {
    String firstDateTime = dates!.first.toIso8601String();
    return firstDateTime.substring(0, 10);
  }

   String getLastDate()
  {
    String lastDateTime = dates!.last.toIso8601String();
    return lastDateTime.substring(0, 10);
  }

}