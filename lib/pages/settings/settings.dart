import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/theme_provider.dart';
import '../../theme/language_provider.dart';
import '../auth/change_password.dart';
import 'change_email_screen.dart';

class SettingsScreen extends StatefulWidget {
  final String username;
  final String password;
  final String email;
  final bool showAppBar;

  const SettingsScreen({
    super.key,
    required this.username,
    required this.password,
    this.email = '',
    this.showAppBar = true,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late String userEmail;
  bool isDarkMode = false;
  String currentLanguage = 'Español';
  
  @override
  void initState() {
    super.initState();
    userEmail = widget.email;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkCurrentTheme();
  }

  // Verifica el tema actual para establecer el estado inicial de la interfaz
  void _checkCurrentTheme() {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    setState(() {
      isDarkMode = themeProvider.isDarkMode;
    });
  }

  // Cambia el tema de la aplicación al alternar el switch
  void _changeTheme(bool value) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    themeProvider.toggleTheme(value);
    
    setState(() {
      isDarkMode = value;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(value ? 'Tema oscuro activado' : 'Tema claro activado'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Navega a la pantalla de cambio de correo si se cambia se actualiza
  void _navigateToChangeEmail() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ChangeEmailScreen(),
      ),
    );
    
    if (result != null && result is String) {
      setState(() {
        userEmail = result;
      });

      // Muestra mensaje de confirmación
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Correo electrónico actualizado correctamente'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  // Navega a la pantalla de cambio de contraseña
  void _navigateToChangePassword() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ChangePasswordScreen(),
      ),
    );
  }

  // Cambiar el idioma de la aplicación
  void _changeLanguage() {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    
    // Cambiar el idioma actual
    if (currentLanguage == 'Español') {
      setState(() {
        currentLanguage = 'Français';
      });
      languageProvider.toggleLanguage('fr');
    } else {
      setState(() {
        currentLanguage = 'Español';
      });
      languageProvider.toggleLanguage('es');
    }
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Idioma cambiado a $currentLanguage'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: true,
        title: const Text(''),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Sección de cuenta
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Cuenta',
                  style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),
                ),
              ),
              
              // Cambiar correo electrónico
              Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: Icon(Icons.email, color: Theme.of(context).primaryColor),
                  title: const Text('Cambiar correo electrónico'),
                  subtitle: Text('Actualice su dirección de correo electrónico'),
                  trailing: Icon(Icons.chevron_right, color: Theme.of(context).primaryColor),
                  onTap: _navigateToChangeEmail,
                ),
              ),
              
              // Cambiar Contraseña
              Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: Icon(Icons.lock, color: Theme.of(context).primaryColor),
                  title: const Text('Cambiar Contraseña'),
                  subtitle: const Text('Establezca una nueva contraseña segura'),
                  trailing: Icon(Icons.chevron_right, color: Theme.of(context).primaryColor),
                  onTap: _navigateToChangePassword,
                ),
              ),
              
              // Sección de Apariencia
              Padding(
                padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
                child: Text(
                  'Apariencia',
                  style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),
                ),
              ),
              
              // Tema de la App
              Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: Icon(Icons.palette, color: Theme.of(context).primaryColor),
                  title: const Text('Tema de la App'),
                  subtitle: const Text('Personaliza colores y aspecto'),
                  trailing: Switch(
                    value: isDarkMode,
                    onChanged: _changeTheme,
                    activeColor: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              
              // Idioma
              Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: Icon(Icons.language, color: Theme.of(context).primaryColor),
                  title: const Text('Idioma'),
                  subtitle: Text('Seleccione el idioma de la aplicación'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(currentLanguage),
                      Icon(Icons.chevron_right, color: Theme.of(context).primaryColor),
                    ],
                  ),
                  onTap: _changeLanguage,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}