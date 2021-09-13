import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';
class FiltersScreen extends StatefulWidget {
static const routeName = '/filters';

final Function saveFilters;
Map<String,bool> currentFilters;
FiltersScreen(this.currentFilters,this.saveFilters);



  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegan = false;
  var _vegetarian = false;
  var _lactoseFree = false;

 @override
 initState(){

   _glutenFree = widget.currentFilters['gluten'];
   _lactoseFree = widget.currentFilters['lactose'];
   _vegan = widget.currentFilters['vegan'];
   _vegetarian = widget.currentFilters['vegetarian'];

   super.initState();
 }

  Widget _buildSwitchListTile(String title,String description, bool currentValue, Function updateValue)
  {
  return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updateValue,
  );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save), onPressed: (){

            final selectedFilters={
              'gluten' : _glutenFree,
              'lactose' : _lactoseFree,
              'vegan' : _vegan,
              'vegetarian' : _vegetarian
            };

            widget.saveFilters(selectedFilters);
          })
        ],
      ),
      drawer: MainDrawer(),
      body: Column(children : <Widget>[
        Container(padding: EdgeInsets.all(20),
        child: Text('Adjust your meal selection',
          style: Theme.of(context).textTheme.title,
        ),
        ),
        Expanded(
          child: ListView(
            children: <Widget>[
           _buildSwitchListTile('Gluten-free',
               'only include gluten-free meals',
               _glutenFree,
                   (newValue){
             setState(() {
               _glutenFree = newValue;
             });
           }),
              Divider(),
              _buildSwitchListTile('Lactose-free',
                  'only include lactose-free meals',
                  _lactoseFree,
                      (newValue){
                    setState(() {
                      _lactoseFree = newValue;
                    });
                  }),Divider(
                height: 10,
              ),
              _buildSwitchListTile('Vegetarian',
                  'only include vegetarian meals',
                  _vegetarian,
                      (newValue){
                    setState(() {
                      _vegetarian = newValue;
                    });
                  }),Divider(),
              _buildSwitchListTile('Vegan',
                  'only include vegan meals',
                  _vegan,
                      (newValue){
                    setState(() {
                      _vegan = newValue;
                    });
                  }),
            ],
          ),
        ),
      ],
      ),
    );
  }
}
