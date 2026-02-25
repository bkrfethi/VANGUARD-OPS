import 'package:dartz/dartz.dart';
import 'package:vanguard_ops/domain/contacts/entities/contact.dart';

abstract class ContactRepository {
  Future<Either> getContacts();
  Future<void> createContact(ContactEntity contact);
}