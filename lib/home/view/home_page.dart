import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practicame_app/app/view/app.dart';
import 'package:practicame_app/game_session/advanced_games.dart';
import 'package:practicame_app/game_session/starter_games.dart';
import 'package:practicame_app/game_session/view/game_session_page.dart';
import 'package:url_launcher/url_launcher.dart';
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
      appBar: AppBar(
        title: const Text(
          'Inicio',
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Información del usuario y estrellas
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${_userStars?.goldStars ?? 0}',
                  style: GoogleFonts.chewy(fontSize: 20),
                ),
                const Icon(Icons.star, color: Colors.yellow, size: 24),
                const SizedBox(width: 16),
                Text(
                  '${_userStars?.greenStars ?? 0}',
                  style: GoogleFonts.chewy(fontSize: 20),
                ),
                const Icon(Icons.star, color: Colors.green, size: 24),
              ],
            ),
            const SizedBox(height: 25),

            // Logo del muñeco de Practicame
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

            // Saludo al usuario
            Center(
              child: Text(
                '¡Hola $_userName!\n¿Practicamos?',
                style: GoogleFonts.chewy(fontSize: 26),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 25),

            // Botones para los modos
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

            const Spacer(),

            // Texto "Una app de Aula Abierta"
            // Texto "Una app de Aula Abierta" con logo
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo de Aula Abierta
                const SizedBox(
                  height: 120, // Ajusta el tamaño del logo
                  child: Image(
                    image: AssetImage('assets/brand/logo.png'),
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 8), // Espacio entre logo y texto

                // Texto "Una app de Aula Abierta"
                Text(
                  'Una app de Aula Abierta',
                  style: GoogleFonts.chewy(fontSize: 16),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Botón de Créditos
            SizedBox(
              width: 150,
              child: ElevatedButton(
                onPressed: () {
                  _showCreditsDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 207, 225, 249),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
                child: const Text('CRÉDITOS', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método para crear botones de modo de juego
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

  // Diálogo de Créditos
  void _showCreditsDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Créditos', textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildCreditItem(
              name: 'Juan Pablo Díaz Correa',
              githubUrl: 'https://github.com/juanipis',
            ),
            _buildCreditItem(
              name: 'Susana Uribe Velásquez',
              githubUrl: 'https://github.com/susiur',
            ),
            const SizedBox(height: 16),
            _buildCreditItem(
              name: 'Repositorio del Proyecto',
              githubUrl: 'https://github.com/Juanipis/practicame_app',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

// Widget para un ítem de créditos con nombre y logo de GitHub
  Widget _buildCreditItem({required String name, required String githubUrl}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Nombre de la persona o proyecto
          Flexible(
            child: Text(
              name,
              style: GoogleFonts.chewy(fontSize: 16),
              overflow: TextOverflow.ellipsis, // Maneja nombres largos
            ),
          ),

          // Logo de GitHub con enlace
          GestureDetector(
            onTap: () => _launchUrl(githubUrl),
            child: const Icon(
              Icons.code, // Cambia esto al logo de GitHub si tienes un asset
              size: 28,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

// Método para abrir la URL en el navegador (requiere url_launcher)
  Future<void> _launchUrl(String url) async {
    // Usa url_launcher para abrir el enlace
    await launchUrl(Uri.parse(url));
  }
}
