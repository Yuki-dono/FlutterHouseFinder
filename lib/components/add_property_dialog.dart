//add property dialog

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:safe_stay/api/db_details.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safe_stay/api/models/properties.dart';
import 'package:safe_stay/api/riverpod/property_state.dart';

class AddPropertyDialog extends ConsumerStatefulWidget {
  const AddPropertyDialog({super.key});

  @override
  ConsumerState createState() => _AddPropertyDialogState();
}

class _AddPropertyDialogState extends ConsumerState<AddPropertyDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController distanceController = TextEditingController();  
  final TextEditingController durationController = TextEditingController();  
  final TextEditingController priceController = TextEditingController();  


  List<Object> _selectedImages = [];

  Future<void> _pickImages() async {
  final pickedFiles = await ImagePicker().pickMultiImage();

  if (pickedFiles.isEmpty == false) {
    print('Picked Files: $pickedFiles'); // Debug log for picked files

    setState(() {
      _selectedImages = pickedFiles.map((pickedFile) {
        if (kIsWeb) {
          // For web: Convert to Uint8List
          print('Picked file for web: ${pickedFile.name}');
          return pickedFile.readAsBytes();
        } else {
          // For mobile/desktop: Convert to File
          print('Picked file for mobile: ${pickedFile.path}');
          return File(pickedFile.path);
        }
      }).toList();
    });

    print('Selected Images after mapping: $_selectedImages'); // Debug log
  } else {
    print('No files picked');
  }
}


  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(34, 124, 29, 1),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Add a Property',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: titleController,
                      label: 'Property Title',
                      hint: 'Enter property title',
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      controller: locationController,
                      label: 'Location',
                      hint: 'Enter location',
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      controller: addressController,
                      label: 'Address',
                      hint: 'Enter address',
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      controller: descriptionController,
                      label: 'Property Description',
                      hint: 'Enter property description',
                      maxLines: 3,
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      controller: distanceController,
                      label: 'Property Distance',
                      hint: 'Enter property distance from Downtown',
                      maxLines: 1,
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      controller: durationController,
                      label: 'Duration of Stay',
                      hint: 'Enter max duration of stay',
                      maxLines: 1,
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      controller: priceController,
                      label: 'Price per Stay',
                      hint: 'Enter price per day',
                      maxLines: 1,
                    ),
                    const SizedBox(height: 20),
                    _buildImagePicker(context),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Dismiss dialog
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                  const Color.fromARGB(255, 223, 116, 116),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 18), // Slightly taller
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      8), // Less round corners
                                ),
                              ),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: ElevatedButton(
                              onPressed: () async {
                                if(_formKey.currentState!.validate()){
                                  final userId = supabaseDB.auth.currentUser?.id;

                                  if(kIsWeb){
                                    print('Uplading images');
                                    final List<Uint8List> bytesToUpload = await Future.wait(_selectedImages.whereType<Future<Uint8List>>(),);

                                    if (bytesToUpload.isEmpty) {
                                      print('No valid files selected for upload on web');
                                      return;
                                    }

                                    final List<String> imageUrls = await ref.read(propertyServiceProvider).uploadImagesForWeb(bytesToUpload);

                                    final newProperty = PropertyData(
                                      propID: 0,
                                      userID: userId,
                                      propName: titleController.text,
                                      propLocation: locationController.text,
                                      propPrice: double.parse(priceController.text), // Assuming addressController holds price
                                      propTag: 'tagName', 
                                      propURL: imageUrls, // This will be populated by the addProperty method
                                      propDesc: descriptionController.text,
                                      hidden: true,
                                      distance:double.parse(distanceController.text),
                                      duration: double.parse(durationController.text),
                                    );
                                    await ref.read(propertyServiceProvider).addProperty(newProperty); 

                                    print('Uploaded Image URLs (Web): $imageUrls');
                                  }else{
                                    final List<File> filesToUpload = _selectedImages.whereType<File>().toList();

                                    if (filesToUpload.isEmpty) {
                                      print('No valid files selected for upload');
                                      return;
                                    }
                      
                                    final List<String> imageUrls = await ref.read(propertyServiceProvider).uploadImages(filesToUpload);

                                    final newProperty = PropertyData(
                                      propID: 0,
                                      userID: userId,
                                      propName: titleController.text,
                                      propLocation: locationController.text,
                                      propPrice: double.parse(priceController.text), // Assuming addressController holds price
                                      propTag: 'tagName', 
                                      propURL: imageUrls, // This will be populated by the addProperty method
                                      propDesc: descriptionController.text,
                                      hidden: true,
                                      distance:double.parse(distanceController.text),
                                      duration: double.parse(durationController.text),
                                    );
                                    await ref.read(propertyServiceProvider).addProperty(newProperty); 
                                  }
                                  ref.invalidate(propertyServiceProvider);
                                  Navigator.of(context).pop(); // Close the dialog
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(129, 223, 116, 1),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 18), // Slightly taller
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      8), // Less round corners
                                ),
                              ),
                              child: const Text(
                                'Add Property',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  Widget _buildImagePicker(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Upload Images',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 10),
      Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          ..._selectedImages.map((image) {
            if (image is Future<Uint8List>) {
              // For web: Handle bytes
              return FutureBuilder<Uint8List>(
                future: image,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.memory(
                        snapshot.data!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              );
            } else if (image is File) {
              // For mobile/desktop: Handle file
              return ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.file(
                  image,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              );
            } else {
              return const SizedBox(); // Fallback
            }
          }),
          GestureDetector(
            onTap: _pickImages,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.grey[200],
              ),
              child: const Icon(
                Icons.add,
                color: Colors.grey,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
}