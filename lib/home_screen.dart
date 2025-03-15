import 'package:deo_borg_swd62b/add_meal_screen.dart';
import 'package:flutter/material.dart';
import 'meal_selection_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int totalCalories = 0; // Tracks total calories eaten

  // Function to update calories when a meal is selected
  void updateCalories(int mealCalories) {
    setState(() {
      totalCalories += mealCalories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8D6E63), 
      appBar: AppBar(
        title: const Text("Calorie Snap", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF4B2E2E), 
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(0xFFD7B899),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Text("Today's Calories",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text(
                    "$totalCalories / 1700", // Dynamically updates
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Latest eaten meal placeholder
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text("Latest Eaten Meal",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 20),

            const Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Add Existing Meal Button
                ElevatedButton(
                  onPressed: () async {
                    final selectedMeal = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MealSelectionScreen()),
                    );

                    if (selectedMeal != null) {
                      updateCalories(selectedMeal["calories"]); // Update calories
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD7B899), // Latte Beige
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child: const Text("Add Existing Meal", style: TextStyle(color: Colors.black)),
                ),

                // Camera Button
                FloatingActionButton(
                  onPressed: () {},
                  backgroundColor: const Color(0xFF4B2E2E), // Espresso Brown
                  child: const Icon(Icons.camera_alt, color: Colors.white),
                ),

                // Add New Meal Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddMealScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD7B899),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child: const Text("Add New Meal", style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
