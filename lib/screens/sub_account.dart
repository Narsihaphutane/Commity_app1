
// Sub-Accounts Manager (Teal Theme) – Single-file Flutter demo
// Drop into lib/main.dart and run.
// Screens: List (search, status chips, actions) + Create/Edit form (email/mobile, relationship, roles, toggles, invite method).

import 'package:flutter/material.dart';

void main() => runApp(const SubAccountsApp());

class SubAccountsApp extends StatelessWidget {
  const SubAccountsApp({super.key});
  @override
  Widget build(BuildContext context) {
    final cs = ColorScheme.fromSeed(seedColor: const Color(0xFF00897B)); // teal
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sub-Accounts',
      theme: ThemeData(useMaterial3: true, colorScheme: cs),
      home: const SubAccountListScreen(),
    );
  }
}

/* ================== DATA ================== */

enum Relationship { child, spouse, parent, sibling, friend, colleague, other }
enum Role { viewer, contributor, manager }
enum InviteMethod { createAccount, sendLink }

class SubAccount {
  String id;
  String name;
  Relationship relationship;
  String? email;
  String? mobile;
  Role role;
  bool allowPersonalInfo;
  bool healthSync;
  bool notifications;
  String status; // Active | Invited | Suspended
  DateTime createdAt;

  SubAccount({
    required this.id,
    required this.name,
    required this.relationship,
    this.email,
    this.mobile,
    this.role = Role.viewer,
    this.allowPersonalInfo = true,
    this.healthSync = true,
    this.notifications = true,
    this.status = "Active",
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  SubAccount copy() => SubAccount(
        id: id,
        name: name,
        relationship: relationship,
        email: email,
        mobile: mobile,
        role: role,
        allowPersonalInfo: allowPersonalInfo,
        healthSync: healthSync,
        notifications: notifications,
        status: status,
        createdAt: createdAt,
      );
}

class SubAccountStore extends ChangeNotifier {
  final List<SubAccount> _items = [
    SubAccount(
      id: "1",
      name: "Aarav Sharma",
      relationship: Relationship.child,
      email: "aarav@example.com",
      mobile: "+91 90000 00001",
      role: Role.viewer,
      status: "Active",
    ),
    SubAccount(
      id: "2",
      name: "Riya Kapoor",
      relationship: Relationship.spouse,
      email: "riya@example.com",
      mobile: "+91 90000 00002",
      role: Role.contributor,
      status: "Invited",
    ),
    SubAccount(
      id: "3",
      name: "Raj Sharma",
      relationship: Relationship.parent,
      email: "raj@example.com",
      mobile: "+91 90000 00003",
      role: Role.manager,
      status: "Suspended",
    ),
  ];

  List<SubAccount> get items => List.unmodifiable(_items);

  void add(SubAccount a) {
    _items.add(a);
    notifyListeners();
  }

  void update(SubAccount a) {
    final i = _items.indexWhere((x) => x.id == a.id);
    if (i != -1) {
      _items[i] = a;
      notifyListeners();
    }
  }

  void remove(String id) {
    _items.removeWhere((x) => x.id == id);
    notifyListeners();
  }
}

final store = SubAccountStore();

/* ================== LIST SCREEN ================== */

class SubAccountListScreen extends StatefulWidget {
  const SubAccountListScreen({super.key});
  @override
  State<SubAccountListScreen> createState() => _SubAccountListScreenState();
}

class _SubAccountListScreenState extends State<SubAccountListScreen> {
  String query = "";
  String statusFilter = "All";

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sub-Accounts"),
        actions: [
          IconButton(
            tooltip: "Add Sub-Account",
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SubAccountFormScreen(mode: FormMode.create)),
              );
              setState(() {});
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: store,
        builder: (_, __) {
          final data = store.items.where((x) {
            final matchQuery = query.isEmpty ||
                x.name.toLowerCase().contains(query.toLowerCase()) ||
                (x.email ?? "").toLowerCase().contains(query.toLowerCase()) ||
                (x.mobile ?? "").toLowerCase().contains(query.toLowerCase());
            final matchStatus = statusFilter == "All" || x.status == statusFilter;
            return matchQuery && matchStatus;
          }).toList();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
                child: TextField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search name, email, or mobile",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (v) => setState(() => query = v),
                ),
              ),
              SizedBox(
                height: 44,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  children: [
                    _chip("All"),
                    _chip("Active"),
                    _chip("Invited"),
                    _chip("Suspended"),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemCount: data.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (_, i) => _SubAccountCard(item: data[i]),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => SubAccountFormScreen(mode: FormMode.create)),
          );
          setState(() {});
        },
        label: const Text("Add Sub-Account"),
        icon: const Icon(Icons.person_add_alt_1),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: cs.surface,
    );
  }

  Widget _chip(String label) {
    final selected = statusFilter == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => setState(() => statusFilter = label),
      ),
    );
  }
}

