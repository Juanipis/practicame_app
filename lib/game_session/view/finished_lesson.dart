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
  final List<AnimationController> _controllers = [];
  bool _isDisposed = false;
  int _currentGoldStar = 0;
  int _currentGreenStar = 0;

  // Dynamic properties based on MediaQuery with default values
  int starsPerRow = 5; // Default value
  double starSize = 50; // Default value
  double spacing = 10; // Default value

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _playSound();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startFallingStars(); // Ensure stars are added after initial build
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Calculate based on MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;
    starsPerRow = (screenWidth / 50).floor(); // Adjust based on initial size
    starSize = screenWidth / starsPerRow * 0.8; // Proportional size
    spacing = screenWidth / starsPerRow * 0.2; // Proportional spacing
  }

  @override
  void dispose() {
    _isDisposed = true;

    // Dispose all remaining animation controllers
    for (final controller in List.of(_controllers)) {
      controller.dispose();
    }
    _controllers.clear(); // Clear the list after disposal

    // Stop audio playback safely
    _audioPlayer.stop();
    _audioPlayer.dispose();

    super.dispose();
  }

  Future<void> _playSound() async {
    if (_isDisposed) return;
    await _audioPlayer.play(AssetSource('sounds/win.wav'));
  }

  Future<void> _startFallingStars() async {
    // Add gold stars one by one
    for (var i = 0; i < widget.totalGoldStars; i++) {
      if (_isDisposed) return; // Stop if widget is disposed
      await _addFallingStar(Colors.yellow, i);
      if (_isDisposed) return;
      setState(() {
        _currentGoldStar++;
      });
    }

    // Add green stars one by one
    for (var i = 0; i < widget.totalGreenStars; i++) {
      if (_isDisposed) return; // Stop if widget is disposed
      await _addFallingStar(Colors.green, i + widget.totalGoldStars);
      if (_isDisposed) return;
      setState(() {
        _currentGreenStar++;
      });
    }
  }

  Future<void> _addFallingStar(Color color, int index) async {
    final controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // Track the controller for safe disposal
    _controllers.add(controller);

    final row = index ~/ starsPerRow; // Row in the grid
    final column = index % starsPerRow; // Column in the grid
    final startX = column * (starSize + spacing);
    final startY = row * (starSize + spacing);

    final animation = Tween<double>(
      begin: -100, // Start outside the screen
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

    if (_isDisposed) return;

    setState(() {
      _fixedStars.add(fallingStar);
    });

    await controller.forward();

    if (_isDisposed) return;

    // Once finished, fix the star in place
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

    controller.dispose(); // Dispose controller after use
    _controllers.remove(controller); // Remove the controller from the list
  }

  @override
  Widget build(BuildContext context) {
    final totalStars = widget.totalGoldStars + widget.totalGreenStars;
    final rows = (totalStars / starsPerRow).ceil();

    // Total height based on rows and spacing
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
        Row(
          children: [
            Text('Estrellas doradas ${widget.totalGoldStars}'),
            const Icon(Icons.star, color: Colors.yellow),
          ],
        ),
        Row(
          children: [
            Text('Estrellas verdes ${widget.totalGreenStars}'),
            const Icon(Icons.star, color: Colors.green),
          ],
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          style: AppTheme.greenButtonStyle(),
          onPressed: () {
            Navigator.pop(context); // Close the screen
          },
          child: const Text('Finalizar'),
        ),
      ],
    );
  }
}
