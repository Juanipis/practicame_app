import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

void showCreditsDialog(BuildContext context) {
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
          Text(
            'Universidad EIA',
            style: GoogleFonts.chewy(fontSize: 16),
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
