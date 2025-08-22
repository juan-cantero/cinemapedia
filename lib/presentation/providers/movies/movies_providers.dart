import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// a javascript example to understand this part of the code
// const nowPlayingMoviesProvider = new StateNotifierProvider((ref) => {
//   const movieRepository = ref.watch(movieRepositoryProvider);

//   const fetchMoreMovies = movieRepository.getNowPlaying;

//   const moviesNotifier = new MoviesNotifier({ fetchMoreMovies });

//   return moviesNotifier;
// });

// diferentes formas de escribirlo

final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>(
      (ref) => MoviesNotifier(
        fetchMoreMovies: ref.watch(movieRepositoryProvider).getNowPlaying,
      ),
    );

// ✅ función separada
MoviesNotifier createPopularMoviesNotifier(ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getPopular;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
}

// ✅ provider usando la función
final popularMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>(
      createPopularMoviesNotifier,
                                                                      );

//upcomingMoviesProvider
final upcomingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
      final fetchMoreMovies = ref.watch(movieRepositoryProvider).getUpcoming;
      return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
    });
final topratedMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
      final fetchMoreMovies = ref.watch(movieRepositoryProvider).getTopRated;
      return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
    });

typedef MovieCallback = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  MovieCallback fetchMoreMovies;
  MoviesNotifier({required this.fetchMoreMovies}) : super([]);

  Future<void> loadNextPage() async {
    print('loading more movies');
    currentPage++;
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    state = [...state, ...movies];
  }
}
