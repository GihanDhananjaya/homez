import 'package:cloud_firestore/cloud_firestore.dart';

class Property {
  final String title;
  final String location;
  final int numberOfBathrooms;
  final int numberOfBeds;
  final double price;

  Property({
    required this.title,
    required this.location,
    required this.numberOfBathrooms,
    required this.numberOfBeds,
    required this.price,
  });

  // Factory method to create a Property object from Firestore data
  factory Property.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Property(
      title: data['title'] ?? '',
      location: data['location'] ?? '',
      numberOfBathrooms: data['number_of_bathrooms'] ?? 0,
      numberOfBeds: data['number_of_beds'] ?? 0,
      price: (data['price'] ?? 0).toDouble(),
    );
  }
}