import 'package:blog_app/core/common/cubits/cubit/app_user_cubit.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/core/secrets/app_secret.dart';
import 'package:blog_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_login.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/blog/data/datasources/blog_local_data_source.dart';
import 'package:blog_app/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog_app/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get_it/get_it.dart';
import '../features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:hive/hive.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final supabase = await Supabase.initialize(
    url: AppSecret.supabaseUrl,
    anonKey: AppSecret.supabaseAnon,
  );

  serviceLocator.registerLazySingleton(() => supabase.client);
  serviceLocator.registerFactory(() => InternetConnection());
  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(serviceLocator()),
  );
  final appDir = await getApplicationDocumentsDirectory();
  Hive.init(appDir.path); // ✅ initialise Hive correctement

  final blogBox = await Hive.openBox('blogs'); // ✅ ouvre le box

  serviceLocator.registerLazySingleton<Box>(() => blogBox);

  //core dependencies
  serviceLocator.registerLazySingleton(() => AppUserCubit());
  _initAuth();
  _initBlog();
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(serviceLocator()),
  );
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(serviceLocator(), serviceLocator()),
  );
  serviceLocator.registerFactory<Currentuser>(
    () => Currentuser(serviceLocator()),
  );
  serviceLocator.registerFactory(() => UserSignUp(serviceLocator()));
  serviceLocator.registerFactory(() => UserLogIn(serviceLocator()));
  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignUp: serviceLocator(),
      userLogIn: serviceLocator(),
      currentUser: serviceLocator(),
      appUserCubit: serviceLocator(),
    ),
  );
}

void _initBlog() {
  //dataSource
  serviceLocator.registerLazySingleton<BlogRemoteDataSource>(
    () => BlogRemoteDataSourceImpl(supabaseClient: serviceLocator()),
  );

  //repository

  serviceLocator.registerLazySingleton<BlogRepository>(
    () => BlogRepositoryImpl(
      blogRemoteDataSource: serviceLocator(),
      connectionChecker: serviceLocator(),
      blogLocalDataSource: serviceLocator(),
    ),
  );
  // useCases

  serviceLocator.registerFactory(
    () => UploadBlogUseCase(blogRepository: serviceLocator()),
  );
  serviceLocator.registerFactory(() => GetAllBlogsUseCase(serviceLocator()));

  //Blog

  serviceLocator.registerLazySingleton(
    () => BlogBloc(serviceLocator(), GetAllBlogsUseCase(serviceLocator())),
  );
  serviceLocator.registerFactory<BlogLocalDataSource>(
    () => BlogLocalDataSourceImpl(serviceLocator()),
  );
}
