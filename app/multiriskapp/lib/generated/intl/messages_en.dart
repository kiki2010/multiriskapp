// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static m0(spi) => "SPI: ${spi}";

  static m1(fireRiskLevel) => "Fire Risk: ${fireRiskLevel}";

  static m2(floodRiskLevel) => "Flood Risk: ${floodRiskLevel}";

  static m3(humidity) => "Humidity: ${humidity} %";

  static m4(precipRate) => "Rain (Rate): ${precipRate}";

  static m5(temperature) => "Temperature: ${temperature} °C";

  static m6(rain) => "Rain: ${rain} mm";

  static m7(wind) => "Wind: \$${wind} km/h";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "SPI" : m0,
    "fireRisk" : MessageLookupByLibrary.simpleMessage("Fire Risk"),
    "fireRiskLevel" : m1,
    "floodRisk" : MessageLookupByLibrary.simpleMessage("Flood Risk"),
    "floodRiskLevel" : m2,
    "getRisk" : MessageLookupByLibrary.simpleMessage("Getting Risk"),
    "high" : MessageLookupByLibrary.simpleMessage("High"),
    "humidity" : m3,
    "loadData" : MessageLookupByLibrary.simpleMessage("Loading Data"),
    "low" : MessageLookupByLibrary.simpleMessage("Low"),
    "medium" : MessageLookupByLibrary.simpleMessage("Medium"),
    "nearMe" : MessageLookupByLibrary.simpleMessage("Near me"),
    "noFound" : MessageLookupByLibrary.simpleMessage("No places found"),
    "placesNearCordoba" : MessageLookupByLibrary.simpleMessage("Places Near Cordoba"),
    "rateRain" : m4,
    "setting" : MessageLookupByLibrary.simpleMessage("Setting"),
    "temperature" : m5,
    "titleFireRiskScreen" : MessageLookupByLibrary.simpleMessage("Fire Risk Screen"),
    "titleFloodRiskScreen" : MessageLookupByLibrary.simpleMessage("Riesgo de Inundación"),
    "totalRain" : m6,
    "wind" : m7
  };
}
