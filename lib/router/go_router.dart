import 'package:go_router/go_router.dart';
import 'package:login_musica/presentations/screens/login_screen.dart';
import 'package:login_musica/presentations/screens/home_screen.dart';
import 'package:login_musica/presentations/screens/album_detail.dart';
import 'package:login_musica/presentations/screens/album_information.dart';
import 'package:login_musica/entities/datos_usuario.dart';
import 'package:login_musica/entities/album.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const Login(),
    ),

    GoRoute(
      path: '/home',
      builder: (context, state) {
        final user = state.extra as Datos;
        return Home(user: user);
      },
    ),

    GoRoute(
      path: '/album_detail',
      builder: (context, state) {
        final map = state.extra as Map<String, dynamic>; 
        final album = map['album'] as Albums?;
        final user = map['user'] as Datos;
        return AlbumDetail(album: album, user: user);
      },
    ),

    GoRoute(
      path: '/album_information',
      builder: (context, state) {
        final map = state.extra as Map<String, dynamic>;
        return AlbumInformation(
          album: map['album'],
          user: map['user'],
        );
      },
    ),
  ],
);