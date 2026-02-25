import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vanguard_ops/common/bloc/NavigationCubit.dart';
import 'package:vanguard_ops/data/auth/repositoires/auth.dart';
import 'package:vanguard_ops/data/auth/serevices/auth_supabase_service.dart';
import 'package:vanguard_ops/data/contacts/repository/contact_repository_impl.dart';
import 'package:vanguard_ops/data/contacts/services/contact_service.dart';
import 'package:vanguard_ops/domain/auth/repositoreies/auth.dart';
import 'package:vanguard_ops/domain/auth/usecases/SigninUseCase.dart';
import 'package:vanguard_ops/domain/contacts/repository/contact_repository.dart';
import 'package:vanguard_ops/presentaion/auth/bloc/signin_cubit.dart';
import 'package:vanguard_ops/presentaion/setting/bloc/settings_cubit.dart';

final sl =GetIt.instance;

Future<void> initializeDependencies() async {
    final sharedPrefs = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPrefs);
  // services 

    sl.registerSingleton<AuthSupabaseService>(AuthSupabaseServiceImpl());

    sl.registerSingleton<ContactService>(ContactServiceImpl());

  //repositories 
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<ContactRepository>(ContactRepositoryImpl());



  // usecese 
    sl.registerSingleton<SigninUseCase>(SigninUseCase());

    //cubit 
  sl.registerFactory(() => SigninCubit());
  sl.registerFactory(() => NavigationCubit(sl<SharedPreferences>()));
  sl.registerFactory(() => SettingsCubit());

}