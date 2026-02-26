class ContactEntity {
  final String? id;
  final String name;
  final String phone;
  final String type; 
  final bool hasAlert;

  ContactEntity({this.id, required this.name, required this.phone, required this.type, this.hasAlert = false});
}
