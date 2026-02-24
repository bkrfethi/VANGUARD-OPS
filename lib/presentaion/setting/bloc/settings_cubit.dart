import 'package:flutter_bloc/flutter_bloc.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());

  void selectOption(String title) {
    final currentTitle = state is SettingsUpdated ? (state as SettingsUpdated).selectedTitle : null;
    
    if (currentTitle == title) {
      emit(SettingsUpdated(null)); 
    } else {
      emit(SettingsUpdated(title));
    }
  }
}