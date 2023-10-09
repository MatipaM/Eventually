import 'package:flutter/material.dart';
import 'package:hotel_hunter/Models/messagingObjects.dart';
import 'package:hotel_hunter/Views/listWidgets.dart';
import 'package:hotel_hunter/Views/textWidgets.dart';

class ConversationPage extends StatefulWidget {

  static const String routeName = '/conversationPageRoute';

  final Conversation? conversation;

  const ConversationPage({this.conversation, super.key});

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {

  Conversation? _conversation;
  

  @override
  void initState()
  {
    _conversation = widget.conversation;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: AppBarText(text: _conversation!.otherContact!.fullName!),
        ),
      body: Column(
        children: <Widget>[
         Expanded(child: 
                 ListView.builder(
                  itemCount: _conversation!.messages!.length,
            itemBuilder: (context, index){
              Message currentMessage = _conversation!.messages![index];
              return MessageListTile(
                message: currentMessage,
              );
            }
          ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              )),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                
                SizedBox(
                  width: MediaQuery.of(context).size.width*5/6, //tut. 76
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Write a message',
                      contentPadding: EdgeInsets.all(20.0),
                      border: InputBorder.none,
                     
                
                    ),
                     minLines: 1,
                     maxLines: 5,
                     style: TextStyle(
                      fontSize: 20),
                  ),
                ),
                Expanded(
                  child: MaterialButton(
                    onPressed: (){},
                     child: const Text('Send'),),
                ),
                 
              ]
              ),
            )
        ],
        )
    );
  }
}



