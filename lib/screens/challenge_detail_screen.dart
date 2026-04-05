// ─── challenge_detail_screen.dart ────────────────────────────────────────────
import 'package:commity_app1/screens/challenge_model_screen.dart';

import 'package:flutter/material.dart';

import '../appcolour.dart';
import 'challenge_join_screen.dart';

class ChallengeDetailScreen extends StatefulWidget {
  final Challenge challenge;
  const ChallengeDetailScreen({super.key, required this.challenge});

  @override
  State<ChallengeDetailScreen> createState() =>
      _ChallengeDetailScreenState();
}

class _ChallengeDetailScreenState extends State<ChallengeDetailScreen> {
  bool _saved = false;

  void _openJoin() => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ChallengeJoinScreen(challenge: widget.challenge),
        ),
      );

  // ═══════════════════════════════════════════════════════════════════════════
  @override
  Widget build(BuildContext context) {
    final c = widget.challenge;
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                _buildHeader(c),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeroImage(c),
                        Padding(
                          padding: const EdgeInsets.all(18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(c.title,
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.text,
                                      height: 1.3)),
                              const SizedBox(height: 6),
                              Text(c.description,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: AppColors.muted,
                                      height: 1.6)),
                              const SizedBox(height: 18),
                              _buildInfoGrid(c),
                              const SizedBox(height: 20),
                              _buildProgressSection(c),
                              const SizedBox(height: 20),
                              _buildSection('🏷️  Tags', _buildTags(c)),
                              const SizedBox(height: 20),
                              _buildSection(
                                  '✅  How it Works', _buildSteps(c)),
                              const SizedBox(height: 20),
                              _buildRewardBanner(c),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Sticky bottom action bar
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildBottomAction(),
            ),
          ],
        ),
      ),
    );
  }

  // ── Header ──────────────────────────────────────────────────────────────────
  Widget _buildHeader(Challenge c) {
    return Container(
      color: AppColors.card,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: AppColors.accentSoft,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_back_ios_new,
                  size: 16, color: AppColors.accent),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              c.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.text),
            ),
          ),
          // Validity chip
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.danger.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Text('⏳', style: TextStyle(fontSize: 11)),
                const SizedBox(width: 4),
                Text(
                  '${c.validity} left',
                  style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.danger),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Hero Image ──────────────────────────────────────────────────────────────
  Widget _buildHeroImage(Challenge c) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.accentSoft, Color(0xFFDFE0FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Text(c.emoji, style: const TextStyle(fontSize: 72)),
      ),
    );
  }

  // ── Info Grid ───────────────────────────────────────────────────────────────
  Widget _buildInfoGrid(Challenge c) {
    final items = [
      {'label': 'Duration',     'value': c.duration,           'icon': '📅'},
      {'label': 'Difficulty',   'value': c.difficulty,         'icon': '⚡'},
      {'label': 'Mode',         'value': c.mode,               'icon': c.mode == 'Online' ? '🌐' : '📍'},
      {'label': 'Valid for',    'value': c.validity,           'icon': '⏳'},
      {'label': 'Participants', 'value': _fmt(c.participants),  'icon': '👥'},
      {'label': 'Suitable for', 'value': c.suitable.join(', '), 'icon': '🎯'},
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2.4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemCount: items.length,
      itemBuilder: (_, i) => _infoBox(items[i]),
    );
  }

  Widget _infoBox(Map<String, String> item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${item['icon']}  ${item['label']}',
            style: const TextStyle(
                fontSize: 10.5,
                color: AppColors.muted,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 2),
          Text(
            item['value']!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w700,
                color: AppColors.text),
          ),
        ],
      ),
    );
  }

  // ── Progress ─────────────────────────────────────────────────────────────────
  Widget _buildProgressSection(Challenge c) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Challenge Progress',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.text)),
              Text(
                '${c.progressPercent}% slots filled',
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.accent),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: c.progressPercent / 100,
              minHeight: 9,
              backgroundColor: AppColors.border,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.accent),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${_fmt(c.participants)} people have already joined',
            style:
                const TextStyle(fontSize: 12, color: AppColors.muted),
          ),
        ],
      ),
    );
  }

  // ── Section wrapper ──────────────────────────────────────────────────────────
  Widget _buildSection(String title, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.text)),
        const SizedBox(height: 10),
        child,
      ],
    );
  }

  // ── Tags ─────────────────────────────────────────────────────────────────────
  Widget _buildTags(Challenge c) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: c.tags
          .map((t) => Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 13, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.accentSoft,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(t,
                    style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: AppColors.accent)),
              ))
          .toList(),
    );
  }

  // ── Steps ─────────────────────────────────────────────────────────────────────
  Widget _buildSteps(Challenge c) {
    return Column(
      children: List.generate(c.steps.length, (i) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  color: AppColors.accentSoft,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text('${i + 1}',
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.accent)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(c.steps[i],
                      style: const TextStyle(
                          fontSize: 13.5,
                          color: AppColors.text,
                          height: 1.5)),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  // ── Reward Banner ─────────────────────────────────────────────────────────────
  Widget _buildRewardBanner(Challenge c) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFF9EC), Color(0xFFFFF3D0)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFDE68A)),
      ),
      child: Row(
        children: [
          const Text('🎁', style: TextStyle(fontSize: 28)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Your Reward',
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.warning,
                        letterSpacing: 0.5)),
                const SizedBox(height: 2),
                Text(c.reward,
                    style: const TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.text)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Bottom Action Bar ─────────────────────────────────────────────────────────
  Widget _buildBottomAction() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: const BoxDecoration(
        color: AppColors.card,
        border:
            Border(top: BorderSide(color: AppColors.border, width: 1.5)),
      ),
      child: Row(
        children: [
          // Bookmark / Save button
          GestureDetector(
            onTap: () => setState(() => _saved = !_saved),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color:
                    _saved ? AppColors.accentSoft : AppColors.bg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: _saved
                        ? AppColors.accent
                        : AppColors.border,
                    width: 1.5),
              ),
              child: Center(
                child: Text(_saved ? '🔖' : '🔗',
                    style: const TextStyle(fontSize: 18)),
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Apply / Join → navigates to ChallengeJoinScreen
          Expanded(
            child: GestureDetector(
              onTap: _openJoin,
              child: Container(
                height: 46,
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    'Apply / Join Challenge 🚀',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: 0.3),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _fmt(int n) =>
      n >= 1000 ? '${(n / 1000).toStringAsFixed(1)}k' : '$n';
}