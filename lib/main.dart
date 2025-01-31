import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const RecipeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/splash_logo.jpg', width: 150),
            const SizedBox(height: 20),
            const Text(
              'Welcome to Recipe App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key});

  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  String _selectedRecipe = 'Sushi';
  int _selectedPacks = 1;

  final Map<String, Map<String, dynamic>> recipes = {
    'Sushi': {
      'cuisine': 'Japanese',
      'image': 'assets/Sushi.jpg',
      'description': 'A traditional Japanese dish with vinegared rice and seafood.',
      'ingredients': {'Rice': 200, 'Seaweed': 2, 'Fish': 150},
      'steps': [
        'Rinse the rice and cook it with vinegar.',
        'Lay seaweed on a bamboo mat.',
        'Spread rice evenly over the seaweed.',
        'Place fish on top and roll tightly.',
        'Cut into bite-sized pieces and serve.'
      ],
      'time': '30 mins',
      'serving': 2,
    },
    'Butter Chicken': {
      'cuisine': 'Indian',
      'image': 'assets/butter_chicken.jpeg',
      'description': 'Rich and creamy Indian dish with spiced tomato sauce.',
      'ingredients': {'Chicken': 500, 'Butter': 50, 'Tomato Puree': 200},
      'steps': [
        'Marinate chicken in yogurt and spices for 2 hours.',
        'Cook in butter until golden brown.',
        'Add tomato puree and simmer for 20 minutes.',
        'Finish with cream and serve with rice or naan.'
      ],
      'time': '40 mins',
      'serving': 4,
    },
    'Fried Rice': {
      'cuisine': 'Chinese',
      'image': 'assets/fried_rice.jpeg',
      'description': 'Chinese-style stir-fried rice with vegetables and soy sauce.',
      'ingredients': {'Rice': 300, 'Vegetables': 200, 'Soy Sauce': 30},
      'steps': [
        'Stir-fry vegetables in oil.',
        'Add cooked rice and soy sauce.',
        'Mix well and serve hot.'
      ],
      'time': '25 mins',
      'serving': 3,
    },
    'Tacos': {
      'cuisine': 'Mexican',
      'image': 'assets/tacos.jpg',
      'description': 'Mexican-style tacos with fresh toppings.',
      'ingredients': {'Tortillas': 2, 'Beef': 1, 'Cheese': 1, 'Lettuce': 1},
      'steps': [
        'Cook beef with spices.',
        'Fill tortillas with beef and toppings.',
        'Serve with salsa and guacamole.'
      ],
      'time': '20 mins',
      'servings': 2,
    },
    'Spaghetti Carbonara': {
      'cuisine': 'Italian',
      'image': 'assets/carbonara.jpeg',
      'description': 'A classic Italian pasta dish with creamy sauce.',
      'ingredients': {'Pasta': 1, 'Eggs': 2, 'Bacon': 1, 'Parmesan': 1},
      'steps': [
        'Boil pasta until al dente.',
        'Cook bacon until crispy.',
        'Mix eggs and cheese, then add to pasta.',
        'Toss with bacon and serve.'
      ],
      'time': '25 mins',
      'servings': 2,
    },
    'Pad Thai': {
      'cuisine': 'Thai',
      'image': 'assets/pad_thai.jpg',
      'description': 'A flavorful Thai noodle dish.',
      'ingredients': {'Noodles': 1, 'Shrimp': 1, 'Egg': 1, 'Peanuts': 1},
      'steps': [
        'Stir-fry shrimp and egg in a pan.',
        'Add noodles and sauce, mix well.',
        'Top with crushed peanuts and serve.'
      ],
      'time': '30 mins',
      'servings': 2,
    }
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Recipe App',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold, // Make text bold
          ),
        ),
        backgroundColor: Colors.orangeAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 5,
              children: recipes.keys.map((String key) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio<String>(
                      value: key,
                      groupValue: _selectedRecipe,
                      activeColor: Colors.orange,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedRecipe = value!;
                          _selectedPacks = 1;
                        });
                      },
                    ),
                    Text(key, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            Image.asset(
              recipes[_selectedRecipe]!['image'],
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.orange[100],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.restaurant, color: Colors.orange),
                      const SizedBox(width: 5),
                      Text('Cuisine: ${recipes[_selectedRecipe]!['cuisine']}',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.timer, color: Colors.orange),
                      const SizedBox(width: 5),
                      Text('Time: ${recipes[_selectedRecipe]!['time']}',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    recipes[_selectedRecipe]!['description'],
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            DropdownButton<int>(
              value: _selectedPacks,
              items: [1, 2, 3, 4, 5].map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text('$value Packs'),
                );
              }).toList(),
              onChanged: (int? newValue) {
                setState(() {
                  _selectedPacks = newValue!;
                });
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.food_bank, color: Colors.orange),
                        const SizedBox(width: 5),
                        const Text('Ingredients:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    ...recipes[_selectedRecipe]!['ingredients'].entries.map((entry) {
                      return Text('${entry.key}: ${entry.value * _selectedPacks}g',
                          textAlign: TextAlign.right);
                    }).toList(),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.list, color: Colors.orange),
                        const SizedBox(width: 5),
                        const Text('Steps:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    ...recipes[_selectedRecipe]!['steps'].map((step) => Text('- $step',
                        textAlign: TextAlign.right)).toList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
