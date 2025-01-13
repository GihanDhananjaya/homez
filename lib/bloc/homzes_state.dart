import 'package:equatable/equatable.dart';
import '../../domain/entity/property_list_entity.dart';
import '../domain/entity/category1_entity.dart';

abstract class PropertyState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PropertyInitial extends PropertyState {}

class PropertyLoading extends PropertyState {}

class PropertyLoaded extends PropertyState {
  final List<Property> properties;

  PropertyLoaded(this.properties);

  @override
  List<Object?> get props => [properties];
}

class PropertyError extends PropertyState {
  final String error;

  PropertyError(this.error);

  @override
  List<Object?> get props => [error];
}
