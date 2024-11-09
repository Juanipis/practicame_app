import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practicame_app/app/view/app.dart';
import 'package:practicame_app/game_session/advanced_games.dart';
import 'package:practicame_app/game_session/starter_games.dart';
import 'package:practicame_app/game_session/view/game_session_page.dart';
import 'package:user_repository/user_repository.dart';
import 'package:practicame_app/teacher/view/teacher_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({required this.userRepository, super.key});
  final UserRepository userRepository;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with RouteAware {
  String? _userName;
  int _goldStars = 0;
  int _greenStars = 0;
  AppMode _appMode = AppMode.unknown;

  @override
  void initState() {
    super.initState();
    _initializeHomeScreen();
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
    _initializeHomeScreen();
  }

  Future<void> _initializeHomeScreen() async {
    final appMode = await widget.userRepository.getAppMode();
    final user = await widget.userRepository.getActiveUser();

    setState(() {
      _appMode = appMode;
      _userName = user?.name ?? '';
      _goldStars = user?.goldStars ?? 0;
      _greenStars = user?.greenStars ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '¡Hola $_userName!',
          style: const TextStyle(fontSize: 24),
        ),
        leading: _appMode == AppMode.teacher
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute<TeacherScreen>(
                      builder: (_) =>
                          TeacherScreen(userRepository: widget.userRepository),
                    ),
                  );
                },
              )
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: _buildStudentMode(),
      ),
    );
  }

  Widget _buildStudentMode() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$_goldStars',
              style: GoogleFonts.chewy(fontSize: 20),
            ),
            const Icon(Icons.star, color: Colors.yellow, size: 24),
            const SizedBox(width: 16),
            Text(
              '$_greenStars',
              style: GoogleFonts.chewy(fontSize: 20),
            ),
            const Icon(Icons.star, color: Colors.green, size: 24),
          ],
        ),
        const SizedBox(height: 25),
        const SizedBox(
          height: 200,
          child: Center(
            child: Image(
              image: AssetImage('assets/brand/person.png'),
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(height: 25),
        Center(
          child: Text(
            '¡Hola $_userName!\n¿Practicamos?',
            style: GoogleFonts.chewy(fontSize: 26),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 25),
        _buildGameModeButton(
          label: 'FÁCIL',
          color: const Color.fromARGB(255, 193, 236, 194),
          borderColor: Colors.green,
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute<GameSessionPage>(
              builder: (context) => GameSessionPage(
                games: starterGames,
                userRepository: widget.userRepository,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildGameModeButton(
          label: 'DIFÍCIL',
          color: const Color.fromARGB(255, 233, 172, 168),
          borderColor: Colors.red,
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute<GameSessionPage>(
              builder: (context) => GameSessionPage(
                games: advancedGames,
                userRepository: widget.userRepository,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGameModeButton({
    required String label,
    required Color color,
    required Color borderColor,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 150,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: borderColor, width: 2),
          ),
        ),
        child: Text(label, style: GoogleFonts.chewy(fontSize: 16)),
      ),
    );
  }
}
