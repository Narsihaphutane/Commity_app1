import 'package:flutter/material.dart';

// ===== NAVIN LIGHT THEME COLOR PALETTE =====
class AppColorsLight {
  static const bg = Color(0xFFF5F5FF);
  static const card = Color(0xFFFFFFFF);
  static const border = Color(0xFFE4E5FF);
  static const accent = Color(0xFF7C83FD);
  static const accentSoft = Color(0xFFEEEFFF);
  static const text = Color(0xFF1A1A2E); // Dark text for readability
  static const textMuted = Color(0xFF6B7280); // Gray for hints
  static const success = Color(0xFF10B981);
  static const danger = Color(0xFFEF4444);
}

// Enum for selecting campaign type (No change)
enum CampaignType { cash, goods, volunteer }

// Helper class for icon/color options (No change)
class _IconColorOption {
  final IconData icon;
  final Color color;
  const _IconColorOption(this.icon, this.color);
}

// ===== THE NEW, BEAUTIFUL LIGHT UI SCREEN =====
class CreateCampaignLightScreen extends StatefulWidget {
  const CreateCampaignLightScreen({super.key});

  @override
  State<CreateCampaignLightScreen> createState() =>
      _CreateCampaignLightScreenState();
}

class _CreateCampaignLightScreenState extends State<CreateCampaignLightScreen> {
  final _formKey = GlobalKey<FormState>();
  CampaignType _selectedType = CampaignType.cash;

  // Form Controllers (No change)
  final _titleCtrl = TextEditingController();
  final _orgCtrl = TextEditingController();
  final _descriptionCtrl = TextEditingController();
  final _goalCtrl = TextEditingController();
  final _locationCtrl = TextEditingController();
  final _spotsCtrl = TextEditingController();

  // State variables (No change)
  int? _selectedIconColorIndex;

  // Data for pickers (No change)
  final List<_IconColorOption> _iconColorOptions = const [
    _IconColorOption(Icons.school_rounded, AppColorsLight.accent),
    _IconColorOption(Icons.local_hospital_rounded, Color(0xFFEF4444)),
    _IconColorOption(Icons.pets_rounded, Color(0xFF10B981)),
    _IconColorOption(Icons.park_rounded, Color(0xFF059669)),
    _IconColorOption(Icons.food_bank_rounded, Color(0xFFF59E0B)),
    _IconColorOption(Icons.water_drop_rounded, Color(0xFF06B6D4)),
  ];

