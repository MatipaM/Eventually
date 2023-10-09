import 'package:flutter/material.dart';
import 'package:hotel_hunter/Models/AppConstants.dart';
import 'package:hotel_hunter/Models/postingObject.dart';
import 'package:hotel_hunter/Views/calendarWidgets.dart';
import 'package:hotel_hunter/Views/textWidgets.dart';

class BookPostingPage extends StatefulWidget {

  static const String routeName = '/bookPostingPageRoute';
    final Posting? posting;

  const BookPostingPage({this.posting, Key? key}): super(key: key);

  @override
  State<BookPostingPage> createState() => _BookPostingPageState();
}

class _BookPostingPageState extends State<BookPostingPage> {

  Posting? _posting;

  @override
  void initState(){
    _posting = widget.posting;
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const AppBarText(text: 'Book an event'),
        ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
           child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                Text('Sun'),
                Text('Mon'),
                Text('Tue'),
                Text('Wed'),
                Text('Thur'),
                Text('Fri'),
                Text('Sat'),

              ],),
              SizedBox(
                 height: MediaQuery.of(context).size.height/1.5,
                 child: PageView.builder(
                  itemCount: 12,
                  itemBuilder: (context, index){
                    return CalendarMonthWidget(
                      monthIndex: index,
                      bookedDates: _posting!.getAllBookedDates(),//was not meant to be required
                    );
                  }
                   ),
                ),
                MaterialButton(onPressed: 
                (){},
                minWidth: double.infinity,
                height: MediaQuery.of(context).size.height/14,
                color: AppConstants.secondaryColor,
                child: const Text('Book Now'),
                )
            ],
            
            )
          )
       
      
    );
  }
}



