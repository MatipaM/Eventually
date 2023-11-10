 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_hunter/Models/AppConstants.dart';
import 'package:hotel_hunter/Models/UserObjects.dart';

class Conversation{

  String? id;
  Contact? otherContact;
  List<Message>? messages;
  Message? lastMessage;
  String? lastMessageText;

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

  Future<void> getConversationInfoFromFirestore(DocumentSnapshot snapshot) async{ //badstate exception, snapshot does not exist
    //print("getConversationInfoFromFirestore");
    id = snapshot.id;
    lastMessageText = snapshot['lastMessageText']??"";
    Timestamp lastMessageTimeStamp = snapshot['lastMessageDate']??Timestamp.now();
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

  Future<void> addConversationToFirestore(Contact otherContact) async{
    List<String> userNames = ['${AppConstants.currentUser!.firstName} ${AppConstants.currentUser!.firstName}',
    '${otherContact.firstName} ${otherContact.lastName}'];

     List<String> userIDs = ['${AppConstants.currentUser!.id}',
    '${otherContact.id}'];

    Map<String, dynamic> convoData = {
       'lastMessageDate': DateTime.now(),
      'lastMessageText': "",
      'userNames': userNames,
      'userIDs': userIDs,
    };

    DocumentReference reference = await FirebaseFirestore.instance.collection('conversations/').add(convoData);
    id = reference.id;
  }

  Future<void> addMessageToFirestore(String messageText)
  async {
    DateTime now = DateTime.now();
    Map<String, dynamic> messageData = {
      'dateTime': now,
      'senderID': AppConstants.currentUser!.id,
      'text':messageText,
    };

    await FirebaseFirestore.instance.collection('conversations/$id/messages').add(messageData);
    Map<String, dynamic> convoData = {
      'lastMessageDate': now,
      'lastMessageText': messageText,
    };
    await FirebaseFirestore.instance.doc('conversations/$id').update(convoData);
  }

 }

 class Message{
  Contact? sender;
  String? text;
  DateTime? dateTime;


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