  @override
  void dispose() {
    _titleCtrl.dispose();
    _orgCtrl.dispose();
    _descriptionCtrl.dispose();
    _goalCtrl.dispose();
    _locationCtrl.dispose();
    _spotsCtrl.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _selectedIconColorIndex != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('🎉 Campaign Created Successfully!'),
          backgroundColor: AppColorsLight.success,
          behavior: SnackBarBehavior.floating,
        ),
      );
      Navigator.of(context).pop();
    } else if (_selectedIconColorIndex == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an icon for your campaign.'),
          backgroundColor: AppColorsLight.danger,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsLight.bg, // WHITE BACKGROUND
      appBar: AppBar(
        title: const Text('Create New Campaign',
            style: TextStyle(color: AppColorsLight.text)), // BLACK TEXT
        backgroundColor: AppColorsLight.card, // WHITE APPBAR
        elevation: 1,
        shadowColor: AppColorsLight.border,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: AppColorsLight.text), // BLACK ICON
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildSectionTitle('1. Choose Campaign Type'),
              const SizedBox(height: 12),
              _buildCampaignTypeSelector(),
              const SizedBox(height: 24),

              _buildSectionTitle('2. Campaign Details'),
              const SizedBox(height: 12),
              _buildCustomTextFormField(
                controller: _titleCtrl,
                label: 'Campaign Title',
                hint: 'e.g., Education for All',
              ),
              const SizedBox(height: 16),
              _buildCustomTextFormField(
                controller: _orgCtrl,
                label: 'Organization / Your Name',
                hint: 'e.g., Bright Futures Foundation',
              ),
              const SizedBox(height: 16),
              _buildCustomTextFormField(
                controller: _descriptionCtrl,
                label: 'Description',
                hint: 'Tell people why your campaign is important...',
                maxLines: 4,
              ),
              const SizedBox(height: 24),

              _buildSectionTitle('3. Specific Information'),
              const SizedBox(height: 12),
              _buildConditionalFields(),
              const SizedBox(height: 24),

              _buildSectionTitle('4. Choose Icon & Color'),
              const SizedBox(height: 12),
              _buildIconColorPicker(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildSubmitButton(),
    );
  }

  // --- BUILDER WIDGETS FOR UI COMPONENTS ---

  Widget _buildCampaignTypeSelector() {
    return Row(
      children: [
        _buildTypeChip(
            'Cash', Icons.monetization_on_rounded, CampaignType.cash),
        const SizedBox(width: 10),
        _buildTypeChip('Goods', Icons.inventory_2_rounded, CampaignType.goods),
        const SizedBox(width: 10),
        _buildTypeChip('Volunteer', Icons.volunteer_activism_rounded,
            CampaignType.volunteer),
      ],
    );
  }

  Widget _buildTypeChip(String label, IconData icon, CampaignType type) {
    final isSelected = _selectedType == type;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedType = type),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColorsLight.accentSoft : AppColorsLight.card,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected ? AppColorsLight.accent : AppColorsLight.border,
              width: isSelected ? 2.0 : 1.0,
            ),
             boxShadow: [
              if (!isSelected)
                BoxShadow(
                  color: AppColorsLight.border.withOpacity(0.5),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                )
            ],
          ),
          child: Column(
            children: [
              Icon(icon,
                  color: isSelected ? AppColorsLight.accent : AppColorsLight.textMuted,
                  size: 24),
              const SizedBox(height: 6),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? AppColorsLight.accent : AppColorsLight.textMuted,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConditionalFields() {
    switch (_selectedType) {
      case CampaignType.cash:
        return _buildCustomTextFormField(
          controller: _goalCtrl,
          label: 'Fundraising Goal (₹)',
          hint: 'e.g., 50000',
          keyboardType: TextInputType.number,
          prefixIcon: Icons.currency_rupee_rounded,
        );
      case CampaignType.goods:
        return _buildCustomTextFormField(
          controller: _descriptionCtrl,
          label: 'List of Goods Needed',
          hint: 'e.g., 50 School Bags, 100 Notebooks, etc.',
          maxLines: 3,
        );
      case CampaignType.volunteer:
        return Column(
          children: [
            _buildCustomTextFormField(
              controller: _locationCtrl,
              label: 'Location',
              hint: 'e.g., Pune, Maharashtra',
              prefixIcon: Icons.location_on_rounded,
            ),
            const SizedBox(height: 16),
            _buildCustomTextFormField(
              controller: _spotsCtrl,
              label: 'Number of Volunteers Needed',
              hint: 'e.g., 15',
              keyboardType: TextInputType.number,
              prefixIcon: Icons.people_alt_rounded,
            ),
          ],
        );
    }
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColorsLight.textMuted,
      ),
    );
  }

  Widget _buildCustomTextFormField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    IconData? prefixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColorsLight.text), // BLACK TEXT
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: const TextStyle(fontSize: 15, color: AppColorsLight.text), // BLACK TEXT
          decoration: InputDecoration(
            hintText: hint,
            hintStyle:
                const TextStyle(color: AppColorsLight.textMuted, fontSize: 14),
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: AppColorsLight.textMuted, size: 20)
                : null,
            filled: true,
            fillColor: AppColorsLight.card, // WHITE TEXTFIELD
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColorsLight.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColorsLight.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColorsLight.accent, width: 1.5),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildIconColorPicker() {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _iconColorOptions.length,
        itemBuilder: (context, index) {
          final option = _iconColorOptions[index];
          final isSelected = _selectedIconColorIndex == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedIconColorIndex = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 60,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: option.color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: isSelected ? option.color : Colors.transparent,
                  width: 2.5,
                ),
              ),
              child: Icon(option.icon, color: option.color, size: 28),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      decoration: BoxDecoration(
          color: AppColorsLight.card, // WHITE
          border: Border(
              top: BorderSide(
                  color: AppColorsLight.border, // Light border on top
                  width: 1.0))),
      child: ElevatedButton(
        onPressed: _submitForm,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColorsLight.accent,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 2,
          shadowColor: AppColorsLight.accent.withOpacity(0.4),
        ),
        child: const Text(
          'Submit',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}