class _SubAccountCard extends StatelessWidget {
  final SubAccount item;
  const _SubAccountCard({required this.item});

  Color _statusColor(BuildContext context) {
    switch (item.status) {
      case "Active":
        return Colors.green;
      case "Invited":
        return Colors.orange;
      case "Suspended":
        return Colors.red;
      default:
        return Theme.of(context).colorScheme.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: cs.primaryContainer,
                child: Text(item.name.isNotEmpty ? item.name[0] : "?"),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 2),
                    Text("${_rel(item.relationship)} • ${_role(item.role)}",
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: _statusColor(context).withOpacity(.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(item.status, style: TextStyle(color: _statusColor(context), fontWeight: FontWeight.w600)),
              ),
              PopupMenuButton<String>(
                onSelected: (v) {
                  switch (v) {
                    case "edit":
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => SubAccountFormScreen(mode: FormMode.edit, existing: item)),
                      );
                      break;
                    case "invite":
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Joining link sent to ${item.email ?? item.mobile ?? 'contact'}")));
                      break;
                    case "suspend":
                      store.update(item.copy()..status = "Suspended");
                      break;
                    case "activate":
                      store.update(item.copy()..status = "Active");
                      break;
                    case "delete":
                      store.remove(item.id);
                      break;
                  }
                },
                itemBuilder: (_) => [
                  const PopupMenuItem(value: "edit", child: Text("Edit")),
                  const PopupMenuItem(value: "invite", child: Text("Resend joining link")),
                  if (item.status != "Suspended")
                    const PopupMenuItem(value: "suspend", child: Text("Suspend")),
                  if (item.status == "Suspended")
                    const PopupMenuItem(value: "activate", child: Text("Activate")),
                  const PopupMenuItem(value: "delete", child: Text("Delete")),
                ],
              )
            ]),
            const SizedBox(height: 8),
            if (item.email != null && item.email!.isNotEmpty)
              Row(children: [
                const Icon(Icons.email_outlined, size: 16),
                const SizedBox(width: 6),
                Text(item.email!),
              ]),
            if (item.mobile != null && item.mobile!.isNotEmpty)
              Row(children: [
                const Icon(Icons.phone_outlined, size: 16),
                const SizedBox(width: 6),
                Text(item.mobile!),
              ]),
            const SizedBox(height: 8),
            Wrap(spacing: 6, children: [
              if (item.allowPersonalInfo) const Chip(label: Text("Personal info")),
              if (item.healthSync) const Chip(label: Text("Health sync")),
              if (item.notifications) const Chip(label: Text("Notifications")),
            ]),
          ],
        ),
      ),
    );
  }
}

String _rel(Relationship r) => r.name[0].toUpperCase() + r.name.substring(1);
String _role(Role r) => r.name[0].toUpperCase() + r.name.substring(1);

/* ================== FORM SCREEN ================== */

enum FormMode { create, edit }

class SubAccountFormScreen extends StatefulWidget {
  final FormMode mode;
  final SubAccount? existing;
  const SubAccountFormScreen({super.key, required this.mode, this.existing});

  @override
  State<SubAccountFormScreen> createState() => _SubAccountFormScreenState();
}

