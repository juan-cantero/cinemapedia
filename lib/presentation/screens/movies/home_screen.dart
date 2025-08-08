import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottonNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topratedMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return FullScreenLoader();
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch(popularMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topRated = ref.watch(topratedMoviesProvider);
    final upcoming = ref.watch(upcomingMoviesProvider);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(title: CustomAppbar()),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              children: [
                MoviesSlideshow(movies: slideShowMovies),
                // MovieHorizontalListview(
                //   movies: nowPlayingMovies,
                //   title: 'En cines',
                //   subtitle: 'Lunes 20',
                //   loadNextPage: () => ref
                //       .read(nowPlayingMoviesProvider.notifier)
                //       .loadNextPage(),
                // ),
                MovieHorizontalListview(
                  movies: popularMovies,
                  title: 'Populares',
                  subtitle: 'Lunes 20',
                  loadNextPage: () =>
                      ref.read(popularMoviesProvider.notifier).loadNextPage(),
                ),
                MovieHorizontalListview(
                  movies: upcoming,
                  title: 'Proximas',
                  subtitle: 'Lunes 20',
                  loadNextPage: () =>
                      ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
                ),
                MovieHorizontalListview(
                  movies: topRated,
                  title: 'Mejor Calificadas',
                  subtitle: 'Lunes 20',
                  loadNextPage: () =>
                      ref.read(topratedMoviesProvider.notifier).loadNextPage(),
                ),
                SizedBox(height: 20),
              ],
            );
          }, childCount: 1),
        ),
      ],
    );
  }
}
