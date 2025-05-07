import 'package:dooss_business_app/core/network/api.dart';
import 'package:dooss_business_app/core/network/app_dio.dart';
import 'package:dooss_business_app/features/auth/data/data_source/auth_remote_data_source_imp.dart';
import 'package:dooss_business_app/features/auth/presentation/manager/auth_cubit.dart';
import 'package:get_it/get_it.dart';

final GetIt getItInstance = GetIt.instance;

void intialLoclatorService (){

  getItInstance.registerLazySingleton<AppDio>(()=>AppDio());
  getItInstance.registerLazySingleton<API>(()=>API(dio: getItInstance<AppDio>().dio));
  getItInstance.registerLazySingleton<AuthCubit>(()=>AuthCubit(getItInstance<AuthRemoteDataSourceImp>()));
  getItInstance.registerLazySingleton<AuthRemoteDataSourceImp>(()=>AuthRemoteDataSourceImp(api: getItInstance<API>() ));


}