import 'package:flutter/material.dart';

class MealSelectionScreen extends StatefulWidget {
  @override
  _MealSelectionScreenState createState() => _MealSelectionScreenState();
}

class _MealSelectionScreenState extends State<MealSelectionScreen> {
  final List<Map<String, dynamic>> meals = [
    {"name": "Grilled Chicken", "calories": 350, "weight": 200, "image": ""},
    {"name": "Avocado Toast", "calories": 250, "weight": 150, "image": ""},
    {
      "name": "Spaghetti Bolognese",
      "calories": 600,
      "weight": 300,
      "image": ""
    },
    {"name": "Salmon with Rice", "calories": 450, "weight": 250, "image": ""},
    {"name": "Caesar Salad", "calories": 300, "weight": 180, "image": ""},
    {"name": "Protein Smoothie", "calories": 200, "weight": 250, "image": ""},
  ];

  int? selectedMealIndex; // Track selected meal index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8D6E63),
      appBar: AppBar(
        title:
            Text("Calorie Snap", style: TextStyle(fontWeight: FontWeight.bold)),
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
                  bool isSelected =
                      selectedMealIndex == index; //check if selected

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedMealIndex = index;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Color(0xFFC69C6D)
                            : Colors.grey[300], // Highlight selection
                        borderRadius: BorderRadius.circular(12),
                        border: isSelected
                            ? Border.all(
                                color: Colors.black,
                                width: 2) // Add border when selected
                            : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.fastfood,
                              size: 50, color: Colors.brown), // Temporary icon
                          SizedBox(height: 8),
                          Text(
                            meals[index]["name"], // Meal Name
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${meals[index]["calories"]} cal | ${meals[index]["weight"]}g",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
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
                  onPressed: selectedMealIndex != null
                      ? () {
                          // Return the selected meal data to the HomeScreen
                          Navigator.pop(context, meals[selectedMealIndex!]);
                        }
                      : null, // Disable button if no meal is selected
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFD7B899),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child:
                      Text("Add Meal", style: TextStyle(color: Colors.black)),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Go back to Home Screen
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
