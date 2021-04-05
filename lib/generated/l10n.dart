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
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Checking if you are loggin in`
  String get loginCheck {
    return Intl.message(
      'Checking if you are loggin in',
      name: 'loginCheck',
      desc: '',
      args: [],
    );
  }

  /// `User profile`
  String get userScreenTitle {
    return Intl.message(
      'User profile',
      name: 'userScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Leaderboard`
  String get leaderboardScreenTitle {
    return Intl.message(
      'Leaderboard',
      name: 'leaderboardScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Herbary`
  String get herbaryScreenTitle {
    return Intl.message(
      'Herbary',
      name: 'herbaryScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get homeScreenTitle {
    return Intl.message(
      'Home',
      name: 'homeScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Question`
  String get question {
    return Intl.message(
      'Question',
      name: 'question',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Has more than 6 petals?`
  String get qHasMoreThan6Petals {
    return Intl.message(
      'Has more than 6 petals?',
      name: 'qHasMoreThan6Petals',
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
      Locale.fromSubtags(languageCode: 'it', countryCode: 'IT'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}