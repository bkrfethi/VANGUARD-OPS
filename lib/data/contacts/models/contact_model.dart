
import 'package:vanguard_ops/domain/contacts/entities/contact.dart';

class ContactModel extends ContactEntity {
  ContactModel({super.id, required super.name, required super.phone, required super.type, super.hasAlert});

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      type: json['type'],
      hasAlert: json['has_alert'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'phone': phone, 'type': type, 'has_alert': hasAlert};
  }
}