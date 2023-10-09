 import 'package:flutter/material.dart';
import 'package:hotel_hunter/Models/AppConstants.dart';
import 'package:hotel_hunter/Views/calendarWidgets.dart';
import 'package:hotel_hunter/Views/listWidgets.dart';


class BookingsPage extends StatefulWidget {

  const BookingsPage({super.key});

  @override
  _BookingsPageState createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {

  List<DateTime> _bookedDates = [];

  @override
  void initState() {
   
    _bookedDates =  AppConstants.currentUser!.getAllBookedDates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
             child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(bottom: 25.0),
                  child: Row(
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
                ),
                Padding(
                  padding: const EdgeInsets.only( bottom: 0),
                  child: SizedBox(

                     height: MediaQuery.of(context).size.height/1.5,
                     child: PageView.builder(
                      itemCount: 12,
                      itemBuilder: (context, index){
                        return Padding(
                          padding: const EdgeInsets.only(bottom:0),
                          child: CalendarMonthWidget(
                            monthIndex: index,
                            bookedDates: _bookedDates,
                          ),
                        );
                       
                      }
                       ),
                    ),
                ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 35, 25, 25),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  
                      children: <Widget>[
                        const Text("Filter by Hosting",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),),
                        MaterialButton(
                          onPressed: (){},
                        child: const Text('Reset',
                         style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),),)
                      ],
                    ),
                  ),
                  Padding(
      padding: const EdgeInsets.only( bottom: 25),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: AppConstants.currentUser!.myPostings!.length,

        itemBuilder: (context, index){
        
          return Padding(
            padding: const EdgeInsets.only(bottom: 25.0,),
            child: InkResponse(
                  onTap: (){
                 },
              child: Container(
            
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppConstants.backgroundColor,
                    width: 2.0,
                    
                    ),
                    borderRadius: BorderRadius.circular(5.0)),
                child: MyPostingListTile(
                  posting: AppConstants.currentUser!.myPostings![index],
                ),
              ),
            ),
          );
        },
      ),
    ), 
              ],
              
              )
            ),
    ); 
  }
}



