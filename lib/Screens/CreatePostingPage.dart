
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hotel_hunter/Models/AppConstants.dart';
import 'package:hotel_hunter/Models/postingObject.dart';
import 'package:hotel_hunter/Screens/hostHomePage.dart';
import 'package:hotel_hunter/Views/textWidgets.dart';
import 'package:image_picker/image_picker.dart';

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

  final _formKey = GlobalKey<FormState>();
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

  void _selectImage(int index) async{
        var imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(imageFile!=null){
      Uint8List newImage = await imageFile.readAsBytes();
      if(index<0)
      { 
        _images!.add(MemoryImage(newImage));
      }else{
        _images![index] = newImage as MemoryImage;
      }
      setState(() {
        
      });
      print("select completed");
    }
  }

  void _savePosting(){
    if(!_formKey.currentState!.validate()){return;}
    //if(_eventType==null){return;}
    // if(_images!.isEmpty){return;}

    Posting posting = Posting();
    posting.name = _nameController!.text;
    posting.price = double.parse(_priceController!.text);
    posting.description = _descriptionController!.text;
    posting.address = _addressController!.text;
    posting.city = _cityController!.text;
    posting.country = _countryController!.text;
    posting.amenities = _amenitiesController!.text.split(",");
    posting.type = _eventType;
    posting.workers = _workers;
    posting.facilities = _facilities!;
    posting.displayImages = _images;
    posting.setImageNames();
    posting.host = AppConstants.currentUser!.createContactFromUser();
    if(widget.posting==null){
      posting.rating = 2.5;
      posting.bookings = [];
      posting.reviews = [];
      posting.addPostingInfoToFirestore().whenComplete((){
        posting.addImagesToFirestore().whenComplete(() {
           Navigator.push(context, 
        MaterialPageRoute(builder: (context)=> const HostHomePage(index: 1)));
        });
       
      });
    }else{
      posting.rating = widget.posting!.rating;
      posting.bookings = widget.posting!.bookings;
      posting.reviews = widget.posting!.reviews;
      posting.id = widget.posting!.id;
      for(int i=0; i<AppConstants.currentUser!.myPostings!.length; i++){
        if(AppConstants.currentUser!.myPostings![i].id==posting.id){
          AppConstants.currentUser!.myPostings![i] = posting;
          break;
        }
      }

         posting.updatePostingInfoInFirestore().whenComplete((){
         posting.addImagesToFirestore().whenComplete(() {
           Navigator.push(context, 
        MaterialPageRoute(builder: (context)=> const HostHomePage(index: 1)));
        });
      });
    }
  }

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
        'security': 0,
        'manager': 0,
        'organiser': 0,
        'cooks': 0,
        'entertainer': 0,
        'volunteers': 0,
      };

      _facilities = {
        'coffee': 0,
        'drinks': 0,
        'meals': 0,
        'paper': 0,
        'pots': 0,
        'wooden spoons': 0,
      };

      _images=[];

    }else{
_nameController = TextEditingController();
      _nameController = TextEditingController(text: widget.posting!.name);
      _descriptionController = TextEditingController(text: widget.posting!.description);
      _priceController = TextEditingController(text: widget.posting!.price.toString());
      _addressController = TextEditingController(text: widget.posting!.address);
      _cityController = TextEditingController(text: widget.posting!.city);
      _countryController = TextEditingController(text: widget.posting!.country);
      _amenitiesController = TextEditingController(text: widget.posting!.getAmenitiesString());

      _workers = widget.posting!.workers!;

      _facilities = widget.posting!.facilities;

      _images=widget.posting!.displayImages;
      _eventType = widget.posting!.type;
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
            onPressed: (){
             
            },
            ),
             IconButton(
            icon: const Icon(Icons.save),
            onPressed: _savePosting,
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
              
                Form(
                  key: _formKey,
                  child: Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 35.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Event Name'),
                          style: const TextStyle(
                  fontSize: 25,
                  
                ),
                 controller: _nameController,
                 validator: (text){
                  if(text!.isEmpty)
                  {
                    return "Please enter a name";
                  }else{
                    return null;
                  }
                 },
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
                        _eventType = value;
                        setState(() {
                          
                        });
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
                                        validator: (text){
                  if(text!.isEmpty)
                  {
                    return "Please enter a price";
                  }else{
                    return null;
                  }
                 },
                                        
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
                 validator: (text){
                  if(text!.isEmpty)
                  {
                    return "Please enter a description";
                  }else{
                    return null;
                  }
                 },
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
                validator: (text){
                  if(text!.isEmpty)
                  {
                    return "Please enter an address";
                  }else{
                    return null;
                  }
                 },
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
                validator: (text){
                  if(text!.isEmpty)
                  {
                    return "Please enter a city";
                  }else{
                    return null;
                  }
                 },
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
                validator: (text){
                  if(text!.isEmpty)
                  {
                    return "Please enter a country";
                  }else{
                    return null;
                  }
                 },
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
                          type: 'entertainer', startValue: _workers!['entertainer'],
                          decreaseValue: (){
                            _workers!['entertainer'] = _workers!['entertainer']!-1;
                            if(_workers!['entertainer']!<=0)
                            {

                              _workers!['entertainer'] = 0;
                            }
                            print(_workers!['entertainer']);
                          },
                            increaseValue: (){
                            _workers!['entertainer'] = _workers!['entertainer']!+1;
                            print(_workers!['entertainer']);
                          },
                        ),
                        FacilitiesWidget(
                          type: 'cooks', startValue: _workers!['cooks'],
                            decreaseValue: (){
                            _workers!['cooks'] = _workers!['cooks']!-1;
                            if(_workers!['cooks']!<=0)
                            {

                              _workers!['cooks'] = 0;
                            }
                            print(_workers!['cooks']);
                          },
                            increaseValue: (){
                            _workers!['cooks'] = _workers!['cooks']!+1;
                            print(_workers!['cooks']);
                          },
                        ),
                        FacilitiesWidget(
                          type: 'security', startValue: _workers!['security'],
                                   decreaseValue: (){
                            _workers!['security'] = _workers!['security']!-1;
                            if(_workers!['security']!<=0)
                            {

                              _workers!['security'] = 0;
                            }
                            print(_workers!['security']);
                          },
                            increaseValue: (){
                            _workers!['security'] = _workers!['security']!+1;
                            print(_workers!['security']);
                          },
                        ),
                        FacilitiesWidget(
                          type: 'organiser', startValue: _workers!['organiser'],
                                           decreaseValue: (){
                            _workers!['organiser'] = _workers!['organiser']!-1;
                            if(_workers!['organiser']!<=0)
                            {

                              _workers!['organiser'] = 0;
                            }
                            print(_workers!['organiser']);
                          },
                            increaseValue: (){
                            _workers!['organiser'] = _workers!['organiser']!+1;
                            print(_workers!['organiser']);
                          },
                        ),
                        FacilitiesWidget(
                          type: 'manager', startValue: _workers!['manager'],
                                                     decreaseValue: (){
                            _workers!['manager'] = _workers!['manager']!-1;
                            if(_workers!['manager']!<=0)
                            {

                              _workers!['manager'] = 0;
                            }
                            print(_workers!['manager']);
                          },
                            increaseValue: (){
                            _workers!['manager'] = _workers!['manager']!+1;
                            print(_workers!['manager']);
                          },
                        ),
                         FacilitiesWidget(
                          type: 'volunteers', startValue: _workers!['volunteers'],
                                                             decreaseValue: (){
                            _workers!['volunteers'] = _workers!['volunteers']!-1;
                            if(_workers!['volunteers']!<=0)
                            {

                              _workers!['volunteers'] = 0;
                            }
                            print(_workers!['volunteers']);
                          },
                            increaseValue: (){
                            _workers!['volunteers'] = _workers!['volunteers']!+1;
                            print(_workers!['volunteers']);
                          },
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
                          type: 'pots', startValue: _facilities!['pots'],
                          decreaseValue: (){
                            _facilities!['pots'] = _facilities!['pots']!-1;
                            if(_facilities!['pots']!<=0)
                            {

                              _facilities!['pots'] = 0;
                            }
                            print(_facilities!['pots']);
                            
                          },
                            increaseValue: (){
                            _facilities!['pots'] = _facilities!['pots']!+1;
                              print(_facilities!['pots']);
                          },
                        ),
                        FacilitiesWidget(
                          type: 'wooden spoons', startValue:_facilities!['wooden spoons'],
                          decreaseValue: (){
                            _facilities!['wooden spoons'] = _facilities!['wooden spoons']!-1;
                            if(_facilities!['wooden spoons']!<=0)
                            {

                              _facilities!['wooden spoons'] = 0;
                            }
                              print(_facilities!['pots']);
                          },
                            increaseValue: (){
                            _facilities!['wooden spoons'] = _facilities!['wooden spoons']!+1;
                              print(_facilities!['wooden spoons']);
                          },
                        ),
                        FacilitiesWidget(
                          type: 'coffee', startValue: _facilities!['coffee'],
                          decreaseValue: (){
                            _facilities!['coffee'] = _facilities!['coffee']!-1;
                            if(_facilities!['coffee']!<=0)
                            {

                              _facilities!['coffee'] = 0;
                            }
                            print(_facilities!['coffee']);
                          },
                            increaseValue: (){
                            _facilities!['coffee'] = _facilities!['coffee']!+1;
                            print(_facilities!['coffee']);
                          },
                        ),   
                   
                        FacilitiesWidget(
                          type: 'drinks', startValue: _facilities!['drinks'],
                          decreaseValue: (){
                            _facilities!['drinks'] = _facilities!['drinks']!-1;
                            if(_facilities!['drinks']!<=0)
                            {

                              _facilities!['drinks'] = 0;
                            }
                             print(_facilities!['drinks']);
                          },
                            increaseValue: (){
                            _facilities!['drinks'] = _facilities!['drinks']!+1;
                             print(_facilities!['drinks']);
                          },
                        ),
                             FacilitiesWidget(
                          type: 'meals', startValue:_facilities!['meals'],
                          decreaseValue: (){
                            _facilities!['meals'] = _facilities!['meals']!-1;
                            if(_facilities!['meals']!<=0)
                            {

                              _facilities!['meals'] = 0;
                            }
                             print(_facilities!['meals']);
                          },
                            increaseValue: (){
                            _facilities!['meals'] = _facilities!['meals']!+1;
                             print(_facilities!['meals']);
                          },
                        ),
                        FacilitiesWidget(
                          type: 'paper', startValue: _facilities!['paper'],
                          decreaseValue: (){
                            _facilities!['paper'] = _facilities!['paper']!-1;
                            print(_facilities!['paper']);
                            if(_facilities!['paper']!<=0)
                            {

                              _facilities!['paper'] = 0;
                            }
                          },
                            increaseValue: (){
                            _facilities!['paper'] = _facilities!['paper']!+1;
                            print(_facilities!['paper']);
                          },
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
                      itemCount: _images!.length+1,
                      itemBuilder: (context, index){
                        if(index==_images!.length)
                        {
                          return 
                          // Container(
                          //   color: Colors.grey,
                          //   child: 
                            IconButton(
                               icon: const Icon(Icons.add),
                              onPressed: (){
                                 _selectImage(-1);
                              }, 
                              
                             
                              //),
                          );
                        }
                          
                          return MaterialButton(
                            
                            onPressed: (){
                               _selectImage(-1);
                            },
                 
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

  final Function? decreaseValue;
  final Function? increaseValue;

  const FacilitiesWidget({Key? key, this.startValue, this.increaseValue, this.decreaseValue, this.type}):super(key: key);

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
                widget.decreaseValue!();
                _value = _value!-1;
                if(_value!<0)
                {
                  _value=0;
                }
                setState(() {
                  
                });
              },
            ), Text(_value.toString(),
            style: const TextStyle(
            fontSize: 18,
          ),),
             IconButton(
              icon: const Icon(Icons.add),
              onPressed: (){
                widget.increaseValue!();
                _value = _value!+1;
                setState(() {
                  
                });
              },
             ),
          ],
      )

      
      ],
    );
   
  }

}



