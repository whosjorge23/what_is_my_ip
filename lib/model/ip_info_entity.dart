import 'package:json_annotation/json_annotation.dart';
part 'ip_info_entity.g.dart';

@JsonSerializable()
class IPInfoEntity {
  late String? ip;
  late String? hostname;
  late String? city;
  late String? region;
  late String? country;
  late String? loc;
  late String? org;
  late String? postal;
  late String? timezone;
  late String? readme;

  IPInfoEntity();

  factory IPInfoEntity.fromJson(Map<String, dynamic> json) =>
      _$IPInfoEntityFromJson(json);
  Map<String, dynamic> toJson() => _$IPInfoEntityToJson(this);
}
