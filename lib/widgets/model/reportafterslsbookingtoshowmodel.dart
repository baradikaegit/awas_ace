// ignore_for_file: no_leading_underscores_for_local_identifiers
class ListRptAfterSlsBookingToShowResponse {
  ListRptAfterSlsBookingToShowResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.listRptBookingToShow,
  });
  late final int statusCode;
  late final String statusMessage;
  late final List<ListRptBookingToShow>? listRptBookingToShow;

  ListRptAfterSlsBookingToShowResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    listRptBookingToShow = (json['listRptBookingToShow'] != null)
        ? List.from(json['listRptBookingToShow'])
            .map((e) => ListRptBookingToShow.fromJson(e))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['statusMessage'] = statusMessage;
    _data['listRptBookingToShow'] =
        listRptBookingToShow!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ListRptBookingToShow {
  ListRptBookingToShow({
    required this.num,
    required this.periodTipe,
    required this.monthID,
    required this.month,
    required this.year,
    required this.headerCode,
    required this.headerName,
    required this.booking,
    required this.show,
    required this.persen,
  });
  late final int num;
  late final String periodTipe;
  late final String monthID;
  late final int month;
  late final int year;
  late final String headerCode;
  late final String headerName;
  late final int booking;
  late final int show;
  late final int persen;

  ListRptBookingToShow.fromJson(Map<String, dynamic> json) {
    num = json['num'];
    periodTipe = json['periodTipe'];
    monthID = json['monthID'];
    month = json['month'];
    year = json['year'];
    headerCode = json['headerCode'];
    headerName = json['headerName'];
    booking = json['booking'];
    show = json['show'];
    persen = json['persen'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['num'] = num;
    _data['periodTipe'] = periodTipe;
    _data['monthID'] = monthID;
    _data['month'] = month;
    _data['year'] = year;
    _data['headerCode'] = headerCode;
    _data['headerName'] = headerName;
    _data['booking'] = booking;
    _data['show'] = show;
    _data['persen'] = persen;
    return _data;
  }
}
