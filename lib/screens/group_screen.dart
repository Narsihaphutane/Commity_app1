// lib/screens/groups_screen.dart

import 'package:commity_app1/screens/commity_admin.dart';
import 'package:commity_app1/screens/group_model.dart';
import 'package:commity_app1/screens/group_setting_screen.dart';
import 'package:flutter/material.dart';

// String extension for capitalize
extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}

class SuggestedGroup {
  final String id;
  final String name;
  final String category;
  final String coverUrl;
  final int memberCount;
  final String description;
  final String joiningRule;
  final String visibility;
  bool isJoined;
  bool isLoading;

  SuggestedGroup({
    required this.id,
    required this.name,
    required this.category,
    required this.coverUrl,
    required this.memberCount,
    required this.description,
    this.joiningRule = 'free',
    this.visibility = 'public',
    this.isJoined = false,
    this.isLoading = false,
  });
}

class GroupsScreen extends StatefulWidget {
  final String groupName;
  final String communityId;

  const GroupsScreen({
    super.key,
    required this.groupName,
    required this.communityId,
  });

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Mock data for suggested groups
  final List<SuggestedGroup> _suggestedGroups = [
    SuggestedGroup(
      id: '1',
      name: 'Tech Enthusiasts',
      category: 'technology',
      coverUrl: 'https://picsum.photos/400/200?random=1',
      memberCount: 1200,
      description: 'A community for tech lovers and innovators',
    ),
    SuggestedGroup(
      id: '2',
      name: 'Fitness Warriors',
      category: 'fitness',
      coverUrl: 'https://picsum.photos/400/200?random=2',
      memberCount: 850,
      description: 'Get fit, stay healthy, achieve your goals',
    ),
    SuggestedGroup(
      id: '3',
      name: 'Book Club',
      category: 'reading',
      coverUrl: 'https://picsum.photos/400/200?random=3',
      memberCount: 560,
      description: 'Discuss and discover amazing books together',
    ),
    SuggestedGroup(
      id: '4',
      name: 'Photography Hub',
      category: 'photography',
      coverUrl: 'https://picsum.photos/400/200?random=4',
      memberCount: 920,
      description: 'Share your photos and learn from others',
    ),
  ];

  // Mock data for own communities
  List<Map<String, dynamic>> _ownCommunities = [
    {
      'id': '101',
      'community_title': 'My Startup Community',
      'cover_image': 'https://picsum.photos/200/200?random=101',
      'visibility': 'public',
      'role': 'owner',
      'join_status': 'approved',
    },
    {
      'id': '102',
      'community_title': 'Design Thinking Group',
      'cover_image': 'https://picsum.photos/200/200?random=102',
      'visibility': 'private',
      'role': 'admin',
      'join_status': 'approved',
    },
  ];

  // Mock data for joined communities
  List<Map<String, dynamic>> _joinedCommunities = [
    {
      'id': '201',
      'community_title': 'Flutter Developers',
      'cover_image': 'https://picsum.photos/200/200?random=201',
      'visibility': 'public',
      'role': 'member',
      'join_status': 'approved',
    },
    {
      'id': '202',
      'community_title': 'Entrepreneurship Club',
      'logo': 'https://picsum.photos/200/200?random=202',
      'visibility': 'public',
      'role': 'member',
      'join_status': 'pending',
    },
  ];

