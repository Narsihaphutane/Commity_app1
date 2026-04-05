import 'package:commity_app1/services/post_api_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:commity_app1/model/post_model.dart';
import 'package:photo_manager/photo_manager.dart';
//import 'package:commity_app1/services/api_service.dart';

// ─── Gallery Picker Screen ────────────────────────────────────────────────────
class StoryGalleryPickerScreen extends StatefulWidget {
  const StoryGalleryPickerScreen({super.key});

  @override
  State<StoryGalleryPickerScreen> createState() =>
      _StoryGalleryPickerScreenState();
}

class _StoryGalleryPickerScreenState extends State<StoryGalleryPickerScreen> {
  List<AssetEntity> _allAssets = [];
  AssetEntity? _previewAsset;
  Uint8List? _previewBytes;
  bool _multiMode = false;
  final List<AssetEntity> _selected = [];
  bool _loading = true;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final ps = await PhotoManager.requestPermissionExtend();
    if (!ps.isAuth && !ps.hasAccess) {
      if (mounted) setState(() => _loading = false);
      return;
    }

    final albums = await PhotoManager.getAssetPathList(
      type: RequestType.image,
      onlyAll: true,
      filterOption: FilterOptionGroup(
        orders: [const OrderOption(type: OrderOptionType.createDate, asc: false)],
      ),
    );
    if (albums.isEmpty || !mounted) {
      setState(() => _loading = false);
      return;
    }

    final total = await albums[0].assetCountAsync;
    final assets = await albums[0].getAssetListRange(start: 0, end: total);

    if (!mounted) return;
    setState(() {
      _allAssets = assets;
      _loading = false;
    });

