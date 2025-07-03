import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_musica/entities/album.dart';


final AlbumProvider = StateNotifierProvider<AlbumNotifier, List<Albums>> (
  (ref) => AlbumNotifier(),
);

class AlbumNotifier extends StateNotifier<List<Albums>> {
  AlbumNotifier() : super ([
    Albums (title: 'FOUR (Deluxe)', singer: 'One Direction', year: '2014', poster: 'https://i.scdn.co/image/ab67616d0000b273d304ba2d71de306812eebaf4' ),
    Albums (title: '1989(Deluxe)', singer: 'Taylor Swift', year: '2014', poster: 'https://upload.wikimedia.org/wikipedia/en/f/f6/Taylor_Swift_-_1989.png'),
    Albums (title: 'Faith In The Future (Deluxe)', singer: 'Louis Tomlinson', year: '2022', poster: 'https://upload.wikimedia.org/wikipedia/en/1/16/Louis_Tomlinson_-_Faith_in_the_Future.png'),
    Albums (title: 'Snow Angel', singer: 'Reneé Rapp', year: '2023', poster: 'https://cdn-images.dzcdn.net/images/cover/e2728454168a221597bd74042eb4bea9/1900x1900-000000-80-0-0.jpg'),
    Albums (title: 'Mind Of Mine', singer: 'ZAYN', year: '2016', poster: 'https://cdn-images.dzcdn.net/images/cover/1224e92320d2d00568fb0327b248acf4/1900x1900-000000-80-0-0.jpg'),

  ]);

  void addAlbum (Albums album) {
    state = [...state, album];
  }

  void deleteAlbum (Albums album) {
    state = state.where((m) => m != album).toList();
  }
}

class selectedAlbumNotifier extends StateNotifier <Albums>{
  selectedAlbumNotifier() : super (
    Albums(
      title: "",
      singer: "",
      year: "",
      poster: "",
      ),
  );
    void selectedAlbum (
      String title,
      String singer,
      String year,
      String poster,
    ) {
      state = Albums(
        title: title,
        singer: singer,
        year: year,
        poster: poster,
      );
    }
}

final selectedAlbumProvider = StateNotifierProvider<selectedAlbumNotifier, Albums> (
  (ref,){
   return selectedAlbumNotifier();
}
);