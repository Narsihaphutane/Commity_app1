// Add this import at the top of your file
import 'dart:async';
import 'package:commity_app1/model/post_model.dart';
import 'package:commity_app1/screens/cash_donation_screen.dart';
import 'package:commity_app1/screens/create_post.dart';
import 'package:commity_app1/screens/createcommity_screen.dart';
import 'package:commity_app1/screens/donation_screen.dart';
import 'package:commity_app1/screens/good_donation_screen.dart';
import 'package:commity_app1/screens/group_screen.dart';
import 'package:commity_app1/screens/industries_screen.dart';
import 'package:commity_app1/screens/loginscreen.dart';
import 'package:commity_app1/screens/marketplace2_screen.dart';
import 'package:commity_app1/screens/marketplace_screen.dart';
import 'package:commity_app1/screens/notification_screen.dart';
import 'package:commity_app1/screens/opportunity_card.dart';
import 'package:commity_app1/screens/opportunity_screen.dart';
import 'package:commity_app1/screens/post_item.dart';
import 'package:commity_app1/screens/profile_screen.dart';
import 'package:commity_app1/screens/setting_screen.dart';
import 'package:commity_app1/screens/submit_content.dart';
import 'package:commity_app1/screens/templete_picker_screen.dart';
import 'package:commity_app1/screens/volunters_screen.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

// ─── app_colors.dart ─────────────────────────────────────────────────────────
class AppColors {
  static const accent = Color(0xFF7C83FD);
  static const accent2 = Color(0xFF9EA3FF);
  static const accentSoft = Color(0xFFEEEFFF);
  static const bg = Color(0xFFF5F5FF);
  static const card = Color(0xFFFFFFFF);
  static const border = Color(0xFFE4E5FF);
  static const muted = Color(0xFF6B7280);
  static const text = Color(0xFF1A1A2E);
  static const success = Color(0xFF10B981);
  static const danger = Color(0xFFEF4444);
  static const warning = Color(0xFFF59E0B);
}

