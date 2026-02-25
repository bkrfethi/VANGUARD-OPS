import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vanguard_ops/domain/contacts/entities/contact.dart';
import 'package:vanguard_ops/domain/contacts/repository/contact_repository.dart';
import '../models/contact_model.dart';

class ContactRepositoryImpl implements ContactRepository {
  final SupabaseClient supabase;
  ContactRepositoryImpl(this.supabase);

  @override
  Future<List<ContactEntity>> getContacts() async {
    final response = await supabase.from('contacts').select();
    return response.map((json) => ContactModel.fromJson(json)).toList();
  }

  @override
  Future<void> createContact(ContactEntity contact) async {
    final model = ContactModel(
      name: contact.name,
      phone: contact.phone,
      type: contact.type,
      hasAlert: contact.hasAlert,
    );
    await supabase.from('contacts').insert(model.toJson());
  }
}