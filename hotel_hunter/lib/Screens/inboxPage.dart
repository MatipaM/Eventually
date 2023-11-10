import 'package:cloud_firestore/cloud_firestore.dart';
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
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('conversations').where(
            'userIDs', arrayContains: AppConstants.currentUser!.id).snapshots(),
        builder: (context, snapshots) {
          switch (snapshots.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.none:

            default: 
              return ListView.builder(
                itemCount: snapshots.data!.docs.length, //returning 0
                itemExtent: MediaQuery.of(context).size.height / 7,
                itemBuilder: (context, index) {
                  DocumentSnapshot snapshot = snapshots.data!.docs[index];
                  Conversation currentConversation = Conversation();
                  currentConversation.getConversationInfoFromFirestore(snapshot);
                  return InkResponse(
                    child: ConversationListTile(conversation: currentConversation,),
                    onTap: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder:
                            (context) => ConversationPage(conversation: currentConversation,),
                        ),
                      );
                    },
                  );
                }
              );
          }
        },
      ),
    );
  }
}



