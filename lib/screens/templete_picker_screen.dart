import 'package:flutter/material.dart';

// ─── App Colors ───────────────────────────────────────────────────────────────
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

// ─── Template Model ───────────────────────────────────────────────────────────
class ResumeTemplate {
  final String id;
  final String title;
  final String subtitle;
  final String price;
  final bool isFree;
  final Color accentColor;
  final Widget thumbnail;

  const ResumeTemplate({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.isFree,
    required this.accentColor,
    required this.thumbnail,
  });
}

// ─── Template Picker Screen ───────────────────────────────────────────────────
class TemplatePickerScreen extends StatefulWidget {
  const TemplatePickerScreen({Key? key}) : super(key: key);

  @override
  State<TemplatePickerScreen> createState() => _TemplatePickerScreenState();
}

class _TemplatePickerScreenState extends State<TemplatePickerScreen> {
  String? _selectedId;

  late final List<ResumeTemplate> _templates = [
    ResumeTemplate(
      id: 't1',
      title: 'Executive Classic',
      subtitle: 'Mint & Teal · Project Manager',
      price: 'Free',
      isFree: true,
      accentColor: const Color(0xFF2C5F5D),
      thumbnail: const _T1Thumbnail(),
    ),
    ResumeTemplate(
      id: 't2',
      title: 'Modern Clean',
      subtitle: 'Teal Accent · Entry Level',
      price: '₹99',
      isFree: false,
      accentColor: const Color(0xFF4ECDC4),
      thumbnail: const _T2Thumbnail(),
    ),
    ResumeTemplate(
      id: 't3',
      title: 'Dark Sidebar',
      subtitle: 'Blue Accent · Graphic Designer',
      price: '₹149',
      isFree: false,
      accentColor: const Color(0xFF4299E1),
      thumbnail: const _T3Thumbnail(),
    ),
    ResumeTemplate(
      id: 't4',
      title: 'Legal Sage',
      subtitle: 'Sage & Gold · Attorney',
      price: '₹199',
      isFree: false,
      accentColor: const Color(0xFF6B7C6E),
      thumbnail: const _T4Thumbnail(),
    ),
  ];

