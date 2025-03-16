import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class MealSelectionScreen extends StatefulWidget {
  const MealSelectionScreen({super.key});

  @override
  _MealSelectionScreenState createState() => _MealSelectionScreenState();
}

class _MealSelectionScreenState extends State<MealSelectionScreen> {
  final DatabaseReference mealsRef = FirebaseDatabase.instanceFor(
          app: Firebase.app(),
          databaseURL:
              "https://calorie-snap-4942e-default-rtdb.europe-west1.firebasedatabase.app")
      .ref("meals");

  List<Map<String, dynamic>> meals = [];
  int? selectedMealIndex;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMeals();
  }

  void _loadMeals() {
    mealsRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;

      if (data != null) {
        List<Map<String, dynamic>> loadedMeals = [];
        data.forEach((key, value) {
          loadedMeals.add({
            "id": key,
            "name": value["name"] ?? "Unknown",
            "calories": value["calories"] ?? 0,
            "weight": value["weight"] ?? 0,
            "imageUUID": value["imageUUID"] ?? "",
          });
        });

        setState(() {
          meals = loadedMeals;
          isLoading = false;
        });
      } else {
        setState(() {
          meals = [];
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8D6E63),
      appBar: AppBar(
        title: const Text("Calorie Snap",
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF4B2E2E),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator()) // Loading state
            : meals.isEmpty
                ? const Center(child: Text("No meals found"))
                : Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                          itemCount: meals.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.9,
                          ),
                          itemBuilder: (context, index) {
                            bool isSelected = selectedMealIndex == index;

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedMealIndex = index;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFFC69C6D)
                                      : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(12),
                                  border: isSelected
                                      ? Border.all(
                                          color: Colors.black, width: 2)
                                      : null,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.fastfood,
                                        size: 50, color: Colors.brown),
                                    const SizedBox(height: 8),
                                    Text(
                                      meals[index]["name"],
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "${meals[index]["calories"]} cal | ${meals[index]["weight"]}g",
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: selectedMealIndex != null
                                ? () {
                                    Navigator.pop(
                                        context, meals[selectedMealIndex!]);
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFD7B899),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            child: const Text("Add Meal",
                                style: TextStyle(color: Colors.black)),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            child: const Text("Cancel",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ],
                  ),
      ),
    );
  }
}
