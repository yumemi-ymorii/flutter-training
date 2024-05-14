// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Location',
      json,
      ($checkedConvert) {
        final val = Location(
          area: $checkedConvert('area', (v) => v as String),
          date: $checkedConvert('date', (v) => DateTime.parse(v as String)),
        );
        return val;
      },
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'area': instance.area,
      'date': instance.date.toIso8601String(),
    };
