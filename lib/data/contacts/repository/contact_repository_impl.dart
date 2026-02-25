import 'package:dartz/dartz.dart';
import 'package:vanguard_ops/data/contacts/services/contact_service.dart';
import 'package:vanguard_ops/domain/contacts/entities/contact.dart';
import 'package:vanguard_ops/domain/contacts/repository/contact_repository.dart';
import 'package:vanguard_ops/service_loacator.dart';
import '../models/contact_model.dart';

class ContactRepositoryImpl implements ContactRepository {


 @override
  Future<Either> getContacts() async {
    final result = await sl<ContactService>().fetchContacts();

    return result.fold(
      (error) => Left(error), 
      (models) => Right(models),
    );
  }

  @override
  Future<Either> createContact(ContactEntity contact) async {
    final model = ContactModel(
      id: contact.id,
      name: contact.name,
      phone: contact.phone,
      type: contact.type,
      hasAlert: contact.hasAlert,
    );

    return await sl<ContactService>().saveContact(model);
  }
}

