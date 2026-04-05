import 'package:flutter/material.dart';


class AppColors {
  static const accent = Color(0xFF7C83FD);
  static const accentSoft = Color(0xFFEEEFFF);
  static const bg = Color(0xFFF5F5FF);
  static const card = Color(0xFFFFFFFF);
  static const border = Color(0xFFE4E5FF);
  static const muted = Color(0xFF6B7280);
  static const text = Color(0xFF1A1A2E);
  static const success = Color(0xFF10B981);
}


// Item chi mahiti thevnyasathi, 'details' navin add kela ahe.
class _GoodsItem {
  final String name;
  final String description;
  final String details; // HA NAVIN FIELD ADD KELA AHE
  final int price;
  final String unit;
  final IconData icon;
  final Color color;
  final String category;
  final int quantity;
  final int needed;

  const _GoodsItem({
    required this.name,
    required this.description,
    required this.details, // CONSTRUCTOR MADHE ADD KELA
    required this.price,
    required this.unit,
    required this.icon,
    required this.color,
    required this.category,
    required this.quantity,
    required this.needed,
  });
}

// ===== GOODS DONATION SCREEN (PAHLI SCREEN - LIST) =====
class GoodsDonationScreen extends StatelessWidget {
  const GoodsDonationScreen({super.key});

  // ITEM LIST MADHE 'details' PROPERTY ADD KELI AHE
  final List<_GoodsItem> _items = const [
    _GoodsItem(
      name: 'School Bag',
      description: 'Quality bags for underprivileged students',
      details:
          'A good quality school bag allows a child to carry their books and stationery safely, encouraging them to attend school regularly and focus on their studies without worry.',
      price: 350,
      unit: 'per bag',
      icon: Icons.backpack_rounded,
      color: Color(0xFF10B981),
      category: 'Education',
      quantity: 150,
      needed: 400,
    ),
    _GoodsItem(
      name: 'Food Kit',
      description: 'Monthly ration kit for one family',
      details:
          'This monthly ration kit provides essential food supplies like rice, dal, flour, and oil to a family in need, ensuring they have nutritious meals and food security for a month.',
      price: 800,
      unit: 'per kit',
      icon: Icons.food_bank_rounded,
      color: Color(0xFFF59E0B),
      category: 'Food',
      quantity: 80,
      needed: 200,
    ),
    _GoodsItem(
      name: 'School Uniform',
      description: 'Complete uniform set for a child',
      details:
          'A school uniform gives a child a sense of identity, belonging, and discipline. It removes visible markers of economic disparity among students, promoting equality in the classroom.',
      price: 450,
      unit: 'per set',
      icon: Icons.checkroom_rounded,
      color: Color(0xFF7C83FD),
      category: 'Education',
      quantity: 60,
      needed: 180,
    ),
    _GoodsItem(
      name: 'Medical Supplies',
      description: 'Basic first aid kit for rural clinics',
      details:
          'This first-aid kit contains essential medical supplies for treating common injuries and illnesses in rural areas where access to healthcare is limited. It can be a lifesaver in emergencies.',
      price: 600,
      unit: 'per kit',
      icon: Icons.medical_services_rounded,
      color: Color(0xFFEF4444),
      category: 'Health',
      quantity: 30,
      needed: 100,
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
            _buildInfoBanner(),
            const SizedBox(height: 20),
            const Text(
              'Items Needed',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 12),
            ..._items.map((item) => _buildGoodsCard(context, item)),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.accentSoft,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.info_outline_rounded,
                color: AppColors.accent, size: 22),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'You can either donate the cost of goods, or directly purchase & send them.',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.text,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  // YA CARD CHA UI ADHIPRAMANECH AHE, KAHIHI BADAL NAHI
  Widget _buildGoodsCard(BuildContext context, _GoodsItem item) {
    final progress = item.quantity / item.needed;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => GoodsDetailScreen(item: item),
        ));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: AppColors.accent.withOpacity(0.05),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: item.color.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(item.icon, color: item.color, size: 28),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              item.name,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: AppColors.text,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 2),
                              decoration: BoxDecoration(
                                color: item.color.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                item.category,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: item.color,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Text(
                          item.description,
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.muted),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${item.quantity} / ${item.needed} collected',
                        style: const TextStyle(
                            fontSize: 12, color: AppColors.muted),
                      ),
                      Text(
                        '${(progress * 100).toInt()}%',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: item.color,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 6,
                      backgroundColor: item.color.withOpacity(0.12),
                      valueColor: AlwaysStoppedAnimation<Color>(item.color),
                    ),
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

