import 'package:flutter/material.dart';
import 'package:hotel_hunter/Models/AppConstants.dart';
import 'package:hotel_hunter/Models/messagingObjects.dart';
import 'package:hotel_hunter/Screens/conversationPage.dart';
import 'package:hotel_hunter/Views/listWidgets.dart';

class InboxPage extends StatefulWidget {

  const InboxPage({super.key});

  @override
  _InboxPageState createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: AppConstants.currentUser!.conversations!.length,
      itemExtent: MediaQuery.of(context).size.height/7, //can display 7 conversations at once
      itemBuilder: (context, index){
        Conversation currentConversation = AppConstants.currentUser!.conversations![index];
        return InkResponse(
          onTap: ()
          {
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) => ConversationPage(
                  conversation: currentConversation,)));
            },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ConversationListTile(
              conversation: currentConversation,
            ),
          ),
        );
      },
      );
  }
}



