
import 'package:flutter/material.dart';

import '../appcolour.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notificationsOn = true;
  bool _emailUpdatesOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(context),
            _buildImpactStats(),
            _buildBadges(),
            _buildActivitySection(),
            _buildSettingsSection(),
            _buildLogoutButton(context),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ── Hero Header ──────────────────────────────────
  Widget _buildProfileHeader(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        // Gradient banner
        Container(
          height: 200,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF7C83FD), Color(0xFF9EA3FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 44),
                  const Text(
                    'My Profile',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _showEditProfile(context),
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Colors.white.withOpacity(0.3)),
                      ),
                      child: const Icon(Icons.edit_rounded,
                          color: Colors.white, size: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Avatar + name (overlapping)
        Positioned(
          top: 130,
          child: Column(
            children: [
              // Avatar with camera icon
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accent.withOpacity(0.25),
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        )
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 46,
                      backgroundColor: AppColors.accentSoft,
                      child: const Icon(Icons.person_rounded,
                          size: 48, color: AppColors.accent),
                    ),
                  ),
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: AppColors.accent,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.camera_alt_rounded,
                          size: 14, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'Mang Gemblong',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  const Icon(Icons.location_on_rounded,
                      size: 13, color: AppColors.muted),
                  const SizedBox(width: 3),
                  const Text('Nashik, Maharashtra',
                      style:
                          TextStyle(fontSize: 13, color: AppColors.muted)),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [AppColors.accent, AppColors.accent2]),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.verified_rounded,
                        size: 13, color: Colors.white),
                    SizedBox(width: 4),
                    Text('Verified Donor',
                        style: TextStyle(
                            fontSize: 11,
                            color: Colors.white,
                            fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Impact Stats ──────────────────────────────────
  Widget _buildImpactStats() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 220, 20, 0),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('My Impact',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text)),
          const SizedBox(height: 16),
          Row(
            children: [
              _statBox('₹4.2K', 'Total Given', Icons.volunteer_activism_rounded,
                  AppColors.accent),
              const SizedBox(width: 12),
              _statBox('12', 'Donations', Icons.favorite_rounded,
                  Color(0xFFEF4444)),
              const SizedBox(width: 12),
              _statBox('3', 'Volunteered', Icons.people_alt_rounded,
                  Color(0xFF10B981)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _statBox('6', 'Goods Sent', Icons.shopping_bag_rounded,
                  Color(0xFFF59E0B)),
              const SizedBox(width: 12),
              _statBox('2', 'Services', Icons.handshake_rounded,
                  Color(0xFF8B5CF6)),
              const SizedBox(width: 12),
              _statBox('8', 'Causes', Icons.star_rounded,
                  Color(0xFF06B6D4)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statBox(
      String value, String label, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.07),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withOpacity(0.18)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(height: 6),
            Text(value,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color)),
            Text(label,
                style: const TextStyle(
                    fontSize: 10, color: AppColors.muted),
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }

  // ── Badges ──────────────────────────────────
  Widget _buildBadges() {
    final badges = [
      _Badge('First Donor', Icons.military_tech_rounded, Color(0xFFF59E0B)),
      _Badge('Kind Heart', Icons.favorite_rounded, Color(0xFFEF4444)),
      _Badge('Helper', Icons.people_alt_rounded, Color(0xFF10B981)),
      _Badge('Supporter', Icons.star_rounded, Color(0xFF7C83FD)),
    ];
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('My Badges',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text)),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: badges.map((b) => _buildBadge(b)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(_Badge badge) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [badge.color.withOpacity(0.25), badge.color.withOpacity(0.05)],
            ),
            shape: BoxShape.circle,
            border: Border.all(color: badge.color.withOpacity(0.35), width: 2),
          ),
          child: Icon(badge.icon, color: badge.color, size: 26),
        ),
        const SizedBox(height: 6),
        Text(badge.label,
            style: const TextStyle(fontSize: 10, color: AppColors.muted),
            textAlign: TextAlign.center),
      ],
    );
  }

  // ── Recent Activity ──────────────────────────────────
  Widget _buildActivitySection() {
    final activities = [
      _Activity('Donated ₹500', 'Animal Kaiser', '2 days ago',
          Icons.volunteer_activism_rounded, AppColors.accent),
      _Activity('Applied as Teacher', 'Bright Futures NGO', '5 days ago',
          Icons.cast_for_education_rounded, Color(0xFF7C83FD)),
      _Activity('Sent 2 School Bags', 'Hope Foundation', '1 week ago',
          Icons.backpack_rounded, Color(0xFF10B981)),
    ];
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Recent Activity',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text)),
              Text('See All',
                  style: TextStyle(
                      fontSize: 12,
                      color: AppColors.accent,
                      fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 14),
          ...activities.map((a) => _activityRow(a)),
        ],
      ),
    );
  }

  Widget _activityRow(_Activity a) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: a.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(a.icon, color: a.color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(a.title,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.text)),
                Text(a.subtitle,
                    style: const TextStyle(
                        fontSize: 11, color: AppColors.muted)),
              ],
            ),
          ),
          Text(a.time,
              style: const TextStyle(fontSize: 11, color: AppColors.muted)),
        ],
      ),
    );
  }

  // ── Settings ──────────────────────────────────
  Widget _buildSettingsSection() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          _settingToggle(
              Icons.notifications_rounded,
              'Push Notifications',
              'Get notified about campaigns',
              _notificationsOn,
              AppColors.accent,
              (v) => setState(() => _notificationsOn = v)),
          Divider(height: 1, color: AppColors.border),
          _settingToggle(
              Icons.email_rounded,
              'Email Updates',
              'Weekly digest of causes',
              _emailUpdatesOn,
              Color(0xFF10B981),
              (v) => setState(() => _emailUpdatesOn = v)),
          Divider(height: 1, color: AppColors.border),
          _settingTile(Icons.lock_rounded, 'Privacy Settings',
              'Manage data & security', Color(0xFF8B5CF6)),
          Divider(height: 1, color: AppColors.border),
          _settingTile(Icons.help_outline_rounded, 'Help & Support',
              'FAQs and contact us', Color(0xFF06B6D4)),
          Divider(height: 1, color: AppColors.border),
          _settingTile(Icons.info_outline_rounded, 'About DonateGood',
              'Version 1.0.0', Color(0xFFF59E0B)),
        ],
      ),
    );
  }

  Widget _settingToggle(
    IconData icon,
    String title,
    String subtitle,
    bool value,
    Color color,
    ValueChanged<bool> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.text)),
                Text(subtitle,
                    style: const TextStyle(
                        fontSize: 11, color: AppColors.muted)),
              ],
            ),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeColor: color,
          ),
        ],
      ),
    );
  }

  Widget _settingTile(
      IconData icon, String title, String subtitle, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.text)),
                Text(subtitle,
                    style: const TextStyle(
                        fontSize: 11, color: AppColors.muted)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded,
              color: AppColors.muted, size: 20),
        ],
      ),
    );
  }

  // ── Logout ──────────────────────────────────
  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: OutlinedButton.icon(
        onPressed: () => _showLogoutDialog(context),
        icon: const Icon(Icons.logout_rounded, size: 18, color: AppColors.danger),
        label: const Text('Log Out',
            style: TextStyle(
                color: AppColors.danger,
                fontWeight: FontWeight.w600,
                fontSize: 14)),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.danger, width: 1.5),
          padding: const EdgeInsets.symmetric(vertical: 13),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          minimumSize: const Size(double.infinity, 0),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Log Out?',
            style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text(
            'Are you sure you want to log out of DonateGood?',
            style: TextStyle(color: AppColors.muted)),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel',
                  style: TextStyle(color: AppColors.muted))),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.danger,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 0,
            ),
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
  }

  // ── Edit Profile Sheet ──────────────────────────────────
  void _showEditProfile(BuildContext context) {
    final nameCtrl = TextEditingController(text: 'Mang Gemblong');
    final phoneCtrl = TextEditingController(text: '+91 98765 43210');
    final locationCtrl = TextEditingController(text: 'Nashik, Maharashtra');

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => AnimatedPadding(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: Container(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
          decoration: const BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                    width: 44,
                    height: 4,
                    decoration: BoxDecoration(
                        color: AppColors.border,
                        borderRadius: BorderRadius.circular(2))),
              ),
              const SizedBox(height: 18),
              const Text('Edit Profile',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text)),
              const SizedBox(height: 20),
              _editField('Full Name', nameCtrl, Icons.person_rounded),
              const SizedBox(height: 12),
              _editField('Phone', phoneCtrl, Icons.phone_rounded,
                  type: TextInputType.phone),
              const SizedBox(height: 12),
              _editField('Location', locationCtrl, Icons.location_on_rounded),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(ctx),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  child: const Text('Save Changes',
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _editField(String label, TextEditingController ctrl, IconData icon,
      {TextInputType type = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.text)),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: AppColors.bg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: TextField(
            controller: ctrl,
            keyboardType: type,
            style: const TextStyle(fontSize: 14, color: AppColors.text),
            decoration: InputDecoration(
              prefixIcon: Icon(icon, size: 18, color: AppColors.accent),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 12),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Models ──────────────────────────────────
class _Badge {
  final String label;
  final IconData icon;
  final Color color;
  _Badge(this.label, this.icon, this.color);
}

class _Activity {
  final String title;
  final String subtitle;
  final String time;
  final IconData icon;
  final Color color;
  _Activity(this.title, this.subtitle, this.time, this.icon, this.color);
}