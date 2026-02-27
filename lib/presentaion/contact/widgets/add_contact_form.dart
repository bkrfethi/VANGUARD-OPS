import 'package:flutter/material.dart';

class AddContactForm extends StatefulWidget {
  final Function(String name, String phone, String type) onSave;

  const AddContactForm({super.key, required this.onSave});

  @override
  State<AddContactForm> createState() => _AddContactFormState();
}

class _AddContactFormState extends State<AddContactForm> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  String _selectedType = 'personal';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        top: 20, left: 20, right: 20,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF121212),
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Container(width: 50, height: 5, decoration: BoxDecoration(color: Colors.grey[800], borderRadius: BorderRadius.circular(10)))),
          const SizedBox(height: 20),
          const Text("New Contact", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          _buildTextField("Full Name", _nameController, Icons.person_outline),
          const SizedBox(height: 15),
          _buildTextField("Phone Number", _phoneController, Icons.phone_outlined, isPhone: true),
          const SizedBox(height: 20),
          _buildTypeSelector(),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () => widget.onSave(_nameController.text, _phoneController.text, _selectedType),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFB71C1C),
              minimumSize: const Size(double.infinity, 55),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            ),
            child: const Text("Save Contact", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon, {bool isPhone = false}) {
    return TextField(
      controller: controller,
      keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        prefixIcon: Icon(icon, color: Colors.redAccent),
        filled: true,
        fillColor: const Color(0xFF1E1E1E),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
      ),
    );
  }

  Widget _buildTypeSelector() {
    return Row(
      children: [
        _typeChip("Personal", 'personal'),
        const SizedBox(width: 10),
        _typeChip("Police", 'police'),
      ],
    );
  }

  Widget _typeChip(String label, String value) {
    bool isSelected = _selectedType == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedType = value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.red.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? Colors.red : Colors.grey[800]!),
        ),
        child: Text(label, style: TextStyle(color: isSelected ? Colors.red : Colors.grey)),
      ),
    );
  }
}