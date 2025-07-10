// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
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
  String get localeName => 'es';

  static m0(spi) => "SPI: ${spi}";

  static m1(fireRiskLevel) => "Riesgo de incendio: ${fireRiskLevel}";

  static m2(floodRiskLevel) => "Riesgo de inundacion: ${floodRiskLevel}";

  static m3(humidity) => "Humedad: ${humidity} %";

  static m4(precipRate) => "Intensidad Lluvia: ${precipRate}";

  static m5(temperature) => "Temperatura: ${temperature} °C";

  static m6(rain) => "Lluvia Total: ${rain}";

  static m7(wind) => "Velocidad del Viento: \$${wind} km/h";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "SPI" : m0,
    "fireRisk" : MessageLookupByLibrary.simpleMessage("Riesgo de incendio"),
    "fireRiskLevel" : m1,
    "floodRisk" : MessageLookupByLibrary.simpleMessage("Riesgo de inundación"),
    "floodRiskLevel" : m2,
    "getRisk" : MessageLookupByLibrary.simpleMessage("Obteniendo el Riesgo"),
    "high" : MessageLookupByLibrary.simpleMessage("Alto"),
    "humidity" : m3,
    "low" : MessageLookupByLibrary.simpleMessage("Bajo"),
    "medium" : MessageLookupByLibrary.simpleMessage("Medio"),
    "nearMe" : MessageLookupByLibrary.simpleMessage("Cerca de mí"),
    "rateRain" : m4,
    "setting" : MessageLookupByLibrary.simpleMessage("Configuración"),
    "temperature" : m5,
    "titleFireRiskScreen" : MessageLookupByLibrary.simpleMessage("Riesgo de incendio"),
    "titleFloodRiskScreen" : MessageLookupByLibrary.simpleMessage("Riesgo de Inundación"),
    "totalRain" : m6,
    "wind" : m7
  };
}
