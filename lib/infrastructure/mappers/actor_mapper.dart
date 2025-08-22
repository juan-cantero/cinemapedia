import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';

class ActorMapper {
  static Actor castToEnity(Cast cast) => Actor(
    id: cast.id,
    name: cast.name,
    profilePath: cast.profilePath != null
        ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
        : 'https://previews.123rf.com/images/blankstock/blankstock2303/blankstock230301517/200668125-user-profile-icon-vector-avatar-or-person-icon-profile-picture-portrait-symbol-neutral-gender.jpg',
    character: cast.character,
  );
}
