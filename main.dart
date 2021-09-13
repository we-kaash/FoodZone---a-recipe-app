import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'screens/category_meals_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/meal_details_screen.dart';
import './screens/tabs_screen.dart';
import './screens/filters_screen.dart';
import './models/meals.dart';
void main() => runApp(MyApp());


class MyApp extends StatefulWidget {


  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Map<String,bool> _filters={
    'gluten' : false,
    'lactose' : false,
    'vegan' : false,
    'vegetarian' : false
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoritedMeals = [];

  void _setFilters(Map<String,bool> filterData){
  setState(() {
    _filters = filterData;

    _availableMeals = DUMMY_MEALS.where((meal){
     if(_filters['gluten'] && !meal.isGlutenFree )
       {
         return false;
       }
     if(_filters['lactose'] && !meal.isLactoseFree )
     {
       return false;
     }
     if(_filters['vegan'] && !meal.isVegan )
     {
       return false;
     }
     if(_filters['vegetarian'] && !meal.isVegetarian )
     {
       return false;
     }
     return true;
    }).toList();

  });
  }

  void _toggleFavorite(String mealId){
    final existingIndex =
          _favoritedMeals.indexWhere((meal) => meal.id == mealId);
    if(existingIndex >= 0){
      setState(() {
        _favoritedMeals.removeAt(existingIndex);
      });
    }else
      {
        setState(() {
          _favoritedMeals.add(DUMMY_MEALS.firstWhere((meal)=> meal.id == mealId),);
        });
      }
  }

  bool _isMealFavorite(String id){
    return _favoritedMeals.any((meal) => meal.id == id );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delimeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
          body1: TextStyle(color: Color.fromRGBO(20, 24, 5, 1)
           ),
          body2: TextStyle(color: Color.fromRGBO(20, 24, 5, 1),
           ),
          title: TextStyle(fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'RobotoCondensed',))
          ),
      //home: CategoriesScreen(),
      routes: {
        '/' : (cxt) => TabsScreen(_favoritedMeals),
        '/category_meals' : (cxt) => CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName : (ctx) => MealDetailScreen(_toggleFavorite,_isMealFavorite),
        FiltersScreen.routeName : (ctx) => FiltersScreen(_filters,_setFilters),
      },
      // onGenerateRoute: (settings){
      //   print(settings.arguments);
      // },
      onUnknownRoute: (settings){
        return MaterialPageRoute(builder: (ctx)=> CategoriesScreen(),);
      },

    );
  }
}


