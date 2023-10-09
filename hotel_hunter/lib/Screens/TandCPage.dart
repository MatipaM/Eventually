import 'package:flutter/material.dart';

class TandCPage extends StatefulWidget {
  const TandCPage({super.key});



  @override
  State<TandCPage> createState() => _TandCPageState();
}


class _TandCPageState extends State<TandCPage> {



  @override
  void initState()
  {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return const Padding(
      padding: EdgeInsets.fromLTRB(25, 15,25,0),
      child: Column(
          
        )
    );
  }
}

class TandCPageListTile extends StatelessWidget{

final String text;
final IconData iconData;

const TandCPageListTile({Key? key, required this.text, required this.iconData}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ListTile( //return custom component, stating consequences of each profile then are you sure? with ok button to move on
     
      );
  }

}



