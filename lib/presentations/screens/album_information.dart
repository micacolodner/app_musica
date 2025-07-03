import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login_musica/entities/album.dart';
import 'package:login_musica/entities/datos_usuario.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlbumInformation extends ConsumerWidget {
  final Albums album;
  final Datos user;

  const AlbumInformation({super.key, required this.album, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ALBUM: ${album.title}"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              context.push('/album_detail', extra: {
                'album': album,
                'user': user,
              });
            },
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(album.poster, width: 300, height: 300, fit: BoxFit.cover),
              ),
              const SizedBox(height: 30),
              Text(album.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
              const SizedBox(height: 10),
              Text(album.singer, style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 5),
              Text('Año: ${album.year}', style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}