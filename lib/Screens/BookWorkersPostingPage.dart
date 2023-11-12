import 'package:flutter/material.dart';
import 'package:hotel_hunter/Models/AppConstants.dart';
import 'package:hotel_hunter/Models/postingObject.dart';
import 'package:hotel_hunter/Views/calendarWidgets.dart';
import 'package:hotel_hunter/Views/textWidgets.dart';

class BookWorkersPostingPage extends StatefulWidget {

  static const String routeName = '/bookPostingPageRoute';
    final Posting? posting;
    final String? job;

  const BookWorkersPostingPage({this.posting, Key? key, required this.job}): super(key: key);

  @override
  State<BookWorkersPostingPage> createState() => _BookWorkersPostingPageState();
}

class _BookWorkersPostingPageState extends State<BookWorkersPostingPage> {

  Posting? _posting;
  String? job;
  List<CalendarWorkerMonthWidget> _calendarWidgets = [];
  List<DateTime> _bookedDates = [];
  final List<DateTime> _selectedDates = [];

  void _buildCalendarWidgets(){
    _calendarWidgets = [];
    for(int i=0; i<12; i++){
      _calendarWidgets.add(CalendarWorkerMonthWidget(monthIndex: i, bookedDates: _bookedDates, selectDate: _selectDate, getSelectedDates: _getSelectedDates,));
    }
    setState(() {
      
    });
  }
  
  List<DateTime> _getSelectedDates()
  {
    return _selectedDates;
  }

  void _selectDate(DateTime date)
  {
     if(_selectedDates.contains(date))
    {
      _selectedDates.remove(date);
    }else{
        _selectedDates.add(date);
    }

    _selectedDates.sort();

    setState(() {
      
    });
    print('selected dates $_selectedDates');

  }

  void _loadBookedDates(){
    _bookedDates = [];
    _posting!.getAllBookingsFromFireStore().whenComplete((){
        _bookedDates = _posting!.getAllBookedDates();
        _buildCalendarWidgets();
  });
  }

  void _makeApplication()
  {
    if(_selectedDates.isEmpty){print("returned");return;} //changed from isEmpty
    print("making booking");
      AppConstants.currentUser!.addJobApplicationsToMyJobs(_posting!);
     _posting!.makeNewJobBooking(_selectedDates, job!).whenComplete((){
      print("made application");
      Navigator.pop(context);
    });
    

  }

      @override
  void initState(){
    _posting = widget.posting;
    job=widget.job;
    print("I am applying for $job");
    _makeApplication();
    _loadBookedDates();
   
  }
    
  



  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const AppBarText(text: 'Book a Day'), //${this._posting.name}
        ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
        
           child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text("Eventually I'll be free to work on: ",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),),
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
                 child: (_calendarWidgets.isEmpty)?Container(): 
                  PageView.builder(
                    itemCount: _calendarWidgets.length,
                  itemBuilder: (context, index){
                    return _calendarWidgets[index];
                  }
                   ),
                ),
                MaterialButton(
                  onPressed: 
                _makeApplication,
                minWidth: double.infinity,
                height: MediaQuery.of(context).size.height/14,
                color: AppConstants.secondaryColor,
                child: const Text('Apply Now'),
                )
            ],
            
            )
          )
       
      
    );
  }
}



