import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';


// ===== COLORS (TUMHI DILELA NAVIN COLOR PALETTE) =====
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
  static const lavenderBg = Color(0xFFF3E8FF);
  static const textDark = Color(0xFF1F1F1F);
  static const textMuted = Color(0xFF6B7280);
}

// ===== VOLUNTEER SCREEN =====
class VolunteerScreen extends StatefulWidget {
  const VolunteerScreen({super.key});

  @override
  State<VolunteerScreen> createState() => _VolunteerScreenState();
}

class _VolunteerScreenState extends State<VolunteerScreen> {
  String _selectedFilter = 'All';
  final List<String> _filters = [
    'All',
    'Education',
    'Health',
    'Animal',
    'Environment'
  ];

  final List<_VolunteerRole> _roles = [
    _VolunteerRole(
      title: 'Teacher Needed',
      org: 'Bright Futures NGO',
      description:
          'Teach primary school subjects to underprivileged children aged 6–12.',
      requirements: ['Graduate degree', '2 hrs/week', 'Patient & friendly'],
      location: 'Mumbai, Maharashtra',
      category: 'Education',
      icon: Icons.cast_for_education_rounded,
      color: Color(0xFF7C83FD),
      spots: 5,
      deadline: 'Apr 15',
      urgency: 'Urgent',
    ),
    _VolunteerRole(
      title: 'Medical Volunteer',
      org: 'HealthFirst Camp',
      description:
          'Assist doctors at free health camps in rural areas on weekends.',
      requirements: ['Medical background', 'Weekends only', '1 day/month'],
      location: 'Nashik, Maharashtra',
      category: 'Health',
      icon: Icons.local_hospital_rounded,
      color: Color(0xFFEF4444),
      spots: 3,
      deadline: 'Apr 20',
      urgency: 'Open',
    ),
    _VolunteerRole(
      title: 'Animal Care Volunteer',
      org: 'Animal Kaiser Shelter',
      description:
          'Help feed, bathe and care for rescued animals at our shelter.',
      requirements: ['Animal lover', 'Weekends', 'No experience needed'],
      location: 'Pune, Maharashtra',
      category: 'Animal',
      icon: Icons.pets_rounded,
      color: Color(0xFF10B981),
      spots: 10,
      deadline: 'Apr 30',
      urgency: 'Open',
    ),
    _VolunteerRole(
      title: 'Digital Literacy Coach',
      org: 'TechForAll India',
      description:
          'Teach basic computer & smartphone skills to senior citizens.',
      requirements: ['Tech savvy', 'Hindi/Marathi speaker', 'Flexible timing'],
      location: 'Remote / Nashik',
      category: 'Education',
      icon: Icons.computer_rounded,
      color: Color(0xFFF59E0B),
      spots: 8,
      deadline: 'May 5',
      urgency: 'Open',
    ),
    _VolunteerRole(
      title: 'Tree Plantation Drive',
      org: 'Green Earth Warriors',
      description:
          'Join our monthly tree plantation drives across Maharashtra.',
      requirements: ['Physical fitness', '1 day/month', 'Any background'],
      location: 'Maharashtra',
      category: 'Environment',
      icon: Icons.park_rounded,
      color: Color(0xFF059669),
      spots: 50,
      deadline: 'May 1',
      urgency: 'Open',
    ),
  ];

