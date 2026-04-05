import 'package:commity_app1/appcolour.dart';
import 'package:flutter/material.dart';


class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All', 'Education', 'Health', 'Legal', 'Tech', 'Animal', 'Environment'
  ];

  final List<_ServicePost> _services = [
    _ServicePost(
      title: 'Primary School Teacher Needed',
      org: 'Bright Futures NGO',
      description:
          'We need passionate teachers to educate underprivileged children aged 6–12 in Hindi, Math & English. Classes held every Saturday morning.',
      category: 'Education',
      icon: Icons.cast_for_education_rounded,
      color: Color(0xFF7C83FD),
      location: 'Nashik, Maharashtra',
      duration: '2 hrs/week',
      spotsLeft: 5,
      deadline: 'Apr 15, 2026',
      skills: ['Teaching', 'Hindi/English', 'Patience'],
      isUrgent: true,
      postedDaysAgo: 1,
    ),
    _ServicePost(
      title: 'Doctor / Health Volunteer',
      org: 'HealthFirst Camp',
      description:
          'Assist our team of doctors at free rural health camps on alternate weekends. MBBS / BAMS / Nursing background required.',
      category: 'Health',
      icon: Icons.local_hospital_rounded,
      color: Color(0xFFEF4444),
      location: 'Trimbak, Nashik',
      duration: '1 day/month',
      spotsLeft: 3,
      deadline: 'Apr 20, 2026',
      skills: ['Medical', 'First Aid', 'Rural experience'],
      isUrgent: true,
      postedDaysAgo: 2,
    ),
    _ServicePost(
      title: 'Legal Aid Volunteer',
      org: 'Justice For All',
      description:
          'Help underprivileged families with basic legal documentation, RTI applications, and awareness drives in rural Maharashtra.',
      category: 'Legal',
      icon: Icons.gavel_rounded,
      color: Color(0xFF8B5CF6),
      location: 'Remote + Field',
      duration: '3 hrs/week',
      spotsLeft: 2,
      deadline: 'May 1, 2026',
      skills: ['LLB / Law student', 'Marathi fluency', 'Documentation'],
      isUrgent: false,
      postedDaysAgo: 3,
    ),
    _ServicePost(
      title: 'Tech Support Volunteer',
      org: 'TechForAll India',
      description:
          'Teach basic smartphone and computer skills to senior citizens and homemakers in semi-urban areas. Remote or in-person both ok.',
      category: 'Tech',
      icon: Icons.devices_rounded,
      color: Color(0xFF06B6D4),
      location: 'Nashik / Remote',
      duration: 'Flexible',
      spotsLeft: 10,
      deadline: 'May 10, 2026',
      skills: ['Tech savvy', 'Hindi/Marathi', 'Communication'],
      isUrgent: false,
      postedDaysAgo: 4,
    ),
    _ServicePost(
      title: 'Animal Shelter Helper',
      org: 'Animal Kaiser',
      description:
          'Help feed, groom, and care for rescued animals at our shelter. No prior experience needed — just compassion for animals!',
      category: 'Animal',
      icon: Icons.pets_rounded,
      color: Color(0xFF10B981),
      location: 'Pune, Maharashtra',
      duration: 'Weekends',
      spotsLeft: 15,
      deadline: 'Apr 30, 2026',
      skills: ['Animal lover', 'Physically active', 'Weekends free'],
      isUrgent: false,
      postedDaysAgo: 2,
    ),
    _ServicePost(
      title: 'Plantation Drive Coordinator',
      org: 'Green Earth Warriors',
      description:
          'Coordinate logistics and volunteers for monthly tree plantation drives across Nashik district. Leadership skills preferred.',
      category: 'Environment',
      icon: Icons.park_rounded,
      color: Color(0xFF059669),
      location: 'Nashik District',
      duration: '1–2 days/month',
      spotsLeft: 4,
      deadline: 'May 5, 2026',
      skills: ['Coordination', 'Leadership', 'Local transport'],
      isUrgent: false,
      postedDaysAgo: 5,
    ),
  ];

  List<_ServicePost> get _filtered =>
      _selectedCategory == 'All'
          ? _services
          : _services.where((s) => s.category == _selectedCategory).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Column(
        children: [
          _buildHeader(),
          _buildCategoryFilter(),
          Expanded(
            child: _filtered.isEmpty
                ? _buildEmpty()
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                    itemCount: _filtered.length,
                    itemBuilder: (ctx, i) => _buildServiceCard(ctx, _filtered[i]),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF7C83FD), Color(0xFF9EA3FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16,
        left: 20,
        right: 20,
        bottom: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Volunteer Services',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 4),
          Text(
            'Find causes that need your skills',
            style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.85)),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _headerStat('${_services.length}', 'Open Roles'),
              const SizedBox(width: 10),
              _headerStat(
                  '${_services.where((s) => s.isUrgent).length}', 'Urgent'),
              const SizedBox(width: 10),
              _headerStat('6', 'Categories'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _headerStat(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.18),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.25)),
        ),
        child: Column(
          children: [
            Text(value,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            Text(label,
                style: TextStyle(
                    fontSize: 10, color: Colors.white.withOpacity(0.8))),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return SizedBox(
      height: 52,
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (ctx, i) {
          final selected = _selectedCategory == _categories[i];
          return GestureDetector(
            onTap: () => setState(() => _selectedCategory = _categories[i]),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: selected ? AppColors.accent : AppColors.card,
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(color: selected ? AppColors.accent : AppColors.border),
                boxShadow: selected
                    ? [
                        BoxShadow(
                            color: AppColors.accent.withOpacity(0.25),
                            blurRadius: 8,
                            offset: const Offset(0, 2))
                      ]
                    : [],
              ),
              child: Text(
                _categories[i],
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: selected ? Colors.white : AppColors.muted,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, _ServicePost s) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: s.isUrgent ? s.color.withOpacity(0.45) : AppColors.border,
          width: s.isUrgent ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: s.color.withOpacity(0.1),
            blurRadius: 18,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Colorful top strip ──
          Container(
            height: 5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [s.color, s.color.withOpacity(0.4)]),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(22),
                topRight: Radius.circular(22),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [s.color.withOpacity(0.15), s.color.withOpacity(0.05)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: s.color.withOpacity(0.2)),
                      ),
                      child: Icon(s.icon, color: s.color, size: 28),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  s.title,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.text,
                                    height: 1.3,
                                  ),
                                ),
                              ),
                              if (s.isUrgent) ...[
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEF4444).withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text('🔥 Urgent',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFEF4444))),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 3),
                          Row(
                            children: [
                              Icon(Icons.verified_rounded,
                                  size: 13, color: AppColors.success),
                              const SizedBox(width: 4),
                              Text(s.org,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.muted,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  s.description,
                  style: const TextStyle(
                      fontSize: 13, color: AppColors.muted, height: 1.5),
                ),
                const SizedBox(height: 14),

                // ── Info chips ──
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _chip(Icons.location_on_rounded, s.location, s.color),
                    _chip(Icons.schedule_rounded, s.duration, s.color),
                    _chip(Icons.group_rounded, '${s.spotsLeft} spots', s.color),
                    _chip(Icons.calendar_today_rounded, s.deadline, s.color),
                  ],
                ),
                const SizedBox(height: 14),

                // ── Skills needed ──
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: s.color.withOpacity(0.04),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: s.color.withOpacity(0.15)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Skills Needed',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: s.color)),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: s.skills.map((skill) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: s.color.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(skill,
                                style: TextStyle(
                                    fontSize: 11,
                                    color: s.color,
                                    fontWeight: FontWeight.w600)),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text('Posted ${s.postedDaysAgo}d ago',
                      style: const TextStyle(
                          fontSize: 11, color: AppColors.muted)),
                ),
              ],
            ),
          ),

          // ── Action buttons ──
          Container(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 16),
            child: Row(
              children: [
                // Interested
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _showInterestSheet(context, s),
                    icon: const Icon(Icons.bookmark_outline_rounded, size: 16),
                    label: const Text("I'm Interested",
                        style: TextStyle(fontSize: 13)),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.accent,
                      side: const BorderSide(color: AppColors.accent, width: 1.5),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Apply
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _showApplySheet(context, s),
                    icon: const Icon(Icons.send_rounded, size: 16),
                    label: const Text('Apply Now',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: s.color,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13)),
                      elevation: 0,
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

  Widget _chip(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.07),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.18)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(text,
              style: TextStyle(
                  fontSize: 11, color: color, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off_rounded, size: 56, color: AppColors.border),
          const SizedBox(height: 12),
          const Text('No services in this category',
              style: TextStyle(color: AppColors.muted, fontSize: 15)),
        ],
      ),
    );
  }

  void _showInterestSheet(BuildContext context, _ServicePost s) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _InterestSheet(service: s),
    );
  }

  void _showApplySheet(BuildContext context, _ServicePost s) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _ApplySheet(service: s),
    );
  }
}

