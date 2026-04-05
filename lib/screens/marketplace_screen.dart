// ─── marketplace_screen.dart ──────────────────────────────────────────────────
import 'package:commity_app1/appcolour.dart';
import 'package:commity_app1/screens/challenge_detail_screen.dart';
import 'package:commity_app1/screens/challenge_model_screen.dart';

import 'package:flutter/material.dart';



import 'challenge_join_screen.dart';

class MarketplaceScreen3 extends StatefulWidget {
  const MarketplaceScreen3({super.key});

  @override
  State<MarketplaceScreen3> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen3> {
  String _selectedCategory = 'all';
  String _selectedSort = 'popular';
  final TextEditingController _searchCtrl = TextEditingController();

  // ── Filtered + Sorted List ──────────────────────────────────────────────────
  List<Challenge> get _filtered {
    List<Challenge> list = allChallenges.where((c) {
      final matchCat =
          _selectedCategory == 'all' || c.category == _selectedCategory;
      final q = _searchCtrl.text.toLowerCase();
      final matchQ = q.isEmpty ||
          c.title.toLowerCase().contains(q) ||
          c.description.toLowerCase().contains(q) ||
          c.tags.any((t) => t.toLowerCase().contains(q));
      return matchCat && matchQ;
    }).toList();

    if (_selectedSort == 'popular') {
      list.sort((a, b) => b.participants.compareTo(a.participants));
    } else if (_selectedSort == 'newest') {
      list.sort((a, b) => b.id.compareTo(a.id));
    } else if (_selectedSort == 'deadline') {
      list.sort((a, b) => int.parse(a.validity.split(' ')[0])
          .compareTo(int.parse(b.validity.split(' ')[0])));
    } else if (_selectedSort == 'easy') {
      const order = {'Easy': 0, 'Moderate': 1, 'Intermediate': 2, 'Hard': 3};
      list.sort((a, b) =>
          (order[a.difficulty] ?? 99).compareTo(order[b.difficulty] ?? 99));
    }
    return list;
  }

  // ── Navigation ──────────────────────────────────────────────────────────────
  void _openDetail(Challenge c) => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => ChallengeDetailScreen(challenge: c)),
      );

  void _openJoin(Challenge c) => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => ChallengeJoinScreen(challenge: c)),
      );

  // ═══════════════════════════════════════════════════════════════════════════
  @override
  Widget build(BuildContext context) {
    final filtered = _filtered;
    final showFeatured =
        _selectedCategory == 'all' && _searchCtrl.text.isEmpty;

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor:Color(0xFF7C83FD),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.text),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Challenge Marketplace',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppColors.text,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildFilterChips(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                children: [
                  if (showFeatured) ...[
                    const SizedBox(height: 16),
                    _buildSectionLabel('⭐  Featured Challenge'),
                    const SizedBox(height: 10),
                    _buildFeaturedCard(allChallenges[0]),
                    const SizedBox(height: 20),
                  ] else
                    const SizedBox(height: 16),
                  _buildSectionLabel(
                      '${filtered.length} Challenge${filtered.length == 1 ? '' : 's'} Found'),
                  const SizedBox(height: 10),
                  if (filtered.isEmpty)
                    _buildEmptyState()
                  else
                    ...filtered.map((c) => _buildChallengeCard(c)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Header ──────────────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      color: AppColors.card,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Challenge Marketplace',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppColors.text),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Find & join your next challenge',
                    style: TextStyle(fontSize: 12, color: AppColors.muted),
                  ),
                ],
              ),
              Container(
                width: 38,
                height: 38,
                decoration: const BoxDecoration(
                  color: AppColors.accentSoft,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                    child: Text('🔔', style: TextStyle(fontSize: 16))),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Search Bar
          Container(
            decoration: BoxDecoration(
              color: AppColors.bg,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border, width: 1.5),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Row(
              children: [
                const Text('🔍', style: TextStyle(fontSize: 15)),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _searchCtrl,
                    onChanged: (_) => setState(() {}),
                    style: const TextStyle(
                        fontSize: 14, color: AppColors.text),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search challenges...',
                      hintStyle:
                          TextStyle(color: AppColors.muted, fontSize: 14),
                      isDense: true,
                    ),
                  ),
                ),
                if (_searchCtrl.text.isNotEmpty)
                  GestureDetector(
                    onTap: () => setState(() => _searchCtrl.clear()),
                    child: const Icon(Icons.close,
                        size: 18, color: AppColors.muted),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Sort Row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: sortOptions.map((opt) {
                final isActive = _selectedSort == opt['id'];
                return GestureDetector(
                  onTap: () =>
                      setState(() => _selectedSort = opt['id']!),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppColors.accent
                          : AppColors.card,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isActive
                            ? AppColors.accent
                            : AppColors.border,
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      opt['label']!,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isActive ? Colors.white : AppColors.muted,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // ── Filter Chips ────────────────────────────────────────────────────────────
  Widget _buildFilterChips() {
    return Container(
      color: AppColors.card,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: filterCategories.map((cat) {
            final isActive = _selectedCategory == cat['id'];
            return GestureDetector(
              onTap: () =>
                  setState(() => _selectedCategory = cat['id']!),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 7),
                decoration: BoxDecoration(
                  color: isActive
                      ? AppColors.accentSoft
                      : AppColors.card,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isActive
                        ? AppColors.accent
                        : AppColors.border,
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    Text(cat['icon']!,
                        style: const TextStyle(fontSize: 13)),
                    const SizedBox(width: 5),
                    Text(
                      cat['label']!,
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: isActive
                            ? AppColors.accent
                            : AppColors.muted,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // ── Featured Card ───────────────────────────────────────────────────────────
  Widget _buildFeaturedCard(Challenge c) {
    return GestureDetector(
      onTap: () => _openDetail(c),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.accent, AppColors.accent2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -12,
              bottom: -12,
              child: Text(
                c.emoji,
                style: TextStyle(
                    fontSize: 80,
                    color: Colors.white.withOpacity(0.15)),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Editor's pick badge
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.22),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "EDITOR'S PICK",
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: 1),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  c.title,
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.3),
                ),
                const SizedBox(height: 4),
                Text(
                  c.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.85)),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          ...c.suitable
                              .take(2)
                              .map((s) => _fpill(s)),
                          _fpill(c.mode),
                        ],
                      ),
                    ),
                    // Featured Join Now → goes directly to Join screen
                    GestureDetector(
                      onTap: () => _openJoin(c),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Join Now →',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: AppColors.accent),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _fpill(String label) => Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.22),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(label,
            style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.white)),
      );

  // ── Challenge Card ──────────────────────────────────────────────────────────
  Widget _buildChallengeCard(Challenge c) {
    return GestureDetector(
      onTap: () => _openDetail(c),   // Card tap → Detail Screen
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border, width: 1.5),
        ),
        child: Column(
          children: [
            // ── Image Area ──────────────────────────────────────────
            Stack(
              children: [
                Container(
                  height: 130,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.accentSoft, Color(0xFFDFE0FF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(18)),
                  ),
                  child: Center(
                    child: Text(c.emoji,
                        style: const TextStyle(fontSize: 52)),
                  ),
                ),
                if (c.badge.isNotEmpty)
                  Positioned(
                      top: 10,
                      left: 10,
                      child: _badgeWidget(c.badge)),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 9, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.92),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const Text('⏳',
                            style: TextStyle(fontSize: 11)),
                        const SizedBox(width: 4),
                        Text(
                          '${c.validity} left',
                          style: const TextStyle(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                              color: AppColors.warning),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // ── Body ────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(c.title,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.text,
                          height: 1.3)),
                  const SizedBox(height: 4),
                  Text(
                    c.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 12.5,
                        color: AppColors.muted,
                        height: 1.5),
                  ),
                  const SizedBox(height: 10),

                  // Meta Pills
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      _metaPill('👥 ${c.suitable.join(', ')}'),
                      _metaPill(
                          '${c.mode == 'Online' ? '🌐' : '📍'} ${c.mode}',
                          isMode: true,
                          modeOnline: c.mode == 'Online'),
                      _metaPill('📅 ${c.duration}'),
                      _metaPill('⚡ ${c.difficulty}'),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Footer
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text('👥',
                              style: TextStyle(fontSize: 13)),
                          const SizedBox(width: 4),
                          Text(
                            '${_fmt(c.participants)} joined',
                            style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.muted),
                          ),
                        ],
                      ),
                      // Join Now → goes directly to Join screen
                      ElevatedButton(
                        onPressed: () => _openJoin(c),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accent,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          textStyle: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700),
                        ),
                        child: const Text('Join Now'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Helpers ─────────────────────────────────────────────────────────────────
  Widget _badgeWidget(String badge) {
    Color bg;
    if (badge == 'HOT') {
      bg = AppColors.danger;
    } else if (badge == 'NEW') {
      bg = AppColors.success;
    } else {
      bg = AppColors.accent;
    }
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(badge,
          style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: 0.5)),
    );
  }

  Widget _metaPill(String label,
      {bool isMode = false, bool modeOnline = true}) {
    Color textColor = AppColors.text;
    Color borderColor = AppColors.border;
    Color bgColor = AppColors.bg;

    if (isMode && modeOnline) {
      textColor = AppColors.success;
      borderColor = const Color(0xFFA7F3D0);
      bgColor = const Color(0xFFF0FDF8);
    } else if (isMode && !modeOnline) {
      textColor = AppColors.warning;
      borderColor = const Color(0xFFFDE68A);
      bgColor = const Color(0xFFFFFBEB);
    }

    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor),
      ),
      child: Text(label,
          style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: textColor)),
    );
  }

  Widget _buildSectionLabel(String label) => Text(
        label,
        style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: AppColors.muted,
            letterSpacing: 0.6),
      );

  Widget _buildEmptyState() => const Padding(
        padding: EdgeInsets.only(top: 60),
        child: Column(
          children: [
            Text('🔍', style: TextStyle(fontSize: 42)),
            SizedBox(height: 12),
            Text('No challenges found',
                style:
                    TextStyle(color: AppColors.muted, fontSize: 15)),
          ],
        ),
      );

  String _fmt(int n) =>
      n >= 1000 ? '${(n / 1000).toStringAsFixed(1)}k' : '$n';
}