  List<_VolunteerRole> get _filteredRoles {
    if (_selectedFilter == 'All') return _roles;
    return _roles.where((r) => r.category == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bg,
      
      body: Column(
        children: [
          _buildFilters(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              itemCount: _filteredRoles.length,
              itemBuilder: (ctx, i) => _buildRoleCard(ctx, _filteredRoles[i]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return SizedBox(
      height: 52,
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length,
        itemBuilder: (ctx, i) {
          final selected = _selectedFilter == _filters[i];
          return GestureDetector(
            onTap: () => setState(() => _selectedFilter = _filters[i]),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              margin: const EdgeInsets.only(right: 8),
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: selected ? AppColors.accent : AppColors.card,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color:
                        selected ? AppColors.accent : AppColors.border),
              ),
              child: Text(
                _filters[i],
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

  Widget _buildRoleCard(BuildContext context, _VolunteerRole role) {
    final isUrgent = role.urgency == 'Urgent';
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isUrgent ? role.color.withOpacity(0.4) : AppColors.border,
          width: isUrgent ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: role.color.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: role.color.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(role.icon, color: role.color, size: 26),
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
                                  role.title,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.text,
                                  ),
                                ),
                              ),
                              if (isUrgent)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 7, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: AppColors.danger.withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Text(
                                    '🔥 Urgent',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.danger,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 3),
                          Text(
                            role.org,
                            style: const TextStyle(
                                fontSize: 12, color: AppColors.muted),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  role.description,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.muted,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _infoChip(Icons.location_on_rounded, role.location,
                        role.color),
                    _infoChip(Icons.people_rounded,
                        '${role.spots} spots left', role.color),
                    _infoChip(Icons.calendar_today_rounded,
                        'By ${role.deadline}', role.color),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.bg,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Requirements',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.text,
                        ),
                      ),
                      const SizedBox(height: 6),
                      ...role.requirements.map((req) => Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Row(
                              children: [
                                Icon(Icons.check_circle_rounded,
                                    size: 14, color: role.color),
                                const SizedBox(width: 6),
                                Text(
                                  req,
                                  style: const TextStyle(
                                      fontSize: 12, color: AppColors.muted),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _showInterestSheet(context, role),
                    icon:
                        const Icon(Icons.favorite_outline_rounded, size: 16),
                    label: const Text('I\'m Interested'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.accent,
                      side: const BorderSide(color: AppColors.accent),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _showApplySheet(context, role),
                    icon: const Icon(Icons.send_rounded, size: 16),
                    label: const Text('Apply Now'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: role.color,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
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

  Widget _infoChip(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _showInterestSheet(BuildContext context, _VolunteerRole role) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _InterestSheet(role: role),
    );
  }

  void _showApplySheet(BuildContext context, _VolunteerRole role) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => _ApplySheet(role: role),
    );
  }
}

// --- I'm Interested Sheet ---
class _InterestSheet extends StatelessWidget {
  final _VolunteerRole role;
  const _InterestSheet({required this.role});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppColors.accentSoft,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.favorite_rounded,
                color: AppColors.accent, size: 30),
          ),
          const SizedBox(height: 16),
          const Text(
            'Show Interest',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.text),
          ),
          const SizedBox(height: 8),
          Text(
            'We\'ll notify you about updates for\n"${role.title}" at ${role.org}.',
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: AppColors.muted, fontSize: 14, height: 1.5),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        const Text('❤️ Saved! We\'ll keep you updated.'),
                    backgroundColor: AppColors.accent,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                );
              },
              icon: const Icon(Icons.notifications_active_rounded, size: 18),
              label: const Text('Notify Me',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                elevation: 0,
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

// --- Apply Sheet ---
class _ApplySheet extends StatefulWidget {
  final _VolunteerRole role;
  const _ApplySheet({required this.role});

  @override
  State<_ApplySheet> createState() => _ApplySheetState();
}

class _ApplySheetState extends State<_ApplySheet> {
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _msgCtrl = TextEditingController();
  // STEP 1: VARIABLE ADD KELA
  String? _resumeName;

  // STEP 2: FILE PICK FUNCTION ADD KELA
  Future<void> _pickResume() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null) {
      setState(() {
        _resumeName = result.files.single.name;
      });
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _msgCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                      color: AppColors.border,
                      borderRadius: BorderRadius.circular(2))),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: widget.role.color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(widget.role.icon,
                      color: widget.role.color, size: 22),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.role.title,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.text),
                    ),
                    Text(
                      widget.role.org,
                      style: const TextStyle(
                          fontSize: 12, color: AppColors.muted),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            _inputField('Your Name', 'Enter full name', _nameCtrl,
                Icons.person_rounded),
            const SizedBox(height: 12),
            _inputField('Phone Number', 'Enter mobile number', _phoneCtrl,
                Icons.phone_rounded,
                type: TextInputType.phone),
            const SizedBox(height: 12),
            _inputField(
                'Why do you want to volunteer?',
                'Tell us a bit about yourself...',
                _msgCtrl,
                Icons.chat_bubble_outline_rounded,
                maxLines: 3),

            // STEP 3: UI MADHE RESUME UPLOAD BOX ADD KELA
            const SizedBox(height: 14),
            const Text(
              'Upload Resume',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 6),
            GestureDetector(
              onTap: _pickResume,
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.bg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.upload_file_rounded,
                        color: AppColors.accent, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        _resumeName ?? 'Upload your resume (PDF, DOC)',
                        style: TextStyle(
                          fontSize: 13,
                          overflow: TextOverflow.ellipsis,
                          color: _resumeName == null
                              ? AppColors.muted
                              : AppColors.text,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.arrow_forward_ios_rounded,
                        size: 14, color: AppColors.muted),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                // STEP 4: SUBMIT BUTTON VAR VALIDATION LAVLE
                onPressed: () {
                  if (_nameCtrl.text.isEmpty || _phoneCtrl.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill in your name and phone number.'),
                        backgroundColor: AppColors.danger,
                      ),
                    );
                    return;
                  }
                  if (_resumeName == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please upload your resume to apply.'),
                        backgroundColor: AppColors.danger,
                      ),
                    );
                    return;
                  }

                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          '🎉 Applied for ${widget.role.title}! We\'ll contact you soon.'),
                      backgroundColor: widget.role.color,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  );
                },
                icon: const Icon(Icons.send_rounded, size: 18),
                label: const Text('Submit Application',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.role.color,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  elevation: 0,
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _inputField(
    String label,
    String hint,
    TextEditingController ctrl,
    IconData icon, {
    TextInputType type = TextInputType.text,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.text)),
        const SizedBox(height: 6),
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
            style: const TextStyle(fontSize: 14, color: AppColors.text),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: AppColors.muted, fontSize: 13),
              prefixIcon: Icon(icon, size: 18, color: AppColors.accent),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            ),
          ),
        ),
      ],
    );
  }
}

// Data Model
class _VolunteerRole {
  final String title;
  final String org;
  final String description;
  final List<String> requirements;
  final String location;
  final String category;
  final IconData icon;
  final Color color;
  final int spots;
  final String deadline;
  final String urgency;

  const _VolunteerRole({
    required this.title,
    required this.org,
    required this.description,
    required this.requirements,
    required this.location,
    required this.category,
    required this.icon,
    required this.color,
    required this.spots,
    required this.deadline,
    required this.urgency,
  });
}