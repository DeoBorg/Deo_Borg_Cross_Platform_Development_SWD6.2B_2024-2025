import 'package:flutter/material.dart';

class AddMealScreen extends StatefulWidget {
  @override
  _AddMealScreenState createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  final TextEditingController mealNameController = TextEditingController();
  final TextEditingController caloriesController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8D6E63), 
      appBar: AppBar(
        title: Text("Calorie Snap", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFF4B2E2E), 
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Meal name input Field
            TextField(
              controller: mealNameController,
              decoration: InputDecoration(
                labelText: "Meal Name",
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 15),

            // Calories input field
            TextField(
              controller: caloriesController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Calories",
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 15),

            // Weight input Field
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Weight (grams)",
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 20),

            // Add Photo Button
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // TODO: Implement Camera Functionality
                },
                icon: Icon(Icons.camera_alt),
                label: Text("Add Photo of Meal"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFD7B899), 
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
            ),
            SizedBox(height: 30),

            //Add Meal & Cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFD7B899),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child: Text("Add Meal", style: TextStyle(color: Colors.black)),
                ),

                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Go To Home screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child: Text("Cancel", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
