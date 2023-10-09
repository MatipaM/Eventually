import 'package:flutter/material.dart';
import 'package:hotel_hunter/Models/AppConstants.dart';
import 'package:hotel_hunter/Models/postingObject.dart';
import 'package:hotel_hunter/Screens/viewPostingPage.dart';
import 'package:hotel_hunter/Views/gridWidgets.dart';

class TripsPage extends StatefulWidget {

  const TripsPage({super.key});

  @override
  _TripsPage createState() => _TripsPage();
}

class _TripsPage extends State<TripsPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 25.0),
                child: Text('Upcoming Events',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 25),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height/2,
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount:  AppConstants.currentUser!.getUpcomingTrips().length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index){
                     Booking currentBooking = AppConstants.currentUser!.getUpcomingTrips()[index];
                      //Booking currentBooking = Booking();
                      return Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width/2.5,
                          child: InkResponse(
                          enableFeedback: true,
                          child: TripsGridTile(
                            booking: currentBooking,
                          ),
                          onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                              builder: (context) => ViewPostingPage(
                                posting: currentBooking.posting!)),
                            );
                    },
                    ),
                          ),
                      );
                    },)
                
                  // color: Colors.blue,
                ),
              ),   
              const Text('Previous Events' ,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),),
               Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 25),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height/2,
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: AppConstants.currentUser!.getPreviousTrips().length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index){
                      Booking currentBooking = AppConstants.currentUser!.getPreviousTrips()[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width/2.5,
                          child: InkResponse(
                          enableFeedback: true,
                          child: TripsGridTile(
                            booking:currentBooking,
                    
                          ),
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                              builder: (context) => ViewPostingPage(
                                posting: currentBooking.posting!)),
                            );
                            
                    },
                    ),
                          ),
                      );
                    },)
                
                  // color: Colors.blue,
                ),
              ),
            ],
          ),
        )
    );
  }
}



