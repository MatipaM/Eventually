import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hotel_hunter/Models/AppConstants.dart';
import 'package:hotel_hunter/Models/messagingObjects.dart';
import 'package:hotel_hunter/Models/postingObject.dart';
import 'package:hotel_hunter/Models/reviewObjects.dart';
import 'package:hotel_hunter/Screens/viewProfilePage.dart';


class ReviewListTile extends StatefulWidget {  

  final Review? review;

const ReviewListTile({Key? key, this.review}): super(key: key);

  @override
   _ReviewListTileState createState()=> _ReviewListTileState();
  
}

class _ReviewListTileState extends State<ReviewListTile>{

  Review? _review;

  @override
  void initState()
  {
    _review = widget.review;
    _review!.contact!.getImageFromStorage().whenComplete(() => { 
      setState(() {
        
      })
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      color: AppConstants.backgroundColor,
      borderRadius: BorderRadius.circular(15),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          children: <Widget>[
            InkResponse(
              onTap: () {
                 Navigator.push(
                            context,
                          MaterialPageRoute(
                            builder: (context) => ViewProfilePage(
                              contact:  _review!.contact,
                            ),
                          ) 
                           );
              },
              child: Container(
                child: (_review!.contact!.displayImage==null)? Container(
                  width: MediaQuery.of(context).size.width/7.5
                ):CircleAvatar(
                  backgroundImage: _review!.contact!.displayImage,
                  radius: MediaQuery.of(context).size.width/15,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: AutoSizeText(_review!.contact!.firstName!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20),),
            ),
           RatingBar.builder(
         initialRating: 3,
         minRating: 1,
         direction: Axis.horizontal,
         allowHalfRating: true,
         itemCount: 5,
         itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
         itemBuilder: (context, _) => const Icon(
         Icons.star,
         color: AppConstants.accentColor,
         ),
         onRatingUpdate: 
         (rating) {
         print(_review!.rating);
         },
          ),
            const Row(),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15),
              child: AutoSizeText(
                _review!.text!,
                style: const TextStyle(
                  fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class ConversationListTile extends StatefulWidget{

  final Conversation conversation;
  const ConversationListTile({required this.conversation, Key? key}):super(key: key);
  
  @override
  _ConversationListTileState createState() => _ConversationListTileState();

}

class _ConversationListTileState extends State<ConversationListTile>
{

Conversation? _conversation;

 @override
  void initState(){
  _conversation = widget.conversation;
  super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0,0,0,0),
      child: Material(
        borderRadius: BorderRadius.circular(15),
        color: AppConstants.backgroundColor,
        child: ListTile(
          leading: GestureDetector(
            onTap:(){
               Navigator.push(
                            context,
                          MaterialPageRoute(
                            builder: (context) => ViewProfilePage(
                              contact:  _conversation!.otherContact,
                            ),
                          ) 
                           );
            },
            child: CircleAvatar(
              backgroundImage: _conversation!.otherContact!.displayImage,
              radius: MediaQuery.of(context).size.width/30.0,
             
              ),
          ),
             title: Text(_conversation!.otherContact!.fullName!,
             style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22.5,
             )),
            subtitle: AutoSizeText(_conversation!.getLastMessageDateTime(),
            style: const TextStyle(
             //fontSize: 20
              ),
              minFontSize: 20,
              overflow: TextOverflow.ellipsis,),
              trailing: Text(_conversation!.getLastMessageText(),
              style: const TextStyle(
                fontSize: 15 )),
                contentPadding: const EdgeInsets.fromLTRB(25, 15,25,15),
          ),
      ),
    );
  }

}

class MessageListTile extends StatelessWidget{

  final Message? message;

  const MessageListTile({this.message, Key? key}):super(key:key);

  @override
  Widget build(BuildContext context) {

    if(message!.sender!.firstName == AppConstants.currentUser!.firstName)
    {
       return Padding(
      padding: const EdgeInsets.fromLTRB(35,5,15, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Material(
                //color: AppConstants.backgroundColor,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppConstants.primaryColor,
                    borderRadius: BorderRadius.circular(
                      10
                    )
                    ),
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(message!.text!,
                      textWidthBasis: TextWidthBasis.parent,
                      style: const TextStyle(
                        fontSize: 17,
                      )),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(message!.getMessageDateTime(),
                      style: const TextStyle(
                        fontSize: 13,
                      ),)),
                    ],
                  ),
                  
                  ),
              ),
            ),
          ),

        GestureDetector(
            onTap:()
            {
              Navigator.push(context, 
              MaterialPageRoute(
                builder: (context) => ViewProfilePage(
                  contact: AppConstants.currentUser!.createContactFromUser(),
                  
                )));
            },
            child: CircleAvatar(
              backgroundImage: AppConstants.currentUser!.displayImage,
              radius: MediaQuery.of(context).size.width/20,
            ),
          ),
        ],
      ),
    );
    }else{

    return Padding(
      padding: const EdgeInsets.fromLTRB(15,5,35, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          GestureDetector(
            onTap:(){
              Navigator.push(context, 
              MaterialPageRoute(
                builder: (context) => ViewProfilePage(
                  contact:message!.sender,
                  
                )));
            },
            child: CircleAvatar(
              backgroundImage: message!.sender!.displayImage!,
              radius: MediaQuery.of(context).size.width/20,
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppConstants.secondaryColor,
                  borderRadius: BorderRadius.circular(
                    10
                  )
                  ),
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(message!.text!,
                    textWidthBasis: TextWidthBasis.parent,
                    style: const TextStyle(
                      fontSize: 17,
                    )),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(message!.getMessageDateTime(),
                    style: const TextStyle(
                      fontSize: 13,
                    ),)),
                  ],
                ),
                
                ),
            ),
          )
        
        ],
      ),
    );
    }

    
     
  }

}

