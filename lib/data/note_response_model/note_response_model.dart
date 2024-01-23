import 'package:flutter_note_app/data/note_model/note_model.dart';
import 'package:json_annotation/json_annotation.dart';



part 'note_response_model.g.dart';

@JsonSerializable()
class NoteResponseModel {

  @JsonKey(name: 'data')
	List<NoteModel>? data;

	NoteResponseModel({this.data=const []});

	factory NoteResponseModel.fromJson(Map<String, dynamic> json) {
		return _$NoteResponseModelFromJson(json);
	}

	Map<String, dynamic> toJson() => _$NoteResponseModelToJson(this);
}
