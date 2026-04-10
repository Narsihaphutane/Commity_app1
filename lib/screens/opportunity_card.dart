import 'package:flutter/material.dart';

class AppColors {
  static const accent = Color(0xFF7C83FD); // attache ahhe
  static const accent2 = Color(0xFF9EA3FF);
  static const accentSoft = Color(0xFFEEEFFF);
  static const bg = Color(0xFFF5F5FF);
  static const card = Color(0xFFFFFFFF);
  static const border = Color(0xFFE4E5FF);
  static const muted = Color(0xFF6B7280);
  static const text = Color(0xFF1A1A2E);
  static const success = Color(0xFF10B981);
  static const danger = Color(0xFFEF4444);
}

// Data model for an opportunity
class Opportunity {
  final String title;
  final String description;
  final String validTill;
  final String location;
  final String jobType;
  final int applications;
  final double views;
  final int saves;
  final double cvr;
  final bool isFeatured;
  final bool isPromoted;
  final String category;

  // These are no longer final to allow modification
  String status;
  bool isActive;
  bool isDraft;

  Opportunity({
    required this.category,
    required this.status,
    required this.title,
    required this.description,
    required this.validTill,
    required this.location,
    required this.jobType,
    required this.applications,
    required this.views,
    required this.saves,
    required this.cvr,
    this.isFeatured = false,
    this.isPromoted = false,
    this.isActive = true,
    this.isDraft = false,
  });
}

class OpportunityListScreen extends StatefulWidget {
  const OpportunityListScreen({super.key});

  @override
  State<OpportunityListScreen> createState() => _OpportunityListScreenState();
}

class _OpportunityListScreenState extends State<OpportunityListScreen> {
  String? selectedCategory;
  String? selectedType;
  String? selectedStatus;
  String? selectedSort;
  String searchQuery = '';

  // Main list of all opportunities
  final List<Opportunity> allOpportunities = [
    Opportunity(
      category: 'Jobs',
      status: 'Active',
      title: 'Frontend Developer Hiring',
      description: 'Hiring React developer for startup',
      validTill: '30 Sept',
      location: 'Remote',
      jobType: 'Full-time',
      applications: 45,
      views: 2.3,
      saves: 120,
      cvr: 2.0,
      isFeatured: true,
      isPromoted: true,
      isActive: true,
    ),
    Opportunity(
      category: 'Events',
      status: 'Expired',
      title: 'Startup Networking Meetup',
      description: 'Join 100+ founders in Delhi',
      validTill: 'Expired',
      location: 'Delhi',
      jobType: 'Free',
      applications: 120,
      views: 5.2,
      saves: 300,
      cvr: 3.5,
      isFeatured: false,
      isPromoted: true,
      isActive: false,
    ),
    Opportunity(
      category: 'Training',
      status: 'Draft',
      title: 'Digital Marketing Course',
      description: '6 weeks course with certificate',
      validTill: '15 Oct',
      location: 'Online',
      jobType: 'Paid',
      applications: 28,
      views: 0.89,
      saves: 65,
      cvr: 3.1,
      isFeatured: false,
      isPromoted: false,
      isActive: false,
      isDraft: true,
    ),
    Opportunity(
      category: 'Jobs',
      status: 'Active',
      title: 'Backend Developer (Node.js)',
      description: 'Looking for an experienced Node.js developer.',
      validTill: '15 Nov',
      location: 'Remote',
      jobType: 'Part-time',
      applications: 88,
      views: 4.1,
      saves: 210,
      cvr: 2.1,
      isFeatured: true,
      isPromoted: false,
      isActive: true,
    ),
    Opportunity(
      category: 'Funding',
      status: 'Active',
      title: 'Seed Funding for EdTech',
      description: 'Early-stage funding for innovative education startups.',
      validTill: '31 Dec',
      location: 'Online',
      jobType: 'Equity',
      applications: 15,
      views: 8.5,
      saves: 550,
      cvr: 0.1,
      isFeatured: false,
      isPromoted: true,
      isActive: true,
    ),
    Opportunity(
      category: 'Events',
      status: 'Active',
      title: 'Flutter Developers Conference',
      description: 'A 3-day virtual conference for Flutter enthusiasts.',
      validTill: '05 Oct',
      location: 'Online',
      jobType: 'Paid',
      applications: 250,
      views: 10.2,
      saves: 800,
      cvr: 2.4,
      isFeatured: true,
      isPromoted: true,
      isActive: true,
    ),
  ];