class _SubAccountFormScreenState extends State<SubAccountFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameCtl = TextEditingController();
  final emailCtl = TextEditingController();
  final mobileCtl = TextEditingController();
  Relationship relationship = Relationship.child;
  Role role = Role.viewer;
  bool allowPersonalInfo = true;
  bool healthDataSync = true;
  bool notifications = true;
  InviteMethod inviteMethod = InviteMethod.createAccount;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    if (e != null) {
      nameCtl.text = e.name;
      emailCtl.text = e.email ?? "";
      mobileCtl.text = e.mobile ?? "";
      relationship = e.relationship;
      role = e.role;
      allowPersonalInfo = e.allowPersonalInfo;
      healthDataSync = e.healthSync;
      notifications = e.notifications;
      inviteMethod = e.status == "Invited" ? InviteMethod.sendLink : InviteMethod.createAccount;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.mode == FormMode.edit;
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? "Edit Sub-Account" : "Add Sub-Account")),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          children: [
            _section("Personal Info"),
            TextFormField(
              controller: nameCtl,
              decoration: const InputDecoration(labelText: "Sub-account Name", border: OutlineInputBorder()),
              validator: (v) => v == null || v.trim().isEmpty ? "Enter a name" : null,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<Relationship>(
              value: relationship,
              items: Relationship.values.map((e) => DropdownMenuItem(value: e, child: Text(_rel(e)))).toList(),
              onChanged: (v) => setState(() => relationship = v!),
              decoration: const InputDecoration(labelText: "Relationship", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: emailCtl,
              decoration: const InputDecoration(labelText: "Email", border: OutlineInputBorder()),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: mobileCtl,
              decoration: const InputDecoration(labelText: "Mobile (with country code)", border: OutlineInputBorder()),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 18),
            _section("Account Settings"),
            DropdownButtonFormField<Role>(
              value: role,
              items: Role.values.map((e) => DropdownMenuItem(value: e, child: Text(_role(e)))).toList(),
              onChanged: (v) => setState(() => role = v!),
              decoration: const InputDecoration(labelText: "Account Role", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 8),
            SwitchListTile(
              value: allowPersonalInfo,
              onChanged: (v) => setState(() => allowPersonalInfo = v),
              title: const Text("Allow access to personal info"),
            ),
            SwitchListTile(
              value: healthDataSync,
              onChanged: (v) => setState(() => healthDataSync = v),
              title: const Text("Enable health data sync"),
            ),
            SwitchListTile(
              value: notifications,
              onChanged: (v) => setState(() => notifications = v),
              title: const Text("Activity notifications"),
            ),
            const SizedBox(height: 18),
            _section("Invite Method"),
            SegmentedButton<InviteMethod>(
              segments: const [
                ButtonSegment(value: InviteMethod.createAccount, label: Text("Create Account"), icon: Icon(Icons.person_add_alt_1)),
                ButtonSegment(value: InviteMethod.sendLink, label: Text("Send Joining Link"), icon: Icon(Icons.link)),
              ],
              selected: {inviteMethod},
              onSelectionChanged: (s) => setState(() => inviteMethod = s.first),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _save,
                icon: const Icon(Icons.save_outlined),
                label: Text(isEdit ? "Save Changes" : "Create Sub-Account"),
              ),
            ),
            const SizedBox(height: 8),
            if (!isEdit && inviteMethod == InviteMethod.sendLink)
              Text("A secure invite link will be sent to the email/mobile provided.",
                  style: TextStyle(color: cs.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }

  Widget _section(String title) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
      );

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final isEdit = widget.mode == FormMode.edit;

    if (isEdit) {
      final e = widget.existing!.copy()
        ..name = nameCtl.text.trim()
        ..relationship = relationship
        ..email = emailCtl.text.trim().isEmpty ? null : emailCtl.text.trim()
        ..mobile = mobileCtl.text.trim().isEmpty ? null : mobileCtl.text.trim()
        ..role = role
        ..allowPersonalInfo = allowPersonalInfo
        ..healthSync = healthDataSync
        ..notifications = notifications
        ..status = inviteMethod == InviteMethod.sendLink ? "Invited" : "Active";
      store.update(e);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Sub-account updated")));
    } else {
      final id = DateTime.now().millisecondsSinceEpoch.toString();
      final a = SubAccount(
        id: id,
        name: nameCtl.text.trim(),
        relationship: relationship,
        email: emailCtl.text.trim().isEmpty ? null : emailCtl.text.trim(),
        mobile: mobileCtl.text.trim().isEmpty ? null : mobileCtl.text.trim(),
        role: role,
        allowPersonalInfo: allowPersonalInfo,
        healthSync: healthDataSync,
        notifications: notifications,
        status: inviteMethod == InviteMethod.createAccount ? "Active" : "Invited",
      );
      store.add(a);
      final msg = inviteMethod == InviteMethod.createAccount
          ? "Sub-account '${a.name}' created"
          : "Invite link sent to ${a.email ?? a.mobile ?? 'contact'}";
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    }
    Navigator.pop(context);
  }
}
