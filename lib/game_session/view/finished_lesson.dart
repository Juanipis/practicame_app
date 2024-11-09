import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:practicame_app/app/view/app_theme.dart';

class FinishedLesson extends StatefulWidget {
  const FinishedLesson({
    required this.totalGoldStars,
    required this.totalGreenStars,
    super.key,
  });
  final int totalGoldStars;
  final int totalGreenStars;

  @override
  State<FinishedLesson> createState() => _FinishedLessonState();
}

class _FinishedLessonState extends State<FinishedLesson>
    with TickerProviderStateMixin {
  late AudioPlayer _audioPlayer;
  final List<Widget> _fixedStars = [];
  int _currentGoldStar = 0;
  int _currentGreenStar = 0;

  // Propiedades dinámicas basadas en MediaQuery con valores predeterminados
  int starsPerRow = 5; // Valor predeterminado
  double starSize = 50; // Valor predeterminado
  double spacing = 10; // Valor predeterminado

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _playSound();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startFallingStars(); // Asegura que las estrellas se añadan después de la construcción inicial
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Cálculos basados en MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;
    starsPerRow =
        (screenWidth / 50).floor(); // Ajusta basado en el tamaño inicial
    starSize = screenWidth / starsPerRow * 0.8; // Tamaño proporcional
    spacing = screenWidth / starsPerRow * 0.2; // Espaciado proporcional
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playSound() async {
    await _audioPlayer.play(AssetSource('sounds/win.wav'));
  }

  Future<void> _startFallingStars() async {
    // Añadimos las estrellas doradas una por una
    for (var i = 0; i < widget.totalGoldStars; i++) {
      await _addFallingStar(Colors.yellow, i);
      setState(() {
        _currentGoldStar++;
      });
    }

    // Añadimos las estrellas verdes una por una
    for (var i = 0; i < widget.totalGreenStars; i++) {
      await _addFallingStar(Colors.green, i + widget.totalGoldStars);
      setState(() {
        _currentGreenStar++;
      });
    }
  }

  Future<void> _addFallingStar(Color color, int index) async {
    final controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    final row = index ~/ starsPerRow; // Fila en la cuadrícula
    final column = index % starsPerRow; // Columna en la cuadrícula
    final startX = column * (starSize + spacing);
    final startY = row * (starSize + spacing);

    final animation = Tween<double>(
      begin: -100, // Inicia fuera de la pantalla
      end: startY,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));

    final fallingStar = AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Positioned(
          top: animation.value,
          left: startX,
          child: Icon(Icons.star, size: starSize, color: color),
        );
      },
    );

    setState(() {
      _fixedStars.add(fallingStar);
    });

    await controller.forward();

    // Una vez finalizada, fija la estrella
    setState(() {
      _fixedStars
        ..remove(fallingStar)
        ..add(
          Positioned(
            top: startY,
            left: startX,
            child: Icon(Icons.star, size: starSize, color: color),
          ),
        );
    });

    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalStars = widget.totalGoldStars + widget.totalGreenStars;
    final rows = (totalStars / starsPerRow).ceil();

    // Altura total basada en filas y espaciado
    final totalHeight = rows * (starSize + spacing);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '¡Felicidades! Has completado la lección',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 20),
        Stack(
          alignment: Alignment.topCenter,
          children: [
            SizedBox(
              height: totalHeight,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: _fixedStars,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          'Estrellas Doradas: $_currentGoldStar',
          style: const TextStyle(fontSize: 18),
        ),
        Text(
          'Estrellas Verdes: $_currentGreenStar',
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          style: AppTheme.greenButtonStyle(),
          onPressed: () {
            Navigator.pop(context); // Cierra la pantalla
          },
          child: const Text('Finalizar'),
        ),
      ],
    );
  }
}