  List<Opportunity> filteredOpportunities = [];

  @override
  void initState() {
    super.initState();
    filteredOpportunities = List.from(allOpportunities);
  }

  void _filterAndSortOpportunities() {
    List<Opportunity> tempOpportunities = List.from(allOpportunities);

    if (searchQuery.isNotEmpty) {
      tempOpportunities = tempOpportunities.where((op) {
        return op.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
            op.description.toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    if (selectedCategory != null) {
      tempOpportunities = tempOpportunities
          .where((op) => op.category == selectedCategory)
          .toList();
    }

    if (selectedType != null) {
      tempOpportunities = tempOpportunities
          .where((op) => op.jobType == selectedType)
          .toList();
    }

    if (selectedStatus != null) {
      tempOpportunities = tempOpportunities
          .where((op) => op.status == selectedStatus)
          .toList();
    }

    if (selectedSort != null) {
      switch (selectedSort) {
        case 'Most Responses':
          tempOpportunities.sort(
            (a, b) => b.applications.compareTo(a.applications),
          );
          break;
        case 'Most Views':
          tempOpportunities.sort((a, b) => b.views.compareTo(a.views));
          break;
        case 'Latest':
          tempOpportunities.sort((a, b) => a.title.compareTo(b.title));
          break;
      }
    }

    setState(() {
      filteredOpportunities = tempOpportunities;
    });
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FilterBottomSheet(
        selectedCategory: selectedCategory,
        selectedType: selectedType,
        selectedStatus: selectedStatus,
        selectedSort: selectedSort,
        onApply: (category, type, status, sort) {
          setState(() {
            selectedCategory = category;
            selectedType = type;
            selectedStatus = status;
            selectedSort = sort;
          });
          _filterAndSortOpportunities();
        },
      ),
    );
  }

  void _showDeleteConfirmationDialog(Opportunity opportunity) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Opportunity'),
          content: const Text('Are you sure you want to delete this?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Yes',
                style: TextStyle(color: AppColors.danger),
              ),
              onPressed: () {
                _deleteOpportunity(opportunity);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteOpportunity(Opportunity opportunity) {
    setState(() {
      allOpportunities.remove(opportunity);
      _filterAndSortOpportunities();
    });
  }

  // Sets the status of an opportunity
  void _setOpportunityStatus(Opportunity opportunity, String newStatus) {
    setState(() {
      opportunity.status = newStatus;
      if (newStatus == 'Active') {
        opportunity.isActive = true;
        opportunity.isDraft = false;
      } else if (newStatus == 'Expired') {
        opportunity.isActive = false;
        opportunity.isDraft = false;
      } else if (newStatus == 'Draft') {
        opportunity.isActive = false;
        opportunity.isDraft = true;
      }
      _filterAndSortOpportunities();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.card,
                border: Border(
                  bottom: BorderSide(color: AppColors.border, width: 1),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '📢 My Opportunities',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.text,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.notifications_outlined),
                        color: AppColors.accent,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Search Bar
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.bg,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: TextField(
                            onChanged: (value) {
                              searchQuery = value;
                              _filterAndSortOpportunities();
                            },
                            decoration: const InputDecoration(
                              hintText: 'Search opportunities...',
                              hintStyle: TextStyle(color: AppColors.muted),
                              prefixIcon: Icon(
                                Icons.search,
                                color: AppColors.accent,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Filter Button
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.accent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          onPressed: _showFilterSheet,
                          icon: const Icon(Icons.tune),
                          color: Colors.white,
                          tooltip: 'Filters',
                        ),
                      ),
                    ],
                  ),
                  // Active Filters
                  if (selectedCategory != null ||
                      selectedType != null ||
                      selectedStatus != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          if (selectedCategory != null)
                            _buildFilterChip(selectedCategory!, () {
                              setState(() => selectedCategory = null);
                              _filterAndSortOpportunities();
                            }),
                          if (selectedType != null)
                            _buildFilterChip(selectedType!, () {
                              setState(() => selectedType = null);
                              _filterAndSortOpportunities();
                            }),
                          if (selectedStatus != null)
                            _buildFilterChip(selectedStatus!, () {
                              setState(() => selectedStatus = null);
                              _filterAndSortOpportunities();
                            }),
                        ],
                      ),
                    ),
                ],
              ),
            ),

