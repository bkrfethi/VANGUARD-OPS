import 'package:get_it/get_it.dart';
import 'package:vanguard_ops/data/auth/repositoires/auth.dart';
import 'package:vanguard_ops/data/auth/serevices/auth_supabase_service.dart';
import 'package:vanguard_ops/domain/auth/repositoreies/auth.dart';
import 'package:vanguard_ops/domain/auth/usecases/SigninUseCase.dart';

final sl =GetIt.instance;

Future<void> initializedependencies() async {
  // services 

    sl.registerSingleton<AuthSupabaseService>(AuthSupabaseServiceImpl());


  //repositories 
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());



  // usecese 
    sl.registerSingleton<SigninUseCase>(SigninUseCase());

}