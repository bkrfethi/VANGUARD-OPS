abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsUpdated extends SettingsState {
  final String? selectedTitle; 
  SettingsUpdated(this.selectedTitle);
}