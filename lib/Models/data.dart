
import 'package:hotel_hunter/Models/UserObjects.dart';
import 'package:hotel_hunter/Models/messagingObjects.dart';
import 'package:hotel_hunter/Models/postingObject.dart';
import 'package:hotel_hunter/Models/reviewObjects.dart';

class PracticeData{
  static List<UserObj> users = [];
  static List<Posting> postings = [];

  static populateFields()
  {
    UserObj user1 = UserObj(
      firstName: "Matipa",
      lastName: "Marufu",
      email: "ocmatipa@gmail.com",
      bio: "I like going to festivals",
      city: "Johanessburg",
      country: "South Africa",
      // password: "1@3#Rthv"
    );
    // user1.isHost=true;

     UserObj user2 = UserObj(
      firstName: "Kevin",
      lastName: "Hart",
      email: "kevinhart@gmail.com",
      bio: "I like going to family events",
      city: "Atlanta",
      country: "USA",
      // password: "1@3#Rthv234"
    );

    users.add(user1);
    users.add(user2);

    Review review = Review();
      review.createReview(
        user2.createContactFromUser(),
        "Fun dinner, with great colleagues and equally good food",
        4,
        DateTime.now(),
      );
      user1.reviews!.add(review);

      Conversation conversation = Conversation();
      conversation.createConversation(user2.createContactFromUser(), []);

      Message message1 = Message();
      message1.createMessage(
        user1.createContactFromUser(),
          "Hey, how's it going?",
          DateTime.now()
      );

      Message message2 = Message();
      message2.createMessage(
        user2.createContactFromUser(),
          "Hey, I'm doing well, how are you?",
          DateTime.now()
      );

      conversation.messages!.add(message1);
      conversation.messages!.add(message2);

      user1.conversations!.add(conversation);

      Posting posting1 = Posting(
        name: "Soup Kitchen",
        type: "Volunteer",
        price: 120,
        description: "Feed the homeless",
        address: "123 West 1 Avenue",
        city: "Johannesburg",
        country: "South Africa",
        host: user1.createContactFromUser(),
      );

      // posting1.setImages(["assets/images/SoupKitchen.jpeg", "assets/images/SoupKitchen1.jpeg"]);
      posting1.amenities = ['Wi-fi, coffee'];
      posting1.workers = {
        'Volunteers': 1,
         'Security': 2,
         'Cooks': 10,
         'Organiser': 1,
         'Entertainers': 1,
        'Managers': 0,
      };
      posting1.facilities={
       'Stove': 5,
       'Microwave': 2,
       'Kettle': 3,
        'Music': 3,
        'Rooms': 0,
        'Meals': 0,
        'Drinks': 0,
      };


        Posting posting2 = Posting(
        name: "Work Dinner",
        type: "work event",
        price: 0,
        description: "work event",
        address: "123 West 1 Avenue",
        city: "Rosebank",
        country: "South Africa",
        host: user2.createContactFromUser(),
      );


      // posting2.setImages(["assets/images/WorkEvent1.jpeg", "assets/images/WorkEvent2.jpeg"]);
      posting2.amenities = ['Wi-fi, coffee'];
      posting2.workers = {
        'Volunteers': 1,
         'Cooks': 2,
         'Entertainers': 1,
          'Security': 0,
        'Managers': 0,
        'Organiser': 0,
      };
      posting2.facilities={
       'Stove': 1,
       'Microwave': 1,
       'Music': 3,
        'Kettle': 0,
        'Rooms': 0,
        'Meals': 0,
        'Drinks': 0,
      };
      postings.add(posting1);
      postings.add(posting2);

      Booking booking1 = Booking();
      booking1.createBooking(
        posting1, 
        user1.createContactFromUser(), 
        [DateTime(2023, 09, 20), DateTime(2023, 10, 31)]);

        Booking booking2 = Booking();
      booking2.createBooking(
        posting2, 
        user1.createContactFromUser(), 
        [DateTime(2023, 08, 10), DateTime(2023, 08, 13)]);

        posting1.bookings!.add(booking1);
        posting2.bookings!.add(booking2);

        Review postingReview = Review();
        postingReview.createReview(
          user2.createContactFromUser(), 
          "Lovely soup kitchen, really making a different", 
          3.5, 
          DateTime(2023, 09, 15));

          posting1.reviews!.add(postingReview);
          posting2.reviews!.add(review);

          user1.bookings!.add(booking1);
          user1.bookings!.add(booking2);

          user1.myPostings!.add(posting1);
          user2.myPostings!.add(posting2);

          user1.savedPostings!.add(posting2);
  }


}