Ninguno seleccionado

Ir al contenido
Uso de Correo de Asociacion ORT Argentina con lectores de pantalla
24 de 710
markdown
Externo
Recibidos

Eva Moreno Cava
19 jun 2025, 13:34 (hace 7 días)
para mí

Here is the instructive, written clearly and concisely for a developer who already has the `Movie` class and UI in place:

---

## 🔄 Managing a `List<Movie>` with `flutter_riverpod`

This guide walks you through setting up local state management for a `List<Movie>` using `flutter_riverpod`. The app already has the UI and a `Movie` class implemented. This is about connecting the data layer.

---

### 1. 🧠 What is a Notifier and a Provider?

* A **Notifier** holds the logic and the actual state. Here, it will contain and manage the `List<Movie>`.
* A **Provider** exposes that notifier to the rest of the app, allowing widgets to *read* and *modify* the movie list.

We’ll use `StateNotifier` and `StateNotifierProvider` for this.

---

### 2. 🛠 Declaring the Notifier and Provider

Create a file like `movie_provider.dart` and add:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'movie.dart'; // your existing Movie class

// 1. Notifier class
class MovieNotifier extends StateNotifier<List<Movie>> {
  MovieNotifier() : super([
    Movie(title: 'The Matrix'),
    Movie(title: 'Inception'),
    Movie(title: 'Interstellar'),
  ]);

  void addMovie(Movie movie) {
    state = [...state, movie];
  }

  void removeMovie(Movie movie) {
    state = state.where((m) => m != movie).toList();
  }
}

// 2. Provider
final movieProvider = StateNotifierProvider<MovieNotifier, List<Movie>>(
  (ref) => MovieNotifier(),
);
```

---

### 3. 🧱 Wrapping the App in ProviderScope

In your `main.dart`, wrap your app with `ProviderScope`:

```dart
void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}
```

This gives access to all providers across the widget tree.

---

### 4. 🧪 Accessing the Movie List in Widgets

To read the list in any widget:

#### If your widget is `StatelessWidget`, change it to `ConsumerWidget`:

```dart
class MovieList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = ref.watch(movieProvider);

    return ListView(
      children: movies.map((movie) => Text(movie.title)).toList(),
    );
  }
}
```

#### If your widget is `StatefulWidget`, change it to `ConsumerStatefulWidget`:

```dart
class MovieForm extends ConsumerStatefulWidget {
  @override
  ConsumerState<MovieForm> createState() => _MovieFormState();
}

class _MovieFormState extends ConsumerState<MovieForm> {
  final controller = TextEditingController();

  void _add() {
    final newMovie = Movie(title: controller.text);
    ref.read(movieProvider.notifier).addMovie(newMovie);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(controller: controller),
        ElevatedButton(onPressed: _add, child: Text('Add Movie')),
      ],
    );
  }
}
```

---

### 5. 📦 What Gets Modified in the Project

* Add the file `movie_provider.dart` with the notifier and provider.
* Wrap the app in `ProviderScope` in `main.dart`.
* Update widgets that depend on the movie list:

  * Use `ConsumerWidget` or `ConsumerStatefulWidget`.
  * Use `ref.watch(movieProvider)` to read the list.
  * Use `ref.read(movieProvider.notifier)` to call methods like `addMovie()`.

---

### ✅ You’re Done

This setup:

* Stores and manages your `List<Movie>` centrally.
* Automatically updates any widget using the provider.
* Can be extended to support editing, sorting, filtering, etc.<!-- slide -->


