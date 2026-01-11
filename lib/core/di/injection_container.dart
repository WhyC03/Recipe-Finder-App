import 'package:get_it/get_it.dart';
import '../../features/recipes/data/datasources/meal_api_service.dart';
import '../../features/recipes/data/datasources/favorites_local_storage.dart';
import '../../features/recipes/data/repositories/meal_repository.dart';
import '../../features/recipes/presentation/bloc/recipe_bloc.dart';
import '../../features/recipes/presentation/bloc/favorites_bloc.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // Data sources
  getIt.registerLazySingleton<MealApiService>(
    () => MealApiService(),
  );

  getIt.registerLazySingleton<FavoritesLocalStorage>(
    () => FavoritesLocalStorage(),
  );

  // Repositories
  getIt.registerLazySingleton<MealRepository>(
    () => MealRepositoryImpl(apiService: getIt()),
  );

  // BLoC
  getIt.registerFactory<RecipeBloc>(
    () => RecipeBloc(repository: getIt()),
  );

  getIt.registerLazySingleton<FavoritesBloc>(
    () => FavoritesBloc(localStorage: getIt()),
  );
}