    if (assets.isNotEmpty) _setPreview(assets[0]);
  }

  Future<void> _setPreview(AssetEntity asset) async {
    setState(() {
      _previewAsset = asset;
      _previewBytes = null;
    });
    final bytes = await asset.thumbnailDataWithSize(
        const ThumbnailSize(1080, 1080),
        quality: 95);
    if (mounted) setState(() => _previewBytes = bytes);
  }

  void _tapAsset(AssetEntity asset) async {
    if (_multiMode) {
      final i = _selected.indexWhere((a) => a.id == asset.id);
      setState(() {
        if (i >= 0) {
          _selected.removeAt(i);
        } else {
          _selected.add(asset);
        }
      });
      await _setPreview(asset);
    } else {
      await _setPreview(asset);
    }
  }

  bool _isSelected(AssetEntity asset) {
    if (_multiMode) return _selected.any((a) => a.id == asset.id);
    return asset.id == _previewAsset?.id;
  }

  int _selIdx(AssetEntity asset) =>
      _selected.indexWhere((a) => a.id == asset.id) + 1;

  void _toggleMulti() {
    setState(() {
      _multiMode = !_multiMode;
      if (_multiMode) {
        _selected.clear();
        if (_previewAsset != null) _selected.add(_previewAsset!);
      } else {
        _selected.clear();
      }
    });
  }

  Future<void> _openCamera() async {
    final p = await _picker.pickImage(
        source: ImageSource.camera, imageQuality: 85);
    if (p != null && mounted) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => CaptionScreen(images: [File(p.path)])));
    }
  }

  Future<void> _onNext() async {
    List<File> files = [];
    if (_multiMode && _selected.isNotEmpty) {
      final r = await Future.wait(_selected.map((a) => a.file));
      files = r.whereType<File>().toList();
    } else if (_previewAsset != null) {
      final f = await _previewAsset!.file;
      if (f != null) files = [f];
    }
    if (files.isNotEmpty && mounted) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => CaptionScreen(images: files)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('New Post',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 17)),
        actions: [
          GestureDetector(
            onTap: _toggleMulti,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: _multiMode ? Colors.blue : Colors.white24,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _multiMode && _selected.isNotEmpty
                    ? '${_selected.length} selected'
                    : 'Select',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          TextButton(
            onPressed: (_multiMode ? _selected.isNotEmpty : _previewAsset != null)
                ? _onNext
                : null,
            child: Text('Next',
                style: TextStyle(
                  color: (_multiMode
                          ? _selected.isNotEmpty
                          : _previewAsset != null)
                      ? Colors.blue
                      : Colors.grey,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                )),
          ),
        ],
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: _previewBytes != null
                ? Image.memory(_previewBytes!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    gaplessPlayback: true)
                : Container(
                    color: const Color(0xFF1A1A1A),
                    child: _loading
                        ? const Center(
                            child: CircularProgressIndicator(
                                color: Colors.white38, strokeWidth: 2))
                        : null),
          ),
          Container(
            color: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(children: [
                  Text('Recents',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15)),
                  SizedBox(width: 4),
                  Icon(Icons.keyboard_arrow_down,
                      color: Colors.white, size: 20),
                ]),
                GestureDetector(
                  onTap: _openCamera,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.grey[800], shape: BoxShape.circle),
                    child: const Icon(Icons.camera_alt,
                        color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _loading
                ? const Center(
                    child: CircularProgressIndicator(
                        color: Colors.white38, strokeWidth: 2))
                : _allAssets.isEmpty
                    ? const Center(
                        child: Text('No photos found',
                            style: TextStyle(color: Colors.white54)))
                    : GridView.builder(
                        padding: EdgeInsets.zero,
                        cacheExtent: 600,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 1.5,
                          mainAxisSpacing: 1.5,
                        ),
                        itemCount: _allAssets.length,
                        itemBuilder: (ctx, i) {
                          final asset = _allAssets[i];
                          final sel = _isSelected(asset);
                          final idx = _multiMode ? _selIdx(asset) : 0;
                          return GestureDetector(
                            onTap: () => _tapAsset(asset),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                _Thumb(key: ValueKey(asset.id), asset: asset),
                                if (sel) Container(color: Colors.black38),
                                Positioned(
                                  top: 4,
                                  right: 4,
                                  child: Container(
                                    width: 22,
                                    height: 22,
                                    decoration: BoxDecoration(
                                      color: sel
                                          ? Colors.blue
                                          : Colors.transparent,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: sel
                                            ? Colors.white
                                            : Colors.white60,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: sel
                                        ? Center(
                                            child: _multiMode
                                                ? Text('$idx',
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.bold))
                                                : const Icon(Icons.check,
                                                    color: Colors.white,
                                                    size: 13))
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}

// ─── Thumb ────────────────────────────────────────────────────────────────────
class _Thumb extends StatefulWidget {
  final AssetEntity asset;
  const _Thumb({required Key key, required this.asset}) : super(key: key);

  @override
  State<_Thumb> createState() => _ThumbState();
}

class _ThumbState extends State<_Thumb> {
  Uint8List? _bytes;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final b = await widget.asset.thumbnailDataWithSize(
        const ThumbnailSize(200, 200),
        quality: 75);
    if (mounted && b != null) setState(() => _bytes = b);
  }

  @override
  Widget build(BuildContext context) {
    if (_bytes == null) return Container(color: const Color(0xFF2A2A2A));
    return Image.memory(_bytes!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        gaplessPlayback: true);
  }
}

// ─── Caption Screen ───────────────────────────────────────────────────────────
class CaptionScreen extends StatefulWidget {
  final List<File> images;
  const CaptionScreen({super.key, required this.images});

  @override
  State<CaptionScreen> createState() => _CaptionScreenState();
}

class _CaptionScreenState extends State<CaptionScreen> {
  final _caption = TextEditingController();
  String _location = '';
  String _tags = '';
  bool _posting = false;

  @override
  void dispose() {
    _caption.dispose();
    super.dispose();
  }

  Future<void> _post() async {
    if (_caption.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please write a caption'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _posting = true);

    try {
      // ✅ 1. Create post in database
      final response = await ApiService.createPost(
        contentType: 'post',
        visibility: 'public',
        label: _caption.text.trim(),
        tags: _tags.isNotEmpty ? _tags : null,
        location: _location.isNotEmpty ? _location : null,
        vendorId: 1, // TODO: Replace with actual logged-in user ID
        siteId: 1,
      );

      if (response['success'] == true) {
        final postId = int.parse(response['data']['post_id'].toString());
        
        // ✅ 2. Upload images
        if (widget.images.isNotEmpty) {
          final uploadResponse = await ApiService.uploadPostImages(
            postId: postId,
            imagePaths: widget.images.map((f) => f.path).toList(),
          );
          
          print('Upload Result: $uploadResponse');
        }

        // ✅ 3. Add to local feed
        globalPosts.insert(
          0,
          Post(
            id: postId.toString(),
            username: "Narsiha", // TODO: Replace with actual username
            userImage: "https://picsum.photos/100/100?random=99",
            postImages: widget.images.map((e) => e.path).toList(),
            likes: 0,
            caption: _caption.text,
            timeAgo: "Just now",
            comments: 0,
            shares: 0,
          ),
        );

        if (!mounted) return;
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("✅ Post shared successfully! 🎉"),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );

        await Future.delayed(const Duration(milliseconds: 300));
        
        if (mounted) {
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      } else {
        throw Exception(response['message'] ?? 'Failed to create post');
      }
    } catch (e) {
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('❌ Error: ${e.toString()}'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _posting = false);
      }
    }
  }

  Future<String?> _showTagsDialog() async {
    final controller = TextEditingController(text: _tags);
    
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Tags'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'e.g., launch,product,new',
            helperText: 'Separate tags with commas',
            border: OutlineInputBorder(),
          ),
          maxLines: 2,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('New Post',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 18)),
        actions: [
          _posting
              ? const Padding(
                  padding: EdgeInsets.all(16),
                  child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.blue)))
              : TextButton(
                  onPressed: _post,
                  child: const Text('Share',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w700,
                          fontSize: 16))),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: const NetworkImage(
                        'https://picsum.photos/100/100?random=99'),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _caption,
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: 'Write a caption...',
                        hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 15),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(widget.images[0],
                        width: 70, height: 70, fit: BoxFit.cover),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, thickness: 0.5),
            
            _opt(
              icon: Icons.tag,
              title: _tags.isEmpty ? 'Add Tags' : _tags,
              titleColor: _tags.isEmpty ? Colors.black : Colors.blue,
              onTap: () async {
                final tags = await _showTagsDialog();
                if (tags != null && tags.isNotEmpty) {
                  setState(() => _tags = tags);
                }
              },
            ),
            const Divider(height: 1, thickness: 0.5),
            
            _opt(
                icon: Icons.person_add_outlined,
                title: 'Tag People',
                onTap: () {}),
            const Divider(height: 1, thickness: 0.5),
            _opt(
              icon: Icons.location_on_outlined,
              title: _location.isEmpty ? 'Add Location' : _location,
              titleColor: _location.isEmpty ? Colors.black : Colors.blue,
              onTap: () async {
                final loc = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const LocationPickerScreen()));
                if (loc != null) setState(() => _location = loc);
              },
            ),
            const Divider(height: 1, thickness: 0.5),
            _opt(
                icon: Icons.tune,
                title: 'Advanced Settings',
                onTap: () {}),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _opt({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? titleColor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(children: [
          Icon(icon, size: 24, color: Colors.black),
          const SizedBox(width: 12),
          Expanded(
              child: Text(title,
                  style: TextStyle(
                      fontSize: 15, color: titleColor ?? Colors.black))),
          const Icon(Icons.chevron_right, size: 22, color: Colors.grey),
        ]),
      ),
    );
  }
}

