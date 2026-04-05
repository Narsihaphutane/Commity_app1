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

// ===== DATA MODEL =====
// ADHIK MAAHITI SATHI 'description' ANI 'impact' ADD KELE AHE.
class _Campaign {
  final String title;
  final String org;
  final int daysLeft;
  final double raised;
  final double goal;
  final IconData icon;
  final Color color;
  final String description; // About the campaign sathi
  final Map<int, String> impact; // Donation cha parinam dakhavnyasathi

  _Campaign({
    required this.title,
    required this.org,
    required this.daysLeft,
    required this.raised,
    required this.goal,
    required this.icon,
    required this.color,
    required this.description,
    required this.impact,
  });
}

// ===== SCREEN 1: LIST OF CAMPAIGNS (PAHLI SCREEN) =====
// Hi screen sarva campaigns chi list dakhavte.
class CashDonationScreen extends StatefulWidget {
  const CashDonationScreen({super.key});

  @override
  State<CashDonationScreen> createState() => _CashDonationScreenState();
}

class _CashDonationScreenState extends State<CashDonationScreen> {
  // DATA MADHE NAVIN MAAHITI ADD KELI AHE
  final List<_Campaign> _campaigns = [
    _Campaign(
      title: 'Help abandoned animals',
      org: 'Animal Kaiser',
      daysLeft: 2,
      raised: 8700,
      goal: 10000,
      icon: Icons.pets_rounded,
      color: AppColors.accent,
      description:
          'Our mission is to rescue, rehabilitate, and re-home abandoned and stray animals. We provide them with medical care, food, and a safe shelter until they find a loving forever home.',
      impact: {
        200: 'Feeds a dog for a week',
        500: 'Provides essential vaccination',
        1000: 'Sponsors a sterilization surgery',
      },
    ),
    _Campaign(
      title: 'Orphanage scholarship',
      org: 'OP Warriors',
      daysLeft: 4,
      raised: 42000,
      goal: 50000,
      icon: Icons.school_rounded,
      color: const Color(0xFF10B981),
      description:
          'This campaign aims to provide full academic scholarships to talented children in orphanages. Your donation covers their school fees, books, uniforms, and stationery for an entire year.',
      impact: {
        500: 'Provides a complete stationery kit',
        1500: 'Covers one term school fees',
        5000: 'Sponsors a child for a full year',
      },
    ),
    _Campaign(
      title: 'Clean water project',
      org: 'Blue Earth',
      daysLeft: 7,
      raised: 15000,
      goal: 25000,
      icon: Icons.water_drop_rounded,
      color: const Color(0xFF06B6D4),
      description:
          'We are installing community water purifiers in remote villages that lack access to clean and safe drinking water. This project will prevent water-borne diseases and improve the health of hundreds of families.',
      impact: {
        300: 'Provides a family with a water filter',
        1000: 'Contributes to pipe installation',
        2500: 'Funds a portion of the purifier unit',
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: AppColors.bg,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('Trending Campaigns'),
            const SizedBox(height: 12),
            ..._campaigns.map((c) => _buildCampaignCard(c)),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.text,
      ),
    );
  }