            // Opportunity List
            Expanded(
              child: filteredOpportunities.isEmpty
                  ? const Center(
                      child: Text(
                        'No opportunities found.',
                        style: TextStyle(color: AppColors.muted, fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: filteredOpportunities.length,
                      itemBuilder: (context, index) {
                        final opportunity = filteredOpportunities[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: OpportunityCard(
                            opportunity: opportunity,
                            onDelete: () =>
                                _showDeleteConfirmationDialog(opportunity),
                            // MODIFIED: This button now ALWAYS makes the card Active
                            onPublish: () =>
                                _setOpportunityStatus(opportunity, 'Active'),
                            onStatusChange: (newStatus) =>
                                _setOpportunityStatus(opportunity, newStatus),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, VoidCallback onDelete) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.accentSoft,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.accent.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.accent,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: onDelete,
            child: const Icon(Icons.close, size: 16, color: AppColors.accent),
          ),
        ],
      ),
    );
  }
}

class FilterBottomSheet extends StatefulWidget {
  final String? selectedCategory;
  final String? selectedType;
  final String? selectedStatus;
  final String? selectedSort;
  final Function(String?, String?, String?, String?) onApply;

  const FilterBottomSheet({
    super.key,
    this.selectedCategory,
    this.selectedType,
    this.selectedStatus,
    this.selectedSort,
    required this.onApply,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late String? category;
  late String? type;
  late String? status;
  late String? sort;

  @override
  void initState() {
    super.initState();
    category = widget.selectedCategory;
    type = widget.selectedType;
    status = widget.selectedStatus;
    sort = widget.selectedSort;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
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
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Filters',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      category = null;
                      type = null;
                      status = null;
                      sort = null;
                    });
                  },
                  child: const Text(
                    'Reset',
                    style: TextStyle(color: AppColors.accent),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Category',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildChip('Jobs', category == 'Jobs', () {
                  setState(() => category = category == 'Jobs' ? null : 'Jobs');
                }),
                _buildChip('Events', category == 'Events', () {
                  setState(
                    () => category = category == 'Events' ? null : 'Events',
                  );
                }),
                _buildChip('Training', category == 'Training', () {
                  setState(
                    () => category = category == 'Training' ? null : 'Training',
                  );
                }),
                _buildChip('Funding', category == 'Funding', () {
                  setState(
                    () => category = category == 'Funding' ? null : 'Funding',
                  );
                }),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Type',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildChip('Full-time', type == 'Full-time', () {
                  setState(
                    () => type = type == 'Full-time' ? null : 'Full-time',
                  );
                }),
                _buildChip('Part-time', type == 'Part-time', () {
                  setState(
                    () => type = type == 'Part-time' ? null : 'Part-time',
                  );
                }),
                _buildChip('Remote', type == 'Remote', () {
                  setState(() => type = type == 'Remote' ? null : 'Remote');
                }),
                _buildChip('Equity', type == 'Equity', () {
                  setState(() => type = type == 'Equity' ? null : 'Equity');
                }),
                _buildChip('Paid', type == 'Paid', () {
                  setState(() => type = type == 'Paid' ? null : 'Paid');
                }),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Status',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildChip('Active', status == 'Active', () {
                  setState(() => status = status == 'Active' ? null : 'Active');
                }),
                _buildChip('Expired', status == 'Expired', () {
                  setState(
                    () => status = status == 'Expired' ? null : 'Expired',
                  );
                }),
                _buildChip('Draft', status == 'Draft', () {
                  setState(() => status = status == 'Draft' ? null : 'Draft');
                }),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Sort By',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildChip('Most Responses', sort == 'Most Responses', () {
                  setState(
                    () => sort = sort == 'Most Responses'
                        ? null
                        : 'Most Responses',
                  );
                }),
                _buildChip('Most Views', sort == 'Most Views', () {
                  setState(
                    () => sort = sort == 'Most Views' ? null : 'Most Views',
                  );
                }),
                _buildChip('Latest', sort == 'Latest', () {
                  setState(() => sort = sort == 'Latest' ? null : 'Latest');
                }),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  widget.onApply(category, type, status, sort);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Apply Filters',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.accent : AppColors.accentSoft,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.accent : AppColors.border,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : AppColors.text,
          ),
        ),
      ),
    );
  }
}

