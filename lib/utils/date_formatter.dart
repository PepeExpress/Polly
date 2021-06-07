String? date(DateTime tm) {
  tm = DateTime(tm.year, tm.month, tm.day);
  DateTime today = new DateTime.now();
  Duration oneDay = new Duration(days: 1);
  Duration twoDay = new Duration(days: 2);
  Duration oneWeek = new Duration(days: 7);
  String? month;
  switch (tm.month) {
    case 1:
      month = "gennaio";
      break;
    case 2:
      month = "febbraio";
      break;
    case 3:
      month = "marzo";
      break;
    case 4:
      month = "aprile";
      break;
    case 5:
      month = "maggio";
      break;
    case 6:
      month = "giugno";
      break;
    case 7:
      month = "luglio";
      break;
    case 8:
      month = "agosto";
      break;
    case 9:
      month = "settembre";
      break;
    case 10:
      month = "ottobre";
      break;
    case 11:
      month = "novembre";
      break;
    case 12:
      month = "dicembre";
      break;
  }

  Duration difference = today.difference(tm);

  if (difference.compareTo(oneDay) < 1) {
    return "oggi";
  } else if (difference.compareTo(twoDay) < 1) {
    return "ieri";
  } else if (difference.compareTo(oneWeek) < 1) {
    switch (tm.weekday) {
      case 1:
        return "lunedì";
      case 2:
        return "martedì";
      case 3:
        return "marcoledì";
      case 4:
        return "giovedì";
      case 5:
        return "venerdì";
      case 6:
        return "sabato";
      case 7:
        return "domenica";
    }
  } else if (tm.year == today.year) {
    return '${tm.day} $month';
  } else {
    return '${tm.day} $month ${tm.year}';
  }
}
