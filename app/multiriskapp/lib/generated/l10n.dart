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

class AppLocalizations {
  AppLocalizations();

  static AppLocalizations? _current;

  static AppLocalizations get current {
    assert(_current != null, 'No instance of AppLocalizations was loaded. Try to initialize the AppLocalizations delegate before accessing AppLocalizations.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<AppLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppLocalizations();
      AppLocalizations._current = instance;
 
      return instance;
    });
  } 

  static AppLocalizations of(BuildContext context) {
    final instance = AppLocalizations.maybeOf(context);
    assert(instance != null, 'No instance of AppLocalizations present in the widget tree. Did you add AppLocalizations.delegate in localizationsDelegates?');
    return instance!;
  }

  static AppLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// `Fire Risk`
  String get fireRisk {
    return Intl.message(
      'Fire Risk',
      name: 'fireRisk',
      desc: '',
      args: [],
    );
  }

  /// `Flood Risk`
  String get floodRisk {
    return Intl.message(
      'Flood Risk',
      name: 'floodRisk',
      desc: '',
      args: [],
    );
  }

  /// `Near me`
  String get nearMe {
    return Intl.message(
      'Near me',
      name: 'nearMe',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get setting {
    return Intl.message(
      'Setting',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `High`
  String get high {
    return Intl.message(
      'High',
      name: 'high',
      desc: '',
      args: [],
    );
  }

  /// `Medium`
  String get medium {
    return Intl.message(
      'Medium',
      name: 'medium',
      desc: '',
      args: [],
    );
  }

  /// `Low`
  String get low {
    return Intl.message(
      'Low',
      name: 'low',
      desc: '',
      args: [],
    );
  }

  /// `Getting Risk`
  String get getRisk {
    return Intl.message(
      'Getting Risk',
      name: 'getRisk',
      desc: '',
      args: [],
    );
  }

  /// `Fire Risk Screen`
  String get titleFireRiskScreen {
    return Intl.message(
      'Fire Risk Screen',
      name: 'titleFireRiskScreen',
      desc: '',
      args: [],
    );
  }

  /// `Fire Risk: {fireRiskLevel}`
  String fireRiskLevel(Object fireRiskLevel) {
    return Intl.message(
      'Fire Risk: $fireRiskLevel',
      name: 'fireRiskLevel',
      desc: '',
      args: [fireRiskLevel],
    );
  }

  /// `Temperature: {temperature} °C`
  String temperature(Object temperature) {
    return Intl.message(
      'Temperature: $temperature °C',
      name: 'temperature',
      desc: '',
      args: [temperature],
    );
  }

  /// `Humidity: {humidity} %`
  String humidity(Object humidity) {
    return Intl.message(
      'Humidity: $humidity %',
      name: 'humidity',
      desc: '',
      args: [humidity],
    );
  }

  /// `Wind: ${wind} km/h`
  String wind(Object wind) {
    return Intl.message(
      'Wind: \$$wind km/h',
      name: 'wind',
      desc: '',
      args: [wind],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);
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