  ResumeTemplate? get _selected => _selectedId == null
      ? null
      : _templates.firstWhere((t) => t.id == _selectedId);

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(child: _buildGrid()),
          _BottomBar(selected: _selected, paddingBottom: bottom),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.card,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          margin: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: AppColors.accentSoft,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.arrow_back,
            color: AppColors.accent,
            size: 20,
          ),
        ),
      ),
      titleSpacing: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Resume Templates',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: AppColors.text,
            ),
          ),
          Text(
            '${_templates.length} templates available',
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.muted,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0.5),
        child: Container(height: 0.5, color: AppColors.border),
      ),
    );
  }

  Widget _buildGrid() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Row(
            children: [
              Container(
                width: 3,
                height: 16,
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'CHOOSE A TEMPLATE',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppColors.accent,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Padding(
            padding: EdgeInsets.only(left: 11),
            child: Text(
              'Tap a template to preview and select',
              style: TextStyle(fontSize: 11, color: AppColors.muted),
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.60,
            ),
            itemCount: _templates.length,
            itemBuilder: (_, i) => _TemplateCard(
              template: _templates[i],
              isSelected: _selectedId == _templates[i].id,
              onTap: () => setState(() => _selectedId = _templates[i].id),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Template Card ────────────────────────────────────────────────────────────
class _TemplateCard extends StatelessWidget {
  final ResumeTemplate template;
  final bool isSelected;
  final VoidCallback onTap;

  const _TemplateCard({
    required this.template,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.accent : AppColors.border,
            width: isSelected ? 2.5 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.accent.withOpacity(0.18),
                    blurRadius: 16,
                    spreadRadius: 0,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    spreadRadius: 0,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Thumbnail ──
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(14),
                    ),
                    child: SizedBox.expand(
                      child: FittedBox(
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          width: 850,
                          height: 1100,
                          child: template.thumbnail,
                        ),
                      ),
                    ),
                  ),
                  // Badge
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: template.isFree
                            ? const Color(0xFFDCFCE7)
                            : AppColors.accentSoft,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        template.isFree ? 'FREE' : 'PRO',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: template.isFree
                              ? const Color(0xFF15803D)
                              : AppColors.accent,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                  // Checkmark
                  if (isSelected)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        width: 22,
                        height: 22,
                        decoration: const BoxDecoration(
                          color: AppColors.accent,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 13,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // ── Info ──
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.accentSoft : AppColors.card,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(14),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    template.title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? AppColors.accent : AppColors.text,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    template.subtitle,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.muted,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: template.isFree
                              ? const Color(0xFFDCFCE7)
                              : AppColors.accentSoft,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          template.price,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: template.isFree
                                ? const Color(0xFF15803D)
                                : AppColors.accent,
                          ),
                        ),
                      ),
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: template.accentColor,
                          shape: BoxShape.circle,
                        ),
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
}

// ─── Bottom Bar ───────────────────────────────────────────────────────────────
class _BottomBar extends StatelessWidget {
  final ResumeTemplate? selected;
  final double paddingBottom;

  const _BottomBar({required this.selected, required this.paddingBottom});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.card,
        border: Border(top: BorderSide(color: AppColors.border, width: 0.5)),
        boxShadow: [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 12,
            offset: Offset(0, -4),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(16, 14, 16, 14 + paddingBottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Selected chip
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: selected != null
                ? Container(
                    key: ValueKey(selected!.id),
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.accentSoft,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_circle_rounded,
                          size: 15,
                          color: AppColors.success,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Selected: ',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.muted,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            selected!.title,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.accent,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: selected!.isFree
                                ? const Color(0xFFDCFCE7)
                                : AppColors.accentSoft,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: selected!.isFree
                                  ? const Color(0xFF86EFAC)
                                  : AppColors.border,
                            ),
                          ),
                          child: Text(
                            selected!.price,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: selected!.isFree
                                  ? const Color(0xFF15803D)
                                  : AppColors.accent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          // CTA Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: selected != null ? () {} : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                disabledBackgroundColor: AppColors.border,
                foregroundColor: Colors.white,
                disabledForegroundColor: AppColors.muted,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    selected == null
                        ? 'Select a Template'
                        : 'Use This Template',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (selected != null) ...[
                    const SizedBox(width: 6),
                    const Icon(Icons.arrow_forward_rounded, size: 18),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// THUMBNAIL WIDGETS  — fixed 850×1100, overflow-safe
// ═══════════════════════════════════════════════════════════════════════════════

// ─── T1: Executive Classic ────────────────────────────────────────────────────
class _T1Thumbnail extends StatelessWidget {
  const _T1Thumbnail();
  static const mint = Color(0xFFB8DDD4);
  static const teal = Color(0xFF2C5F5D);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 850,
      height: 1100,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Container(width: 160, height: 280, color: mint),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 40, 40, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                const Text(
                  'ROBERT WIX',
                  style: TextStyle(
                    fontSize: 52,
                    fontWeight: FontWeight.w800,
                    color: teal,
                    letterSpacing: 2,
                  ),
                ),
                const Text(
                  'PROJECT MANAGER',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: teal,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 14),
                Container(height: 2, color: teal),
                const SizedBox(height: 16),
                _sec('WORK HISTORY'),
                const SizedBox(height: 8),
                _job(
                  'Project Manager',
                  'DEERSWEATER INC., MINNEAPOLIS, MN',
                  '2018-05 · 2022-05',
                ),
                const SizedBox(height: 10),
                _job(
                  'Assistant Project Manager',
                  'FASHIONOVO, LINCOLN, NE',
                  '2016-04 · 2018-04',
                ),
                const SizedBox(height: 18),
                _sec('EDUCATION'),
                const SizedBox(height: 8),
                _job(
                  'Management Studies, M.Sc.',
                  'KELLOGG SCHOOL OF MANAGEMENT',
                  '2017-09 · 2018-06',
                ),
                const SizedBox(height: 18),
                _sec('SKILLS'),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 16,
                  runSpacing: 8,
                  children: const [
                    _DotChip('Project Planning', teal),
                    _DotChip('Six Sigma', teal),
                    _DotChip('Agile', teal),
                    _DotChip('Scrum', teal),
                    _DotChip('Budget Mgmt', teal),
                  ],
                ),
                const SizedBox(height: 18),
                _sec('CERTIFICATES'),
                const SizedBox(height: 8),
                _job(
                  'Lean Six Sigma Black Belt™',
                  'INTERNATIONAL ASSOCIATION FOR SIX SIGMA',
                  '2021-10',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sec(String t) => Text(
    t,
    style: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: teal,
      letterSpacing: 1.5,
    ),
  );

  Widget _job(String title, String org, String date) => Padding(
    padding: const EdgeInsets.only(bottom: 2),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: teal,
          ),
        ),
        Text(
          org,
          style: const TextStyle(fontSize: 10, color: teal),
          overflow: TextOverflow.ellipsis,
        ),
        Text(date, style: const TextStyle(fontSize: 9, color: teal)),
      ],
    ),
  );
}

