import 'package:flutter/material.dart';

// ─── AppColors ───────────────────────────────────────────────────────────────
class AppColors {
  static const accent     = Color(0xFF7C83FD);
  static const accent2    = Color(0xFF9EA3FF);
  static const accentSoft = Color(0xFFEEEFFF);
  static const bg         = Color(0xFFF5F5FF);
  static const card       = Color(0xFFFFFFFF);
  static const border     = Color(0xFFE4E5FF);
  static const muted      = Color(0xFF6B7280);
  static const text       = Color(0xFF1A1A2E);
  static const success    = Color(0xFF10B981);
  static const danger     = Color(0xFFEF4444);
  static const warning    = Color(0xFFF59E0B);
}

// ─── PackageFormScreen ────────────────────────────────────────────────────────
class PackageFormScreen extends StatefulWidget {
  const PackageFormScreen({super.key});

  @override
  State<PackageFormScreen> createState() => _PackageFormScreenState();
}

class _PackageFormScreenState extends State<PackageFormScreen>
    with SingleTickerProviderStateMixin {
  // Controllers
  final _titleCtrl       = TextEditingController();
  final _priceCtrl       = TextEditingController();
  final _descCtrl        = TextEditingController();
  final _daysCtrl        = TextEditingController();

  // State
  String? _selectedPackageFor;
  String? _selectedPackageType;
  String? _selectedUser;

  bool _postCount        = false;
  bool _responsePerPost  = false;
  bool _accessToResponse = false;
  bool _discount         = false;

  late AnimationController _animCtrl;
  late Animation<double>   _fadeAnim;
  late Animation<Offset>   _slideAnim;

  final List<String> _packageForOptions  = ['Package for Jobs', 'Package for Services', 'Package for Freelance'];
  final List<String> _packageTypeOptions = ['Basic', 'Standard', 'Premium', 'Enterprise'];
  final List<String> _userOptions        = ['Alice Johnson', 'Bob Smith', 'Charlie Brown', 'Diana Prince'];

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _fadeAnim  = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero)
        .animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOutCubic));
    _animCtrl.forward();
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    _titleCtrl.dispose();
    _priceCtrl.dispose();
    _descCtrl.dispose();
    _daysCtrl.dispose();
    super.dispose();
  }

  // ── Helpers ─────────────────────────────────────────────────────────────────
  InputDecoration _inputDeco(String hint, {IconData? icon}) => InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(color: AppColors.muted, fontSize: 14),
    prefixIcon: icon != null
        ? Icon(icon, color: AppColors.accent2, size: 18)
        : null,
    filled: true,
    fillColor: AppColors.card,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: AppColors.border, width: 1.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: AppColors.accent, width: 2),
    ),
  );

  Widget _sectionLabel(String label) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      label,
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: AppColors.accent,
        letterSpacing: 1.1,
      ),
    ),
  );

  Widget _card({required Widget child, EdgeInsets? padding}) => Container(
    width: double.infinity,
    padding: padding ?? const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: AppColors.card,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: AppColors.border, width: 1.2),
      boxShadow: [
        BoxShadow(
          color: AppColors.accent.withOpacity(0.06),
          blurRadius: 18,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: child,
  );

  // ── Fancy Checkbox Tile ─────────────────────────────────────────────────────
  Widget _checkTile({
    required String label,
    required bool value,
    required ValueChanged<bool?> onChanged,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        decoration: BoxDecoration(
          color: value ? AppColors.accentSoft : AppColors.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: value ? AppColors.accent : AppColors.border,
            width: value ? 1.8 : 1.2,
          ),
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: value ? AppColors.accent : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: value ? AppColors.accent : AppColors.border,
                  width: 1.8,
                ),
              ),
              child: value
                  ? const Icon(Icons.check_rounded, size: 14, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 12),
            Icon(icon, size: 16, color: value ? AppColors.accent : AppColors.muted),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: value ? FontWeight.w600 : FontWeight.w500,
                color: value ? AppColors.text : AppColors.muted,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Styled Dropdown ─────────────────────────────────────────────────────────
  Widget _dropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    IconData? icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: value != null ? AppColors.accent : AppColors.border,
          width: value != null ? 1.8 : 1.5,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 16, color: AppColors.muted),
                const SizedBox(width: 8),
              ],
              Text(hint, style: const TextStyle(color: AppColors.muted, fontSize: 14)),
            ],
          ),
          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.accent),
          isExpanded: true,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          borderRadius: BorderRadius.circular(14),
          dropdownColor: AppColors.card,
          style: const TextStyle(color: AppColors.text, fontSize: 14, fontWeight: FontWeight.w500),
          items: items
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // ── BUILD ──────────────────────────────────────────────────────────────────
  // ══════════════════════════════════════════════════════════════════════════
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      // ── AppBar ─────────────────────────────────────────────────────────────
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF7C83FD), Color(0xFF9EA3FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        leading: IconButton(
          icon: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 16),
          ),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Forms',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.3,
              ),
            ),
            Text(
              'Create Package',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white30, width: 1),
            ),
            child: Row(
              children: const [
                Icon(Icons.help_outline_rounded, color: Colors.white, size: 14),
                SizedBox(width: 4),
                Text('Help', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),

      body: FadeTransition(
        opacity: _fadeAnim,
        child: SlideTransition(
          position: _slideAnim,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── User Selection ───────────────────────────────────────────
                _card(
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.accentSoft,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.person_rounded, color: AppColors.accent, size: 22),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _selectedUser ?? 'No User Selected',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: _selectedUser != null ? AppColors.text : AppColors.muted,
                              ),
                            ),
                            if (_selectedUser != null)
                              const Text('Assigned user', style: TextStyle(fontSize: 11, color: AppColors.muted)),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => showDialog(
                          context: context,
                          builder: (_) => _userPickerDialog(),
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [AppColors.accent, AppColors.accent2],
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            _selectedUser != null ? 'Change' : 'Select User',
                            style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                // ── Package Category ─────────────────────────────────────────
                _sectionLabel('PACKAGE CATEGORY'),
                _card(
                  child: _dropdown(
                    hint: 'Package for Jobs',
                    value: _selectedPackageFor,
                    items: _packageForOptions,
                    icon: Icons.category_outlined,
                    onChanged: (v) => setState(() => _selectedPackageFor = v),
                  ),
                ),

                const SizedBox(height: 14),

                // ── Package Details ──────────────────────────────────────────
                _sectionLabel('PACKAGE DETAILS'),
                _card(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: _dropdown(
                              hint: 'Package Type',
                              value: _selectedPackageType,
                              items: _packageTypeOptions,
                              icon: Icons.layers_outlined,
                              onChanged: (v) => setState(() => _selectedPackageType = v),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 6,
                            child: TextFormField(
                              controller: _titleCtrl,
                              decoration: _inputDeco('Package Title', icon: Icons.title_rounded),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _priceCtrl,
                        keyboardType: TextInputType.number,
                        decoration: _inputDeco('Package Price', icon: Icons.currency_rupee_rounded),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                // ── Features ─────────────────────────────────────────────────
                _sectionLabel('FEATURES INCLUDED'),
                _card(
                  child: Column(
                    children: [
                      _checkTile(
                        label: 'Post Count',
                        value: _postCount,
                        icon: Icons.format_list_numbered_rounded,
                        onChanged: (v) => setState(() => _postCount = v ?? false),
                      ),
                      const SizedBox(height: 8),
                      _checkTile(
                        label: 'Response Per Post',
                        value: _responsePerPost,
                        icon: Icons.reply_rounded,
                        onChanged: (v) => setState(() => _responsePerPost = v ?? false),
                      ),
                      const SizedBox(height: 8),
                      _checkTile(
                        label: 'Access to Response',
                        value: _accessToResponse,
                        icon: Icons.lock_open_rounded,
                        onChanged: (v) => setState(() => _accessToResponse = v ?? false),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                // ── Description ───────────────────────────────────────────────
                _sectionLabel('DESCRIPTION'),
                _card(
                  child: TextFormField(
                    controller: _descCtrl,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Package Description',
                      hintStyle: const TextStyle(color: AppColors.muted, fontSize: 14),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                // ── Validity ─────────────────────────────────────────────────
                _sectionLabel('VALIDITY'),
                _card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.accentSoft,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.calendar_today_rounded, color: AppColors.accent, size: 16),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Set Validity Period',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.text,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _daysCtrl,
                        keyboardType: TextInputType.number,
                        decoration: _inputDeco('Number of days', icon: Icons.timelapse_rounded),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                // ── Discount ─────────────────────────────────────────────────
                _sectionLabel('OFFERS'),
                _card(
                  child: _checkTile(
                    label: 'Enable Discount',
                    value: _discount,
                    icon: Icons.local_offer_rounded,
                    onChanged: (v) => setState(() => _discount = v ?? false),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // ── Bottom Action Bar ───────────────────────────────────────────────────
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).padding.bottom + 16,
          top: 12,
        ),
        decoration: BoxDecoration(
          color: AppColors.card,
          border: const Border(top: BorderSide(color: AppColors.border, width: 1)),
          boxShadow: [
            BoxShadow(
              color: AppColors.accent.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Progress indicator
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Form completion', style: TextStyle(fontSize: 11, color: AppColors.muted)),
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: _formProgress(),
                      backgroundColor: AppColors.border,
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accent),
                      minHeight: 5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Close button
            OutlinedButton(
              onPressed: () => Navigator.maybePop(context),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.muted,
                side: const BorderSide(color: AppColors.border, width: 1.5),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 13),
              ),
              child: const Text('Close', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            ),
            const SizedBox(width: 10),
            // Save button
            ElevatedButton(
              onPressed: _onSave,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 13),
              ),
              child: Row(
                children: const [
                  Icon(Icons.save_rounded, size: 16),
                  SizedBox(width: 6),
                  Text('Save', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Form Progress ────────────────────────────────────────────────────────────
  double _formProgress() {
    int filled = 0;
    if (_selectedUser != null)      filled++;
    if (_selectedPackageFor != null) filled++;
    if (_selectedPackageType != null) filled++;
    if (_titleCtrl.text.isNotEmpty) filled++;
    if (_priceCtrl.text.isNotEmpty) filled++;
    if (_descCtrl.text.isNotEmpty)  filled++;
    if (_daysCtrl.text.isNotEmpty)  filled++;
    return filled / 7.0;
  }

  // ── Save Handler ─────────────────────────────────────────────────────────────
  void _onSave() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: const [
            Icon(Icons.check_circle_rounded, color: Colors.white, size: 18),
            SizedBox(width: 10),
            Text('Package saved successfully!', style: TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // ── User Picker Dialog ────────────────────────────────────────────────────────
  Widget _userPickerDialog() {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: AppColors.card,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select User',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: AppColors.text),
            ),
            const SizedBox(height: 4),
            const Text('Choose a user to assign this package to',
                style: TextStyle(fontSize: 12, color: AppColors.muted)),
            const SizedBox(height: 16),
            ..._userOptions.map((user) => GestureDetector(
                  onTap: () {
                    setState(() => _selectedUser = user);
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: _selectedUser == user ? AppColors.accentSoft : AppColors.bg,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _selectedUser == user ? AppColors.accent : AppColors.border,
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: AppColors.accentSoft,
                          child: Text(
                            user[0],
                            style: const TextStyle(
                                color: AppColors.accent, fontWeight: FontWeight.w700, fontSize: 13),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          user,
                          style: TextStyle(
                            fontWeight: _selectedUser == user ? FontWeight.w700 : FontWeight.w500,
                            color: AppColors.text,
                            fontSize: 14,
                          ),
                        ),
                        const Spacer(),
                        if (_selectedUser == user)
                          const Icon(Icons.check_circle_rounded, color: AppColors.accent, size: 18),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}