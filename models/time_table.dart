
import '../providers/subject.dart';

Map<int, Subject> table = {
//Monday

  1: Subjects.tDSP,
  2: Subjects.tNetworking,
  3: Subjects.tVLSI,

  //Tuesday
  4: Subjects.tOOP,
  5: Subjects.tNetworking,
  6: Subjects.tDSP,

  //Wednesday
  7: Subjects.tOptical,
  8: Subjects.tDSP,
  9: Subjects.tPD,
  10: Subjects.tNetworking,
  11: Subjects.tVLSI,
  12: Subjects.tOptical,
  //Thursday
  13: Subjects.tVLSI,
  14: Subjects.tNetworking,
  15: Subjects.tOOP,
  16: Subjects.tPOM,
  17: Subjects.tPOM,
  //Friday
  18: Subjects.tOptical,
  19: Subjects.tOptical,
  20: Subjects.tOOP,

  //
  21: Subjects.free};

   Map<int, Subject> get items {
    return {...table};
  }

int getMapNumber(DateTime time) {
  int dayNumber = time.weekday;

  int minutesSinceMidnight = time.hour * 60 + time.minute;
  int periodNumber;
  int mapNumber;
  if (minutesSinceMidnight >= 540 && minutesSinceMidnight <= 705 /*11:45*/) {
    periodNumber = (minutesSinceMidnight - 540 /*9:00*/) ~/ 55 + 1;
    mapNumber = (dayNumber - 1) * 5 + periodNumber;
  } else if (minutesSinceMidnight >= 745 /*12:25*/ &&
      minutesSinceMidnight <= 1075) {
    periodNumber =
        (minutesSinceMidnight - 580 /*9:00 + 40min break*/) ~/ 55 + 1;
    mapNumber = (dayNumber - 1) * 5 + periodNumber;
  }

  return mapNumber ?? 21;
}
