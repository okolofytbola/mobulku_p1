import 'package:flutter/material.dart';
import 'welcome_screen.dart';
import 'meditate_screen.dart';
import 'organizer_screen.dart';
import 'popular_menu_screen.dart';

void main() => runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: RootScreen()));

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _idx = 0;
  final List<Widget> _pages = const [
    WelcomeScreen(),
    MeditateScreen(),
    OrganizerScreen(),
    PopularMenuScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      body: Center(
        child: Container(
          width: 390,
          height: 844,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(44),
            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 25, offset: Offset(0, 10))],
          ),
          child: Stack(
            children: [
              Positioned.fill(child: _pages[_idx]),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 47,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      width: 156,
                      height: 30,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('9:41', style: TextStyle(fontFamily: 'SF Pro Text', fontSize: 16, fontWeight: FontWeight.w600, color: _idx == 0 ? Colors.white : Colors.black)),
                          Row(
                            children: [
                              Icon(Icons.signal_cellular_alt, size: 17, color: _idx == 0 ? Colors.white : Colors.black),
                              const SizedBox(width: 5),
                              Icon(Icons.wifi, size: 17, color: _idx == 0 ? Colors.white : Colors.black),
                              const SizedBox(width: 5),
                              Icon(Icons.battery_full, size: 20, color: _idx == 0 ? Colors.white : Colors.black),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 8,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 134,
                    height: 5,
                    decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(100)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _idx,
        onDestinationSelected: (i) => setState(() => _idx = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.looks_one_outlined), selectedIcon: Icon(Icons.looks_one), label: 'Простой 1'),
          NavigationDestination(icon: Icon(Icons.looks_two_outlined), selectedIcon: Icon(Icons.looks_two), label: 'Простой 2'),
          NavigationDestination(icon: Icon(Icons.star_outline), selectedIcon: Icon(Icons.star), label: 'Сложный 1'),
          NavigationDestination(icon: Icon(Icons.restaurant_menu), selectedIcon: Icon(Icons.restaurant), label: 'Сложный 2'),
        ],
      ),
    );
  }
}