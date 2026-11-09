import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:practicame_app/game/model/game_input.dart';
import 'package:user_repository/user_repository.dart';

class EpsGameBody extends StatefulWidget {
  const EpsGameBody({
    required this.gameInput,
    required this.onGameComplete,
    super.key,
  });

  final GameInput gameInput;
  final void Function(int, int) onGameComplete;

  @override
  State<EpsGameBody> createState() => _EpsGameBodyState();
}

class _EpsGameBodyState extends State<EpsGameBody> {
  Logger logger = Logger();
  EPS? selectedEps;
  bool isFirstAttempt =
      true; // Nueva variable para rastrear la primera selección

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final cardWidth = constraints.maxWidth > 600
              ? (constraints.maxWidth - 48) / 3
              : (constraints.maxWidth - 32) / 2;

          return SingleChildScrollView(
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: EPS.values.map((eps) {
                final isSelectedCorrect = eps.name == widget.gameInput.answer;
                final isCurrentSelection = selectedEps == eps;
                final color = isCurrentSelection
                    ? (isSelectedCorrect
                        ? Colors.green // Verde para la respuesta correcta
                        : Colors.red) // Rojo para la respuesta incorrecta
                    : Colors.grey.shade300;

                return SizedBox(
                  width: cardWidth,
                  child: Card(
                    elevation: isCurrentSelection ? 8 : 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: color,
                        width: 2,
                      ),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        setState(() {
                          selectedEps = eps;
                        });

                        if (isSelectedCorrect) {
                          logger.i('Correct answer');
                          widget.onGameComplete(
                            isFirstAttempt ? 1 : 0,
                            isFirstAttempt ? 0 : 1,
                          );
                        } else {
                          logger.i(
                            'Incorrect answer, it should be ${widget.gameInput.answer}',
                          );
                          isFirstAttempt =
                              false; // Marca que ya se hizo un intento
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AspectRatio(
                              aspectRatio: 16 / 9,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    eps.image,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              eps.name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: isCurrentSelection
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: Colors.black87,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
