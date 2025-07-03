// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `TickNote`
  String get title {
    return Intl.message(
      'TickNote',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `الإعدادات`
  String get settingsSubtitle {
    return Intl.message(
      'الإعدادات',
      name: 'settingsSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Change light and dark appearance`
  String get themeSubtitle {
    return Intl.message(
      'Change light and dark appearance',
      name: 'themeSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Change app language`
  String get languageSubtitle {
    return Intl.message(
      'Change app language',
      name: 'languageSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Notification settings`
  String get notificationsSubtitle {
    return Intl.message(
      'Notification settings',
      name: 'notificationsSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Backup`
  String get backup {
    return Intl.message(
      'Backup',
      name: 'backup',
      desc: '',
      args: [],
    );
  }

  /// `Save and restore data`
  String get backupSubtitle {
    return Intl.message(
      'Save and restore data',
      name: 'backupSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `App information and version`
  String get aboutSubtitle {
    return Intl.message(
      'App information and version',
      name: 'aboutSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get help {
    return Intl.message(
      'Help',
      name: 'help',
      desc: '',
      args: [],
    );
  }

  /// `Support and FAQ`
  String get helpSubtitle {
    return Intl.message(
      'Support and FAQ',
      name: 'helpSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Select Theme`
  String get selectTheme {
    return Intl.message(
      'Select Theme',
      name: 'selectTheme',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get lightTheme {
    return Intl.message(
      'Light',
      name: 'lightTheme',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get darkTheme {
    return Intl.message(
      'Dark',
      name: 'darkTheme',
      desc: '',
      args: [],
    );
  }

  /// `Auto`
  String get autoTheme {
    return Intl.message(
      'Auto',
      name: 'autoTheme',
      desc: '',
      args: [],
    );
  }

  /// `Select Language`
  String get selectLanguage {
    return Intl.message(
      'Select Language',
      name: 'selectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arabicLanguage {
    return Intl.message(
      'Arabic',
      name: 'arabicLanguage',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get englishLanguage {
    return Intl.message(
      'English',
      name: 'englishLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Notification settings coming soon`
  String get notificationSettingsComingSoon {
    return Intl.message(
      'Notification settings coming soon',
      name: 'notificationSettingsComingSoon',
      desc: '',
      args: [],
    );
  }

  /// `Backup options coming soon`
  String get backupOptionsComingSoon {
    return Intl.message(
      'Backup options coming soon',
      name: 'backupOptionsComingSoon',
      desc: '',
      args: [],
    );
  }

  /// `Help page coming soon`
  String get helpPageComingSoon {
    return Intl.message(
      'Help page coming soon',
      name: 'helpPageComingSoon',
      desc: '',
      args: [],
    );
  }

  /// `TickNote`
  String get appName {
    return Intl.message(
      'TickNote',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `© 2024 TickNote App`
  String get appLegalese {
    return Intl.message(
      '© 2024 TickNote App',
      name: 'appLegalese',
      desc: '',
      args: [],
    );
  }

  /// `Note-taking and task management app`
  String get appDescription {
    return Intl.message(
      'Note-taking and task management app',
      name: 'appDescription',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
