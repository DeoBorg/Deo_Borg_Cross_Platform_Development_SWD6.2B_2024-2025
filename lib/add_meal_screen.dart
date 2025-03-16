import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class AddMealScreen extends StatefulWidget {
  const AddMealScreen({super.key});

  @override
  _AddMealScreenState createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  final TextEditingController mealNameController = TextEditingController();
  final TextEditingController caloriesController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  final DatabaseReference mealsRef = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL:
        "https://calorie-snap-4942e-default-rtdb.europe-west1.firebasedatabase.app",
  ).ref("meals");

  File? _mealImage;
  String? _imageUUID;
  bool _isSubmitting = false;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initNotifications();
  }

  /// Initialize Local Notifications
  Future<void> _initNotifications() async {
  const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings settings =
      InitializationSettings(android: androidSettings);

  await flutterLocalNotificationsPlugin.initialize(settings);

  if(await Permission.notification.isDenied){
    await Permission.notification.request();
  }
}


  // Show a Local Notification
  Future<void> _showNotification() async {
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'meal_added_channel', // ID
    'Meal Notifications', // Name
    description: 'Notifications for meal addition', // Description
    importance: Importance.high,
  );

  // **Ensure the channel is created**
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'meal_added_channel',
    'Meal Notifications',
    importance: Importance.high,
    priority: Priority.high,
  );

  const NotificationDetails details = NotificationDetails(android: androidDetails);

  await flutterLocalNotificationsPlugin.show(
    0, // Notification ID
    'Meal Added', // Title
    'Your meal was added successfully!', // Message
    details,
  );
}


  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final appDir = await getApplicationDocumentsDirectory();
      String fileName = const Uuid().v4();
      final localImage = File('${appDir.path}/$fileName.jpg');

      await File(pickedFile.path).copy(localImage.path);

      setState(() {
        _mealImage = localImage;
        _imageUUID = fileName;
      });
    }
  }

  bool _isFormValid() {
    return mealNameController.text.isNotEmpty &&
        caloriesController.text.isNotEmpty &&
        weightController.text.isNotEmpty &&
        _mealImage != null;
  }

  Future<void> _submitMeal() async {
    if (!_isFormValid()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      String mealId = mealsRef.push().key!;
      await mealsRef.child(mealId).set({
        "name": mealNameController.text.trim(),
        "calories": int.parse(caloriesController.text.trim()),
        "weight": int.parse(weightController.text.trim()),
        "imageUUID": _imageUUID,
      });

      // Show local notification
      _showNotification();

      setState(() {
        _isSubmitting = false;
      });

      Navigator.pop(context);
    } catch (e) {
      setState(() {
        _isSubmitting = false;
      });
    }
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: mealNameController,
              decoration: InputDecoration(
                labelText: "Meal Name",
                fillColor: Colors.white,
                filled: true,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: caloriesController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Calories",
                fillColor: Colors.white,
                filled: true,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Weight (grams)",
                fillColor: Colors.white,
                filled: true,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 20),
            if (_mealImage != null)
              Center(
                child: Column(
                  children: [
                    Image.file(_mealImage!, height: 150),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: _pickImage,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent),
                          child: const Text("Retake",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            Center(
              child: ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.camera_alt),
                label: const Text("Add Photo of Meal"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD7B899),
                  foregroundColor: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitMeal,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD7B899),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                  child: _isSubmitting
                      ? const CircularProgressIndicator(color: Colors.black)
                      : const Text("Add Meal",
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

