

// ─── marketplace_screen.dart ────────────────────────────────────────────────── import 'package:community_screen/campaign_review_screen.dart'; import 'package:community_screen/challenge_detail_screen.dart'; import 'package:community_screen/challenge_model_screen.dart'; import 'package:flutter/



import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
 
// ═══════════════════════════════════════════════════════════════════════════
// App Colors
// ═══════════════════════════════════════════════════════════════════════════
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
  static const lavenderBg = Color(0xFFF3E8FF);
  static const textDark = Color(0xFF1F1F1F);
  static const textMuted = Color(0xFF6B7280);
}
 
// ═══════════════════════════════════════════════════════════════════════════
// Campaign Model
// ═══════════════════════════════════════════════════════════════════════════
class CampaignSlot {
  final String id;
  final String campaignName;
  final String orderNo;
  final String clientName;
  final DateTime startTime;
  final DateTime endTime;
  final String brandLogo; // emoji for demo
  final Color color;
 
  CampaignSlot({
    required this.id,
    required this.campaignName,
    required this.orderNo,
    required this.clientName,
    required this.startTime,
    required this.endTime,
    required this.brandLogo,
    required this.color,
  });
 
  String get timeSlot {
    final start = DateFormat('h:mm a').format(startTime);
    final end = DateFormat('h:mm a').format(endTime);
    return '$start - $end';
  }
 
  int get durationMinutes {
    return endTime.difference(startTime).inMinutes;
  }
}
 
// ═══════════════════════════════════════════════════════════════════════════
// Sample Data
// ═══════════════════════════════════════════════════════════════════════════
List<CampaignSlot> _generateSampleCampaigns() {
  final today = DateTime.now();
  final baseDate = DateTime(today.year, today.month, today.day);
 
  return [
    // Today
    CampaignSlot(
      id: '1',
      campaignName: 'Nike Shoe Collection',
      orderNo: '#1234',
      clientName: 'Nike Sports Inc.',
      startTime: baseDate.add(const Duration(hours: 10)),
      endTime: baseDate.add(const Duration(hours: 10, minutes: 20)),
      brandLogo: '👟',
      color: const Color(0xFFFF6B6B),
    ),
    CampaignSlot(
      id: '2',
      campaignName: 'Samsung Galaxy Launch',
      orderNo: '#1235',
      clientName: 'Samsung Electronics',
      startTime: baseDate.add(const Duration(hours: 10, minutes: 30)),
      endTime: baseDate.add(const Duration(hours: 11)),
      brandLogo: '📱',
      color: const Color(0xFF4ECDC4),
    ),
    CampaignSlot(
      id: '3',
      campaignName: 'Coca-Cola Summer Campaign',
      orderNo: '#1236',
      clientName: 'Coca-Cola Company',
      startTime: baseDate.add(const Duration(hours: 11, minutes: 15)),
      endTime: baseDate.add(const Duration(hours: 11, minutes: 45)),
      brandLogo: '🥤',
      color: const Color(0xFFFF4757),
    ),
    CampaignSlot(
      id: '4',
      campaignName: 'Apple Watch Fitness',
      orderNo: '#1237',
      clientName: 'Apple Inc.',
      startTime: baseDate.add(const Duration(hours: 14)),
      endTime: baseDate.add(const Duration(hours: 14, minutes: 30)),
      brandLogo: '⌚',
      color: const Color(0xFF5F27CD),
    ),
    CampaignSlot(
      id: '5',
      campaignName: 'McDonald\'s Happy Meal',
      orderNo: '#1238',
      clientName: 'McDonald\'s Corp.',
      startTime: baseDate.add(const Duration(hours: 15)),
      endTime: baseDate.add(const Duration(hours: 15, minutes: 25)),
      brandLogo: '🍔',
      color: const Color(0xFFFFC312),
    ),
    CampaignSlot(
      id: '6',
      campaignName: 'Tesla Model 3 Showcase',
      orderNo: '#1239',
      clientName: 'Tesla Motors',
      startTime: baseDate.add(const Duration(hours: 16)),
      endTime: baseDate.add(const Duration(hours: 16, minutes: 40)),
      brandLogo: '🚗',
      color: const Color(0xFF0652DD),
    ),
 
    // Tomorrow
    CampaignSlot(
      id: '7',
      campaignName: 'Netflix Original Series',
      orderNo: '#1240',
      clientName: 'Netflix Inc.',
      startTime: baseDate.add(const Duration(days: 1, hours: 9)),
      endTime: baseDate.add(const Duration(days: 1, hours: 9, minutes: 30)),
      brandLogo: '🎬',
      color: const Color(0xFFE50914),
    ),
    CampaignSlot(
      id: '8',
      campaignName: 'Adidas Running Shoes',
      orderNo: '#1241',
      clientName: 'Adidas AG',
      startTime: baseDate.add(const Duration(days: 1, hours: 12)),
      endTime: baseDate.add(const Duration(days: 1, hours: 12, minutes: 35)),
      brandLogo: '👟',
      color: const Color(0xFF00A86B),
    ),
 
    // Day after tomorrow
    CampaignSlot(
      id: '9',
      campaignName: 'Starbucks Holiday Special',
      orderNo: '#1242',
      clientName: 'Starbucks Corporation',
      startTime: baseDate.add(const Duration(days: 2, hours: 10, minutes: 30)),
      endTime: baseDate.add(const Duration(days: 2, hours: 11)),
      brandLogo: '☕',
      color: const Color(0xFF00704A),
    ),
  ];
}
 
