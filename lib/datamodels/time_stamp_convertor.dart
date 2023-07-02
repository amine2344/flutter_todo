import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

class TimestampConverter implements JsonConverter<DateTime, dynamic> {
  const TimestampConverter();

  @override
  //DateTime fromJson(Timestamp timestamp) => timestamp.toDate();
  DateTime fromJson(dynamic data) {
    Timestamp timestamp =Timestamp.now();
    if (data is Timestamp) {
      timestamp = data;
    } else if (data is Map) {
      timestamp = Timestamp(data['_seconds'], data['_nanoseconds']);
    } else if (data is String) {
      timestamp = Timestamp.fromDate(DateTime.parse(data));
    } else if (data is int) {
      timestamp = Timestamp.fromMillisecondsSinceEpoch(data);
    }
    return timestamp.toDate();
  }

  @override
  int toJson(DateTime date) => (date.millisecondsSinceEpoch).floor();
}

class TimestampNullableConverter extends JsonConverter<DateTime?, dynamic> {
  const TimestampNullableConverter();

  @override
  //DateTime? fromJson(Timestamp? timestamp) => timestamp?.toDate();
  DateTime? fromJson(dynamic data) {
    Timestamp? timestamp;
    if (data is Timestamp) {
      timestamp = data;
    } else if (data is Map) {
      timestamp = Timestamp(data['_seconds'], data['_nanoseconds']);
    } else if (data is String) {
      timestamp = Timestamp.fromDate(DateTime.parse(data));
    } else if (data is int) {
      timestamp = Timestamp.fromMillisecondsSinceEpoch(data);
    }
    return timestamp?.toDate();
  }

  @override
  int? toJson(DateTime? date) => date == null ? null : (date.millisecondsSinceEpoch).floor();
}