// ===== GOODS DETAIL SCREEN (ENHANCED & MORE INFORMATIVE) =====
class GoodsDetailScreen extends StatelessWidget {
  final _GoodsItem item;
  const GoodsDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final progress = item.quantity / item.needed;
    final remaining = item.needed - item.quantity;

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: Text(item.name, style: const TextStyle(color: AppColors.text)),
        backgroundColor: AppColors.card,
        elevation: 1,
        shadowColor: AppColors.border,
        iconTheme: const IconThemeData(color: AppColors.text),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with large icon
            Container(
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
                      color: item.color.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Icon(item.icon, color: item.color, size: 36),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.text,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${item.category} • ₹${item.price} ${item.unit}',
                          style: const TextStyle(
                              fontSize: 13, color: AppColors.muted),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // NAVIN "ABOUT" SECTION
            Container(
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
                  const Text('About this Item',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.text)),
                  const SizedBox(height: 8),
                  Text(
                    item.details,
                    style: const TextStyle(
                        fontSize: 13.5, color: AppColors.muted, height: 1.5),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // NAVIN "PROGRESS BREAKDOWN" SECTION
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Progress Breakdown',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.text)),
                  const SizedBox(height: 16),
                  _buildProgressRow(Icons.track_changes_rounded, 'Goal',
                      '${item.needed} items', item.color),
                  const Divider(height: 20, color: AppColors.border),
                  _buildProgressRow(Icons.check_circle_outline_rounded,
                      'Collected', '${item.quantity} items', AppColors.success),
                  const Divider(height: 20, color: AppColors.border),
                  _buildProgressRow(Icons.hourglass_empty_rounded, 'Remaining',
                      '$remaining items', Colors.orange),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 8,
                      backgroundColor: item.color.withOpacity(0.15),
                      valueColor: AlwaysStoppedAnimation<Color>(item.color),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // PAYMENT OPTIONS ADHIPRAMANECH AAHET
            const Text('Choose how to contribute',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _DonateMoneyOption(item: item)),
                const SizedBox(width: 10),
                Expanded(child: _BuyDirectOption(item: item)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // PROGRESS ROW BANAVNYASATHI HELPER WIDGET
  Widget _buildProgressRow(IconData icon, String label, String value, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 12),
        Text(label, style: const TextStyle(fontSize: 14, color: AppColors.muted)),
        const Spacer(),
        Text(value,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.text)),
      ],
    );
  }
}

// --- SHARED WIDGETS & MODALS (YA MADHE KAHI BADAL NAHI) ---

class _DonateMoneyOption extends StatelessWidget {
  final _GoodsItem item;
  const _DonateMoneyOption({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showPayConfirm(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.accentSoft,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.accent.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            const Icon(Icons.volunteer_activism_rounded,
                size: 24, color: AppColors.accent),
            const SizedBox(height: 8),
            Text(
              '₹${item.price}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.accent,
              ),
            ),
            const SizedBox(height: 2),
            const Text(
              'Donate Cost',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.accent,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPayConfirm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _GoodsPaySheet(item: item),
    );
  }
}

class _BuyDirectOption extends StatelessWidget {
  final _GoodsItem item;
  const _BuyDirectOption({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showBuySheet(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: item.color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: item.color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(Icons.shopping_cart_rounded, size: 24, color: item.color),
            const SizedBox(height: 8),
            Text(
              'Buy Now',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: item.color,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Purchase & Send',
              style: TextStyle(
                fontSize: 12,
                color: item.color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBuySheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => _GoodsBuySheet(item: item),
    );
  }
}

class _GoodsPaySheet extends StatelessWidget {
  final _GoodsItem item;
  const _GoodsPaySheet({required this.item});

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
                borderRadius: BorderRadius.circular(2),
              )),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: const BoxDecoration(
              color: AppColors.accentSoft,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.volunteer_activism_rounded,
                color: AppColors.accent, size: 30),
          ),
          const SizedBox(height: 16),
          const Text(
            'Confirm Donation',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.text),
          ),
          const SizedBox(height: 6),
          Text(
            'You are donating ₹${item.price} for one ${item.name}',
            style: const TextStyle(color: AppColors.muted, fontSize: 14),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(color: AppColors.border),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
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
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            '✅ ₹${item.price} donated for ${item.name}!'),
                        backgroundColor: AppColors.success,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: Text('Pay ₹${item.price}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _GoodsBuySheet extends StatefulWidget {
  final _GoodsItem item;
  const _GoodsBuySheet({required this.item});

  @override
  State<_GoodsBuySheet> createState() => _GoodsBuySheetState();
}

class _GoodsBuySheetState extends State<_GoodsBuySheet> {
  int _qty = 1;

  @override
  Widget build(BuildContext context) {
    final total = _qty * widget.item.price;
    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
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
          Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: widget.item.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(widget.item.icon,
                    color: widget.item.color, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item.name,
                      style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: AppColors.text),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '₹${widget.item.price} ${widget.item.unit}',
                      style: const TextStyle(
                          color: AppColors.muted, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.bg,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Quantity',
                    style: TextStyle(
                        fontSize: 14,
                        color: AppColors.text,
                        fontWeight: FontWeight.w500)),
                Row(
                  children: [
                    _qtyButton(Icons.remove_rounded, () {
                      if (_qty > 1) setState(() => _qty--);
                    }),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text('$_qty',
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: AppColors.text)),
                    ),
                    _qtyButton(Icons.add_rounded, () {
                      setState(() => _qty++);
                    }),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  widget.item.color.withOpacity(0.08),
                  widget.item.color.withOpacity(0.04)
                ],
              ),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: widget.item.color.withOpacity(0.2)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Amount',
                    style: TextStyle(
                        fontSize: 14,
                        color: AppColors.text,
                        fontWeight: FontWeight.w600)),
                Text(
                  '₹$total',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: widget.item.color,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        '🛍️ Order placed for $_qty ${widget.item.name}(s)!'),
                    backgroundColor: widget.item.color,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.item.color,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                elevation: 0,
              ),
              child: Text(
                'Buy & Send ₹$total',
                style: const TextStyle(
                    fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _qtyButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: AppColors.accentSoft,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 18, color: AppColors.accent),
      ),
    );
  }
}