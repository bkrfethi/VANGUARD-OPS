import 'package:dartz/dartz.dart';
import 'package:vanguard_ops/data/contacts/models/contact_model.dart';

abstract class ContactService{
  Future<Either> fetchContacts();
  Future<Either> saveContact(ContactModel contact);

}


class ContactServiceImpl extends ContactService{


final List<Map<String, dynamic>> _staticJsonData = [
    {
      "id": "1",
      "name": "Police Station #1",
      "phone": "+91 0345-325-100",
      "type": "police",
      "has_alert": true
    },
    {
      "id": "2",
      "name": "Police Station #2",
      "phone": "+91 2352-356-999",
      "type": "police",
      "has_alert": true
    },
    {
      "id": "3",
      "name": "Amit Singh",
      "phone": "+91 9923563487",
      "type": "personal",
      "has_alert": true
    }
  ];

  @override
  Future<Either> fetchContacts() async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      final contacts = _staticJsonData
          .map((json) => ContactModel.fromJson(json))
          .toList();

      return Right(contacts); 
    } catch (e) {
      return Left("Erreur lors de la récupération : $e"); 
    }
  }

  @override
  Future<Either<String, void>> saveContact(ContactModel contact) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      
      print("Contact sauvegardé dans le service: ${contact.name}");
      
      return const Right(null); 
    } catch (e) {
      return Left("Erreur lors de la sauvegarde : $e");
    }
  }
}