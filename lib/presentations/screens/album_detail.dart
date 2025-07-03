import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login_musica/entities/album.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_musica/presentations/providers.dart';
import 'package:login_musica/entities/datos_usuario.dart';

class AlbumDetail extends ConsumerStatefulWidget {
  final Albums? album;
  final Datos user;
  const AlbumDetail({super.key, this.album, required this.user});

  @override
  ConsumerState<AlbumDetail> createState() => _AlbumDetailState();
}

class _AlbumDetailState extends ConsumerState<AlbumDetail> {
  final TextEditingController inputTitle = TextEditingController();
  final TextEditingController inputSinger = TextEditingController();
  final TextEditingController inputYear = TextEditingController();
  final TextEditingController inputPoster = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.album != null) {
      inputTitle.text = widget.album!.title;
      inputSinger.text = widget.album!.singer;
      inputYear.text = widget.album!.year;
      inputPoster.text = widget.album!.poster;
    }
  }

  void _editOrAdd() {
    if (_inputsCompletos()) {
      final album = Albums(
        title: inputTitle.text,
        singer: inputSinger.text,
        year: inputYear.text,
        poster: inputPoster.text,
      );

      final albumNotifier = ref.read(AlbumProvider.notifier);

      if (widget.album != null) {
        albumNotifier.deleteAlbum(widget.album!);
      }

      albumNotifier.addAlbum(album);
      context.go('/home', extra: widget.user);
    } else {
      _mostrarError();
    }
  }

  bool _inputsCompletos() {
    return inputTitle.text.isNotEmpty &&
        inputSinger.text.isNotEmpty &&
        inputYear.text.isNotEmpty &&
        inputPoster.text.isNotEmpty;
  }

  void _delete() {
    if (widget.album != null) {
      ref.read(AlbumProvider.notifier).deleteAlbum(widget.album!);
      context.go('/home', extra: widget.user);

    }
  }

  void _mostrarError() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Por favor ingrese todos los datos.')),
    );
  }  

  @override
  Widget build(BuildContext context)  {

    final esEdicion = widget.album != null;

    return Scaffold(

  appBar: AppBar(
    title: Text(widget.album != null ? 'EDITAR ÁLBUM' : 'AGREGAR ÁLBUM'),
    centerTitle: true,
  ),


      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: inputTitle,
                decoration: InputDecoration(
                  hintText: 'Ingrese el titulo del album',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),

              TextField(
                controller: inputSinger,
                decoration: InputDecoration(
                  hintText: 'Ingrese el nombre del cantante',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),

              TextField(
                controller: inputYear,
                decoration: InputDecoration(
                  hintText: 'Ingrese el año del album',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),

              TextField(
                controller: inputPoster,
                decoration: InputDecoration(
                  hintText: 'Ingrese la URL de la imagen',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),

              ElevatedButton(
                onPressed: _editOrAdd,
                style: ElevatedButton.styleFrom(
                  backgroundColor: esEdicion
                      ? const Color.fromARGB(255, 50, 118, 52)
                      : const Color.fromARGB(255, 13, 127, 19),
                ),
                child: Text(
                  esEdicion ? 'GUARDAR CAMBIOS' : 'AGREGAR ÁLBUM',
                  style: const TextStyle(color: Colors.white),
                ),
              ),


              const SizedBox(height: 10),

              if (esEdicion == true)
                  ElevatedButton(
                    onPressed: _delete,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 146, 41, 34),
                    ),
                    child: const Text(
                      'ELIMINAR ÁLBUM',
                      style: TextStyle(color: Colors.white),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}