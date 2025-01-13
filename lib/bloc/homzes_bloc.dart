import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entity/property_list_entity.dart';
import '../domain/entity/category1_entity.dart';
import '../views/catalog1/widget/seasonal_location_tile.dart';
import 'homzes_event.dart';
import 'homzes_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PropertyBloc extends Bloc<PropertyEvent, PropertyState> {
  PropertyBloc() : super(PropertyInitial()) {
    on<FetchProperties>(_onFetchProperties);
  }

  Future<void> _onFetchProperties(
      FetchProperties event, Emitter<PropertyState> emit) async {
    emit(PropertyLoading());
    try {
      final querySnapshot =
      await FirebaseFirestore.instance.collection('properties').get();
      final properties = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return Property(

          title: data['title'] ?? '',
          price: data['price']?.toDouble() ?? 0.0,
          location: data['location'],
          numberOfBathrooms: data['number_of_bathrooms'],
          numberOfBeds: data['number_of_beds'],
        );
      }).toList();
      emit(PropertyLoaded(properties));
    } catch (e) {
      emit(PropertyError('Failed to fetch properties.'));
    }
  }
}
