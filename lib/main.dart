import 'package:flutter/material.dart';

void main() {
  runApp(RecipeApp());
}

class RecipeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RecipeListPage(),
    );
  }
}

class RecipeListPage extends StatefulWidget {
  @override
  _RecipeListPageState createState() => _RecipeListPageState();
}

class _RecipeListPageState extends State<RecipeListPage> {
  List<Map<String, String>> recipes = [
    {
      'name': 'Spaghetti',
      'description': 'A delicious spaghetti recipe.',
      'ingredients': 'Spaghetti, Tomato Sauce, Garlic',
      'steps': '1. Boil water\n2. Cook spaghetti\n3. Add sauce'
    },
    {
      'name': 'Chicken Curry',
      'description': 'A spicy chicken curry.',
      'ingredients': 'Chicken, Curry Powder, Coconut Milk',
      'steps': '1. Cook chicken\n2. Add spices\n3. Simmer with coconut milk'
    },
    {
      'name': 'Grilled Cheese',
      'description': 'A classic grilled cheese sandwich.',
      'ingredients': 'Bread, Cheese, Butter',
      'steps': '1. Butter bread\n2. Add cheese\n3. Grill until golden'
    },
  ];

  void _addNewRecipe(Map<String, String> newRecipe) {
    setState(() {
      recipes.add(newRecipe);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Recipes'),
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(screenSize.width * 0.02),
            child: Card(
              child: ListTile(
                title: Text(
                  recipes[index]['name']!,
                  style: TextStyle(fontSize: screenSize.width * 0.05),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeDescriptionPage(recipe: recipes[index]),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              final newRecipe = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddRecipePage(),
                ),
              );

              if (newRecipe != null) {
                _addNewRecipe(newRecipe);
              }
            },
          ),
    );
  }
}

class RecipeDescriptionPage extends StatelessWidget {
  final Map<String, String> recipe;

  RecipeDescriptionPage({required this.recipe});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(recipe['name']!),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenSize.width * 0.05),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                recipe['name']!,
                style: TextStyle(
                  fontSize: screenSize.width * 0.08,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenSize.height * 0.02),
              Container(
                padding: EdgeInsets.all(screenSize.width * 0.05),
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  recipe['description']!,
                  style: TextStyle(
                    fontSize: screenSize.width * 0.05,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: screenSize.height * 0.02),
              Container(
                padding: EdgeInsets.all(screenSize.width * 0.05),
                decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ingredients:',
                      style: TextStyle(
                        fontSize: screenSize.width * 0.06,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.01),
                    Text(
                      recipe['ingredients']!,
                      style: TextStyle(
                        fontSize: screenSize.width * 0.05,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenSize.height * 0.02),
              Container(
                padding: EdgeInsets.all(screenSize.width * 0.05),
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Steps:',
                      style: TextStyle(
                        fontSize: screenSize.width * 0.06,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.01),
                    Text(
                      recipe['steps']!,
                      style: TextStyle(
                        fontSize: screenSize.width * 0.05,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddRecipePage extends StatefulWidget {
  @override
  _AddRecipePageState createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _description = '';
  String _ingredients = '';
  String _steps = '';

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Recipe'),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenSize.width * 0.05),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Recipe Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the recipe name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _name = value!;
                  },
                ),
                SizedBox(height: screenSize.height * 0.02),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the description';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _description = value!;
                  },
                ),
                SizedBox(height: screenSize.height * 0.02),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Ingredients'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the ingredients';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _ingredients = value!;
                  },
                ),
                SizedBox(height: screenSize.height * 0.02),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Steps'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the steps';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _steps = value!;
                  },
                ),
                SizedBox(height: screenSize.height * 0.02),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        final newRecipe = {
                          'name': _name,
                          'description': _description,
                          'ingredients': _ingredients,
                          'steps': _steps,
                        };
                        Navigator.pop(context, newRecipe);
                      }
                    },
                    child: Text('Add Recipe'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
