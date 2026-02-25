import 'package:vanguard_ops/domain/contacts/entities/contact.dart';

abstract class ContactRepository {
  Future<List<ContactEntity>> getContacts();
  Future<void> createContact(ContactEntity contact);
}