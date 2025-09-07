import 'package:custom_components/components/buttons/custom_button.dart';
import 'package:custom_components/constants/dimens.dart';
import 'package:flutter/material.dart';
import 'package:neon_others_challenge/feature/chat_app/chat_page.dart';
import 'package:neon_others_challenge/feature/coral/coral_home_page.dart';
import 'package:neon_others_challenge/feature/ticketmaster_event_app/events.dart';
import 'package:neon_others_challenge/feature/form_db/form_page.dart';
import 'package:neon_others_challenge/feature/magic/ulfr_magic_home.dart';
import 'package:neon_others_challenge/feature/music/music_page.dart';
import 'package:neon_others_challenge/feature/task_manager/task_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _navigate(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      {'title': 'Coral Memory Fragments', 'page': CoralHomePage()},
      {'title': 'Ticketmaster Events', 'page': const EventsPage()},
      {'title': 'Heroes Form (SQLite)', 'page': HeroFormPage()},
      {'title': "Ulfr's Magic (Animations)", 'page': const UlfrMagicHome()},
      {'title': 'iTunes Song Search', 'page': const ITunesSearchPage()},
      {'title': 'Task Management', 'page': TaskPage()},
      {'title': 'Chat', 'page': ChatPage()},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Neon Others Challenge')),
      body: ListView.separated(
        padding: Dimens.paddingLarge,
        itemCount: pages.length,
        separatorBuilder: (_, __) => SizedBox(height: Dimens.spaceXLarge),
        itemBuilder: (context, index) {
          final item = pages[index];
          return CustomButton(
            onPressed: () => _navigate(context, item['page'] as Widget),
            text: item['title'] as String,
          );
        },
      ),
    );
  }
}
