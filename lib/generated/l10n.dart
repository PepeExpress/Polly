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

  /// `Which characteristics are present in the plant?`
  String get whichCharacteristicsPlant {
    return Intl.message(
      'Which characteristics are present in the plant?',
      name: 'whichCharacteristicsPlant',
      desc: '',
      args: [],
    );
  }

  /// `Which characteristics has the flower?`
  String get whichCharacteristicsFlower {
    return Intl.message(
      'Which characteristics has the flower?',
      name: 'whichCharacteristicsFlower',
      desc: '',
      args: [],
    );
  }

  /// `The flower has this trait?`
  String get flowerHasTheseCharacteristics {
    return Intl.message(
      'The flower has this trait?',
      name: 'flowerHasTheseCharacteristics',
      desc: '',
      args: [],
    );
  }

  /// `The plant belongs to one of the following families`
  String get multipleResult {
    return Intl.message(
      'The plant belongs to one of the following families',
      name: 'multipleResult',
      desc: '',
      args: [],
    );
  }

  /// `The plant belongs to the family of `
  String get resultIncipit {
    return Intl.message(
      'The plant belongs to the family of ',
      name: 'resultIncipit',
      desc: '',
      args: [],
    );
  }

  /// `Leaf with parallel veins`
  String get question1text1 {
    return Intl.message(
      'Leaf with parallel veins',
      name: 'question1text1',
      desc: '',
      args: [],
    );
  }

  /// `The flower has a number of petals multiple of 3`
  String get question1text2 {
    return Intl.message(
      'The flower has a number of petals multiple of 3',
      name: 'question1text2',
      desc: '',
      args: [],
    );
  }

  /// `Complex leaf with branched veins`
  String get question1text3 {
    return Intl.message(
      'Complex leaf with branched veins',
      name: 'question1text3',
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