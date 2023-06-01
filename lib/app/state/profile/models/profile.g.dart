// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Profile _$$_ProfileFromJson(Map<String, dynamic> json) => _$_Profile(
      customer_id: json['customer_id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      eng_name: json['eng_name'],
      username: json['username'],
      join_date: DateTime.parse(json['join_date'] as String),
      wallet_balance: json['wallet_balance'],
      cash_back_coupon: json['cash_back_coupon'],
      statistics: json['statistics'],
    );

Map<String, dynamic> _$$_ProfileToJson(_$_Profile instance) =>
    <String, dynamic>{
      'customer_id': instance.customer_id,
      'name': instance.name,
      'phone': instance.phone,
      'email': instance.email,
      'eng_name': instance.eng_name,
      'username': instance.username,
      'join_date': instance.join_date.toIso8601String(),
      'wallet_balance': instance.wallet_balance,
      'cash_back_coupon': instance.cash_back_coupon,
      'statistics': instance.statistics,
    };
