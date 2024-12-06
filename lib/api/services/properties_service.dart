// ignore_for_file: unused_import

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:safe_stay/api/db_details.dart';
import 'package:safe_stay/api/models/properties.dart';

class PropertiesService {

Future<List<String>> uploadImagesForWeb(List<Uint8List> images) async {
  final List<String> imageUrls = [];

  for (var bytes in images) {
    final fileName = 'images/${DateTime.now().millisecondsSinceEpoch}.png';
    final response = await supabaseDB.storage.from('assets').uploadBinary(fileName, bytes);

    if (response.isNotEmpty == true) {
      imageUrls.add(supabaseDB.storage.from('assets').getPublicUrl(fileName));
    } else {
      throw Exception('Failed to upload image @ uploadImagesForWeb');
    }
  }
  return imageUrls;
}


Future<List<PropertyData>> fetchUserProperties() async {
  final userId = supabaseDB.auth.currentUser?.id; // Get current user ID

  // Use the user ID to filter properties 
  // Assuming you have a field like 'owner_id' in your database table
  final properties = await supabaseDB.from('properties_list').select().eq('owner_id', userId.toString()); 

  if (properties.isEmpty == true) {
    print('Dataset is empty');
    return [];
  } else {
    return properties.map<PropertyData>((item) => PropertyData.fromJSON(item)).toList();
  }
}

Future<List<String>> uploadImages(List<File> images) async {
  final List<String> imageUrls = [];
  for (final image in images) {
    print("Image Paths: ${image.path}");
    final fileName = '${DateTime.now().millisecondsSinceEpoch}-${image.path.split('/').last}';
    await supabaseDB.storage.from('assets').upload(fileName, image);

    final imageUrl = supabaseDB.storage.from('assets').getPublicUrl(fileName);
    print("Image URL: ${imageUrl.toString()}");
    imageUrls.add(imageUrl);
    }
    return imageUrls;
  }
  
  Future<List<PropertyData>> fetchProperties() async{
    try{
      final properties = await supabaseDB.from('properties_list').select();
      if(properties.isEmpty == true){
        print('Dataset is empty');
        return [];
      }else{
        return properties.map<PropertyData>((item) => PropertyData.fromJSON(item)).toList();
      }
    }catch(err){
      print('Failed to retrieve data. $err');
      return [];
    }
  }

  //Fetch Available Properties
  Future<List<PropertyData>> fetchAvailableProperties() async{
    try{
      final properties = await supabaseDB.from('properties_list').select().eq('hidden', false);
      if(properties.isEmpty == true){
        print('Dataset is empty');
        return [];
      }else{
        return properties.map<PropertyData>((item) => PropertyData.fromJSON(item)).toList();
      }
    }catch(err){
      print('Failed to retrieve available properties. $err');
      return [];
    }
  }

  //Fetch Hidden/Archived Properties
  Future<List<PropertyData>> fetchHiddenProperties() async{
    try{
      final properties = await supabaseDB.from('properties_list').select().eq('hidden', true);
      if(properties.isEmpty == true){
        print('Dataset is empty');
        return [];
      }else{
        return properties.map<PropertyData>((item) => PropertyData.fromJSON(item)).toList();
      }
    }catch(err){
      print('Failed to retrieve hidden properties. $err');
      return [];
    }
  }

  //Add
  Future<void> addProperty(PropertyData property) async {
    final userID = supabaseDB.auth.currentUser?.id;

    try{
      String defTag = "AVAILABLE";

      await supabaseDB.from('properties_list').insert({
        'userID': userID,
        'name': property.propName,
        'location': property.propLocation,
        'price': property.propPrice,
        'tagName': defTag,
        'imageURL': property.propURL,
        'hidden': true,
        'description': property.propDesc,
        'duration': property.duration,
        'distance': property.distance,
      });
    }catch(err){
      print("Error adding property. $err");
    }
  }


  //Update
  Future<void> updateProperty(PropertyData property, int propID) async {
  try {
    await supabaseDB.from('properties_list').update({ 
        'name': property.propName,
        'location': property.propLocation,
        'price': property.propPrice,
        'tagName': property.propTag,
        'imageURL': property.propURL,
        'hidden': true,
        'description': property.propDesc,
        'duration': property.duration,
        'distance': property.distance,
        })
        .eq('id', propID); 
    } catch (e) {
      print('Error updating property: $e');
      // Handle error
    }
  }

   //Update
  Future<void> updateVisibility(bool isVisible, int propID) async{
  try {
    await supabaseDB.from('properties_list').update({'hidden': isVisible}).eq('id', propID); 
    } catch (e) {
      print('Error updating property: $e');
      // Handle error
    }
  }
}