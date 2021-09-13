import 'package:flutter/material.dart';
import '../screens/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
   final String Id;
   final String title;
   final color;
   CategoryItem(this.Id, this.title,this.color);

  void SelectCategory(BuildContext ctx)
  { Navigator.of(ctx).pushNamed(
      '/category_meals', arguments: {
        'id': Id,
        'title' : title,
  });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> (SelectCategory(context)),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Text(title,style: Theme.of(context).textTheme.title ,),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [color.withOpacity(0.7),
              color,],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
