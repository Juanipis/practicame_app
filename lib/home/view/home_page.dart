import 'package:flutter/material.dart';
import 'package:practicame_app/game/model/game_input.dart';
import 'package:practicame_app/game_session/view/game_session_page.dart';
import 'package:user_repository/user_repository.dart';

GameInput gameInput = GameInput(
  id: 0,
  gameName: 'Write the name',
  question: '¿Cuál es tu nombre?',
  answer: 'Juan Pablo',
  pictogramImage: 'assets/pictograms/name.png',
);

GameInput gameInput2 = GameInput(
  id: 1,
  gameName: 'Write the age',
  question: '¿Cuántos años tienes?',
  answer: '25',
  pictogramImage: 'assets/pictograms/age.png',
);

List<GameInput> games = [gameInput, gameInput2];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _userName;

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final userRepo = UserRepository();
    final prefs = await userRepo.getUser();
    setState(() {
      _userName = prefs.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Column(
        children: [
          Center(
            child: Text(
              '¡Bienvenido, $_userName!',
              style: const TextStyle(fontSize: 24),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<GameSessionPage>(
                builder: (context) => GameSessionPage(games: games),
              ),
            ),
            child: const Text('Jugar'),
          ),
        ],
      ),
    );
  }
}