class MyPostingListTile extends StatefulWidget{

  final Posting? posting;

  const MyPostingListTile({this.posting, Key? key}):super(key:key);

  @override
  _MyPostingListTileState createState() => _MyPostingListTileState();

}

class _MyPostingListTileState extends State<MyPostingListTile>{

  Posting? _posting;

  @override
  void initState()
  {
    _posting = widget.posting;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: AutoSizeText(
            _posting!.name!,
            style:const TextStyle(
              fontWeight: FontWeight.bold
            ),
            minFontSize: 20,
            maxLines: 2,
          ),
        ),
        trailing: AspectRatio(
          aspectRatio: 4/3,
          child: Image(
            image: _posting!.displayImages!.first,
            fit: BoxFit.fitWidth))
      ),
    );
  }
  
}

class CreatePostingListTile extends StatelessWidget{
  const CreatePostingListTile({super.key});

@override
Widget build(BuildContext context){
  return SizedBox(
    height: MediaQuery.of(context).size.height/12,
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 15.0),
          child: Icon(Icons.add),
        ),
        Text('Create a posting',
        style: TextStyle(
          fontSize: 20.0),),
      ],));
}
}

class TandCListTile extends StatefulWidget{

  final Posting? posting;

  const TandCListTile({this.posting, Key? key}):super(key:key);

  @override
  _TandCListTileState createState() => _TandCListTileState();

}

class _TandCListTileState extends State<TandCListTile>{

      Posting? _posting;

      String guestSummary = "";
      String hostSummary = "";
      String workerSummary = "";

      @override
  void initState()
      {
        _posting = widget.posting;
        super.initState();
      }

@override
Widget build(BuildContext context){
  return SizedBox(
    height: MediaQuery.of(context).size.height/12,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text('Terms and Conditions',
        style: TextStyle(
          fontSize: 20.0),),
          //Text(this.posting==''?'summary1':'summary2'), //if statement for different paragraphs
          GestureDetector(
            onTap:()
            {
              Navigator.push(context, 
              MaterialPageRoute(
                builder: (context) => const ViewProfilePage(
                  //place if statement to navigate to desired page
                  //contact: AppConstants.currentUser!.createContactFromUser(),
                  
                )));
            },
            
          ),
      ],));

}
}