import 'package:flutter/material.dart';

void main() {
  runApp(const NovaApp());
}

class NovaApp extends StatelessWidget {
  const NovaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nova',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF239BD8)),
        useMaterial3: true,
      ),
      home: const NovaShell(),
    );
  }
}

class NovaShell extends StatefulWidget {
  const NovaShell({super.key});

  @override
  State<NovaShell> createState() => _NovaShellState();
}

class _NovaShellState extends State<NovaShell> {
  int index = 0;

  static const screens = [
    _PlaceholderScreen(title: 'Chats'),
    _PlaceholderScreen(title: 'Calls'),
    _PlaceholderScreen(title: 'Status'),
    _PlaceholderScreen(title: 'Clips'),
    _PlaceholderScreen(title: 'Communities'),
    _PlaceholderScreen(title: 'Nova AI'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) => setState(() => index = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.chat_bubble_outline), label: 'Chats'),
          NavigationDestination(icon: Icon(Icons.call_outlined), label: 'Calls'),
          NavigationDestination(icon: Icon(Icons.circle_outlined), label: 'Status'),
          NavigationDestination(icon: Icon(Icons.play_circle_outline), label: 'Clips'),
          NavigationDestination(icon: Icon(Icons.groups_outlined), label: 'Communities'),
          NavigationDestination(icon: Icon(Icons.auto_awesome), label: 'AI'),
        ],
      ),
    );
  }
}

class _PlaceholderScreen extends StatelessWidget {
  const _PlaceholderScreen({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
