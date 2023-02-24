import 'package:json_annotation/json_annotation.dart';
part 'ip_entity.g.dart';

@JsonSerializable()
class IPEntity {
  late String? ip;

  IPEntity();

  factory IPEntity.fromJson(Map<String, dynamic> json) =>
      _$IPEntityFromJson(json);
  Map<String, dynamic> toJson() => _$IPEntityToJson(this);
}
