import 'package:safe_stay/api/models/properties.dart';
import 'package:safe_stay/api/services/properties_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Provider for the instance of the properties service

final propertyServiceProvider = Provider<PropertiesService>((ref){
  return PropertiesService();
});

// Reference of the other methods

//Fetching ALL Properties
final fetchPropertyList = FutureProvider<List<PropertyData>>((ref) async {
  final properties = ref.read(propertyServiceProvider);

  List<PropertyData> allProperties = await properties.fetchProperties();
  return allProperties;
});

//Fetching Available Properties
final fetchAvailable = FutureProvider<List<PropertyData>>((ref) async {
  final properties = ref.read(propertyServiceProvider);

  List<PropertyData> allProperties = await properties.fetchAvailableProperties();
  return allProperties;
});

//Fetching Archived Properties
final fetchArchived = FutureProvider<List<PropertyData>>((ref) async {
  final properties = ref.read(propertyServiceProvider);

  List<PropertyData> allProperties = await properties.fetchHiddenProperties();
  return allProperties;
});

