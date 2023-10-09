
import 'package:flutter/material.dart';
import 'package:hotel_hunter/Models/postingObject.dart';
import 'package:hotel_hunter/Views/textWidgets.dart';

class CreatePostingPage extends StatefulWidget {

  static const String routeName = '/createPostingPageRoute';

  final Posting? posting;
  
  const CreatePostingPage({this.posting, super.key});

  @override
  State<CreatePostingPage> createState() => _CreatePostingPageState();
}

class _CreatePostingPageState extends State<CreatePostingPage> {

    final List<String> _eventTypes = [
    'Festival',
    'Volunteer Work',
    'Family/Friend',
    'Restaurant',
    'Live Music'
  ];

  TextEditingController? _nameController;
  TextEditingController? _priceController;
  TextEditingController? _descriptionController;
  TextEditingController? _addressController;
  TextEditingController? _cityController;
  TextEditingController? _countryController;
  TextEditingController? _amenitiesController;

   String? _eventType;
   Map<String, int>? _workers;
  Map<String, int>? _facilities;

  List<MemoryImage>? _images;

  void _setUpInitialValues(){
    if(widget.posting==null)
    {
      _nameController = TextEditingController();
      _priceController = TextEditingController();
      _descriptionController = TextEditingController();
      _addressController = TextEditingController();
      _cityController = TextEditingController();
      _countryController = TextEditingController();
      _amenitiesController = TextEditingController();

      _workers = {
        'Security': 0,
        'Managers': 0,
        'Organiser': 0,
        'Cooks': 0,
        'Entertainers': 0,
        'Volunteers': 0,
      };

      _facilities = {
        'Kettle': 0,
        'Microwave': 0,
        'Stove': 0,
        'Rooms': 0,
        'Meals': 0,
        'Drinks': 0,
        'Music': 0,
      };

      _images=[];

    }else{
_nameController = TextEditingController();
      _priceController = TextEditingController(text: widget.posting!.name);
      _descriptionController = TextEditingController(text: widget.posting!.price.toString());
      _addressController = TextEditingController(text: widget.posting!.address);
      _cityController = TextEditingController(text: widget.posting!.city);
      _countryController = TextEditingController(text: widget.posting!.country);
      _amenitiesController = TextEditingController(text: widget.posting!.getAmenitiesString());

      _workers = widget.posting!.workers;

      _facilities = widget.posting!.facilities;

      _images=widget.posting!.displayImages;
    }

    setState(() {
      
    });
  }


  @override
  void initState() {
   _setUpInitialValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const AppBarText(text: 'Create A Posting'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: (){},
            ),
             IconButton(
            icon: const Icon(Icons.save),
            onPressed: (){},
            )
        ]
        ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(50, 50, 50, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Text('Please enter the following information',    
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  
                ),
                textAlign: TextAlign.center,
                ),
              
