import 'package:flutter/material.dart';
import 'package:hotel_hunter/Models/AppConstants.dart';

class CalendarMonthWidget extends StatefulWidget{

  final int monthIndex;
  final List<DateTime>? bookedDates;
  final Function? selectDate;
  final Function? getSelectedDates;

  const CalendarMonthWidget({Key? key, required this.monthIndex, this.bookedDates, this.selectDate, this.getSelectedDates}): super(key: key);

  @override
  _CalendarMonthState createState() => _CalendarMonthState();


}

class _CalendarMonthState extends State<CalendarMonthWidget>{

final List<DateTime> _selectedDates = [];
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

void _selectDate(DateTime date)
{
  if(_selectedDates.contains(date))
  {
    _selectedDates.remove(date);
  }else{
      _selectedDates.add(date);
  }

_selectedDates.sort();
  widget.selectDate!(date);

  setState(() {
    
  });

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

    _selectedDates.addAll(widget.getSelectedDates!());

    _setUpMonthTiles();
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
             if(monthTile.dateTime==null)
             {
              return MaterialButton(onPressed: null,
                child: monthTile, 
                );
             }
            
              if(widget.bookedDates!.contains(monthTile.dateTime))
              {
                print('month tile date time: ${monthTile.dateTime}');
                return MaterialButton(onPressed: null,
                color: AppConstants.accentColor, 
                disabledColor: AppConstants.backgroundColor,
                child: monthTile, 
                );
              }
              return MaterialButton(
              onPressed: (){
                _selectDate(monthTile.dateTime!);
                print('selected dates are $_selectedDates'); 
              },
              child: monthTile,
              color: (_selectedDates.contains(monthTile.dateTime))?AppConstants.primaryColor:Colors.white,
              );
          },
          )
      ],
    );
  }

}

class CalendarWorkerMonthWidget extends StatefulWidget{

  final int monthIndex;
  final List<DateTime>? bookedDates;
  final Function? selectDate;
  final Function? getSelectedDates;

  const CalendarWorkerMonthWidget({Key? key, required this.monthIndex, this.bookedDates, this.selectDate, this.getSelectedDates}): super(key: key);

  @override
  _CalendarWorkerMonthState createState() => _CalendarWorkerMonthState();


}

class _CalendarWorkerMonthState extends State<CalendarWorkerMonthWidget>{

final List<DateTime> _selectedDates = [];
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

void _selectDate(DateTime date)
{
  if(_selectedDates.contains(date))
  {
    _selectedDates.remove(date);
  }else{
      _selectedDates.add(date);
  }

_selectedDates.sort();
  widget.selectDate!(date);

  setState(() {
    
  });

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

    _selectedDates.addAll(widget.getSelectedDates!());

    _setUpMonthTiles();
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
             if(monthTile.dateTime==null)
             {
              return MaterialButton(onPressed: null,
                child: monthTile, 
                );
             }
            
              if(widget.bookedDates!.contains(monthTile.dateTime))
              {
                print('month tile date time: ${monthTile.dateTime}');
                return MaterialButton(onPressed: (){_selectDate(monthTile.dateTime!);},
                 color: (_selectedDates.contains(monthTile.dateTime))?AppConstants.primaryColor:Colors.white,
               // disabledColor: AppConstants.backgroundColor,
                child: monthTile, 
                
                );
              }
              return MaterialButton(
              onPressed: (){
                null;
              },
              child: monthTile,
              color: AppConstants.backgroundColor,
              );
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