  // YA CARD CHA UI ADHIPRAMANECH AHE, KAHIHI BADAL NAHI
  Widget _buildCampaignCard(_Campaign c) {
    final progress = c.raised / c.goal;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CampaignDetailScreen(campaign: c),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: AppColors.accent.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: c.color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(c.icon, color: c.color, size: 26),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        c.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: AppColors.text,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        c.org,
                        style: const TextStyle(
                            fontSize: 13, color: AppColors.muted),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.accentSoft,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${c.daysLeft}d left',
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.accent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₹${(c.raised / 1000).toStringAsFixed(0)}K raised',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.text,
                  ),
                ),
                Text(
                  'Goal: ₹${(c.goal / 1000).toStringAsFixed(0)}K',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.muted,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                backgroundColor: c.color.withOpacity(0.12),
                valueColor: AlwaysStoppedAnimation<Color>(c.color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===== SCREEN 2: CAMPAIGN DETAILS (ENHANCED & MORE INFORMATIVE) =====
class CampaignDetailScreen extends StatefulWidget {
  final _Campaign campaign;
  const CampaignDetailScreen({super.key, required this.campaign});

  @override
  State<CampaignDetailScreen> createState() => _CampaignDetailScreenState();
}

class _CampaignDetailScreenState extends State<CampaignDetailScreen> {
  int? _selectedAmount;
  final TextEditingController _customCtrl = TextEditingController();
  bool _showCustom = false;
  final List<int> _fixedAmounts = [100, 200, 500, 1000];

  @override
  void dispose() {
    _customCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final supporters = (widget.campaign.raised / 250).ceil(); // Assuming average donation is 250

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.campaign.title,
            style: const TextStyle(color: AppColors.text)),
        backgroundColor: AppColors.card,
        elevation: 1,
        shadowColor: AppColors.border,
        iconTheme: const IconThemeData(color: AppColors.text),
      ),
      backgroundColor: AppColors.bg,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // NAVIN HEADER SECTION
            _buildCampaignHeader(),
            const SizedBox(height: 20),
            // NAVIN PROGRESS BREAKDOWN SECTION
            _buildProgressDetailsCard(supporters),
            const SizedBox(height: 20),
            // NAVIN ABOUT SECTION
            _buildInfoCard(
                'About the Campaign', widget.campaign.description),
            const SizedBox(height: 20),
            // NAVIN IMPACT SECTION
            _buildImpactCard(),
            const SizedBox(height: 24),

            // PAYMENT SECTION (HA SHEVTI AHE)
            _sectionTitle('Choose an Amount'),
            const SizedBox(height: 12),
            _buildAmountGrid(),
            const SizedBox(height: 16),
            _buildCustomAmountToggle(),
            if (_showCustom) ...[
              const SizedBox(height: 12),
              _buildCustomAmountField(),
            ],
          ],
        ),
      ),
      bottomNavigationBar: _buildDonateButton(),
    );
  }
  
  // NAVIN WIDGETS
  Widget _buildCampaignHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: widget.campaign.color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(widget.campaign.icon,
                color: widget.campaign.color, size: 36),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.campaign.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: AppColors.text),
                ),
                const SizedBox(height: 4),
                Text(
                  'by ${widget.campaign.org}',
                  style: const TextStyle(fontSize: 14, color: AppColors.muted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressDetailsCard(int supporters) {
    final progress = widget.campaign.raised / widget.campaign.goal;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '₹${widget.campaign.raised.toStringAsFixed(0)}',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: widget.campaign.color),
              ),
              Text(
                '${(progress * 100).toInt()}% funded',
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'raised of ₹${widget.campaign.goal.toStringAsFixed(0)} goal',
                style: const TextStyle(fontSize: 13, color: AppColors.muted),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: widget.campaign.color.withOpacity(0.15),
              valueColor:
                  AlwaysStoppedAnimation<Color>(widget.campaign.color),
            ),
          ),
          const Divider(height: 24, color: AppColors.border),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatColumn('$supporters', 'Supporters'),
              _buildStatColumn('${widget.campaign.daysLeft}', 'Days Left'),
            ],
          )
        ],
      ),
    );
  }
  
  Widget _buildStatColumn(String value, String label) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.text)),
        const SizedBox(height: 2),
        Text(label,
            style: const TextStyle(fontSize: 13, color: AppColors.muted)),
      ],
    );
  }
  
  Widget _buildInfoCard(String title, String content) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text)),
          const SizedBox(height: 8),
          Text(content,
              style:
                  const TextStyle(fontSize: 14, color: AppColors.muted, height: 1.5)),
        ],
      ),
    );
  }
  
  Widget _buildImpactCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Impact of Your Donation',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text)),
          const SizedBox(height: 12),
          ...widget.campaign.impact.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Icon(Icons.check_circle,
                      color: widget.campaign.color, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                            fontSize: 14, color: AppColors.text, fontFamily: 'Poppins'),
                        children: [
                          TextSpan(
                              text: '₹${entry.key} ',
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: ' - ${entry.value}',
                              style: const TextStyle(color: AppColors.muted)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  // PAYMENT SECTION WIDGETS (ADHIPRAMANECH AAHET)
  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.text,
      ),
    );
  }

  Widget _buildAmountGrid() {
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1.6,
      children: _fixedAmounts.map((amount) {
        final selected = _selectedAmount == amount;
        return GestureDetector(
          onTap: () => setState(() {
            _selectedAmount = amount;
            _showCustom = false;
            _customCtrl.clear();
          }),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            decoration: BoxDecoration(
              color: selected ? AppColors.accent : AppColors.card,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: selected ? AppColors.accent : AppColors.border,
                width: selected ? 2 : 1,
              ),
              boxShadow: selected
                  ? [
                      BoxShadow(
                        color: AppColors.accent.withOpacity(0.25),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      )
                    ]
                  : [],
            ),
            alignment: Alignment.center,
            child: Text(
              '₹$amount',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: selected ? Colors.white : AppColors.text,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCustomAmountToggle() {
    return GestureDetector(
      onTap: () => setState(() {
        _showCustom = !_showCustom;
        _selectedAmount = null;
      }),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 13),
        decoration: BoxDecoration(
          color: _showCustom ? AppColors.accentSoft : AppColors.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _showCustom ? AppColors.accent : AppColors.border,
          ),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.edit_rounded, size: 16, color: AppColors.accent),
            const SizedBox(width: 8),
            Text(
              'Enter custom amount',
              style: TextStyle(
                color: AppColors.accent,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomAmountField() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.accent, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: TextField(
        controller: _customCtrl,
        keyboardType: TextInputType.number,
        onChanged: (value) => setState(() {}),
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.text,
        ),
        decoration: InputDecoration(
          prefixText: '₹  ',
          prefixStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.accent,
          ),
          hintText: '0.00',
          hintStyle: TextStyle(color: AppColors.muted, fontSize: 20),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  Widget _buildDonateButton() {
    final bool canDonate =
        _selectedAmount != null || _customCtrl.text.isNotEmpty;
    String buttonText = 'Select an amount';
    if (_selectedAmount != null) {
      buttonText = 'Donate ₹$_selectedAmount';
    } else if (_customCtrl.text.isNotEmpty) {
      buttonText = 'Donate ₹${_customCtrl.text}';
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border(
          top: BorderSide(color: AppColors.border, width: 1.0),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: canDonate
              ? () => _showDonationConfirmation(context, widget.campaign)
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accent,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
            disabledBackgroundColor: AppColors.border,
            disabledForegroundColor: AppColors.muted,
          ),
          child: Text(
            buttonText,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  void _showDonationConfirmation(BuildContext context, _Campaign c) {
    final amount = _selectedAmount?.toString() ?? _customCtrl.text;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => _DonationConfirmSheet(
        campaignTitle: c.title,
        amount: amount,
        color: c.color,
      ),
    );
  }
}

// ===== WIDGET: CONFIRMATION SHEET (POP-UP) =====
// Ha pop-up adhipramanech ahe, kahi badal nahi.
class _DonationConfirmSheet extends StatelessWidget {
  final String campaignTitle;
  final String amount;
  final Color color;

  const _DonationConfirmSheet({
    required this.campaignTitle,
    required this.amount,
    required this.color,
  });

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
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.favorite_rounded, color: color, size: 32),
            ),
            const SizedBox(height: 16),
            const Text(
              'Confirm Donation',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'You are donating ₹$amount to\n$campaignTitle',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: AppColors.muted, fontSize: 14, height: 1.5),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: AppColors.border),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Cancel',
                        style: TextStyle(color: AppColors.muted)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Pop-up band kara
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text(
                              '🎉 Donation successful! Thank you!'),
                          backgroundColor: AppColors.success,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Send Donation',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}