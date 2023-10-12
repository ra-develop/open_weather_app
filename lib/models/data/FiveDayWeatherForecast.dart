import 'dart:convert';

import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:open_weather_app/models/data/weather_data_detail.dart';

import 'CurrentWeatherData.dart';

/// cod : "200"
/// message : 0
/// cnt : 40
/// list : [{"dt":1661871600,"main":{"temp":296.76,"feels_like":296.98,"temp_min":296.76,"temp_max":297.87,"pressure":1015,"sea_level":1015,"grnd_level":933,"humidity":69,"temp_kf":-1.11},"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10d"}],"clouds":{"all":100},"wind":{"speed":0.62,"deg":349,"gust":1.18},"visibility":10000,"pop":0.32,"rain":{"3h":0.26},"sys":{"pod":"d"},"dt_txt":"2022-08-30 15:00:00"},{"dt":1661882400,"main":{"temp":295.45,"feels_like":295.59,"temp_min":292.84,"temp_max":295.45,"pressure":1015,"sea_level":1015,"grnd_level":931,"humidity":71,"temp_kf":2.61},"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10n"}],"clouds":{"all":96},"wind":{"speed":1.97,"deg":157,"gust":3.39},"visibility":10000,"pop":0.33,"rain":{"3h":0.57},"sys":{"pod":"n"},"dt_txt":"2022-08-30 18:00:00"},{"dt":1661893200,"main":{"temp":292.46,"feels_like":292.54,"temp_min":290.31,"temp_max":292.46,"pressure":1015,"sea_level":1015,"grnd_level":931,"humidity":80,"temp_kf":2.15},"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10n"}],"clouds":{"all":68},"wind":{"speed":2.66,"deg":210,"gust":3.58},"visibility":10000,"pop":0.7,"rain":{"3h":0.49},"sys":{"pod":"n"},"dt_txt":"2022-08-30 21:00:00"},{"dt":1662292800,"main":{"temp":294.93,"feels_like":294.83,"temp_min":294.93,"temp_max":294.93,"pressure":1018,"sea_level":1018,"grnd_level":935,"humidity":64,"temp_kf":0},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"clouds":{"all":88},"wind":{"speed":1.14,"deg":17,"gust":1.57},"visibility":10000,"pop":0,"sys":{"pod":"d"},"dt_txt":"2022-09-04 12:00:00"}]
/// city : {"id":3163858,"name":"Zocca","coord":{"lat":44.34,"lon":10.99},"country":"IT","population":4593,"timezone":7200,"sunrise":1661834187,"sunset":1661882248}

FiveDayWeatherForecast fiveDayWeatherForecastFromJson(String str) =>
    FiveDayWeatherForecast.fromJson(json.decode(str));

String fiveDayWeatherForecastToJson(FiveDayWeatherForecast data) =>
    json.encode(data.toJson());

@jsonSerializable
class FiveDayWeatherForecast {
  FiveDayWeatherForecast({
    String? cod,
    num? message,
    num? cnt,
    List<CurrentWeatherData>? list,
    City? city,
  }) {
    _cod = cod;
    _message = message;
    _cnt = cnt;
    _list = list;
    _city = city;
  }

  FiveDayWeatherForecast.fromJson(dynamic json) {
    _cod = json['cod'];
    _message = json['message'];
    _cnt = json['cnt'];
    if (json['list'] != null) {
      _list = [];
      json['list'].forEach((v) {
        _list?.add(CurrentWeatherData.fromJson(v));
      });
    }
    _city = json['city'] != null ? City.fromJson(json['city']) : null;
  }

  String? _cod;
  num? _message;
  num? _cnt;
  List<CurrentWeatherData>? _list;
  City? _city;

  FiveDayWeatherForecast copyWith({
    String? cod,
    num? message,
    num? cnt,
    List<CurrentWeatherData>? list,
    City? city,
  }) =>
      FiveDayWeatherForecast(
        cod: cod ?? _cod,
        message: message ?? _message,
        cnt: cnt ?? _cnt,
        list: list ?? _list,
        city: city ?? _city,
      );

  String? get cod => _cod;

  num? get message => _message;

  num? get cnt => _cnt;

  List<CurrentWeatherData>? get list => _list;

  City? get city => _city;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cod'] = _cod;
    map['message'] = _message;
    map['cnt'] = _cnt;
    if (_list != null) {
      map['list'] = _list?.map((v) => v.toJson()).toList();
    }
    if (_city != null) {
      map['city'] = _city?.toJson();
    }
    return map;
  }
}

