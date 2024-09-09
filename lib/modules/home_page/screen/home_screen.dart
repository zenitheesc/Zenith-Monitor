import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final User? currentUser;

  const HomeScreen({this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zenith Monitor'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (currentUser != null)
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage(currentUser!.photoURL ?? ''),
                      radius: 30,
                    ),
                  const SizedBox(height: 10),
                  Text(
                    currentUser != null
                        ? currentUser!.displayName ?? 'Usuário'
                        : 'Resgate com Bluetooth',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    currentUser != null ? currentUser!.email ?? '' : '',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configurações'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Logout'),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            _buildCard(context, Icons.bluetooth,
                'Acompanhar resgate com bluetooth', '/bluetooth'),
            _buildCard(context, Icons.map, 'Mapa', '/map'),
            _buildCard(
                context, Icons.settings, 'Configurações', '/configuration'),
            _buildCard(context, Icons.terminal, 'Terminal', '/terminal'),
          ],
        ),
      ),
    );
  }
}

Widget _buildCard(
    BuildContext context, IconData icon, String label, String route) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    elevation: 4,
    margin: const EdgeInsets.symmetric(vertical: 10),
    child: ListTile(
      contentPadding: const EdgeInsets.all(16),
      leading: Icon(icon, size: 50, color: Colors.blue),
      title: Text(
        label,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    ),
  );
}
