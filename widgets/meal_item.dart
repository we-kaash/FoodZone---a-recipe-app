import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/models/meals.dart';
import '../screens/meal_details_screen.dart';
import 'package:meals_app/screens/meal_details_screen.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;

  MealItem({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
    @required this.duration,
    @required this.complexity,
    @required this.affordability,


  });
  String get complexityText{
    switch (complexity){
      case Complexity.Simple:
        return 'Simple';
        break;
      case Complexity.Hard:
        return 'Hard';
        break;
      case Complexity.Challenging:
        return 'Challenging';
        break;
      default:
        return 'Unknown';
    }
  }
  String get affordabilityText{
    switch (affordability){
      case Affordability.Affordable:
        return 'Affordable';
        break;
      case Affordability.Pricey:
        return 'Pricey';
        break;
      case Affordability.Luxurious:
        return 'Expensive';
        break;
      default :
        return 'Unknown';
    }
  }
void selectMeal(BuildContext context) {
    Navigator.of(context).pushNamed(MealDetailScreen.routeName, arguments:id, ).
  then((result){
    if(result!=null) {
     // removeItem(result);
    }
    });
}

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap:() => selectMeal(context) ,
    child: Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)
    ),
      elevation: 4,
      margin: EdgeInsets.all(10),
      child: Column(children: <Widget>[
        Stack(children: <Widget>[
          ClipRRect(borderRadius: BorderRadius.only(topLeft: Radius.circular(15),
              topRight: Radius.circular(15)),
            child: Image.network(imageUrl,height: 250,width: double.infinity,fit: BoxFit.cover ,),
          ),
          Positioned(
            bottom: 20,
            right: 10,
            child: Container(
              width: 380,
              color: Colors.black54,
              padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
              child: Text(title,style: TextStyle(fontSize: 26,color: Colors.white),
                softWrap: true,
                overflow: TextOverflow.fade,
              ),
            ),
          )
        ],
        ),
        Padding(
          padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.schedule),
                  SizedBox(width: 3,),
                    Text('$duration min')
                  ],),
                Row(
                  children: <Widget>[
                    Icon(Icons.work),
                    SizedBox(width: 3,),
                    Text(complexityText)
                  ],),
                Row(
                  children: <Widget>[
                    Icon(Icons.attach_money),
                    SizedBox(width: 3,),
                    Text(affordabilityText)
                  ],)
              ],
            ),
        )
      ],
      ),
    ),);
  }
}
