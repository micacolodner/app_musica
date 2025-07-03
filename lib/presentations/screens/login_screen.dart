import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login_musica/entities/datos_usuario.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _loginState();
}

Datos user1 = Datos(email: 'micacolodner@gmail.com', password: '1234', nombre: 'Mica', direccion: 'Belgrano');
Datos user2 = Datos(email: 'tomicolodner@gmail.com', password: '5678', nombre: 'Tomas', direccion: 'Almagro');
Datos user3 = Datos(email: 'lola@gmail.com', password: 'ORT', nombre: 'Lola', direccion: 'Caballito');
Datos user4 = Datos(email: 'sebcol@gmail.com', password: 'ABCD', nombre: 'Sebastian', direccion: 'Villa Crespo');
Datos user5 = Datos(email: 'noesaid@gmail.com', password: 'EFGH', nombre: 'Noelia', direccion: 'Palermo');
Datos user6 = Datos(email: 'a', password: 'a', nombre: 'mica', direccion: 'ORT');

class _loginState extends State<Login> {
  final TextEditingController inputEmail = TextEditingController();
  final TextEditingController inputPassword = TextEditingController();
  bool _obscureText = true;

  void confirmacion() {
    List<Datos> users = [user1, user2, user3, user4, user5, user6];
    for (var user in users) {
      if (inputEmail.text == user.email && inputPassword.text == user.password) {
        context.go('/home', extra: user); // ✅ CORREGIDO
        return;
      }
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Contraseña y/o usuario incorrectos.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("LOGIN"), centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(controller: inputEmail, decoration: InputDecoration(hintText: 'Ingrese su usuario', border: OutlineInputBorder())),
              SizedBox(height: 20),
              TextField(
                controller: inputPassword,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  hintText: 'Ingrese su contraseña',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => setState(() => _obscureText = !_obscureText),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: confirmacion, child: const Text('INGRESAR'))
            ],
          ),
        ),
      ),
    );
  }
}