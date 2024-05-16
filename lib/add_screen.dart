import 'package:apiflutter/main.dart';
import 'package:apiflutter/user.dart';
import 'package:apiflutter/user_service.dart';
import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  late Future<List<User>> futureUsers;
  final UserService userService = UserService();

  final TextEditingController tituloController = TextEditingController();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController =
      TextEditingController(); // Added for email
  final TextEditingController pictureController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      appBar: AppBar( backgroundColor: Colors.blueAccent,
        title: const Text('Add Usuário',style: TextStyle(fontWeight: FontWeight.bold)),
         actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back_sharp),
            onPressed: () {
              Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => UserListScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
           _buildAddUserForm(),
        ]
      ),    
    );
  }

   Widget _buildAddUserForm() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          TextFormField(
              controller: firstnameController,
              decoration: InputDecoration(labelText: 'Nome')),
          TextFormField(
              controller: lastnameController,
              decoration: InputDecoration(labelText: 'Sobrenome')),
          TextFormField(
              controller: emailController, // Added email input field
              decoration: InputDecoration(labelText: 'Email')),
              SizedBox(height: 100,),
          ElevatedButton(
            onPressed: _addUser,
            child: Text('Adicionar'),
          ),
        ],
      ),
    );
  }

  void _addUser() {
    if (firstnameController.text.isNotEmpty &&
        lastnameController.text.isNotEmpty &&
        emailController.text.isNotEmpty) {
      userService
          .createUser(User(
        id: '', // ID é gerado pela API, não precisa enviar
        title: tituloController
            .text, // Incluído, assumindo que você ainda quer enviar isso
        firstName: firstnameController.text,
        lastName: lastnameController.text,
        email: emailController.text,
        picture: pictureController.text, // Incluído, assumindo que é necessário
      ))
          .then((newUser) {
        _showSnackbar('Usuário adicionado com sucesso!');
        _refreshUserList();
      }).catchError((error) {
        _showSnackbar('Usuário Falhou: $error');
      });
    } else {
      _showSnackbar('Por favor Preencha todos os Campos.');
    }
  }
void _showSnackbar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
  void _refreshUserList() {
    setState(() {
      futureUsers = userService.getUsers();
    });
  }
}

