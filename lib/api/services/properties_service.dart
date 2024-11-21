// ignore_for_file: unused_import

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:safe_stay/api/db_details.dart';

import 'package:safe_stay/api/models/properties.dart';

class PropertiesService {
  
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

  //Add
  //Update
  //Submit

}