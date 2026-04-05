import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState
    extends State<NotificationsScreen> {

  String selectedTab = "All";

  final tabs = [
    "All",
    "Mentions",
    "Payments",
    "Community",
    "System"
  ];

  List<Map<String, dynamic>> notifications = [
    {
      "title": "Rohit liked your post",
      "type": "Mentions",
      "time": "Today",
      "unread": true
    },
    {
      "title": "Payment received ₹499",
      "type": "Payments",
      "time": "Today",
      "unread": false
    },
    {
      "title": "New join request pending",
      "type": "Community",
      "time": "Yesterday",
      "unread": true
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = notifications.where((n) {
      if (selectedTab == "All") return true;
      return n["type"] == selectedTab;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        actions: [
          TextButton(
              onPressed: () {
                setState(() {
                  for (var n in notifications) {
                    n["unread"] = false;
                  }
                });
              },
              child: const Text("Mark All Read"))
        ],
      ),
      body: Column(
        children: [

          /// FILTER TABS
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: tabs.map((t) {
                final active = selectedTab == t;
                return Padding(
                  padding: const EdgeInsets.all(6),
                  child: ChoiceChip(
                    label: Text(t),
                    selected: active,
                    onSelected: (_) =>
                        setState(() => selectedTab = t),
                  ),
                );
              }).toList(),
            ),
          ),

          const Divider(),

          /// LIST
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (_, i) {
                final n = filtered[i];

                return Dismissible(
                  key: UniqueKey(),
                  background:
                      Container(color: Colors.red),
                  onDismissed: (_) {
                    setState(() {
                      notifications.remove(n);
                    });
                  },
                  child: ListTile(
                    leading: const CircleAvatar(
                        child: Icon(Icons.notifications)),
                    title: Text(n["title"]),
                    subtitle: Text(n["time"]),
                    trailing: n["unread"]
                        ? const Icon(Icons.circle,
                            size: 10,
                            color: Colors.red)
                        : null,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
