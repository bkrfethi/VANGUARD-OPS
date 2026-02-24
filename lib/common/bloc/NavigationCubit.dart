import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationCubit extends Cubit<int> {
  final SharedPreferences prefs;
  static const String _storageKey = 'user_last_screen_index';

  NavigationCubit(this.prefs) : super(prefs.getInt(_storageKey) ?? 0);

  void setTab(int index) {
    prefs.setInt(_storageKey, index);
    
    emit(index);
  }
}