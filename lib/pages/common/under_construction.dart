import 'package:flutter/material.dart';
import '../../widgets/appbar.dart';

// Esta pantalla muestra un mensaje de "En Construcción", se utiliza para funcionalidades que aún no están implementade
class UnderConstructionScreen extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  
  const UnderConstructionScreen({
    super.key, 
    required this.title,
    this.message = 'Esta funcionalidad está en desarrollo',
    this.icon = Icons.construction,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    
    return Scaffold(
      appBar: CustomAppBar(
        title: title,
        showBackButton: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 100,
                color: primaryColor,
              ),
              const SizedBox(height: 20),
              Text(
                'En Construcción',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}