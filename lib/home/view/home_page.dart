import 'package:flutter/material.dart';
import 'package:practicame_app/app/view/app.dart';
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

class _HomeScreenState extends State<HomeScreen> with RouteAware {
  String? _userName;
  UserStars? _userStars;

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _loadUserStars();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    _loadUserStars();
  }

  Future<void> _loadUserName() async {
    final userRepo = UserRepository();
    final prefs = await userRepo.getUser();
    setState(() {
      _userName = prefs.name;
    });
  }

  Future<void> _loadUserStars() async {
    final userRepo = UserRepository();
    final prefs = await userRepo.getUserStars();
    setState(() {
      _userStars = prefs;
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
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Estrellas doradas: '),
              Text('${_userStars?.goldStars ?? 0}'),
              const Icon(Icons.star, color: Colors.yellow),
            ],
          ),
          Row(
            children: [
              const Text('Estrellas verdes: '),
              Text('${_userStars?.greenStars ?? 0}'),
              const Icon(Icons.star, color: Colors.green),
            ],
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
