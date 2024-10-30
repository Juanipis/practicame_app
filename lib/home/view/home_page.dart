import 'package:flutter/material.dart';
import 'package:practicame_app/app/view/app.dart';
import 'package:practicame_app/game_session/advanced_games.dart';
import 'package:practicame_app/game_session/starter_games.dart';
import 'package:practicame_app/game_session/view/game_session_page.dart';
import 'package:user_repository/user_repository.dart';

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
                builder: (context) => GameSessionPage(games: starterGames),
              ),
            ),
            child: const Text('Jugar principiante'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<GameSessionPage>(
                builder: (context) => GameSessionPage(games: advancedGames),
              ),
            ),
            child: const Text('Jugar Avanzado'),
          ),
        ],
      ),
    );
  }
}
