import 'package:application_login/pages/settings/settings.dart';
import 'package:flutter/material.dart';
import '../../widgets/appbar.dart';
import '../../widgets/navigation_drawer.dart';
import '../../widgets/navigation_buttom.dart';
import '../user/user.dart';
import '../auth/login.dart';
import '../customer/customer.dart';

class HomeScreen extends StatefulWidget {
  final String username;
  final String password;

  const HomeScreen({
    super.key,
    required this.username,
    required this.password,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeContent(username: widget.username),
      UserScreen(username: widget.username, password: widget.password),
      SettingsScreen(username: widget.username, password: widget.password),
      CustomerScreen(username: widget.username, password: widget.password),
      _buildEmptyPlaceholder('Notificaciones', Icons.notifications_active),
      _buildEmptyPlaceholder('Ayuda', Icons.help_outline),
      _buildEmptyPlaceholder('Acerca de', Icons.info_outline),
    ];
} 

  void _onDrawerItemSelected(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.jumpToPage(index);
    });
    _scaffoldKey.currentState?.closeDrawer();
  }

  void _logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,  
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: _getTitle(),
        showBackButton: false,
        onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
      ),
      drawer: CustomDrawer(
        username: widget.username,
        onItemSelected: _onDrawerItemSelected,
        onLogout: _logout,
        currentIndex: _currentIndex,
      ),
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.jumpToPage(index);
        },
      ),
    );
  }

  String _getTitle() {
    switch (_currentIndex) {
      case 0:
        return 'Inicio';
      case 1:
        return 'Perfil';
      case 2:
        return 'Configuración';
      case 3:
        return 'Cliente';
      case 4:
        return 'Notificaciones';
      case 5:
        return 'Ayuda';
      case 6:
        return 'Acerca de';
      default:
        return 'Mi Aplicación';
    }
  }
  
  // Método para crear un placeholder para las secciones sin implementar
  Widget _buildEmptyPlaceholder(String title, IconData icon) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 100,
              color: Colors.grey,
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  final String username;

  const HomeContent({super.key, required this.username});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '¡Bienvenido, $username!',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.home, size: 50, color: Colors.blue),
                  SizedBox(height: 20),
                  Text('Esta es la pantalla de inicio de la aplicación.'),
                  SizedBox(height: 20),
                  Text(
                    'Usa el menu lateral o la barra de navegación inferior para explorar las diferentes secciones.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: [
              _buildFeatureCard(Icons.person, 'Perfil', Colors.blue),
              _buildFeatureCard(Icons.settings, 'Configuración', Colors.green),
              _buildFeatureCard(Icons.notifications, 'Notificaciones', Colors.orange),
              _buildFeatureCard(Icons.help, 'Ayuda', Colors.purple),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildFeatureCard(IconData icon, String title, Color color, {VoidCallback? onTap}) {
    return Card(
      elevation: 3,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: color),
              const SizedBox(height: 10),
              Text(
                title, 
                style: const TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}