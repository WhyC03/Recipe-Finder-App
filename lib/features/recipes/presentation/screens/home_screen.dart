import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder_app/core/di/injection_container.dart';
import 'package:recipe_finder_app/core/utils/colors.dart';
import 'package:recipe_finder_app/features/recipes/presentation/bloc/recipe_bloc.dart';
import 'package:recipe_finder_app/features/recipes/presentation/bloc/favorites_bloc.dart';
import 'package:recipe_finder_app/features/recipes/presentation/widgets/favorites_screen.dart';
import 'package:recipe_finder_app/features/recipes/presentation/widgets/recipe_list_screen.dart';
import 'package:recipe_finder_app/features/recipes/presentation/widgets/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double bottomBarWidth = 35;
  int _page = 0;

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider.value(value: getIt<FavoritesBloc>())],
      child: Scaffold(
        body: IndexedStack(
          index: _page,
          children: [
            BlocProvider(
              create: (context) => getIt<RecipeBloc>(),
              child: RecipeListScreen(
                onSearchTap: () => updatePage(1),
              ),
            ),
            MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => getIt<RecipeBloc>(),
                ),
                BlocProvider.value(value: getIt<FavoritesBloc>()),
              ],
              child: SearchScreen(),
            ),
            FavoritesScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(),
                child: Image.asset(
                  'assets/images/Home.png',
                  height: 30,
                  color: _page == 0 ? greenColor : Colors.black38,
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(),
                child: Icon(
                  Icons.search,
                  color: _page == 1 ? greenColor : Colors.black38,
                  size: 35,
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(),
                child: Image.asset(
                  'assets/images/Favorites.png',
                  height: 30,
                  color: _page == 2 ? greenColor : Colors.black38,
                ),
              ),
              label: '',
            ),
          ],
          iconSize: 28,
          onTap: updatePage,
          currentIndex: _page,
        ),
      ),
    );
  }
}