// ═══════════════════════════════════════════════════════════════════════════
// Main Screen
// ═══════════════════════════════════════════════════════════════════════════
class CampaignSchedulerScreen extends StatefulWidget {
  const CampaignSchedulerScreen({super.key});
 
  @override
  State<CampaignSchedulerScreen> createState() =>
      _CampaignSchedulerScreenState();
}
 
class _CampaignSchedulerScreenState extends State<CampaignSchedulerScreen> {
  DateTime _selectedDate = DateTime.now();
  final List<CampaignSlot> _allCampaigns = _generateSampleCampaigns();
 
  List<CampaignSlot> get _todayCampaigns {
    return _allCampaigns.where((campaign) {
      return campaign.startTime.year == _selectedDate.year &&
          campaign.startTime.month == _selectedDate.month &&
          campaign.startTime.day == _selectedDate.day;
    }).toList()
      ..sort((a, b) => a.startTime.compareTo(b.startTime));
  }
 
  void _changeDate(int days) {
    setState(() {
      _selectedDate = _selectedDate.add(Duration(days: days));
    });
  }
 
  void _selectDate(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.card,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.text),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Campaign Scheduler',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppColors.text,
          ),
        ),
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.accentSoft,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.add, color: AppColors.accent, size: 20),
            ),
            onPressed: () {
              // Add new campaign
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          _buildCalendarHeader(),
          _buildWeekCalendar(),
          _buildScheduleInfo(),
          Expanded(child: _buildTimeSlots()),
        ],
      ),
    );
  }
 
  // ── Calendar Header ─────────────────────────────────────────────────────────
  Widget _buildCalendarHeader() {
    return Container(
      color: AppColors.card,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('MMMM yyyy').format(_selectedDate),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '${_todayCampaigns.length} campaigns scheduled',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.muted,
                ),
              ),
            ],
          ),
          Row(
            children: [
              _buildNavButton(Icons.chevron_left, () => _changeDate(-1)),
              const SizedBox(width: 8),
              _buildNavButton(Icons.chevron_right, () => _changeDate(1)),
              const SizedBox(width: 8),
              _buildTodayButton(),
            ],
          ),
        ],
      ),
    );
  }
 
  Widget _buildNavButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.accentSoft,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.border),
        ),
        child: Icon(icon, color: AppColors.accent, size: 20),
      ),
    );
  }
 
  Widget _buildTodayButton() {
    final isToday = _selectedDate.year == DateTime.now().year &&
        _selectedDate.month == DateTime.now().month &&
        _selectedDate.day == DateTime.now().day;
 
    return GestureDetector(
      onTap: () => _selectDate(DateTime.now()),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isToday ? AppColors.accent : AppColors.accentSoft,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isToday ? AppColors.accent : AppColors.border,
          ),
        ),
        child: Text(
          'Today',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: isToday ? Colors.white : AppColors.accent,
          ),
        ),
      ),
    );
  }
 
  // ── Week Calendar ───────────────────────────────────────────────────────────
  Widget _buildWeekCalendar() {
    final today = DateTime.now();
    final startOfWeek = _selectedDate.subtract(
      Duration(days: _selectedDate.weekday - 1),
    );
 
    return Container(
      color: AppColors.card,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(7, (index) {
          final date = startOfWeek.add(Duration(days: index));
          final isSelected = date.year == _selectedDate.year &&
              date.month == _selectedDate.month &&
              date.day == _selectedDate.day;
          final isToday = date.year == today.year &&
              date.month == today.month &&
              date.day == today.day;
 
          final campaignsCount = _allCampaigns
              .where((c) =>
                  c.startTime.year == date.year &&
                  c.startTime.month == date.month &&
                  c.startTime.day == date.day)
              .length;
 
          return Expanded(
            child: GestureDetector(
              onTap: () => _selectDate(date),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 3),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.accent
                      : isToday
                          ? AppColors.accentSoft
                          : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.accent
                        : isToday
                            ? AppColors.accent
                            : Colors.transparent,
                    width: isToday && !isSelected ? 1.5 : 0,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      DateFormat('E').format(date).substring(0, 1),
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? Colors.white.withOpacity(0.8)
                            : AppColors.muted,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${date.day}',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: isSelected ? Colors.white : AppColors.text,
                      ),
                    ),
                    if (campaignsCount > 0) ...[
                      const SizedBox(height: 4),
                      Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.white
                              : AppColors.accent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
 
  // ── Schedule Info ───────────────────────────────────────────────────────────
  Widget _buildScheduleInfo() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.accent, AppColors.accent2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.calendar_today,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat('EEEE, MMM d').format(_selectedDate),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _todayCampaigns.isEmpty
                      ? 'No campaigns scheduled'
                      : '${_todayCampaigns.length} campaigns • ${_calculateTotalDuration()} total',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.85),
                  ),
                ),
              ],
            ),
          ),
          if (_todayCampaigns.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '${_todayCampaigns.length}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: AppColors.accent,
                ),
              ),
            ),
        ],
      ),
    );
  }
 
  String _calculateTotalDuration() {
    int totalMinutes = 0;
    for (var campaign in _todayCampaigns) {
      totalMinutes += campaign.durationMinutes;
    }
    if (totalMinutes < 60) {
      return '$totalMinutes mins';
    } else {
      final hours = totalMinutes ~/ 60;
      final mins = totalMinutes % 60;
      return mins > 0 ? '${hours}h ${mins}m' : '${hours}h';
    }
  }
 
  // ── Time Slots ──────────────────────────────────────────────────────────────
  Widget _buildTimeSlots() {
    if (_todayCampaigns.isEmpty) {
      return _buildEmptyState();
    }
 
    return Container(
      color: AppColors.bg,
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        itemCount: _todayCampaigns.length,
        itemBuilder: (context, index) {
          final campaign = _todayCampaigns[index];
          return _buildCampaignCard(campaign);
        },
      ),
    );
  }
 
  Widget _buildCampaignCard(CampaignSlot campaign) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: campaign.color.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // ── Header with time and brand ──
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: campaign.color.withOpacity(0.08),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                // Brand Logo
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: campaign.color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      campaign.brandLogo,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Time and duration
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 14,
                            color: campaign.color,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            campaign.timeSlot,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: campaign.color,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${campaign.durationMinutes} minutes',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.muted,
                        ),
                      ),
                    ],
                  ),
                ),
                // Status badge
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: campaign.color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'LIVE',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
 
          // ── Campaign Details ──
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Campaign name
                Text(
                  campaign.campaignName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.text,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 10),
 
                // Info Pills
                Row(
                  children: [
                    _buildInfoPill(
                      icon: Icons.tag,
                      label: campaign.orderNo,
                      color: AppColors.accent,
                    ),
                    const SizedBox(width: 8),
                    _buildInfoPill(
                      icon: Icons.business,
                      label: campaign.clientName,
                      color: AppColors.success,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
 
                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: _buildActionButton(
                        icon: Icons.visibility,
                        label: 'View Details',
                        color: AppColors.accentSoft,
                        textColor: AppColors.accent,
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildActionButton(
                        icon: Icons.edit,
                        label: 'Edit',
                        color: campaign.color,
                        textColor: Colors.white,
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
 
  Widget _buildInfoPill({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: color.withOpacity(0.3),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
 
  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: textColor),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
 
  // ── Empty State ─────────────────────────────────────────────────────────────
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.accentSoft,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.calendar_today,
              size: 40,
              color: AppColors.accent,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'No campaigns scheduled',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Add a campaign to get started',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.muted,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add),
            label: const Text('Add Campaign'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 14,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
 
