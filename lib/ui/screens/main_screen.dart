import 'package:flutter/material.dart';
import 'package:unsplash_images/data/factories/screen_factory.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final _screenFactory = ScreenFactory();

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _screenFactory.makePhotoListScreen(),
          _screenFactory.makeCollectionListScreen(),
          _screenFactory.makeUserListScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.photo),
            label: 'Photos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.collections),
            label: 'Collections',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Users',
          ),
        ],
        onTap: _onItemTapped,
        backgroundColor: const Color.fromRGBO(17, 17, 17, 1),
        currentIndex: _selectedIndex,
        unselectedItemColor: const Color.fromRGBO(118, 118, 118, 1),
        selectedItemColor: Colors.white,
      ),
    );
  }
}