// ────────────────────────────────────────────
//  I'm Interested Bottom Sheet
// ────────────────────────────────────────────
class _InterestSheet extends StatelessWidget {
  final _ServicePost service;
  const _InterestSheet({required this.service});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: const BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28), topRight: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              width: 44,
              height: 4,
              decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 24),
          // Icon
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  service.color.withOpacity(0.18),
                  service.color.withOpacity(0.06)
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(service.icon, color: service.color, size: 34),
          ),
          const SizedBox(height: 16),
          const Text('Save This Role',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text)),
          const SizedBox(height: 8),
          Text(
            '"${service.title}"\nby ${service.org}',
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: AppColors.muted, fontSize: 14, height: 1.5),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.accentSoft,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: const [
                Icon(Icons.notifications_active_rounded,
                    size: 18, color: AppColors.accent),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "We'll notify you of updates, new deadlines, and when ${0} spots are about to fill.",
                    style: TextStyle(
                        fontSize: 12, color: AppColors.accent, height: 1.4),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    side: const BorderSide(color: AppColors.border),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13)),
                  ),
                  child: const Text('Cancel',
                      style: TextStyle(color: AppColors.muted)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('❤️ Saved "${service.title}"'),
                      backgroundColor: AppColors.accent,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ));
                  },
                  icon: const Icon(Icons.bookmark_rounded, size: 16),
                  label: const Text('Save & Notify',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13)),
                    elevation: 0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ────────────────────────────────────────────
