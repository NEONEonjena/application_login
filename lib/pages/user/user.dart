import 'package:application_login/theme/theme_app.dart';
import 'package:flutter/material.dart';
import '../../widgets/appbar.dart';

class UserScreen extends StatelessWidget {
  final String username;
  final String password;

  const UserScreen({
    super.key,
    required this.username,
    required this.password,
  });

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(value),
      ],
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const CustomAppBar(title: 'Perfil de usuario', showBackButton: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: CustomTheme.secondaryDark,
                child: Icon(Icons.person, size: 70, color: Colors.white),
              ),
            ),
            const SizedBox(height: 30),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildInfoRow('Usuario:', username),
                    const SizedBox(height: 15),
                    _buildInfoRow('Email:', '$username'),
                    const SizedBox(height: 15),
                    _buildInfoRow('Contraseña:', 
                        '${'*' * password.length} (${password.length} caracteres)'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