// ══════════════════════════════════════════════════════════════════════════════
// ── FEED SCREEN WIDGET ────────────────────────────────────────────────────────
// ══════════════════════════════════════════════════════════════════════════════

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> with TickerProviderStateMixin {
  final TextEditingController _commentController = TextEditingController();

  final String _userName = "User";
  final String _userHandle = "@user";

  // Animation controllers for template cards
  late AnimationController _slideController;
  late List<Animation<double>> _cardAnimations;
  late List<Animation<Offset>> _slideAnimations;
  List<Post> globalPosts = [];

  // Auto-scrolling & Dots properties
  final ScrollController _templateScrollController = ScrollController();
  Timer? _autoScrollTimer;
  bool _scrollForward = true;
  int _currentTemplateIndex = 0;

  // ── Template Cards Data ──────────────────────────────────────────────
  final List<_TemplateCard> _templateCards = [
    _TemplateCard(
      label: 'Cash Donation',
      subtitle: 'Donate money to a cause',
      icon: Icons.volunteer_activism_rounded,
      color: Color(0xFF7C83FD),
      bgColor: Color(0xFFF0F1FF),
      emoji: '💸',
      type: 'cash',
    ),
    _TemplateCard(
      label: 'Goods Donation',
      subtitle: 'Donate food & clothes',
      icon: Icons.shopping_bag_rounded,
      color: Color(0xFF7C83FD),
      bgColor: Color(0xFFECFDF5),
      emoji: '🎁',
      type: 'goods',
    ),
    _TemplateCard(
      label: 'Volunteer',
      subtitle: 'Give your time & skills',
      icon: Icons.people_alt_rounded,
      color: Color(0xFF7C83FD),
      bgColor: Color(0xFFFFFBEB),
      emoji: '🤝',
      type: 'volunteer',
    ),
    _TemplateCard(
      label: 'Challenges',
      subtitle: 'Join & earn rewards',
      icon: Icons.emoji_events_rounded,
      color: Color(0xFF7C83FD),
      bgColor: Color(0xFFFDF2F8),
      emoji: '🏆',
      type: 'challenge',
    ),
  ];

  late List<Post> posts;

  @override
  void initState() {
    super.initState();
    _loadDummyPosts();
    _setupAnimations();
    _templateScrollController.addListener(_updateDotsIndicator);
    _startAutoScroll();
  }

  void _setupAnimations() {
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _cardAnimations = List.generate(
      _templateCards.length,
      (index) => Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _slideController,
          curve: Interval(
            index * 0.08,
            0.6 + (index * 0.08),
            curve: Curves.easeOutCubic,
          ),
        ),
      ),
    );

    _slideAnimations = List.generate(
      _templateCards.length,
      (index) =>
          Tween<Offset>(begin: const Offset(0.3, 0), end: Offset.zero).animate(
            CurvedAnimation(
              parent: _slideController,
              curve: Interval(
                index * 0.15,
                0.6 + (index * 0.15),
                curve: Curves.easeOutCubic,
              ),
            ),
          ),
    );

    _slideController.forward();
  }

  void _updateDotsIndicator() {
    if (!_templateScrollController.hasClients) return;
    double offset = _templateScrollController.offset;
    double maxScroll = _templateScrollController.position.maxScrollExtent;
    if (maxScroll <= 0) return;
    int newIndex = 0;
    if (offset >= maxScroll * 0.85) {
      newIndex = 3;
    } else if (offset >= maxScroll * 0.50) {
      newIndex = 2;
    } else if (offset >= maxScroll * 0.15) {
      newIndex = 1;
    } else {
      newIndex = 0;
    }
    if (_currentTemplateIndex != newIndex) {
      setState(() {
        _currentTemplateIndex = newIndex;
      });
    }
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_templateScrollController.hasClients) {
        final double maxScroll =
            _templateScrollController.position.maxScrollExtent;
        if (maxScroll <= 0) return;
        double step = maxScroll / 3;
        if (_scrollForward) {
          if (_currentTemplateIndex < 3) {
            _templateScrollController.animateTo(
              step * (_currentTemplateIndex + 1),
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeInOutCubic,
            );
            if (_currentTemplateIndex == 2) _scrollForward = false;
          }
        } else {
          if (_currentTemplateIndex > 0) {
            _templateScrollController.animateTo(
              step * (_currentTemplateIndex - 1),
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeInOutCubic,
            );
            if (_currentTemplateIndex == 1) _scrollForward = true;
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _templateScrollController.removeListener(_updateDotsIndicator);
    _autoScrollTimer?.cancel();
    _templateScrollController.dispose();
    _slideController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  void _loadDummyPosts() {
    posts = [
      Post(
        id: '1',
        username: 'virat.kohli',
        userImage:
            'https://images.unsplash.com/photo-1546519638-68e109498ffc?w=150',
        isVerified: true,
        postImages: [
          'https://images.unsplash.com/photo-1531415074968-036ba1b575da?w=800',
          'https://images.unsplash.com/photo-1624526267942-ab0ff8a3e972?w=800',
        ],
        likes: 1200,
        caption: 'Practice makes perfect! 🏏',
        timeAgo: '2h',
        comments: 150,
        shares: 890,
      ),
      Post(
        id: '2',
        username: 'rohitsharma45',
        userImage:
            'https://images.unsplash.com/photo-1552374196-1ab2a1c593e8?w=150',
        isVerified: true,
        postImages: [
          'https://images.unsplash.com/photo-1540747913346-19e32dc3e97e?w=800',
        ],
        likes: 950,
        caption: 'New day, new goals! Cricket is life 🏏',
        timeAgo: '5h',
        comments: 80,
        shares: 567,
      ),
    ];
    _addUserPosts();
  }

  void _addUserPosts() {
    try {
      if (globalPosts.isNotEmpty) {
        for (var post in globalPosts.reversed) {
          if (!posts.any((p) => p.id == post.id)) {
            posts.insert(0, post);
          }
        }
      }
    } catch (e) {}
  }

  Future<void> _refreshFeed() async {
    setState(() {
      _loadDummyPosts();
    });
    _slideController.reset();
    _slideController.forward();
  }

  void _deletePost(String postId) {
    setState(() {
      posts.removeWhere((post) => post.id == postId);
      globalPosts.removeWhere((post) => post.id == postId);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Post deleted'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _onTemplateCardTap(_TemplateCard card) {
    Widget screen;
    switch (card.type) {
      case "cash":
        screen = const CashDonationScreen();
        break;
      case "goods":
        screen = const GoodsDonationScreen();
        break;
      case "challenge":
        screen = const ChallengesScreen();
        break;
      default:
        screen = const VolunteerScreen();
    }
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: true,
        transitionDuration: const Duration(milliseconds: 150),
        pageBuilder: (_, __, ___) =>
            Container(color: Colors.white, child: screen),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // ── ANIMATED TEMPLATE SLIDER ───────────────────────────────────────────────
  // ══════════════════════════════════════════════════════════════════════════
  Widget _buildTemplateSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeTransition(
          opacity: _slideController,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.accent, AppColors.accent2],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accent.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.auto_awesome_rounded,
                        color: Colors.white,
                        size: 14,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Quick Actions',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => DonationMainScreen()),
                  ),
                  child: Row(
                    children: const [
                      Text(
                        'See all',
                        style: TextStyle(
                          color: AppColors.accent,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 10,
                        color: AppColors.accent,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 125,
          child: SingleChildScrollView(
            controller: _templateScrollController,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: List.generate(_templateCards.length, (index) {
                final card = _templateCards[index];
                return AnimatedBuilder(
                  animation: _slideController,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _cardAnimations[index],
                      child: SlideTransition(
                        position: _slideAnimations[index],
                        child: _AnimatedTemplateCard(
                          card: card,
                          onTap: () => _onTemplateCardTap(card),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_templateCards.length, (index) {
            bool isActive = _currentTemplateIndex == index;
            final cardColor = _templateCards[index].color;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 6,
              width: isActive ? 24 : 6,
              decoration: BoxDecoration(
                color: isActive
                    ? cardColor
                    : const Color(0xFFD1D5DB).withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
                boxShadow: isActive
                    ? [
                        BoxShadow(
                          color: cardColor.withOpacity(0.6),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : [],
              ),
            );
          }),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  void _openCreateBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFD1D5DB),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Text(
                  'Create',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const Divider(height: 1),
              ListTile(
                leading: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8E5FF),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: const Icon(
                    Icons.edit_outlined,
                    color: Color(0xff8F7CFF),
                    size: 22,
                  ),
                ),
                title: const Text(
                  'Create a post',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                subtitle: const Text(
                  'Share a post on your timeline.',
                  style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => StoryGalleryPickerScreen(),
                    ),
                  ).then((_) {
                    setState(() {
                      _loadDummyPosts();
                    });
                  });
                },
              ),
              ListTile(
                leading: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8E5FF),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: const Icon(
                    Icons.group_add_outlined,
                    color: Color(0xff8F7CFF),
                    size: 22,
                  ),
                ),
                title: const Text(
                  'Create a group',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                subtitle: const Text(
                  'Create a public or private group.',
                  style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CreateCommunityScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  void _openDrawerMenu() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) => const SizedBox(),
      transitionBuilder: (context, animation, _, __) {
        final slide = Tween<Offset>(
          begin: const Offset(-1, 0),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));
        return SlideTransition(
          position: slide,
          child: Align(
            alignment: Alignment.centerLeft,
            child: _buildSideMenu(context),
          ),
        );
      },
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // ── SIDE MENU — overflow fixed, compact sections ───────────────────────────
  // ══════════════════════════════════════════════════════════════════════════
  Widget _buildSideMenu(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.72,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xff8F7CFF),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Compact Profile Header ─────────────────────────────
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: const BoxDecoration(
                  color: Color(0xff7B68EE),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 22, // reduced from 30
                      backgroundImage: NetworkImage(
                        'https://picsum.photos/100/100?random=99',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _userName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15, // reduced from 18
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _userHandle,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 11, // reduced from 13
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // ── Scrollable Menu Items ──────────────────────────────
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(height: 4),
                      _buildDrawerItem(
                        icon: Icons.groups_outlined,
                        label: 'Groups',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const GroupsScreen(
                                groupName: '',
                                communityId: '',
                              ),
                            ),
                          );
                        },
                      ),
                      _buildDrawerItem(
                        icon: Icons.group_add_outlined,
                        label: 'Opportunity',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => OpportunityListScreen(),
                            ),
                          );
                        },
                      ),
                      _buildDrawerItem(
                        icon: Icons.star_border,
                        label: 'Market Places',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const MarketplaceScreen3(),
                            ),
                          );
                        },
                      ),
                      _buildDrawerItem(
                        icon: Icons.person_outline,
                        label: 'Profile',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => ProfileScreen()),
                          );
                        },
                      ),
                      _buildDrawerItem(
                        icon: Icons.notifications_outlined,
                        label: 'Notifications',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => NotificationsScreen(),
                            ),
                          );
                        },
                      ),
                      _buildDrawerItem(
                        icon: Icons.handshake_rounded,
                        label: 'Donation',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DonationMainScreen(),
                            ),
                          );
                        },
                      ),
                      _buildDrawerItem(
                        icon: Icons.pages_rounded,
                        label: 'Resume Template',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TemplatePickerScreen(),
                            ),
                          );
                        },
                      ),
                      _buildDrawerItem(
                        icon: Icons.storefront_outlined,
                        label: 'Marketplace 2',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MarketplaceScreen2(),
                            ),
                          );
                        },
                      ),
                      _buildDrawerItem(
                        icon: Icons.pageview_rounded,
                        label: 'Submit Content',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SubmitCampaignScreen(),
                            ),
                          );
                        },
                      ),
                      _buildDrawerItem(
                        icon: Icons.business_center_outlined,
                        label: 'Industries',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TopicSelectionScreen2(),
                            ),
                          );
                        },
                      ),
                      _buildDrawerItem(
                        icon: Icons.settings_outlined,
                        label: 'Settings',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => SettingsScreen()),
                          );
                        },
                      ),
                      const Divider(
                        color: Colors.white24,
                        height: 8,
                        thickness: 0.5,
                      ),
                      _buildDrawerItem(
                        icon: Icons.logout,
                        label: 'Logout',
                        color: Colors.red.shade100,
                        onTap: () {
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              title: const Text(
                                'Logout',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                              content: const Text(
                                'Are you sure you want to logout?',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF6B7280),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text(
                                    'No',
                                    style: TextStyle(
                                      color: Color(0xff8F7CFF),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff8F7CFF),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => LoginScreen(),
                                      ),
                                      (route) => false,
                                    );
                                  },
                                  child: const Text(
                                    'Yes',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Compact Drawer Item — dense, reduced vertical padding ──────────────────
  Widget _buildDrawerItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color color = Colors.white,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      splashColor: Colors.white12,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 7,
        ), // was default ListTile ~16
        child: Row(
          children: [
            Icon(icon, color: color, size: 20), // reduced from 24
            const SizedBox(width: 12),
            Text(
              label.trim(),
              style: TextStyle(
                color: color,
                fontSize: 13.5, // reduced from 15
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const int adInterval = 4;
    final int totalItems = posts.length + (posts.length ~/ adInterval);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            // ── Top Bar ──────────────────────────────────────────────
            Container(
              color: const Color(0xff8F7CFF),
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 4,
                left: 16,
                right: 16,
                bottom: 4,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: _openDrawerMenu,
                    child: const Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Commity',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          _userName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => NotificationsScreen()),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.notifications_outlined,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                        Positioned(
                          right: 6,
                          top: 6,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ── Feed List ─────────────────────────────────────────────
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshFeed,
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(child: _buildTemplateSlider()),
                    const SliverToBoxAdapter(
                      child: Divider(
                        color: Color(0xFFE6E6F0),
                        thickness: 0.5,
                        height: 0.5,
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        if ((index + 1) % (adInterval + 1) == 0)
                          return _buildAdCard();
                        final postIndex = index - (index ~/ (adInterval + 1));
                        if (postIndex >= posts.length) return null;
                        final post = posts[postIndex];
                        return PostItem(
                          key: ValueKey(post.id),
                          post: post,
                          onLike: () => _handleLike(post.id),
                          onComment: () => _handleComment(post),
                          onShare: () => _handleShare(post),
                          onDelete: () => _deletePost(post.id),
                        );
                      }, childCount: totalItems),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openCreateBottomSheet,
        backgroundColor: const Color(0xff8F7CFF),
        elevation: 4,
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

  Widget _buildAdCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFFFC107).withOpacity(0.2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                "Sponsored",
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF6B7280),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: Image.network(
                "https://picsum.photos/400/300?random=999",
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 180,
                  color: const Color(0xFFF1F2FF),
                  child: const Center(
                    child: Icon(
                      Icons.headphones,
                      size: 60,
                      color: Color(0xFF8F7CFF),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Wireless Earbuds Pro",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "TechBrand Audio",
                  style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
                ),
                const SizedBox(height: 8),
                Row(
                  children: const [
                    Text(
                      "₹1,999",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 6),
                    Text(
                      "₹2,499",
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF6B7280),
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "20% OFF",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF10B981),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: const [
                    Icon(Icons.star, color: Colors.orange, size: 16),
                    SizedBox(width: 4),
                    Text(
                      "4.5",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      "(2,453 reviews)",
                      style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  height: 42,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Opening product details...'),
                          duration: Duration(seconds: 1),
                          backgroundColor: Color(0xFFFFC107),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7C83FD),
                      foregroundColor: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Buy Now",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleLike(String postId) {
    final postIndex = posts.indexWhere((post) => post.id == postId);
    if (postIndex == -1) return;
    final post = posts[postIndex];
    setState(() {
      posts[postIndex] = Post(
        id: post.id,
        username: post.username,
        userImage: post.userImage,
        isVerified: post.isVerified,
        postImages: post.postImages,
        likes: post.isLiked ? post.likes - 1 : post.likes + 1,
        caption: post.caption,
        timeAgo: post.timeAgo,
        comments: post.comments,
        shares: post.shares,
        isLiked: !post.isLiked,
        isBookmarked: post.isBookmarked,
        commentsList: post.commentsList,
      );
    });
  }

  void _handleComment(Post post) => showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => StatefulBuilder(
      builder: (context, setModalState) =>
          _buildCommentSheet(post, setModalState),
    ),
  );

  Widget _buildCommentSheet(Post post, StateSetter setModalState) => Container(
    height: MediaQuery.of(context).size.height * 0.75,
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Color(0xFFE6E6F0), width: 0.5),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 40),
              const Text(
                'Comments',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
        Expanded(
          child: post.commentsList.isEmpty
              ? const Center(
                  child: Text(
                    'No comments yet.\nBe the first to comment!',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF6B7280), fontSize: 14),
                  ),
                )
              : ListView.builder(
                  itemCount: post.commentsList.length,
                  itemBuilder: (context, index) {
                    final comment = post.commentsList[index];
                    return _buildCommentItem(
                      username: comment.username,
                      comment: comment.text,
                      timeAgo: comment.timeAgo,
                      likes: comment.likes,
                    );
                  },
                ),
        ),
        Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: Color(0xFFE6E6F0), width: 0.5),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(
                      'https://picsum.photos/100/100?random=99',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        hintText: 'Add a comment...',
                        hintStyle: TextStyle(color: Color(0xFF6B7280)),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      final text = _commentController.text.trim();
                      if (text.isEmpty) return;
                      final postIndex = posts.indexWhere(
                        (p) => p.id == post.id,
                      );
                      if (postIndex == -1) return;
                      setState(() {
                        posts[postIndex].addComment(
                          Comment(
                            username: 'current_user',
                            userImage:
                                'https://picsum.photos/100/100?random=99',
                            text: text,
                            timeAgo: 'Just now',
                            likes: 0,
                          ),
                        );
                      });
                      _commentController.clear();
                      setModalState(() {});
                    },
                    child: const Text("Post"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _buildCommentItem({
    required String username,
    required String comment,
    required String timeAgo,
    required int likes,
  }) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 18,
          backgroundImage: NetworkImage(
            'https://picsum.photos/100/100?random=${username.hashCode}',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: username,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const TextSpan(text: ' '),
                    TextSpan(
                      text: comment,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    timeAgo,
                    style: const TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    '$likes likes',
                    style: const TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Reply',
                    style: TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.favorite_border,
            size: 14,
            color: Color(0xFF6B7280),
          ),
          onPressed: () {},
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    ),
  );

  void _handleShare(Post post) => showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFF6B7280),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Share',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              Navigator.pop(context);
              await Share.share(
                '${post.username}: ${post.caption}\n${post.postImages.isNotEmpty ? post.postImages[0] : ''}',
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFF25D366),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.chat,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Share on WhatsApp',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
          _buildShareOption(Icons.send_outlined, 'Send in Direct'),
          _buildShareOption(Icons.link, 'Copy link'),
          _buildShareOption(Icons.share_outlined, 'Share to...'),
          _buildShareOption(Icons.bookmark_border, 'Add to favorites'),
          const SizedBox(height: 20),
        ],
      ),
    ),
  );

  Widget _buildShareOption(IconData icon, String label) => InkWell(
    onTap: () {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$label clicked'),
          duration: const Duration(seconds: 1),
          backgroundColor: const Color(0xFF7C83FD),
        ),
      );
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          Icon(icon, color: Colors.black),
          const SizedBox(width: 16),
          Text(
            label,
            style: const TextStyle(color: Colors.black, fontSize: 15),
          ),
        ],
      ),
    ),
  );
}

