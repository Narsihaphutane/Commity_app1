import 'dart:io'; // ajj che screen  // today
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

// ─── App Colors ───────────────────────────────────────────────
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
}

// ─── Entry Point ──────────────────────────────────────────────

// ─── Main Screen ──────────────────────────────────────────────
class SubmitCampaignScreen extends StatefulWidget {
  const SubmitCampaignScreen({super.key});

  @override
  State<SubmitCampaignScreen> createState() => _SubmitCampaignScreenState();
}

class _SubmitCampaignScreenState extends State<SubmitCampaignScreen> {
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _websiteCtrl = TextEditingController();
  final _instructionsCtrl = TextEditingController();

  String _campaignType = 'Product';
  String _ctaType = 'Apply Now';

  final List<Map<String, dynamic>> _contentBlocks = [];

  final List<String> _campaignTypes = [
    'Product',
    'Job',
    'Event',
    'Training',
    'Charity',
  ];
  final List<String> _ctaTypes = ['Apply Now', 'Buy Now', 'Register', 'Donate'];
  final List<String> _contentTypes = ['Image', 'Video', 'PDF', 'Text'];

  void _addContentBlock() {
    setState(() {
      _contentBlocks.add({
        'type': 'Image',
        'urlCtrl': TextEditingController(),
        'captionCtrl': TextEditingController(),
      });
    });
  }

  void _removeContentBlock(int index) {
    setState(() {
      _contentBlocks[index]['urlCtrl'].dispose();
      _contentBlocks[index]['captionCtrl'].dispose();
      _contentBlocks.removeAt(index);
    });
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    _websiteCtrl.dispose();
    _instructionsCtrl.dispose();
    for (final b in _contentBlocks) {
      b['urlCtrl'].dispose();
      b['captionCtrl'].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: Color(0xFF7C83FD),
        elevation: 0,
        title: const Text(
          '  Submit Campaign Content',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.text,
          ),
        ),
        // 👇 BACK BUTTON
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.text),
          onPressed: () {
            Navigator.pop(context); // previous screen la jaato
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 100),
        children: [
          // ── Order Info ──
          _Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _SectionTitle('Order Info'),
                const SizedBox(height: 4),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(fontSize: 12, color: AppColors.muted),
                    children: [
                      TextSpan(
                        text: 'Order ID: ',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      TextSpan(text: 'ORD123  •  '),
                      TextSpan(
                        text: 'Package: ',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      TextSpan(
                        text: 'Startup Promotion  •  7 Posts  •  3 Days',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Campaign Details ──
          _Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _SectionTitle('Campaign Details'),
                const SizedBox(height: 8),
                _AppInput(controller: _titleCtrl, hint: 'Campaign Title'),
                _AppInput(
                  controller: _descCtrl,
                  hint: 'Describe your campaign',
                  maxLines: 3,
                ),
                _AppDropdown(
                  value: _campaignType,
                  items: _campaignTypes,
                  onChanged: (v) => setState(() => _campaignType = v!),
                ),
              ],
            ),
          ),

          // ── Upload Content ──
          _Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _SectionTitle('Upload Content'),
                const SizedBox(height: 8),
                ..._contentBlocks.asMap().entries.map((e) {
                  final i = e.key;
                  final b = e.value;
                  return _ContentBlock(
                    contentTypes: _contentTypes,
                    selectedType: b['type'],
                    urlCtrl: b['urlCtrl'],
                    captionCtrl: b['captionCtrl'],
                    onTypeChanged: (v) => setState(() => b['type'] = v!),
                    onRemove: () => _removeContentBlock(i),
                  );
                }),
                const SizedBox(height: 4),
                OutlinedButton.icon(
                  onPressed: _addContentBlock,
                  icon: const Icon(
                    Icons.add,
                    size: 16,
                    color: AppColors.accent,
                  ),
                  label: const Text(
                    '+ Add Content',
                    style: TextStyle(color: AppColors.accent, fontSize: 13),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.border),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: AppColors.accentSoft,
                  ),
                ),
              ],
            ),
          ),

          // ── CTA & Links ──
          _Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _SectionTitle('CTA & Links'),
                const SizedBox(height: 8),
                _AppDropdown(
                  value: _ctaType,
                  items: _ctaTypes,
                  onChanged: (v) => setState(() => _ctaType = v!),
                ),
                _AppInput(
                  controller: _websiteCtrl,
                  hint: 'Website / Landing Page',
                ),
              ],
            ),
          ),

          // ── Instructions ──
          _Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _SectionTitle('Instructions for Admin'),
                const SizedBox(height: 8),
                _AppInput(
                  controller: _instructionsCtrl,
                  hint: 'Any specific request or instruction',
                  maxLines: 3,
                ),
              ],
            ),
          ),

          // ── Preview ──
          _Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _SectionTitle('Preview'),
                const SizedBox(height: 10),
                ValueListenableBuilder(
                  valueListenable: _titleCtrl,
                  builder: (_, __, ___) => ValueListenableBuilder(
                    valueListenable: _descCtrl,
                    builder: (_, __, ___) => _PreviewCard(
                      title: _titleCtrl.text.isEmpty
                          ? 'Title'
                          : _titleCtrl.text,
                      description: _descCtrl.text.isEmpty
                          ? 'Description'
                          : _descCtrl.text,
                      cta: _ctaType,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // ── Bottom Bar ──
      bottomSheet: Container(
        color: AppColors.card,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    side: const BorderSide(color: AppColors.border),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Save Draft',
                    style: TextStyle(
                      color: AppColors.text,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Submit for Review',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Reusable Widgets ──────────────────────────────────────────

class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: child,
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: AppColors.text,
      ),
    );
  }
}

class _AppInput extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int maxLines;

  const _AppInput({
    required this.controller,
    required this.hint,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: const TextStyle(fontSize: 13, color: AppColors.text),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: AppColors.muted, fontSize: 13),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          filled: true,
          fillColor: AppColors.bg,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.accent, width: 1.5),
          ),
        ),
      ),
    );
  }
}

