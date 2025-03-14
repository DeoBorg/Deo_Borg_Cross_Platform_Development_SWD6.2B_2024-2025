import 'package:flutter/material.dart';

class MealSelectionScreen extends StatelessWidget {
  final List<Map<String, String>> meals = [
    {"name": "Meal Name 1", "image": ""},
    {"name": "Meal Name 2", "image": ""},
    {"name": "Meal Name 3", "image": ""},
    {"name": "Meal Name 4", "image": ""},
    {"name": "Meal Name 5", "image": ""},
    {"name": "Meal Name 6", "image": ""},
  ];

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
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: meals.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // TODO: Handle meal selection
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300], // Placeholder image
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.fastfood, size: 50, color: Colors.brown),
                          SizedBox(height: 8),
                          Text(
                            meals[index]["name"]!,
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 10),

            // Bottom Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // TODO: Handle selection
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFD7B899),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child: Text("Add Meal", style: TextStyle(color: Colors.black)),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Go to home screen
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
