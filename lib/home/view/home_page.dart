import 'package:flutter/material.dart';
import 'package:practicame_app/app/view/app.dart';
import 'package:practicame_app/game_session/advanced_games.dart';
import 'package:practicame_app/game_session/starter_games.dart';
import 'package:practicame_app/game_session/view/game_session_page.dart';
import 'package:user_repository/user_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({required this.userRepository, super.key});
  final UserRepository userRepository;

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
    final prefs = await widget.userRepository.getUser();
    setState(() {
      _userName = prefs.name;
    });
  }

  Future<void> _loadUserStars() async {
    final prefs = await widget.userRepository.getUserStars();
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
          Row(
            children: [
              Text('${_userStars?.goldStars ?? 0}'),
              const Icon(Icons.star, color: Colors.yellow),
              Text('${_userStars?.greenStars ?? 0}'),
              const Icon(Icons.star, color: Colors.green),
            ],
          ),
          // Row(
          //   children: [
          //     const Text('Estrellas doradas: '),
          //     Text('${_userStars?.goldStars ?? 0}'),
          //     const Icon(Icons.star, color: Colors.yellow),
          //   ],
          // ),
          // Row(
          //   children: [
          //     const Text('Estrellas verdes: '),
          //     Text('${_userStars?.greenStars ?? 0}'),
          //     const Icon(Icons.star, color: Colors.green),
          //   ],
          // ),
          const SizedBox(height: 25),
          const SizedBox(
            height: 300,
            child: Center(
              child: Text(
                '*Aca ponemos el muñeco*',
                style: TextStyle(fontSize: 10),
              ),
            ),
          ),
          Center(
            child: Text(
              'Hola $_userName, practicamos?',
              style: const TextStyle(fontSize: 24),
            ),
          ),
          const SizedBox(height: 25),
          SizedBox(
            width: 150,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<GameSessionPage>(
                  builder: (context) => GameSessionPage(
                    games: starterGames,
                    userRepository: widget.userRepository,
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 193, 236, 194),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: Colors.green, width: 2),
                ),
              ),
              child: const Text('FÁCIL', style: TextStyle(fontSize: 16)),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: 150,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<GameSessionPage>(
                  builder: (context) => GameSessionPage(
                    games: advancedGames,
                    userRepository: widget.userRepository,
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 233, 172, 168),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: Colors.red, width: 2),
                ),
              ),
              child: const Text('DIFÍCIL', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
