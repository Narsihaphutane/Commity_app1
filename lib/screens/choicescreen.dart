import 'package:commity_app1/shell.dart';
import 'package:commity_app1/theme.dart';
import 'package:flutter/material.dart';

class TopicSelectionScreen extends StatefulWidget {
  final bool isEditing;
  final List<String>? initialTopics;

  const TopicSelectionScreen({
    super.key,
    this.isEditing = false,
    this.initialTopics,
  });

  @override
  State<TopicSelectionScreen> createState() => _TopicSelectionScreenState();
}

class _TopicSelectionScreenState extends State<TopicSelectionScreen> {
  // Hardcoded list of topics, replacing the API call.
  final List<String> _allTopics = [
    'Flutter Development', 'UI/UX Design', 'Startups', 'Venture Capital',
    'Product Management', 'Digital Marketing', 'Artificial Intelligence',
    'Machine Learning', 'Data Science', 'Blockchain', 'Cybersecurity',
    'Cloud Computing', 'Web Development', 'Mobile Development', 'Gaming',
    'E-commerce', 'Fintech', 'Healthtech', 'Edutech', 'SaaS', 'Content Creation',
    'Photography', 'Videography', 'Music Production', 'Creative Writing',
    'Public Speaking', 'Leadership', 'Entrepreneurship', 'Investing',
    'Personal Finance', 'Fitness & Health', 'Travel', 'Cooking & Food',
  ];

  final Set<String> _selectedTopics = {};
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Pre-select topics if provided (for editing mode)
    if (widget.initialTopics != null) {
      _selectedTopics.addAll(widget.initialTopics!);
    }
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() => _searchQuery = _searchController.text.trim().toLowerCase());
  }

  // Filter the hardcoded list based on the search query
  List<String> get _filteredTopics {
    if (_searchQuery.isEmpty) return _allTopics;
    return _allTopics
        .where((topic) => topic.toLowerCase().contains(_searchQuery))
        .toList();
  }

  // Toggle selection for a topic (String)
  void _toggleSkill(String topic) {
    setState(() {
      if (_selectedTopics.contains(topic)) {
        _selectedTopics.remove(topic);
      } else {
        _selectedTopics.add(topic);
      }
    });
  }

  // Navigate to the next screen without an API call
  void _skip() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const AppShell()), // Use AppShell for consistency
      (route) => false,
    );
  }

  // "Saves" by navigating away. No API call is made.
  void _saveAndContinue() {
    if (_selectedTopics.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one interest'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // In a real app, you might save this to local storage or pass it forward.
    // For now, we just navigate.

    if (widget.isEditing) {
      // Pass back the selected topics to the previous screen
      Navigator.pop(context, _selectedTopics.toList());
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const AppShell()),
        (route) => false,
      );
    }
  }

  // Build the chip widget for a topic (String)
  Widget _buildTopicChip(String topic) {
    final isSelected = _selectedTopics.contains(topic);

    return Padding(
      padding: const EdgeInsets.only(right: 8, bottom: 10),
      child: InkWell(
        onTap: () => _toggleSkill(topic),
        borderRadius: BorderRadius.circular(30),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.lavender : AppTheme.softLavender,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: isSelected ? AppTheme.lavender : AppTheme.border,
              width: 1.5,
            ),
            boxShadow: isSelected
                ? [BoxShadow(color: AppTheme.lavender.withOpacity(0.3), blurRadius: 6, offset: const Offset(0, 2))]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isSelected) ...[
                const Icon(Icons.check_circle_rounded, color: Colors.white, size: 14),
                const SizedBox(width: 5),
              ],
              Text(
                topic,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: widget.isEditing
          ? AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
              title: const Text(
                'Edit Interests',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            )
          : null,
      body: Column(
        children: [
          // Header
          Padding(
            padding: EdgeInsets.fromLTRB(24, widget.isEditing ? 8 : 52, 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!widget.isEditing) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppTheme.softLavender,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.interests_rounded, color: AppTheme.lavender, size: 26),
                      ),
                      TextButton(
                        onPressed: _skip,
                        child: const Text(
                          'Skip',
                          style: TextStyle(
                            color: AppTheme.muted,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
                Text(
                  widget.isEditing
                      ? 'Update your interests'
                      : 'What are you into? 🎯',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  widget.isEditing
                      ? 'Add or remove topics to personalize your feed'
                      : 'Select at least 1 topic to personalize your experience',
                  style: const TextStyle(color: AppTheme.muted, fontSize: 14),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),

          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Search topics...',
                hintStyle: TextStyle(color: AppTheme.muted.withOpacity(0.7)),
                filled: true,
                fillColor: AppTheme.softLavender,
                prefixIcon: const Icon(Icons.search_rounded, color: AppTheme.muted),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded, color: AppTheme.muted),
                        onPressed: () {
                          _searchController.clear();
                          FocusScope.of(context).unfocus();
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppTheme.lavender, width: 2),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Topics list (no loading/error states needed)
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_selectedTopics.isNotEmpty) ...[
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppTheme.lavender,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${_selectedTopics.length} selected',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        TextButton(
                          onPressed: () => setState(() => _selectedTopics.clear()),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Clear all',
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                  Text(
                    _searchQuery.isEmpty ? 'All Topics' : 'Results',
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    children: _filteredTopics.map(_buildTopicChip).toList(),
                  ),
                  const SizedBox(height: 100), // Padding for bottom button
                ],
              ),
            ),
          ),
        ],
      ),

      // Bottom button
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(24, 16, 24, MediaQuery.of(context).padding.bottom + 16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SizedBox(
          height: 54,
          child: ElevatedButton(
            onPressed: _selectedTopics.isNotEmpty ? _saveAndContinue : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.lavender,
              foregroundColor: Colors.white,
              disabledBackgroundColor: AppTheme.lavender.withOpacity(0.4),
              disabledForegroundColor: Colors.white60,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: Text(
              widget.isEditing ? 'Update Interests' : 'Get Started →',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}