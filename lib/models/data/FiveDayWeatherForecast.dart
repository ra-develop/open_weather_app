import 'dart:convert';

import 'package:dart_json_mapper/dart_json_mapper.dart';

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
    List<ListWeatherForecast>? list,
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
        _list?.add(ListWeatherForecast.fromJson(v));
      });
    }
    _city = json['city'] != null ? City.fromJson(json['city']) : null;
  }

  String? _cod;
  num? _message;
  num? _cnt;
  List<ListWeatherForecast>? _list;
  City? _city;

  FiveDayWeatherForecast copyWith({
    String? cod,
    num? message,
    num? cnt,
    List<ListWeatherForecast>? list,
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

  List<ListWeatherForecast>? get list => _list;

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

/// id : 3163858
/// name : "Zocca"
/// coord : {"lat":44.34,"lon":10.99}
/// country : "IT"
/// population : 4593
/// timezone : 7200
/// sunrise : 1661834187
/// sunset : 1661882248

City cityFromJson(String str) => City.fromJson(json.decode(str));

String cityToJson(City data) => json.encode(data.toJson());

@jsonSerializable
class City {
  City({
    num? id,
    String? name,
    Coord? coord,
    String? country,
    num? population,
    num? timezone,
    num? sunrise,
    num? sunset,
  }) {
    _id = id;
    _name = name;
    _coord = coord;
    _country = country;
    _population = population;
    _timezone = timezone;
    _sunrise = sunrise;
    _sunset = sunset;
  }

  City.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _coord = json['coord'] != null ? Coord.fromJson(json['coord']) : null;
    _country = json['country'];
    _population = json['population'];
    _timezone = json['timezone'];
    _sunrise = json['sunrise'];
    _sunset = json['sunset'];
  }

  num? _id;
  String? _name;
  Coord? _coord;
  String? _country;
  num? _population;
  num? _timezone;
  num? _sunrise;
  num? _sunset;

  City copyWith({
    num? id,
    String? name,
    Coord? coord,
    String? country,
    num? population,
    num? timezone,
    num? sunrise,
    num? sunset,
  }) =>
      City(
        id: id ?? _id,
        name: name ?? _name,
        coord: coord ?? _coord,
        country: country ?? _country,
        population: population ?? _population,
        timezone: timezone ?? _timezone,
        sunrise: sunrise ?? _sunrise,
        sunset: sunset ?? _sunset,
      );

  num? get id => _id;

  String? get name => _name;

  Coord? get coord => _coord;

  String? get country => _country;

  num? get population => _population;

  num? get timezone => _timezone;

  num? get sunrise => _sunrise;

  num? get sunset => _sunset;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    if (_coord != null) {
      map['coord'] = _coord?.toJson();
    }
    map['country'] = _country;
    map['population'] = _population;
    map['timezone'] = _timezone;
    map['sunrise'] = _sunrise;
    map['sunset'] = _sunset;
    return map;
  }
}

/// lat : 44.34
/// lon : 10.99

Coord coordFromJson(String str) => Coord.fromJson(json.decode(str));

String coordToJson(Coord data) => json.encode(data.toJson());

@jsonSerializable
class Coord {
  Coord({
    num? lat,
    num? lon,
  }) {
    _lat = lat;
    _lon = lon;
  }

  Coord.fromJson(dynamic json) {
    _lat = json['lat'];
    _lon = json['lon'];
  }

  num? _lat;
  num? _lon;

  Coord copyWith({
    num? lat,
    num? lon,
  }) =>
      Coord(
        lat: lat ?? _lat,
        lon: lon ?? _lon,
      );

  num? get lat => _lat;

  num? get lon => _lon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = _lat;
    map['lon'] = _lon;
    return map;
  }
}

/// dt : 1661871600
/// main : {"temp":296.76,"feels_like":296.98,"temp_min":296.76,"temp_max":297.87,"pressure":1015,"sea_level":1015,"grnd_level":933,"humidity":69,"temp_kf":-1.11}
/// weather : [{"id":500,"main":"Rain","description":"light rain","icon":"10d"}]
/// clouds : {"all":100}
/// wind : {"speed":0.62,"deg":349,"gust":1.18}
/// visibility : 10000
/// pop : 0.32
/// rain : {"3h":0.26}
/// sys : {"pod":"d"}
/// dt_txt : "2022-08-30 15:00:00"

ListWeatherForecast listFromJson(String str) =>
    ListWeatherForecast.fromJson(json.decode(str));

String listToJson(ListWeatherForecast data) => json.encode(data.toJson());

@jsonSerializable
class ListWeatherForecast {
  ListWeatherForecast({
    num? dt,
    Main? main,
    List<Weather>? weather,
    Clouds? clouds,
    Wind? wind,
    num? visibility,
    num? pop,
    Rain? rain,
    Sys? sys,
    String? dtTxt,
  }) {
    _dt = dt;
    _main = main;
    _weather = weather;
    _clouds = clouds;
    _wind = wind;
    _visibility = visibility;
    _pop = pop;
    _rain = rain;
    _sys = sys;
    _dtTxt = dtTxt;
  }