                Form(child: Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 35.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Event Name'),
                          style: const TextStyle(
                  fontSize: 25,
                  
                ),
                 controller: _nameController,
                    ),
                   
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: DropdownButton(
                      isExpanded: true,
                      value: _eventType,
                      hint: const Text('Select the type of event',
                      style: TextStyle(
                        fontSize: 17.0,)),
                      items: _eventTypes.map((type){
                        return DropdownMenuItem(
                          value: type,
                          child: Text(type, 
                          style: 
                          const TextStyle(
                            fontSize: 17.0,

                          ),),
                          );
                      }).toList(),
                      onChanged: (value){ //changes value of type selected 

                      },
                      )
                    
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 35.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                              labelText: 'Price'),
                                 style: const TextStyle(
                                          fontSize: 25,
                                          
                                        ),
                                        controller: _priceController,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0, bottom: 15.0),
                          child: Text('R per night',
                          style: TextStyle(
                            fontSize: 20,
                          ),),
                        ),
                      ],
                    ),
                    
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: TextFormField(
                        decoration: const InputDecoration(
                        labelText: 'Description'),
                           style: const TextStyle(
                  fontSize: 25,
                  
                ),
                controller: _descriptionController,
                maxLines: 3,
                 minLines: 1,
                    ),
                    
                  ),
                   Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: TextFormField(
                        decoration: const InputDecoration(
                        labelText: 'Address'),
                           style: const TextStyle(
                  fontSize: 25,
                  
                ),
                controller: _addressController,
                    ),
                    
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: TextFormField(
                        decoration: const InputDecoration(
                        labelText: 'City'),
                           style: const TextStyle(
                  fontSize: 25,
                  
                ),
                controller: _cityController,
                    ),
                    
                  ),
                   Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: TextFormField(
                        decoration: const InputDecoration(
                        labelText: 'Country'),
                           style: const TextStyle(
                  fontSize: 25,
                  
                ),
                controller: _countryController,
                    ),
                    
                  ),
                   const Padding(
                    padding: EdgeInsets.only(top: 25.0),
                    child: 
                    Text('Workers/Volunteers needed',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),)
                  ),
                      Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: 
                    Column(
                      children: <Widget>[
                        FacilitiesWidget(
                          type: 'Entertainers', startValue: _workers!['Entertainers'],
                        ),
                        FacilitiesWidget(
                          type: 'Cooks', startValue: _workers!['Cooks'],
                        ),
                        FacilitiesWidget(
                          type: 'Organiser', startValue: _workers!['Organiser'],
                        ),
                        FacilitiesWidget(
                          type: 'Security', startValue: _workers!['Security'],
                        ),
                        FacilitiesWidget(
                          type: 'Managers', startValue: _workers!['Managers'],
                        ),
                         FacilitiesWidget(
                          type: 'Volunteers', startValue: _workers!['Volunteers'],
                        ),
                      ],)
                  ),
                   const Padding(
                    padding: EdgeInsets.only(top: 25.0),
                    child: 
                    Padding(
                      padding: EdgeInsets.only(left: 15.0, right: 15),
                      child: Text('Facilities Provided',
                       style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),),
                    )
                  ),
                   Padding(
                    padding: const EdgeInsets.fromLTRB(15, 25.0, 15, 25),
                    child: 
                    Column(
                      children: <Widget>[
                     
                        FacilitiesWidget(
                          type: 'Stove', startValue: _facilities!['Stove'],
                        ),
                        FacilitiesWidget(
                          type: 'Microwave', startValue:_facilities!['Microwave'],
                        ),
                        FacilitiesWidget(
                          type: 'Kettle', startValue: _facilities!['Kettle'],
                        ),   
                   
                        FacilitiesWidget(
                          type: 'Music', startValue: _facilities!['Music'],
                        ),
                             FacilitiesWidget(
                          type: 'Rooms', startValue:_facilities!['Rooms'],
                        ),
                        FacilitiesWidget(
                          type: 'Meals', startValue: _facilities!['Meals'],
                        ),   
                   
                        FacilitiesWidget(
                          type: 'Drinks', startValue: _facilities!['Drinks'],
                        ),
                         
                      ],)
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: TextFormField(
                        decoration: const InputDecoration(
                        labelText: 'Amenities, (Comma seperated)'),
                           style: const TextStyle(
                  fontSize: 25,
                  
                ),
                controller: _amenitiesController,
                maxLines: 3,
                 minLines: 1,
                    ),
                    
                  ),
                   const Padding(
                    
                    padding: EdgeInsets.only(top: 25.0),
                    
                    child: Text('Images',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                    ),
                    
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25, bottom: 25),
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: 0,//_images!.length+1,
                      itemBuilder: (context, index){
                        if(index==_images!.length)
                        {
                          return Container(
                            color: Colors.grey,
                            child: IconButton(
                              onPressed: (){}, 
                              
                              icon: const Icon(Icons.add),),
                          );
                        }
                          
                          return MaterialButton(
                            onPressed: (){},
                         child: Image( 
                          image: _images![index], 
                         fit: BoxFit.fill,
                         
                          ),
                          );
                      },
                     
                      
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 25,
                        crossAxisSpacing: 25,
                        childAspectRatio: 4/3),
                      )
                    )
                 
                ]),
                ),
               
                   
              ],
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class FacilitiesWidget extends StatefulWidget{
  final String? type;
  final int? startValue;

  const FacilitiesWidget({Key? key, this.startValue, this.type}):super(key: key);

  @override
  _FacilitiesWidgetState createState()=> _FacilitiesWidgetState();
  }
  


class _FacilitiesWidgetState extends State<FacilitiesWidget>{

  int? _value;

   @override
  void initState(){
      _value = widget.startValue;
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          widget.type!,
          style: const TextStyle(
            fontSize: 18,
          ),),
        Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: (){

              },
            ), Text(_value.toString(),
            style: const TextStyle(
            fontSize: 18,
          ),),
             IconButton(
              icon: const Icon(Icons.add),
              onPressed: (){

              },
             ),
          ],
      )

      
      ],
    );
   
  }

}



