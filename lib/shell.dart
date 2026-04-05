// lib/app_shell.dart

import 'package:commity_app1/screens/create_post.dart';
import 'package:commity_app1/screens/shorts_screen.dart';
import 'package:flutter/material.dart';
import 'screens/feed_screen.dart';
import 'screens/notification_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/profile_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;

  // Nav index → Stack index mapping
  // Nav:   0=Home  1=Chat  2=Add(skip)  3=Shorts  4=Profile
  // Stack: 0       1       —            2          3
  int get _stackIndex {
    if (_index <= 1) return _index;
    if (_index >= 3) return _index - 1;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ── Body: IndexedStack — screens alive rahtaat ─────────────────
      body: IndexedStack(
        index: _stackIndex,
        children: [
          const FeedScreen(),      // 0 → Home
          ChatListScreen(),        // 1 → Chat
          ShortsScreen(),          // 2 → Shorts (nav index 3)
          ProfileScreen(),         // 3 → Profile (nav index 4)
        ],
      ),

      // ── Bottom Navigation Bar ──────────────────────────────────────
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 12,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 75,
            child: BottomNavigationBar(
              currentIndex: _index,
              onTap: (i) {
                if (i == 2) {
                  // Centre "+" → open create screen, tab change nahi
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => StoryGalleryPickerScreen(),
                    ),
                  );
                  return;
                }
                setState(() => _index = i);
              },
              backgroundColor: Colors.black,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedItemColor: const Color(0xff8F7CFF),
              unselectedItemColor: Colors.white54,
              elevation: 0,
              items: const [
                // 0 – Home
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined, size: 28),
                  activeIcon: Icon(Icons.home_rounded, size: 28),
                  label: '',
                ),
                // 1 – Chat
                BottomNavigationBarItem(
                  icon: Icon(Icons.send_outlined, size: 26),
                  activeIcon: Icon(Icons.send, size: 26),
                  label: '',
                ),
                // 2 – Add (centre)
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.add_circle_outline,
                    size: 34,
                    color: Colors.white,
                  ),
                  activeIcon: Icon(
                    Icons.add_circle_outline,
                    size: 34,
                    color: Colors.white,
                  ),
                  label: '',
                ),
                // 3 – Shorts
                BottomNavigationBarItem(
                  icon: Icon(Icons.play_circle_outline_rounded, size: 28),
                  activeIcon: Icon(Icons.play_circle_rounded, size: 28),
                  label: '',
                ),
                // 4 – Profile
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline, size: 28),
                  activeIcon: Icon(Icons.person, size: 28),
                  label: '',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}