  ListWeatherForecast.fromJson(dynamic json) {
    _dt = json['dt'];
    _main = json['main'] != null ? Main.fromJson(json['main']) : null;
    if (json['weather'] != null) {
      _weather = [];
      json['weather'].forEach((v) {
        _weather?.add(Weather.fromJson(v));
      });
    }
    _clouds = json['clouds'] != null ? Clouds.fromJson(json['clouds']) : null;
    _wind = json['wind'] != null ? Wind.fromJson(json['wind']) : null;
    _visibility = json['visibility'];
    _pop = json['pop'];
    _rain = json['rain'] != null ? Rain.fromJson(json['rain']) : null;
    _sys = json['sys'] != null ? Sys.fromJson(json['sys']) : null;
    _dtTxt = json['dt_txt'];
  }

  num? _dt;
  Main? _main;
  List<Weather>? _weather;
  Clouds? _clouds;
  Wind? _wind;
  num? _visibility;
  num? _pop;
  Rain? _rain;
  Sys? _sys;
  String? _dtTxt;

  ListWeatherForecast copyWith({
    num? dt,
    Main? main,
    List<Weather>? weather,
    Clouds? clouds,
    Wind? wind,
    num? visibility,
    num? pop,
    Rain? rain,
    Sys? sys,
    String? dtTxt,
  }) =>
      ListWeatherForecast(
        dt: dt ?? _dt,
        main: main ?? _main,
        weather: weather ?? _weather,
        clouds: clouds ?? _clouds,
        wind: wind ?? _wind,
        visibility: visibility ?? _visibility,
        pop: pop ?? _pop,
        rain: rain ?? _rain,
        sys: sys ?? _sys,
        dtTxt: dtTxt ?? _dtTxt,
      );

  num? get dt => _dt;

  Main? get main => _main;

  List<Weather>? get weather => _weather;

  Clouds? get clouds => _clouds;

  Wind? get wind => _wind;

  num? get visibility => _visibility;

  num? get pop => _pop;

  Rain? get rain => _rain;

  Sys? get sys => _sys;

  String? get dtTxt => _dtTxt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dt'] = _dt;
    if (_main != null) {
      map['main'] = _main?.toJson();
    }
    if (_weather != null) {
      map['weather'] = _weather?.map((v) => v.toJson()).toList();
    }
    if (_clouds != null) {
      map['clouds'] = _clouds?.toJson();
    }
    if (_wind != null) {
      map['wind'] = _wind?.toJson();
    }
    map['visibility'] = _visibility;
    map['pop'] = _pop;
    if (_rain != null) {
      map['rain'] = _rain?.toJson();
    }
    if (_sys != null) {
      map['sys'] = _sys?.toJson();
    }
    map['dt_txt'] = _dtTxt;
    return map;
  }
}

/// pod : "d"

Sys sysFromJson(String str) => Sys.fromJson(json.decode(str));

String sysToJson(Sys data) => json.encode(data.toJson());

@jsonSerializable
class Sys {
  Sys({
    String? pod,
  }) {
    _pod = pod;
  }

  Sys.fromJson(dynamic json) {
    _pod = json['pod'];
  }

  String? _pod;

  Sys copyWith({
    String? pod,
  }) =>
      Sys(
        pod: pod ?? _pod,
      );

  String? get pod => _pod;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pod'] = _pod;
    return map;
  }
}

/// 3h : 0.26

Rain rainFromJson(String str) => Rain.fromJson(json.decode(str));

String rainToJson(Rain data) => json.encode(data.toJson());

@jsonSerializable
class Rain {
  Rain({
    num? h,
  }) {
    _h = h;
  }

  Rain.fromJson(dynamic json) {
    _h = json['3h'];
  }

  num? _h;

  Rain copyWith({
    num? h,
  }) =>
      Rain(
        h: h ?? _h,
      );

  num? get h => _h;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['3h'] = _h;
    return map;
  }
}

/// speed : 0.62
/// deg : 349
/// gust : 1.18

Wind windFromJson(String str) => Wind.fromJson(json.decode(str));

String windToJson(Wind data) => json.encode(data.toJson());

@jsonSerializable
class Wind {
  Wind({
    num? speed,
    num? deg,
    num? gust,
  }) {
    _speed = speed;
    _deg = deg;
    _gust = gust;
  }

  Wind.fromJson(dynamic json) {
    _speed = json['speed'];
    _deg = json['deg'];
    _gust = json['gust'];
  }

  num? _speed;
  num? _deg;
  num? _gust;

  Wind copyWith({
    num? speed,
    num? deg,
    num? gust,
  }) =>
      Wind(
        speed: speed ?? _speed,
        deg: deg ?? _deg,
        gust: gust ?? _gust,
      );

