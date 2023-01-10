import 'package:flutter/material.dart';
import 'package:AirmineStudy/models/placemodels.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:weather/weather.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

String getPollentypeTranslation({context, required PollenType pollentype}) {
  String result = "";
  switch (pollentype) {
    case PollenType.alder:
      result = AppLocalizations.of(context)!.pollenAlder;
      break;
    case PollenType.hazel:
      result = AppLocalizations.of(context)!.pollenHazel;
      break;
    case PollenType.salix:
      result = AppLocalizations.of(context)!.pollenSalix;
      break;
    case PollenType.birch:
      result = AppLocalizations.of(context)!.pollenBirch;
      break;
    case PollenType.gras:
      result = AppLocalizations.of(context)!.pollenGrass;
      break;
    case PollenType.mugworth:
      result = AppLocalizations.of(context)!.pollenGrass;
      break;
    case PollenType.pitchambrosia:
      result = AppLocalizations.of(context)!.pollenPitchambrosia;
      break;
    case PollenType.pine:
      result = AppLocalizations.of(context)!.pollenPine;
      break;
    case PollenType.air:
      result = AppLocalizations.of(context)!.pollenAir;
      break;
    default:
  }

  return result;
}

BoxConstraints getWebConstraints(context) {
  return BoxConstraints(
      maxWidth: kIsWeb
          ? MediaQuery.of(context).size.width / 3
          : MediaQuery.of(context).size.width);
}

int getTotalAirquality(List<int> qualities) {
  int result;
  qualities.sort((a, b) => a.compareTo(b));
  result = (qualities.first).floor();

  return result;
}

Future<Widget> getWeather(
    {required String place,
    required int index,
    required context,
    required Color color}) async {
  //WeatherFactory wf = WeatherFactory(dotenv.env['openWeather']!);
  WeatherFactory wf = WeatherFactory("44ddaf1f63412f021f54f93765c81a44");

  Widget weatericon = Icon(
    WeatherIcons.day_cloudy_windy,
    color: color,
    size: 20,
  );

  List<Weather> forecast = [];
  if (index > 0) {
    forecast = await wf.fiveDayForecastByCityName(place);
  } else {
    forecast.add(await wf.currentWeatherByCityName(place));
  }

  int temp = 0;
  DateTime now = DateTime.now();

  for (Weather element in forecast) {
    if (element.date!.day == now.day + index) {
      temp = element.temperature!.celsius!.ceil();
      weatericon = getWeatherIcon(weather: element, color: color);
    }
  }

  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        getDay(context: context, day: index),
        style: Theme.of(context)
            .textTheme
            .headline5!
            .copyWith(color: Colors.white),
      ),
      const Expanded(child: SizedBox()),
      weatericon,
      const SizedBox(
        width: 20,
      ),
      Text(
        "${temp.toString()} °C",
        style: TextStyle(color: color),
      ),
    ],
  );
}

String getFormatedTime({required int hour, required int minute}) {
  return "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
}

Widget getWeatherIcon(
    {required Weather weather, Color color = Colors.white, double size = 20}) {
  switch (weather.weatherDescription) {
    case "light rain":
      return Icon(
        WeatherIcons.rain_mix,
        color: color,
        size: size,
      );
    case "light snow":
      return Icon(
        WeatherIcons.day_snow,
        color: color,
        size: size,
      );
    case "overcast clouds":
      return Icon(
        WeatherIcons.cloud,
        color: color,
        size: size,
      );
    case "scattered clouds":
      return Icon(
        WeatherIcons.day_sunny_overcast,
        color: color,
        size: size,
      );
    case "broken clouds":
      return Icon(
        WeatherIcons.day_cloudy,
        color: color,
        size: size,
      );

    default:
      return Icon(
        WeatherIcons.day_cloudy_windy,
        color: color,
        size: size,
      );
  }
}

String getDay({context, required int day}) {
  if (day == 0) {
    return AppLocalizations.of(context)!.dateToday;
  } else if (day == 1) {
    return AppLocalizations.of(context)!.dateTomorrow;
  } else {
    var now = DateTime.now();
    now = now.add(Duration(days: now.weekday + 1));

    switch (now.weekday) {
      case 1:
        return AppLocalizations.of(context)!.dateMonday;
      case 2:
        return AppLocalizations.of(context)!.dateTuesday;
      case 3:
        return AppLocalizations.of(context)!.dateWedensday;
      case 4:
        return AppLocalizations.of(context)!.dateThursday;
      case 5:
        return AppLocalizations.of(context)!.dateFriday;
      case 6:
        return AppLocalizations.of(context)!.dateSaturday;
      case 7:
        return AppLocalizations.of(context)!.dateSunday;

      default:
        return "";
    }
  }
}

String getWeekDay({context, required int weekDay}) {
  if (DateTime.now().weekday == weekDay) {
    return AppLocalizations.of(context)!.dateToday;
  } else if (DateTime.now().weekday == weekDay + 1) {
    return AppLocalizations.of(context)!.dateTomorrow;
  } else {
    switch (weekDay) {
      case 1:
        return AppLocalizations.of(context)!.dateMonday;
      case 2:
        return AppLocalizations.of(context)!.dateTuesday;
      case 3:
        return AppLocalizations.of(context)!.dateWedensday;
      case 4:
        return AppLocalizations.of(context)!.dateThursday;
      case 5:
        return AppLocalizations.of(context)!.dateFriday;
      case 6:
        return AppLocalizations.of(context)!.dateSaturday;
      case 7:
        return AppLocalizations.of(context)!.dateSunday;

      default:
        return "";
    }
  }
}

IconData getPollenIcon({context, required PollenType pollentype}) {
  IconData result = Icons.air;

  switch (pollentype) {
    case PollenType.alder:
      result = Icons.eco;
      break;
    case PollenType.hazel:
      result = Icons.nature;
      break;
    case PollenType.salix:
      result = Icons.air;
      break;
    case PollenType.birch:
      result = Icons.forest;
      break;
    case PollenType.gras:
      result = Icons.grass;
      break;
    case PollenType.mugworth:
      result = Icons.spa;
      break;
    case PollenType.pitchambrosia:
      result = Icons.psychology;
      break;
    case PollenType.pine:
      result = Icons.park;
      break;
    case PollenType.air:
      result = Icons.air_outlined;
      break;
    default:
  }

  return result;
}

String getAirQualityDescription({required context, required int intensity}) {
  if (intensity >= 0 && intensity < 4) {
    return AppLocalizations.of(context)!.airQualityExcelent;
  } else if (intensity >= 4 && intensity < 7) {
    return AppLocalizations.of(context)!.airQualityIntermediate;
  } else {
    return AppLocalizations.of(context)!.airQualityPoor;
  }
}

LinearGradient getGradient({context, required int intensity}) {
  List<Color> colors = [
    const Color.fromARGB(255, 66, 226, 152),
    const Color.fromARGB(255, 56, 179, 181),
  ];

  if (intensity >= 0 && intensity < 4) {
    colors = [
      const Color.fromARGB(255, 56, 179, 181),
      const Color.fromARGB(255, 66, 226, 152),
    ];
  } else if (intensity >= 4 && intensity < 7) {
    colors = [
      const Color.fromARGB(255, 242, 132, 126),
      const Color.fromARGB(255, 252, 220, 141),
    ];
  } else if (intensity >= 7) {
    colors = [
      const Color.fromARGB(255, 246, 80, 159),
      const Color.fromARGB(255, 255, 115, 120),
    ];
  }

  LinearGradient result = LinearGradient(
      begin: Alignment.topLeft, end: Alignment.bottomRight, colors: colors);
  return result;
}
