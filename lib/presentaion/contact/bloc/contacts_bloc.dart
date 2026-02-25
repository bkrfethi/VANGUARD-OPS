import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanguard_ops/domain/contacts/usecases/CreateContactUseCase.dart';
import 'package:vanguard_ops/presentaion/contact/bloc/contacts_state.dart';



class ContactsCubit extends Cubit<ContactsState> {
  final CreateContactUseCase _getContactsUseCase;

  ContactsCubit({required CreateContactUseCase getContactsUseCase})
      : _getContactsUseCase = getContactsUseCase,
        super(ContactsLoading());

  Future<void> loadContacts() async {
    emit(ContactsLoading());
    final result = await _getContactsUseCase();
    
    result.fold(
      (error) => emit(ContactsError(error)),
      (contacts) => emit(ContactsLoaded(contacts)),
    );
  }
}