class _AppDropdown extends StatelessWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _AppDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: DropdownButtonFormField<String>(
        value: value,
        onChanged: onChanged,
        style: const TextStyle(fontSize: 13, color: AppColors.text),
        icon: const Icon(
          Icons.keyboard_arrow_down_rounded,
          color: AppColors.accent,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          filled: true,
          fillColor: AppColors.bg,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.accent, width: 1.5),
          ),
        ),
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
      ),
    );
  }
}

class _ContentBlock extends StatefulWidget {
  final List<String> contentTypes;
  final String selectedType;
  final TextEditingController urlCtrl;
  final TextEditingController captionCtrl;
  final ValueChanged<String?> onTypeChanged;
  final VoidCallback onRemove;

  const _ContentBlock({
    required this.contentTypes,
    required this.selectedType,
    required this.urlCtrl,
    required this.captionCtrl,
    required this.onTypeChanged,
    required this.onRemove,
  });

  @override
  State<_ContentBlock> createState() => _ContentBlockState();
}

/// yetun start image sathi // image video or file sathi package file picker and image_picker
class _ContentBlockState extends State<_ContentBlock> {
  String? _fileName;
  bool _isLoading = false;
  final TextEditingController _linkCtrl = TextEditingController();

  @override
  void dispose() {
    _linkCtrl.dispose();
    super.dispose();
  }

  // ── Pick file based on content type ──
  // Future<void> _pickFile() async {
  //   // hyne image, video, file add zala
  //   setState(() => _isLoading = true);
  //   try {
  //     if (widget.selectedType == 'Image') {
  //       final picked = await ImagePicker().pickImage(
  //         source: ImageSource.gallery,
  //         imageQuality: 85,
  //       );
  //       if (picked != null) {
  //         widget.urlCtrl.text = picked.path;
  //         setState(() => _fileName = picked.name);
  //       }
  //     } else if (widget.selectedType == 'Video') {
  //       final picked = await ImagePicker().pickVideo(
  //         source: ImageSource.gallery,
  //       );
  //       if (picked != null) {
  //         widget.urlCtrl.text = picked.path;
  //         setState(() => _fileName = picked.name);
  //       }
  //     } else if (widget.selectedType == 'PDF') {
  //       final result = await FilePicker.platform.pickFiles(
  //         type: FileType.custom,
  //         allowedExtensions: ['pdf'],
  //         withData: false,
  //         withReadStream: false,
  //       );
  //       if (result != null && result.files.single.path != null) {
  //         widget.urlCtrl.text = result.files.single.path!;
  //         setState(() => _fileName = result.files.single.name);
  //       }
  //     }
  //   } catch (e) {
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Failed to pick file: $e'),
  //           backgroundColor: AppColors.danger,
  //         ),
  //       );
  //     }
  //   } finally {
  //     if (mounted) setState(() => _isLoading = false);
  //   }
  // }

