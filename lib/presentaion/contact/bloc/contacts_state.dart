import 'package:equatable/equatable.dart';
import 'package:vanguard_ops/domain/contacts/entities/contact.dart';

abstract class ContactsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ContactsLoading extends ContactsState {}

class ContactsLoaded extends ContactsState {
  final List<ContactEntity> contacts;
  ContactsLoaded(this.contacts);

  @override
  List<Object?> get props => [contacts];
}

class ContactsError extends ContactsState {
  final String message;
  ContactsError(this.message);

  @override
  List<Object?> get props => [message];
}