class OpportunityCard extends StatelessWidget {
  final Opportunity opportunity;
  final VoidCallback onDelete;
  final VoidCallback onPublish; // For the main button, always makes it "Active"
  final Function(String newStatus) onStatusChange; // For the "More" menu

  const OpportunityCard({
    super.key,
    required this.opportunity,
    required this.onDelete,
    required this.onPublish,
    required this.onStatusChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.accentSoft,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      opportunity.category,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.accent,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      opportunity.status,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: _getStatusTextColor(),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  if (opportunity.isFeatured)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.accentSoft,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        '⭐ Featured',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: AppColors.accent,
                        ),
                      ),
                    ),
                  if (opportunity.isFeatured && opportunity.isPromoted)
                    const SizedBox(width: 6),
                  if (opportunity.isPromoted)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.accentSoft,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        '🚀 Promoted',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: AppColors.accent,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Title & Description
          Text(
            opportunity.title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            opportunity.description,
            style: const TextStyle(fontSize: 14, color: AppColors.muted),
          ),
          const SizedBox(height: 12),

          // Meta Info
          Wrap(
            spacing: 12,
            runSpacing: 6,
            children: [
              _buildMetaItem('📅', opportunity.validTill),
              _buildMetaItem('📍', opportunity.location),
              _buildMetaItem('💼', opportunity.jobType),
            ],
          ),
          const SizedBox(height: 16),

          // Stats
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.bg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStat('Applications', opportunity.applications.toString()),
                _buildStat('Views', '${opportunity.views}K'),
                _buildStat('Saves', opportunity.saves.toString()),
                _buildStat('CVR', '${opportunity.cvr}%'),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Actions
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _buildActionButton(
                '👁 View',
                AppColors.bg,
                AppColors.text,
                () {},
              ),
              _buildActionButton(
                '✏️ Edit',
                AppColors.bg,
                AppColors.text,
                () {},
              ),
              // MODIFIED: Button text is always "Publish"
              _buildActionButton(
                'Publish',
                AppColors.accent,
                Colors.white,
                onPublish, // This callback now only makes the card "Active"
              ),
              _buildActionButton(
                '🗑 Delete',
                AppColors.danger.withOpacity(0.1),
                AppColors.danger,
                onDelete,
              ),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: AppColors.bg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: PopupMenuButton<String>(
                  onSelected: (value) {
                    // "More" menu still has its own logic
                    if (value == 'Republish') {
                      onStatusChange('Active');
                    } else if (value == 'Unpublish') {
                      onStatusChange('Expired');
                    }
                  },
                  icon: const Icon(Icons.more_vert, color: AppColors.muted),
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'Republish',
                          child: Text('Republish'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'Unpublish',
                          child: Text('Unpublish'),
                        ),
                      ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetaItem(String icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(icon, style: const TextStyle(fontSize: 12)),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(fontSize: 12, color: AppColors.muted),
        ),
      ],
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.text,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: AppColors.muted),
        ),
      ],
    );
  }

  Widget _buildActionButton(
    String label,
    Color bgColor,
    Color textColor,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ),
    );
  }

  Color _getStatusColor() {
    if (opportunity.status == 'Active')
      return AppColors.success.withOpacity(0.15);
    if (opportunity.status == 'Draft') return const Color(0xFFFEF9C3);
    return AppColors.danger.withOpacity(0.15);
  }

  Color _getStatusTextColor() {
    if (opportunity.status == 'Active') return AppColors.success;
    if (opportunity.status == 'Draft') return const Color(0xFFCA8A04);
    return AppColors.danger;
  }
}
