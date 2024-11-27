import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safe_stay/api/models/properties.dart';

class EditPropertyDialog extends StatefulWidget {
  final PropertyData property;

  const EditPropertyDialog({super.key, required this.property});

  @override
  _EditPropertyDialogState createState() => _EditPropertyDialogState();
}

class _EditPropertyDialogState extends State<EditPropertyDialog> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _locationController;
  late TextEditingController _isHidden;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing property data
    _titleController = TextEditingController(text: widget.property.propName);
    _descriptionController = TextEditingController(text: widget.property.propDesc ?? '');
    _priceController = TextEditingController(text: widget.property.propPrice.toString());
    _locationController = TextEditingController(text: widget.property.propLocation);
    _isHidden = TextEditingController(text: widget.property.hidden.toString());
  }

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _locationController.dispose();
    _isHidden.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(34, 124, 29, 1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Text(
          'Edit Property',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.raleway().fontFamily,
            fontSize: 20,
          ),
        ),
      ),
      titlePadding: EdgeInsets.zero,
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTextField('Title', _titleController),
            const SizedBox(height: 10),
            _buildTextField('Description', _descriptionController, maxLines: 3),
            const SizedBox(height: 10),
            _buildTextField('Price', _priceController, keyboardType: TextInputType.number),
            const SizedBox(height: 10),
            _buildTextField('Location', _locationController),
            const SizedBox(height: 10),
            _buildTextField('Availability', _isHidden),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel', style: TextStyle(color: Colors.red)),
        ),
        ElevatedButton(
          onPressed: _saveChanges,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(34, 124, 29, 1),
          ),
          child: const Text('Save Changes'),
        ),
      ],
    );
  }

  Widget _buildTextField(
    String label, 
    TextEditingController controller, {
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromRGBO(34, 124, 29, 1)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _saveChanges() {
    print('Saving changes...');
    print('Title: ${_titleController.text}');
    print('Description: ${_descriptionController.text}');
    print('Price: ${_priceController.text}');
    print('Location: ${_locationController.text}');

    Navigator.of(context).pop();
  }
}