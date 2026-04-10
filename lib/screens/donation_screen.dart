import 'package:commity_app1/appcolour.dart';
import 'package:commity_app1/screens/cash_donation_screen.dart' hide AppColors;
// ===== STEP 1: Import your new screen =====

import 'package:commity_app1/screens/create_charity_screen.dart'; 
import 'package:commity_app1/screens/good_donation_screen.dart' hide AppColors;
import 'package:commity_app1/screens/profile_screen.dart';
import 'package:commity_app1/screens/service_screen.dart';
import 'package:commity_app1/screens/volunters_screen.dart' hide AppColors;

import 'package:flutter/material.dart';


class DonationMainScreen extends StatefulWidget {
  const DonationMainScreen({super.key});

  @override
  State<DonationMainScreen> createState() => _DonationMainScreenState();
}

class _DonationMainScreenState extends State<DonationMainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTab = 0;
  int _bottomNavIndex = 0;

  final List<_TabItem> _tabs = [
    _TabItem(icon: Icons.volunteer_activism_rounded, label: 'Cash', color: AppColors.accent),
    _TabItem(icon: Icons.shopping_bag_rounded, label: 'Goods', color: Color(0xFF10B981)),
    _TabItem(icon: Icons.people_alt_rounded, label: 'Volunteer', color: Color(0xFFF59E0B)),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() => _selectedTab = _tabController.index);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: IndexedStack(
        index: _bottomNavIndex,
        children: [
          _buildHomeBody(),
          const ServicesScreen(),
          _buildHistoryBody(),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
      // ===== STEP 2: Add the FloatingActionButton to the Scaffold =====
      // It will only show when the Home tab is selected (_bottomNavIndex == 0)
      floatingActionButton: _bottomNavIndex == 0 ? _buildFab(context) : null,
    );
  }

  // ===== STEP 3: Create a new widget for the FAB =====
  Widget _buildFab(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        // Navigate to the create campaign screen
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const CreateCampaignLightScreen(),
          ),
        );
      },
      backgroundColor: AppColors.accent,
      foregroundColor: Colors.white,
      tooltip: 'Create Campaign',
      child: const Icon(Icons.add_rounded, size: 28),
    );
  }


  // --- Tumche Adhiche Sarva Widgets (No changes below this line) ---

  Widget _buildHomeBody() {
    return Column(
      children: [
        _buildHeader(),
        _buildDonationTabBar(),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              CashDonationScreen(),
              GoodsDonationScreen(),
              VolunteerScreen(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.accent, AppColors.accent2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 12,
        left: 20,
        right: 20,
        bottom: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Hi, Mang 👋',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  const SizedBox(height: 2),
                  Text('Let\'s make a difference today',
                      style: TextStyle(
                          fontSize: 13, color: Colors.white.withOpacity(0.85))),
                ],
              ),
              GestureDetector(
                onTap: () => setState(() => _bottomNavIndex = 3),
                child: CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.white.withOpacity(0.25),
                  child: const Icon(Icons.person_rounded,
                      color: Colors.white, size: 26),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Stats row
          Row(
            children: [
              _statChip(Icons.favorite_rounded, '12', 'Donations'),
              const SizedBox(width: 10),
              _statChip(Icons.volunteer_activism_rounded, '3', 'Volunteered'),
              const SizedBox(width: 10),
              _statChip(Icons.star_rounded, '₹4.2K', 'Given'),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const SizedBox(width: 14),
                Icon(Icons.search_rounded,
                    color: Colors.white.withOpacity(0.8), size: 20),
                const SizedBox(width: 8),
                Text('Search causes...',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.7), fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statChip(IconData icon, String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 14, color: Colors.white),
            const SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                Text(label,
                    style: TextStyle(
                        fontSize: 9,
                        color: Colors.white.withOpacity(0.75))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDonationTabBar() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: List.generate(_tabs.length, (i) {
          final selected = _selectedTab == i;
          return Expanded(
            child: GestureDetector(
              onTap: () => _tabController.animateTo(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: selected ? _tabs[i].color : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(_tabs[i].icon,
                        size: 17,
                        color: selected ? Colors.white : AppColors.muted),
                    const SizedBox(width: 6),
                    Text(
                      _tabs[i].label,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: selected ? Colors.white : AppColors.muted,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildHistoryBody() {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: const Text('Activity History',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text)),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _historyCard('Cash Donation', 'Animal Kaiser', '₹500',
                      Icons.volunteer_activism_rounded, AppColors.accent, '2 days ago'),
                  _historyCard('Goods Donated', 'School Bag × 2', '₹700',
                      Icons.backpack_rounded, Color(0xFF10B981), '5 days ago'),
                  _historyCard('Volunteered', 'Teaching Session', '2 hrs',
                      Icons.cast_for_education_rounded, Color(0xFFF59E0B), '1 week ago'),
                  _historyCard('Cash Donation', 'Orphanage Scholarship', '₹200',
                      Icons.school_rounded, AppColors.accent, '2 weeks ago'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _historyCard(String type, String detail, String amount, IconData icon,
      Color color, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(type,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text)),
                Text(detail,
                    style: const TextStyle(fontSize: 12, color: AppColors.muted)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(amount,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: color)),
              Text(time,
                  style: const TextStyle(fontSize: 11, color: AppColors.muted)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    final items = [
      _NavItem(Icons.home_rounded, 'Home'),
      _NavItem(Icons.handshake_rounded, 'Services'),
      _NavItem(Icons.history_rounded, 'History'),
      _NavItem(Icons.person_rounded, 'Profile'),
    ];
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border(top: BorderSide(color: AppColors.border)),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withOpacity(0.07),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).padding.bottom + 8,
        top: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (i) {
          final active = _bottomNavIndex == i;
          return GestureDetector(
            onTap: () => setState(() => _bottomNavIndex = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: active ? AppColors.accentSoft : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(items[i].icon,
                      size: 22,
                      color: active ? AppColors.accent : AppColors.muted),
                  const SizedBox(height: 3),
                  Text(items[i].label,
                      style: TextStyle(
                          fontSize: 11,
                          color: active ? AppColors.accent : AppColors.muted,
                          fontWeight: active
                              ? FontWeight.w700
                              : FontWeight.normal)),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _TabItem {
  final IconData icon;
  final String label;
  final Color color;
  _TabItem({required this.icon, required this.label, required this.color});
}

class _NavItem {
  final IconData icon;
  final String label;
  _NavItem(this.icon, this.label);
}