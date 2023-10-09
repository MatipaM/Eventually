 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_hunter/Models/AppConstants.dart';
import 'package:hotel_hunter/Models/UserObjects.dart';

class Conversation{

  String? id;
  Contact? otherContact;
  List<Message>? messages;
  Message? lastMessage;

  Conversation(){
    messages = [];
  }

  void createConversation(Contact otherContact, List<Message> messages)
  {
    this.otherContact = otherContact;
    this.messages = messages;
    if(messages.isNotEmpty)
    {
      lastMessage = messages.last;
    }
  }

  void getConversationInfoFromFirestore(DocumentSnapshot snapshot){
    id = snapshot.id;
    String lastMessageText = snapshot['lastMessageText']??"";
    Timestamp lastMessageTimeStamp = snapshot['lastMessageDateTime']??Timestamp.now();
    DateTime lastMessageDateTime = lastMessageTimeStamp.toDate();

    lastMessage  =Message();
    lastMessage!.dateTime = lastMessageDateTime;
    lastMessage!.text = lastMessageText;

    Map<String, String> userInfo = Map<String, String>.from(snapshot['userInfo']);
    userInfo.forEach((id, name) { 
      if(id!=AppConstants.currentUser!.id){
        otherContact = Contact(id: id, firstName: name.split(" ")[0], lastName: name.split(" ")[1]);
      }
    });
  }

  String getLastMessageText()
  {
    if(messages!.isEmpty)
    {
      return "";
    }else{
      return messages!.last.getMessageDateTime();
    }
  }
  
  String getLastMessageDateTime(){
    if(messages!.isEmpty)
    {
      return "";
    }else{
      return messages!.last.text!;
    }
  }


 }

 class Message{
  Contact? sender;
  String? text;
  DateTime? dateTime;

  //Message();

  void getMessageInfoFromFirestore(DocumentSnapshot snapshot){
    Timestamp lastMessageTimestamp = snapshot['dateTime']??Timestamp.now();
    dateTime = lastMessageTimestamp.toDate();
    String senderID = snapshot['senderID']??"";
    sender = Contact(id:senderID);
    text = snapshot['text'];
  }

  void createMessage(Contact sender, String text, DateTime dateTime)
  {
    this.sender = sender;
    this.text = text;
    this.dateTime = dateTime;
  }

  String getMessageDateTime()
  {
    final DateTime now = DateTime.now();
    final int today = now.day;
    if(dateTime!.day==today)
    {
      return _getTime();
    }else{
      return _getDate();
    }
  }

  String _getDate()
  {
    String date = dateTime!.toIso8601String().substring(5, 10);
    String month = date.substring(0,2);
    int monthInt = int.parse(month);
    String monthName = AppConstants.monthDict[monthInt]!;
    String day = date.substring(3,5);
    return "$month $day";
  }

  String _getTime()
  {
    String time = dateTime!.toIso8601String().substring(11, 16);
    String hours = time.substring(0, 2);
    int hoursInt = int.parse(hours);
    if(hoursInt>12)
    {
      hoursInt-=12;
    }
    hours = hoursInt.toString();
    String minutes = time.substring(2);
    return hours + minutes;
  }

 }