  num? get speed => _speed;

  num? get deg => _deg;

  num? get gust => _gust;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['speed'] = _speed;
    map['deg'] = _deg;
    map['gust'] = _gust;
    return map;
  }
}

/// all : 100

Clouds cloudsFromJson(String str) => Clouds.fromJson(json.decode(str));

String cloudsToJson(Clouds data) => json.encode(data.toJson());

@jsonSerializable
class Clouds {
  Clouds({
    num? all,
  }) {
    _all = all;
  }

  Clouds.fromJson(dynamic json) {
    _all = json['all'];
  }

  num? _all;

  Clouds copyWith({
    num? all,
  }) =>
      Clouds(
        all: all ?? _all,
      );

  num? get all => _all;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['all'] = _all;
    return map;
  }
}

/// id : 500
/// main : "Rain"
/// description : "light rain"
/// icon : "10d"

Weather weatherFromJson(String str) => Weather.fromJson(json.decode(str));

String weatherToJson(Weather data) => json.encode(data.toJson());

@jsonSerializable
class Weather {
  Weather({
    num? id,
    String? main,
    String? description,
    String? icon,
  }) {
    _id = id;
    _main = main;
    _description = description;
    _icon = icon;
  }

  Weather.fromJson(dynamic json) {
    _id = json['id'];
    _main = json['main'];
    _description = json['description'];
    _icon = json['icon'];
  }

  num? _id;
  String? _main;
  String? _description;
  String? _icon;

  Weather copyWith({
    num? id,
    String? main,
    String? description,
    String? icon,
  }) =>
      Weather(
        id: id ?? _id,
        main: main ?? _main,
        description: description ?? _description,
        icon: icon ?? _icon,
      );

  num? get id => _id;

  String? get main => _main;

  String? get description => _description;

  String? get icon => _icon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['main'] = _main;
    map['description'] = _description;
    map['icon'] = _icon;
    return map;
  }
}

/// temp : 296.76
/// feels_like : 296.98
/// temp_min : 296.76
/// temp_max : 297.87
/// pressure : 1015
/// sea_level : 1015
/// grnd_level : 933
/// humidity : 69
/// temp_kf : -1.11

Main mainFromJson(String str) => Main.fromJson(json.decode(str));

String mainToJson(Main data) => json.encode(data.toJson());

@jsonSerializable
class Main {
  Main({
    num? temp,
    num? feelsLike,
    num? tempMin,
    num? tempMax,
    num? pressure,
    num? seaLevel,
    num? grndLevel,
    num? humidity,
    num? tempKf,
  }) {
    _temp = temp;
    _feelsLike = feelsLike;
    _tempMin = tempMin;
    _tempMax = tempMax;
    _pressure = pressure;
    _seaLevel = seaLevel;
    _grndLevel = grndLevel;
    _humidity = humidity;
    _tempKf = tempKf;
  }

  Main.fromJson(dynamic json) {
    _temp = json['temp'];
    _feelsLike = json['feels_like'];
    _tempMin = json['temp_min'];
    _tempMax = json['temp_max'];
    _pressure = json['pressure'];
    _seaLevel = json['sea_level'];
    _grndLevel = json['grnd_level'];
    _humidity = json['humidity'];
    _tempKf = json['temp_kf'];
  }

  num? _temp;
  num? _feelsLike;
  num? _tempMin;
  num? _tempMax;
  num? _pressure;
  num? _seaLevel;
  num? _grndLevel;
  num? _humidity;
  num? _tempKf;

  Main copyWith({
    num? temp,
    num? feelsLike,
    num? tempMin,
    num? tempMax,
    num? pressure,
    num? seaLevel,
    num? grndLevel,
    num? humidity,
    num? tempKf,
  }) =>
      Main(
        temp: temp ?? _temp,
        feelsLike: feelsLike ?? _feelsLike,
        tempMin: tempMin ?? _tempMin,
        tempMax: tempMax ?? _tempMax,
        pressure: pressure ?? _pressure,
        seaLevel: seaLevel ?? _seaLevel,
        grndLevel: grndLevel ?? _grndLevel,
        humidity: humidity ?? _humidity,
        tempKf: tempKf ?? _tempKf,
      );

  num? get temp => _temp;

  num? get feelsLike => _feelsLike;

  num? get tempMin => _tempMin;

  num? get tempMax => _tempMax;

  num? get pressure => _pressure;

  num? get seaLevel => _seaLevel;

  num? get grndLevel => _grndLevel;

  num? get humidity => _humidity;

  num? get tempKf => _tempKf;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['temp'] = _temp;
    map['feels_like'] = _feelsLike;
    map['temp_min'] = _tempMin;
    map['temp_max'] = _tempMax;
    map['pressure'] = _pressure;
    map['sea_level'] = _seaLevel;
    map['grnd_level'] = _grndLevel;
    map['humidity'] = _humidity;
    map['temp_kf'] = _tempKf;
    return map;
  }
}