//  Apply Bottom Sheet
// ────────────────────────────────────────────
class _ApplySheet extends StatefulWidget {
  final _ServicePost service;
  const _ApplySheet({required this.service});

  @override
  State<_ApplySheet> createState() => _ApplySheetState();
}

class _ApplySheetState extends State<_ApplySheet> {
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _msgCtrl = TextEditingController();
  bool _submitted = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _msgCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
        decoration: const BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28), topRight: Radius.circular(28)),
        ),
        child: _submitted ? _buildSuccess() : _buildForm(),
      ),
    );
  }

  Widget _buildSuccess() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.success.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check_circle_rounded,
              color: AppColors.success, size: 48),
        ),
        const SizedBox(height: 16),
        const Text('Application Sent! 🎉',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.text)),
        const SizedBox(height: 8),
        Text(
          '${widget.service.org} will review your application and contact you within 2–3 days.',
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: AppColors.muted, fontSize: 14, height: 1.5),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.success,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              elevation: 0,
            ),
            child: const Text('Done',
                style:
                    TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
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
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: widget.service.color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(widget.service.icon,
                    color: widget.service.color, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.service.title,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.text),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                    Text(widget.service.org,
                        style: const TextStyle(
                            fontSize: 12, color: AppColors.muted)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _field('Full Name', 'Enter your name', _nameCtrl,
              Icons.person_rounded),
          const SizedBox(height: 12),
          _field('Phone Number', '+91 XXXXX XXXXX', _phoneCtrl,
              Icons.phone_rounded,
              type: TextInputType.phone),
          const SizedBox(height: 12),
          _field('Email Address', 'example@gmail.com', _emailCtrl,
              Icons.email_rounded,
              type: TextInputType.emailAddress),
          const SizedBox(height: 12),
          _field('Why do you want to volunteer?',
              'Tell us about your background & motivation...', _msgCtrl,
              Icons.chat_bubble_outline_rounded,
              maxLines: 3),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                if (_nameCtrl.text.trim().isEmpty) return;
                setState(() => _submitted = true);
              },
              icon: const Icon(Icons.send_rounded, size: 18),
              label: const Text('Submit Application',
                  style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.service.color,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _field(String label, String hint, TextEditingController ctrl,
      IconData icon,
      {TextInputType type = TextInputType.text, int maxLines = 1}) {
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
            maxLines: maxLines,
            style:
                const TextStyle(fontSize: 14, color: AppColors.text),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle:
                  const TextStyle(color: AppColors.muted, fontSize: 13),
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

// ────────────────────────────────────────────
//  Data Model
// ────────────────────────────────────────────
class _ServicePost {
  final String title;
  final String org;
  final String description;
  final String category;
  final IconData icon;
  final Color color;
  final String location;
  final String duration;
  final int spotsLeft;
  final String deadline;
  final List<String> skills;
  final bool isUrgent;
  final int postedDaysAgo;

  const _ServicePost({
    required this.title,
    required this.org,
    required this.description,
    required this.category,
    required this.icon,
    required this.color,
    required this.location,
    required this.duration,
    required this.spotsLeft,
    required this.deadline,
    required this.skills,
    required this.isUrgent,
    required this.postedDaysAgo,
  });
}