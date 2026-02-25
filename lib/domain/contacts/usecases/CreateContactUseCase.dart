import 'package:dartz/dartz.dart';
import 'package:vanguard_ops/core/usecases/usecases.dart';
import 'package:vanguard_ops/domain/contacts/entities/contact.dart';
import 'package:vanguard_ops/domain/contacts/repository/contact_repository.dart';
import 'package:vanguard_ops/service_loacator.dart';

class CreateContactUseCase implements UseCase<Either, ContactEntity> {
  @override
  Future<Either> call({ContactEntity? params}) {
    return sl<ContactRepository>().createContact(params!);
  }
}