// ─── Location Picker ──────────────────────────────────────────────────────────
class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  final _search = TextEditingController();
  final List<Map<String, String>> _all = [
    {'name': 'Mumbai, Maharashtra', 'type': 'City'},
    {'name': 'Gateway of India', 'type': 'Monument'},
    {'name': 'Marine Drive', 'type': 'Beach Road'},
    {'name': 'Colaba Causeway', 'type': 'Shopping Area'},
    {'name': 'Bandra', 'type': 'Suburb'},
    {'name': 'Andheri', 'type': 'Suburb'},
    {'name': 'Juhu Beach', 'type': 'Beach'},
    {'name': 'Phoenix Palladium', 'type': 'Mall'},
  ];
  List<Map<String, String>> _filtered = [];

  @override
  void initState() {
    super.initState();
    _filtered = _all;
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  void _filter(String q) {
    setState(() {
      _filtered = q.isEmpty
          ? _all
          : _all
              .where((l) =>
                  l['name']!.toLowerCase().contains(q.toLowerCase()))
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context)),
        title: const Text('Add Location',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 18)),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextField(
            controller: _search,
            onChanged: _filter,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Search locations...',
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
              prefixIcon:
                  const Icon(Icons.search, color: Colors.grey, size: 22),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 14),
            ),
          ),
        ),
        ListTile(
          onTap: () => Navigator.pop(context, 'Current Location'),
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                shape: BoxShape.circle),
            child: const Icon(Icons.my_location,
                color: Colors.blue, size: 20),
          ),
          title: const Text('Current Location',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
        ),
        const Divider(height: 1),
        Expanded(
          child: ListView.builder(
            itemCount: _filtered.length,
            itemBuilder: (ctx, i) {
              final loc = _filtered[i];
              return ListTile(
                onTap: () => Navigator.pop(context, loc['name']),
                leading: const Icon(Icons.location_on_outlined,
                    color: Colors.grey, size: 22),
                title: Text(loc['name']!,
                    style: const TextStyle(fontSize: 15)),
                subtitle: Text(loc['type']!,
                    style: const TextStyle(
                        fontSize: 13, color: Colors.grey)),
              );
            },
          ),
        ),
      ]),
    );
  }
}