  void _clearFile() {
    widget.urlCtrl.clear();
    setState(() => _fileName = null);
  }

  IconData get _typeIcon => switch (widget.selectedType) {
    'Image' => Icons.image_outlined,
    'Video' => Icons.videocam_outlined,
    'PDF' => Icons.picture_as_pdf_outlined,
    _ => Icons.text_fields_outlined,
  };

  @override
  Widget build(BuildContext context) {
    final hasFile = _fileName != null;
    final isText = widget.selectedType == 'Text';

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.accent2, width: 1),
        color: AppColors.accentSoft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Type Dropdown ──
          _AppDropdown(
            value: widget.selectedType,
            items: widget.contentTypes,
            onChanged: (v) {
              widget.onTypeChanged(v);
              _clearFile(); // reset when type changes
            },
          ),

          // ── Upload area ──
          if (!isText) ...[
            // File selected → show filename chip
            if (hasFile) ...[
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.success.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Icon(_typeIcon, size: 16, color: AppColors.success),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _fileName!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.text,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    GestureDetector(
                      onTap: _clearFile,
                      child: const Icon(
                        Icons.close,
                        size: 16,
                        color: AppColors.muted,
                      ),
                    ),
                  ],
                ),
              ),
              // Image thumbnail preview
              if (widget.selectedType == 'Image') ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    File(widget.urlCtrl.text),
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ] else
              // No file → Upload button
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: SizedBox(
                  width: double.infinity,
                  // child: ElevatedButton.icon(
                  //   onPressed: _isLoading ? null : _pickFile,
                  //   icon: _isLoading
                  //       ? const SizedBox(
                  //           width: 14,
                  //           height: 14,
                  //           child: CircularProgressIndicator(
                  //             strokeWidth: 2,
                  //             color: Colors.white,
                  //           ),
                  //         )
                  //       : Icon(_typeIcon, size: 16),
                  //   label: Text(
                  //     _isLoading
                  //         ? 'Picking...'
                  //         : 'Upload ${widget.selectedType}',
                  //     style: const TextStyle(
                  //       fontSize: 13,
                  //       fontWeight: FontWeight.w600,
                  //     ),
                  //   ),
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: AppColors.accent,
                  //     foregroundColor: Colors.white,
                  //     padding: const EdgeInsets.symmetric(vertical: 11),
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //     elevation: 0,
                  //   ),
                  // ),
                ),
              ),
          ] else
            // Text type note
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: const [
                  Icon(Icons.info_outline, size: 14, color: AppColors.muted),
                  SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      'Write your text content in the caption below.',
                      style: TextStyle(fontSize: 12, color: AppColors.muted),
                    ),
                  ),
                ],
              ),
            ),

          // ── Caption ──
          _AppInput(
            controller: widget.captionCtrl,
            hint: isText ? 'Write your text content here...' : 'Caption',
            maxLines: 2,
          ),

          // ── URL / Link Box ──
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: TextField(
              controller: _linkCtrl,
              style: const TextStyle(fontSize: 13, color: AppColors.text),
              decoration: InputDecoration(
                hintText: 'Paste URL or file link (optional)',
                hintStyle: const TextStyle(
                  color: AppColors.muted,
                  fontSize: 12,
                ),
                prefixIcon: const Icon(
                  Icons.link_rounded,
                  size: 18,
                  color: AppColors.accent,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                filled: true,
                fillColor: AppColors.card,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: AppColors.accent,
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),

          // ── Remove ──
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: widget.onRemove,
              icon: const Icon(
                Icons.delete_outline,
                size: 16,
                color: AppColors.danger,
              ),
              label: const Text(
                'Remove',
                style: TextStyle(color: AppColors.danger, fontSize: 12),
              ),
              style: TextButton.styleFrom(
                backgroundColor: AppColors.danger.withOpacity(0.08),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PreviewCard extends StatelessWidget {
  final String title;
  final String description;
  final String cta;

  const _PreviewCard({
    required this.title,
    required this.description,
    required this.cta,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.accentSoft,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: const TextStyle(fontSize: 13, color: AppColors.muted),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              disabledBackgroundColor: AppColors.accent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: Text(
              cta,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
