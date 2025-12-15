import 'package:flutter/material.dart';
import 'package:rick_clean_app/features/api_characters/view/api_character_dropdown_page.dart';
import '../../features/api_characters/view/api_characters_list_page.dart';
import '../../features/preferences/view/character_preferences_page.dart';

class AppRoutes {
  static const apiList = '/api-list';
  static const prefs = '/prefs';
  static const characternewprefs = '/prefs/new';

  static Map<String, WidgetBuilder> get routes => {
    apiList: (_) => const ApiListPage(),
    prefs: (_) => const CharacterPreferencesPage(),
    characternewprefs: (_) => const CharacterNewPreferencePage(),
  };
}
