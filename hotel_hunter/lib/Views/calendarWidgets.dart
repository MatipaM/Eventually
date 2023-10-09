import 'package:flutter/material.dart';
import 'package:hotel_hunter/Models/AppConstants.dart';

class CalendarMonthWidget extends StatefulWidget{

  final int monthIndex;
  final List<DateTime>? bookedDates;

  const CalendarMonthWidget({Key? key, required this.monthIndex, this.bookedDates}): super(key: key);

  @override
  _CalendarMonthState createState() => _CalendarMonthState();


}

class _CalendarMonthState extends State<CalendarMonthWidget>{

List<MonthTile> _monthTiles=[];
int? _currentMonthInt;
int _currentYearInt = DateTime.now().year;

//not meant to be initialised here

void _setUpMonthTiles(){
  setState(() {
    
  });

  _monthTiles=[];
  int daysInMonths = AppConstants.daysInMonths[_currentMonthInt]!;
  DateTime firstDayOfMonth = DateTime(_currentYearInt, _currentMonthInt!, 1);
  int firstWeekDayOfMonth = firstDayOfMonth.weekday;

  if(firstWeekDayOfMonth!=7)
  {
  for(int i =0; i<firstWeekDayOfMonth; i++)
  {
    _monthTiles.add(const MonthTile(dateTime: null));
  }
  }

  for(int i=1; i<=daysInMonths; i++)
  {
    DateTime date = DateTime(_currentYearInt, _currentMonthInt!, i);
    _monthTiles.add(MonthTile(dateTime: date));
  }
}

  @override
  void initState(){
  _currentMonthInt = (DateTime.now().month  + widget.monthIndex)%12;
  //_currentMonthInt = (widget.monthIndex)%12;
  if(_currentMonthInt==0){
    _currentMonthInt=12;
  }

 //_currentYearInt = DateTime.now().year;
 if(_currentMonthInt!<DateTime.now().month)
 {
  _currentYearInt+=1;
 }

    _setUpMonthTiles();
    print('unavailable dates: ${widget.bookedDates}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Text(
            "${AppConstants.monthDict[_currentMonthInt]! } - $_currentYearInt"),
        ),
        GridView.builder(
          itemCount: _monthTiles.length,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 1.7/1,
            ),
          itemBuilder: (context, index){
            MonthTile monthTile = _monthTiles[index];
            
              if(widget.bookedDates!.contains(monthTile.dateTime))
              {
                return MaterialButton(onPressed: null,
                color: AppConstants.accentColor, 
                disabledColor: AppConstants.backgroundColor,
                child: monthTile, 
                );
              }
              return MaterialButton(
              onPressed: (){},
              child: monthTile);
          },
          )
      ],
    );
  }

}

class MonthTile extends StatelessWidget{

final DateTime? dateTime;

  const MonthTile({Key? key,required this.dateTime}):super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Text(
      dateTime==null? "": dateTime!.day.toString(), //should be dayTime.day
      
    );
  }

}