  // Mock data for discover tab
  final List<Map<String, dynamic>> _discoverCommunities = [
    {
      'title': 'Startup Hub',
      'members': 1200,
      'joined': false,
      'loading': false,
    },
    {
      'title': 'Tech Geeks',
      'members': 850,
      'joined': false,
      'loading': false,
    },
    {
      'title': 'Flutter Devs',
      'members': 600,
      'joined': false,
      'loading': false,
    },
    {
      'title': 'Fitness Club',
      'members': 430,
      'joined': false,
      'loading': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _searchController.addListener(() {
      setState(
        () => _searchQuery = _searchController.text.trim().toLowerCase(),
      );
    });
  }

  void _joinCommunity(SuggestedGroup group) {
    setState(() {
      group.isLoading = true;
    });

    // Simulate joining
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          group.isJoined = true;
          group.isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Joined successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  String _formatCount(int count) {
    if (count >= 1000) return '${(count / 1000).toStringAsFixed(1)}K';
    return count.toString();
  }

  List<SuggestedGroup> get _filteredSuggested {
    if (_searchQuery.isEmpty) return _suggestedGroups;
    return _suggestedGroups
        .where(
          (g) =>
              g.name.toLowerCase().contains(_searchQuery) ||
              g.category.toLowerCase().contains(_searchQuery) ||
              g.description.toLowerCase().contains(_searchQuery),
        )
        .toList();
  }

  List<Group> get _filteredUserGroups {
    if (_searchQuery.isEmpty) return userCreatedGroups;
    return userCreatedGroups
        .where(
          (g) =>
              g.name.toLowerCase().contains(_searchQuery) ||
              g.privacy.toLowerCase().contains(_searchQuery),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FF),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            // ── Purple Header ──────────────────────────────────────────────
            Container(
              color: const Color(0xff8F7CFF),
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 12,
                left: 16,
                right: 16,
                bottom: 0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Groups',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 150),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GroupSettingScreen(
                                groupName: widget.groupName,
                                privacy: 'Public',
                              ),
                            ),
                          );
                        },
                        child: const Icon(Icons.settings, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  // Search bar
                  Container(
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'Search groups...',
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.white.withOpacity(0.8),
                          size: 20,
                        ),
                        suffixIcon: _searchQuery.isNotEmpty
                            ? GestureDetector(
                                onTap: () => _searchController.clear(),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white.withOpacity(0.8),
                                  size: 18,
                                ),
                              )
                            : null,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Tab bar
                  TabBar(
                    controller: _tabController,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white54,
                    indicatorColor: Colors.white,
                    indicatorWeight: 3,
                    labelStyle: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                    unselectedLabelStyle: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                    tabs: [
                      const Tab(text: 'For You'),
                      Tab(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Your Groups'),
                            if ((_ownCommunities.isNotEmpty) ||
                                (_joinedCommunities.isNotEmpty)) ...[
                              const SizedBox(width: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 1,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  '${_ownCommunities.length + _joinedCommunities.length}',
                                  style: const TextStyle(
                                    color: Color(0xff8F7CFF),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const Tab(text: 'Discover'),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildForYouTab(),
                  _buildYourGroupsTab(),
                  _buildDiscoverTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── For You Tab ────────────────────────────────────────────────────────────
  Widget _buildForYouTab() {
    final groups = _filteredSuggested;
    if (groups.isEmpty) {
      return Center(
        child: Text(
          'No groups found for "$_searchQuery"',
          style: const TextStyle(color: Color(0xFF6B7280), fontSize: 15),
        ),
      );
    }
    final Map<String, List<SuggestedGroup>> byCategory = {};
    for (final g in groups) {
      byCategory.putIfAbsent(g.category, () => []).add(g);
    }
    return ListView(
      padding: const EdgeInsets.only(top: 12, bottom: 24),
      children: byCategory.entries.map((entry) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8E5FF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '#${entry.key}',
                  style: const TextStyle(
                    color: Color(0xff8F7CFF),
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            ...entry.value.map((g) => _buildSuggestedCard(g)),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildSuggestedCard(SuggestedGroup group) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              group.coverUrl,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 120,
                color: const Color(0xFFE8E5FF),
                child: const Center(
                  child: Icon(Icons.group, color: Color(0xff8F7CFF), size: 40),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xff8F7CFF), Color(0xffB5ACFF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: const Icon(Icons.group, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        group.name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        group.description,
                        style: const TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 12,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(
                            Icons.people_outline,
                            size: 13,
                            color: Color(0xFF6B7280),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${_formatCount(group.memberCount)} members',
                            style: const TextStyle(
                              color: Color(0xFF6B7280),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: group.isLoading ? null : () => _joinCommunity(group),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 9,
                    ),
                    decoration: BoxDecoration(
                      color: group.isJoined
                          ? Colors.white
                          : const Color(0xff8F7CFF),
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: const Color(0xff8F7CFF),
                        width: 1.5,
                      ),
                    ),
                    child: group.isLoading
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Color(0xff8F7CFF),
                            ),
                          )
                        : Text(
                            group.isJoined ? 'Joined ✓' : 'Join',
                            style: TextStyle(
                              color: group.isJoined
                                  ? const Color(0xff8F7CFF)
                                  : Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
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

  // ── Your Groups Tab ────────────────────────────────────────────────────────
  Widget _buildYourGroupsTab() {
    final allGroups = [..._ownCommunities, ..._joinedCommunities];

    if (allGroups.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8E5FF),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(
                  Icons.group_add_outlined,
                  color: Color(0xff8F7CFF),
                  size: 40,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'No communities yet',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "You haven't created or joined any communities yet.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF6B7280), fontSize: 14),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, '/create_community'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff8F7CFF),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'Create Community',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: allGroups.length,
      itemBuilder: (context, index) {
        final community = allGroups[index];
        final isOwner = _ownCommunities.contains(community);
        final role = community['role']?.toString() ?? 'member';
        final joinStatus = community['join_status']?.toString() ?? 'approved';

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            leading: CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage(
                community['cover_image'] ??
                    community['logo'] ??
                    'https://picsum.photos/200/200?random=${community['id']}',
              ),
              child:
                  community['cover_image'] == null && community['logo'] == null
                  ? const Icon(Icons.group, color: Color(0xff8F7CFF))
                  : null,
            ),
            title: Text(
              community['community_title'] ?? 'Unknown Community',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                children: [
                  Icon(
                    community['visibility'] == 'private'
                        ? Icons.lock_outline
                        : Icons.public,
                    size: 13,
                    color: const Color(0xFF6B7280),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${community['visibility']?.toString().capitalize() ?? 'Public'} • ${role.capitalize()}',
                    style: const TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 12,
                    ),
                  ),
                  if (joinStatus == 'pending') ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Pending',
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            trailing: isOwner || role == 'admin'
                ? ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CommunityPrivateAdminView(
                          groupName: community['community_title'] ?? '',
                          privacy: community['visibility'] ?? 'public',
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE8E5FF),
                      foregroundColor: const Color(0xff8F7CFF),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Manage',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  )
                : ElevatedButton(
                    onPressed: () {
                      // Show community details
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('View community details'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.withOpacity(0.1),
                      foregroundColor: Colors.grey,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'View',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
          ),
        );
      },
    );
  }

  // ── Discover Tab ───────────────────────────────────────────────────────────
  Widget _buildDiscoverTab() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.85,
      ),
      itemCount: _discoverCommunities.length,
      itemBuilder: (context, index) {
        final data = _discoverCommunities[index];

        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// Image
              Expanded(
                child: Image.network(
                  'https://picsum.photos/300/300?random=${index + 20}',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: const Color(0xFFE8E5FF),
                    child: const Center(
                      child: Icon(
                        Icons.group,
                        color: Color(0xff8F7CFF),
                        size: 36,
                      ),
                    ),
                  ),
                ),
              ),

              /// Content
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    /// Title
                    Text(
                      data['title'],
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 4),

                    /// Members Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.group, size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          '${data['members']} members',
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    /// Join Button
                    SizedBox(
                      width: double.infinity,
                      height: 30,
                      child: ElevatedButton(
                        onPressed: data['loading']
                            ? null
                            : () async {
                                setState(() {
                                  data['loading'] = true;
                                });

                                // Simulate network delay
                                await Future.delayed(
                                  const Duration(milliseconds: 800),
                                );

                                setState(() {
                                  if (!data['joined']) {
                                    data['members']++;
                                    data['joined'] = true;
                                  } else {
                                    data['members']--;
                                    data['joined'] = false;
                                  }
                                  data['loading'] = false;
                                });
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: data['joined']
                              ? const Color(0xFFE8E5FF)
                              : const Color(0xff8F7CFF),
                          foregroundColor: data['joined']
                              ? const Color(0xff8F7CFF)
                              : Colors.white,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          disabledBackgroundColor: Colors.grey.shade300,
                        ),
                        child: data['loading']
                            ? const SizedBox(
                                width: 14,
                                height: 14,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Color(0xff8F7CFF),
                                ),
                              )
                            : Text(
                                data['joined'] ? "Joined ✓" : "Join",
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
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
      },
    );
  }
}