// ─── T2: Modern Clean ────────────────────────────────────────────────────────
class _T2Thumbnail extends StatelessWidget {
  const _T2Thumbnail();
  static const teal = Color(0xFF4ECDC4);
  static const dark = Color(0xFF4A5568);
  static const gray = Color(0xFF718096);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 850,
      height: 1100,
      child: Padding(
        padding: const EdgeInsets.all(50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'GABRIEL BAKER',
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.w800,
                color: dark,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Entry Level Software Engineer',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: teal,
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: const [
                Icon(Icons.phone, size: 14, color: gray),
                SizedBox(width: 5),
                Text(
                  '+1-(234)-555-1234',
                  style: TextStyle(fontSize: 11, color: gray),
                ),
                SizedBox(width: 20),
                Icon(Icons.email, size: 14, color: gray),
                SizedBox(width: 5),
                Flexible(
                  child: Text(
                    'info@resumementor.com',
                    style: TextStyle(fontSize: 11, color: gray),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(height: 2, color: Color(0xFFE2E8F0)),
            const SizedBox(height: 14),
            _sec('PROFILE'),
            const SizedBox(height: 8),
            const Text(
              'Enthusiastic software engineer with a Bachelor\'s degree and internship experience in software development and agile methodologies.',
              style: TextStyle(fontSize: 11, height: 1.6, color: dark),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 20),
            _sec('WORK HISTORY'),
            const SizedBox(height: 10),
            const Text(
              'Software Engineering Intern',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: dark,
              ),
            ),
            const Text(
              'Raytheon Technologies',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: teal,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: const [
                Icon(Icons.calendar_today, size: 11, color: gray),
                SizedBox(width: 4),
                Text(
                  '05/2023 - 08/2023',
                  style: TextStyle(fontSize: 10, color: gray),
                ),
                SizedBox(width: 14),
                Icon(Icons.location_on, size: 11, color: gray),
                SizedBox(width: 4),
                Text(
                  'Indianapolis, Indiana',
                  style: TextStyle(fontSize: 10, color: gray),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Junior Software Developer Intern',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: dark,
              ),
            ),
            const Text(
              'Northrop Grumman',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: teal,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: const [
                Icon(Icons.calendar_today, size: 11, color: gray),
                SizedBox(width: 4),
                Text(
                  '01/2023 - 04/2023',
                  style: TextStyle(fontSize: 10, color: gray),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _sec('KEY SKILLS'),
            const SizedBox(height: 10),
            const Text(
              'Software Development · Agile · Cloud Computing · AI · Debugging',
              style: TextStyle(fontSize: 11, height: 1.6, color: dark),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _sec(String t) => Text(
    t,
    style: const TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w700,
      color: dark,
      letterSpacing: 1.2,
    ),
  );
}

// ─── T3: Dark Sidebar ────────────────────────────────────────────────────────
class _T3Thumbnail extends StatelessWidget {
  const _T3Thumbnail();
  static const sidebar = Color(0xFF2D3748);
  static const blue = Color(0xFF4299E1);
  static const gray = Color(0xFFA0AEC0);
  static const dark = Color(0xFF2D3748);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 850,
      height: 1100,
      child: Row(
        children: [
          // Sidebar
          Container(
            width: 280,
            height: 1100,
            color: sidebar,
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                      color: Colors.white24,
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white54,
                      size: 50,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                _sT('ABOUT ME'),
                const SizedBox(height: 10),
                const Text(
                  'Experienced graphic designer passionate about visual communication and creative problem solving.',
                  style: TextStyle(
                    fontSize: 9,
                    height: 1.6,
                    color: Colors.white70,
                  ),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 20),
                _sT('SKILLS'),
                const SizedBox(height: 12),
                _bar('Photoshop', 0.95),
                const SizedBox(height: 8),
                _bar('Illustrator', 0.90),
                const SizedBox(height: 8),
                _bar('InDesign', 0.85),
                const SizedBox(height: 8),
                _bar('CorelDraw', 0.80),
                const SizedBox(height: 8),
                _bar('WordPress', 0.75),
                const SizedBox(height: 20),
                _sT('LANGUAGE'),
                const SizedBox(height: 12),
                _lang('English', 5),
                const SizedBox(height: 8),
                _lang('Spanish', 4),
                const SizedBox(height: 8),
                _lang('French', 3),
              ],
            ),
          ),
          // Main
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'LORNA ALVARADO',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                      color: dark,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'GRAPHIC DESIGNER',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: gray,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(height: 2, color: const Color(0xFFE2E8F0)),
                  const SizedBox(height: 14),
                  _mT('EXPERIENCE'),
                  const SizedBox(height: 12),
                  _exp(
                    'Lead Graphic Designer',
                    'Borcelle Studio',
                    '2018 - Present',
                  ),
                  const SizedBox(height: 10),
                  _exp('Senior Graphic Designer', 'Studious', '2016 - 2018'),
                  const SizedBox(height: 10),
                  _exp('Graphic Designer', 'Quisque Studio', '2014 - 2016'),
                  const SizedBox(height: 10),
                  _exp('Marketing Manager', 'Fauget Company', '2012 - 2014'),
                  const SizedBox(height: 24),
                  _mT('REFERENCES'),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _ref('Estley Howard', 'Company / 123-456-7890'),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _ref('Harper Brewer', 'Company / 123-456-7890'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sT(String t) => Text(
    t,
    style: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: Colors.white,
      letterSpacing: 1.5,
    ),
  );

  Widget _mT(String t) => Text(
    t,
    style: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: dark,
      letterSpacing: 1.5,
    ),
  );

  Widget _bar(String skill, double pct) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(skill, style: const TextStyle(fontSize: 9, color: Colors.white)),
      const SizedBox(height: 4),
      Stack(
        children: [
          Container(
            height: 5,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          FractionallySizedBox(
            widthFactor: pct,
            child: Container(
              height: 5,
              decoration: BoxDecoration(
                color: blue,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ],
      ),
    ],
  );

  Widget _lang(String lang, int lvl) => Row(
    children: [
      Expanded(
        child: Text(
          lang,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
      Row(
        children: List.generate(
          5,
          (i) => Padding(
            padding: const EdgeInsets.only(left: 3),
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: i < lvl ? blue : Colors.white24,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ),
    ],
  );

  Widget _exp(String title, String company, String period) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: dark,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(period, style: const TextStyle(fontSize: 9, color: gray)),
        ],
      ),
      Text(
        company,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: blue,
        ),
      ),
    ],
  );

  Widget _ref(String name, String details) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        name,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: dark,
        ),
      ),
      const SizedBox(height: 3),
      Text(
        details,
        style: const TextStyle(fontSize: 10, color: gray),
        overflow: TextOverflow.ellipsis,
      ),
    ],
  );
}

// ─── T4: Legal Sage ──────────────────────────────────────────────────────────
class _T4Thumbnail extends StatelessWidget {
  const _T4Thumbnail();
  static const sage = Color(0xFFD4D6C3);
  static const darkG = Color(0xFF6B7C6E);
  static const gold = Color(0xFFB4946F);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 850,
      height: 1100,
      child: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            color: sage,
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'JOHN DOE',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w300,
                    color: darkG,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'ATTORNEY',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: darkG,
                    letterSpacing: 3,
                  ),
                ),
              ],
            ),
          ),
          // Body
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left
                Container(
                  width: 260,
                  padding: const EdgeInsets.all(40),
                  decoration: const BoxDecoration(
                    border: Border(
                      right: BorderSide(color: Color(0xFFE0E0E0), width: 1),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _gs('CONTACT'),
                      const SizedBox(height: 10),
                      _li('4587 Main Street'),
                      _li('Brooklyn, NY 48127'),
                      _li('718.555.0100'),
                      _li('johndoe@gmail.com'),
                      const SizedBox(height: 20),
                      _gs('EDUCATION'),
                      const SizedBox(height: 10),
                      const Text(
                        'JURIS DOCTOR · JUNE 20XX',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: darkG,
                        ),
                      ),
                      const Text(
                        'Jasper University, NYC',
                        style: TextStyle(fontSize: 10, color: darkG),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'BA IN POLITICAL SCIENCE',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: darkG,
                        ),
                      ),
                      const Text(
                        'Mount Flores College',
                        style: TextStyle(fontSize: 10, color: darkG),
                      ),
                      const SizedBox(height: 20),
                      _gs('KEY SKILLS'),
                      const SizedBox(height: 10),
                      _li('Data analytics'),
                      _li('Legal writing'),
                      _li('Excellent communication'),
                      _li('Records search'),
                      const SizedBox(height: 20),
                      _gs('INTERESTS'),
                      const SizedBox(height: 10),
                      _li('Literature'),
                      _li('Environmental conservation'),
                      _li('Art · Yoga · Travel'),
                    ],
                  ),
                ),
                // Right
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _gs('SUMMARY'),
                        const SizedBox(height: 10),
                        const Text(
                          'Detail-oriented attorney with extensive experience in business and real estate law. Skilled in business formation, real estate transactions, due diligence, permitting, contract and lease negotiations, and landlord/tenant matters.',
                          style: TextStyle(
                            fontSize: 11,
                            height: 1.6,
                            color: darkG,
                          ),
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 24),
                        _gs('WORK EXPERIENCE'),
                        const SizedBox(height: 14),
                        _we(
                          'IN-HOUSE COUNSEL · MARCH 20XX — PRESENT',
                          'Banxter Real Estate · NYC, New York',
                          'Draft, negotiate and enforce leases and purchase & sale agreements for boutique real estate development firm.',
                        ),
                        const SizedBox(height: 16),
                        _we(
                          'ASSOCIATE ATTORNEY · FEB 20XX — NOV 20XX',
                          'Luca Udinesi Law Firm · NYC, New York',
                          'Represented and advised parties on small business, real estate, and landlord tenant issues.',
                        ),
                        const SizedBox(height: 16),
                        _we(
                          'JUNIOR ASSOCIATE · SEPT 20XX — JAN 20XX',
                          'Law Offices of Katla Aoki · NYC, New York',
                          'Researched legal issues for senior counsel and assisted in representation of clients.',
                        ),
                      ],
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

  Widget _gs(String t) => Text(
    t,
    style: const TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: gold,
      letterSpacing: 1.5,
    ),
  );

  Widget _li(String t) => Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Text(
      t,
      style: const TextStyle(fontSize: 11, height: 1.5, color: darkG),
      overflow: TextOverflow.ellipsis,
    ),
  );

  Widget _we(String title, String company, String desc) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: gold,
          letterSpacing: 0.5,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        company,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: darkG,
        ),
      ),
      const SizedBox(height: 6),
      Text(
        desc,
        style: const TextStyle(fontSize: 10, height: 1.6, color: darkG),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    ],
  );
}

// ─── Shared helper ────────────────────────────────────────────────────────────
class _DotChip extends StatelessWidget {
  final String label;
  final Color color;
  const _DotChip(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 7, height: 7, color: color),
        const SizedBox(width: 5),
        Text(label, style: TextStyle(fontSize: 9, color: color)),
      ],
    );
  }
}
