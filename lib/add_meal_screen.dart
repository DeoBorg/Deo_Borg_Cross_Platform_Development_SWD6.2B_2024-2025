import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddMealScreen extends StatefulWidget {
  const AddMealScreen({super.key});

  @override
  _AddMealScreenState createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  final TextEditingController mealNameController = TextEditingController();
  final TextEditingController caloriesController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  File? _mealImage;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _mealImage = File(pickedFile.path); // Store the taken photo
      });
    }
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
            const SizedBox(height: 15),

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
            const SizedBox(height: 15),

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
            const SizedBox(height: 20),

            if (_mealImage != null)
            Center(
                child: Column(
                  children: [
                    Image.file(_mealImage!, height: 150), // Show image
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: _pickImage,// Retake the photo
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                          child: const Text("Retake", style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            // Add Photo Button
            Center(
              child: ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.camera_alt),
                label: const Text("Add Photo of Meal"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD7B899), 
                
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 30),

            //Add Meal & Cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD7B899),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child: const Text("Add Meal", style: TextStyle(color: Colors.black)),
                ),

                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Go To Home screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child: const Text("Cancel", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
