import 'package:flutter/material.dart';
import '../models/meals.dart';
import 'package:meals_app/widgets/meal_item.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
// final String categoryId;
// final  String categoryTitle;
//
// CategoryMealsScreen(this.categoryId,this.categoryTitle);

List<Meal> availableMeals;
CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {

  String categoryTitle;
  List<Meal> displayMeals;

  var _loadedInitData = false;

  @override
  void didChangeDependencies() {
    if(!_loadedInitData)
      {
        final routArgs = ModalRoute.of(context).settings.arguments as Map<String, String>;
        categoryTitle = routArgs['title'];
        final categoryId = routArgs['id'];
        displayMeals = widget.availableMeals.where((meal){
          return meal.categories.contains(categoryId);
        }).toList();
        _loadedInitData = true;
      }

    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
     body : ListView.builder(itemBuilder: (ctx, index){
         return MealItem(id: displayMeals[index].id,title: displayMeals[index].title,
             imageUrl: displayMeals[index].imageUrl,
             duration: displayMeals[index].duration,
             complexity: displayMeals[index].complexity,
             affordability: displayMeals[index].affordability,

         );
    }, itemCount: displayMeals.length ,),
    );
  }
}
