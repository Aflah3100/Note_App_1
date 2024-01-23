// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoteResponseModel _$NoteResponseModelFromJson(Map<String, dynamic> json) =>
    NoteResponseModel(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => NoteModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$NoteResponseModelToJson(NoteResponseModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
