import 'package:calorie_ai/providers/camera_provider.dart';
import 'package:calorie_ai/screens/profile_screen.dart';
import 'package:calorie_ai/screens/scan_screen.dart';
import 'package:calorie_ai/screens/tracker_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Class which handles scene switching from the
/// NavigationBar buttons
class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 1; // Index to point to each pages

  /// Method that takes the index and stores it to
  /// the _selectedPageIndex
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final firstCamera = Provider.of<CameraProvider>(context).firstCamera;

    Widget activePage =
        const TrackerScreen(); // Set initial activePage as TrackerScreen
    var activePageTitle = ''; // Set initial activePageTitle as ''

    /// Determine which page to show based on
    /// the index of _selectedPageIndex
    if (_selectedPageIndex == 0) {
      activePage = const TrackerScreen();
      activePageTitle = 'Tracker';
    }
    if (_selectedPageIndex == 1) {
      if (firstCamera != null) {
        activePage = ScanScreen(camera: firstCamera);
      } else {
        activePage = const Center(child: Text('No camera available'));
      }
      activePageTitle = 'Scan';
    }
    if (_selectedPageIndex == 2) {
      activePage = const ProfileScreen();
      activePageTitle = 'Profile';
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  Text(
          activePageTitle,
        ),
      ),
      body: activePage, // set the body to the activePage selected
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color.fromARGB(255, 4, 159, 89),
        unselectedItemColor: Colors.grey,
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: 'Tracker',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}