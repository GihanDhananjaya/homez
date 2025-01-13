import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AddPropertyScreen extends StatefulWidget {
  @override
  _AddPropertyScreenState createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController bedsController = TextEditingController();
  final TextEditingController bathroomsController = TextEditingController();
  File? selectedImage;

  Future<void> pickImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null && result.files.single.path != null) {
        setState(() {
          selectedImage = File(result.files.single.path!);
        });
        print("Image selected: ${selectedImage!.path}");
      } else {
        print("No image selected.");
      }
    } catch (e) {
      print("Error selecting image: $e");
    }
  }

  Future<String> uploadImageToFirebase(File imageFile) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final storageRef = FirebaseStorage.instance.ref().child("property_images/$fileName");
      final snapshot = await storageRef.putFile(imageFile);
      String downloadUrl = await snapshot.ref.getDownloadURL();
      print("Image uploaded: $downloadUrl");
      return downloadUrl;
    } catch (e) {
      throw Exception("Error uploading image: $e");
    }
  }

  Future<void> addPropertyToFirestore({
    required String title,
    required String? imageUrl,
    required String location,
    required double price,
    required int numberOfBeds,
    required int numberOfBathrooms,
  }) async {
    try {
      await FirebaseFirestore.instance.collection("properties").add({
        "title": title,
        "image": imageUrl ?? "", // Use empty string if no image is provided
        "location": location,
        "price": price,
        "number_of_beds": numberOfBeds,
        "number_of_bathrooms": numberOfBathrooms,
        "created_at": FieldValue.serverTimestamp(),
      });
      print("Property added successfully.");
    } catch (e) {
      throw Exception("Error adding property: $e");
    }
  }

  Future<void> handleAddProperty() async {
    try {
      String? imageUrl; // Nullable to handle optional images

      // Upload image only if selected
      if (selectedImage != null) {
        imageUrl = await uploadImageToFirebase(selectedImage!);
      }

      await addPropertyToFirestore(
        title: titleController.text.trim(),
        imageUrl: imageUrl,
        location: locationController.text.trim(),
        price: double.parse(priceController.text.trim()),
        numberOfBeds: int.parse(bedsController.text.trim()),
        numberOfBathrooms: int.parse(bathroomsController.text.trim()),
      );

      // Clear fields after successful addition
      titleController.clear();
      locationController.clear();
      priceController.clear();
      bedsController.clear();
      bathroomsController.clear();
      setState(() {
        selectedImage = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Property added successfully!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Property'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "Title"),
            ),
            SizedBox(height: 10),
            Text(
              "Image (optional)",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: pickImage,
              child: Container(
                height: 150,
                width: double.infinity,
                color: Colors.grey[200],
                child: selectedImage != null
                    ? Image.file(selectedImage!, fit: BoxFit.cover)
                    : Center(child: Text("Tap to select an image (optional)")),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: locationController,
              decoration: InputDecoration(labelText: "Location"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Price"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: bedsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Number of Beds"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: bathroomsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Number of Bathrooms"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: handleAddProperty,
              child: Text("Add Property"),
            ),
          ],
        ),
      ),
    );
  }
}
