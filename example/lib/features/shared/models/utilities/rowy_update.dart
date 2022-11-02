import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'json_utilities.dart';

part 'rowy_update.g.dart';

@JsonSerializable(explicitToJson: true)
class RowyUpdate {
  String? displayName;

  String? email;

  bool? emailVerified;

  bool? isAnonymous;

  String? photoURL;

  @JsonKey(fromJson: getDateFromTimestamp, toJson: getTimestampFromDate)
  DateTime? timestamp;

  String? uid;

  String? updateField;

  RowyUpdate({
    this.displayName,
    this.email,
    this.emailVerified,
    this.isAnonymous,
    this.photoURL,
    this.timestamp,
    this.uid,
    this.updateField,
  });

  factory RowyUpdate.fromJson(Map<String, dynamic> json) => _$RowyUpdateFromJson(json);

  Map<String, dynamic> toJson() => _$RowyUpdateToJson(this);
}
