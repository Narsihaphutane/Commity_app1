import 'package:commity_app1/screens/commity_admin.dart';
import 'package:flutter/material.dart';
// ✅ import

class InviteMembersScreen extends StatefulWidget {
  final String groupName;
  final String privacy;

  const InviteMembersScreen({
    super.key,
    required this.groupName,
    required this.privacy,
  });

  @override
  State<InviteMembersScreen> createState() => _InviteMembersScreenState();
}

class _InviteMembersScreenState extends State<InviteMembersScreen> {
  String searchQuery = "";

  List<Map<String, dynamic>> people = [
    {"name": "Bhanu Tyagi Adv", "invited": false},
    {"name": "Adv Ankit Kumar", "invited": false},
    {"name": "Jagadish TG", "invited": false},
    {"name": "Ajay Prakash Agnihotri", "invited": false},
    {"name": "Adv Daksh Sharma", "invited": false},
    {"name": "Adv Salman Shaykh", "invited": false},
    {"name": "Adv Garima Chaudhary", "invited": false},
    {"name": "Adv Ritik Sonkar", "invited": false},
  ];

  List<Map<String, dynamic>> get filteredPeople {
    return people.where((person) {
      return person["name"]
          .toLowerCase()
          .contains(searchQuery.toLowerCase());
    }).toList();
  }

  int get invitedCount => people.where((p) => p["invited"] == true).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Invite people",
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            // ✅ Show group name + privacy badge
            Row(
              children: [
                Text(
                  widget.groupName,
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 1,
                  ),
                  decoration: BoxDecoration(
                    color: widget.privacy == 'Private'
                        ? const Color(0xFFFFF3E0)
                        : const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        widget.privacy == 'Private'
                            ? Icons.lock_outline
                            : Icons.public,
                        size: 10,
                        color: widget.privacy == 'Private'
                            ? Colors.orange
                            : Colors.green,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        widget.privacy,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: widget.privacy == 'Private'
                              ? Colors.orange
                              : Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
                  // ✅ Next/Skip दोन्ही → CommunityPrivateAdminView
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CommunityPrivateAdminView(
                        groupName: widget.groupName,
                        privacy: widget.privacy,
                      ),
                    ),
                  );
                },
            child: Text(
              invitedCount > 0 ? "Next ($invitedCount)" : "Next",
              style: TextStyle(
                color: invitedCount > 0
                    ? const Color(0xff8F7CFF)
                    : const Color(0xFF6B7280),
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, color: Color(0xFFE5E7EB)),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ✅ Privacy info banner
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: widget.privacy == 'Private'
                  ? const Color(0xFFFFF3E0)
                  : const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: widget.privacy == 'Private'
                    ? const Color(0xFFFF9800)
                    : const Color(0xFF4CAF50),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  widget.privacy == 'Private'
                      ? Icons.lock_outline
                      : Icons.public,
                  color: widget.privacy == 'Private'
                      ? Colors.orange
                      : Colors.green,
                  size: 18,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    widget.privacy == 'Private'
                        ? "Private group — Only invited followers can join & view posts."
                        : "Public group — Anyone can find and view this group's posts.",
                    style: const TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),

          // INVITE OPTIONS
          _inviteOption(
            Icons.link,
            "Invite with link",
            "Invite people to this group with a link",
          ),
          _inviteOption(
            Icons.email_outlined,
            "Invite with email",
            "Send an email invite to people",
          ),

          _simpleOption("Suggested friends"),
          _simpleOption("Friends in Kolhapur, India"),

          const SizedBox(height: 16),

          // SEARCH
          TextField(
            decoration: InputDecoration(
              hintText: "Search for people",
              prefixIcon: const Icon(Icons.search, color: Color(0xFF9CA3AF)),
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
            ),
            onChanged: (v) => setState(() => searchQuery = v),
          ),

          const SizedBox(height: 20),

          const Text(
            "Suggested",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          // PEOPLE LIST
          ...filteredPeople.map((person) => _personTile(person)),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _inviteOption(IconData icon, String title, String subtitle) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      leading: CircleAvatar(
        backgroundColor: const Color(0xFFE8E5FF),
        child: Icon(icon, color: const Color(0xff8F7CFF)),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
      ),
      onTap: () {},
    );
  }

  Widget _simpleOption(String title) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 2),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 14,
        color: Color(0xFF6B7280),
      ),
      onTap: () {},
    );
  }

  Widget _personTile(Map<String, dynamic> person) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      leading: CircleAvatar(
        backgroundColor: const Color(0xFFE8E5FF),
        child: Text(
          person["name"][0],
          style: const TextStyle(
            color: Color(0xff8F7CFF),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(
        person["name"],
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      trailing: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: person["invited"]
              ? Colors.grey.shade300
              : const Color(0xff8F7CFF),
          foregroundColor:
              person["invited"] ? Colors.black54 : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          elevation: 0,
        ),
        onPressed: () {
          setState(() {
            person["invited"] = !person["invited"];
          });
        },
        child: Text(
          person["invited"] ? "Invited ✓" : "Invite",
          style: const TextStyle(fontSize: 13),
        ),
      ),
    );
  }
}