// ══════════════════════════════════════════════════════════════════════════════
// ── ANIMATED TEMPLATE CARD WIDGET ─────────────────────────────────────────────
// ══════════════════════════════════════════════════════════════════════════════

class _AnimatedTemplateCard extends StatefulWidget {
  final _TemplateCard card;
  final VoidCallback onTap;

  const _AnimatedTemplateCard({required this.card, required this.onTap});

  @override
  State<_AnimatedTemplateCard> createState() => _AnimatedTemplateCardState();
}

class _AnimatedTemplateCardState extends State<_AnimatedTemplateCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeInOut),
    );
    _elevationAnimation = Tween<double>(begin: 1.0, end: 0.5).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => _isPressed = true);
        _hoverController.forward();
      },
      onTapUp: (_) {
        setState(() => _isPressed = false);
        _hoverController.reverse();
        widget.onTap();
      },
      onTapCancel: () {
        setState(() => _isPressed = false);
        _hoverController.reverse();
      },
      child: AnimatedBuilder(
        animation: _hoverController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: 138,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: widget.card.bgColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: widget.card.color.withOpacity(0.5),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: widget.card.color.withOpacity(
                      0.15 * _elevationAnimation.value,
                    ),
                    blurRadius: 10 * _elevationAnimation.value,
                    offset: Offset(0, 4 * _elevationAnimation.value),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0.0, end: 1.0),
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.elasticOut,
                          builder: (context, value, child) {
                            return Transform.scale(
                              scale: value,
                              child: Container(
                                width: 42,
                                height: 42,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: widget.card.color.withOpacity(0.2),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  widget.card.icon,
                                  color: widget.card.color,
                                  size: 22,
                                ),
                              ),
                            );
                          },
                        ),
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0.0, end: 1.0),
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.bounceOut,
                          builder: (context, value, child) {
                            return Transform.scale(
                              scale: value,
                              child: Text(
                                widget.card.emoji,
                                style: const TextStyle(fontSize: 20),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.card.label,
                          style: const TextStyle(
                            color: Color(0xFF1A1A2E),
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.2,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          widget.card.subtitle,
                          style: const TextStyle(
                            color: Color(0xFF6B7280),
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ── Template Card Model ──────────────────────────────────────────────────────
class _TemplateCard {
  final String label;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Color bgColor;
  final String emoji;
  final String type;

  const _TemplateCard({
    required this.label,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.bgColor,
    required this.emoji,
    required this.type,
  });
}

// ══════════════════════════════════════════════════════════════════════════════
// ── CHALLENGES SCREEN ─────────────────────────────────────────────────────────
// ══════════════════════════════════════════════════════════════════════════════
class ChallengesScreen extends StatelessWidget {
  const ChallengesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFEC4899),
        title: const Text("Challenges", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.emoji_events_rounded,
              size: 80,
              color: Color(0xFFEC4899),
            ),
            SizedBox(height: 20),
            Text(
              "Coming Soon!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Join challenges and earn rewards.",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
