import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanguard_ops/domain/contacts/usecases/GetContactsUseCase.dart';
import 'package:vanguard_ops/presentaion/contact/bloc/contacts_state.dart';
import 'package:vanguard_ops/service_loacator.dart';



class ContactsCubit extends Cubit<ContactsState> {

  ContactsCubit():super(ContactsLoading());

  Future<void> loadContacts() async {
    emit(ContactsLoading());
    final result = await sl<GetContactsUseCase>().call();
    
    result.fold(
      (error) => emit(ContactsError(error)),
      (contacts) => emit(ContactsLoaded(contacts)),
    );
  }
}