import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'car.freezed.dart';

part 'car.g.dart';

@freezed
class Car with _$Car {
  const factory Car({
    required dynamic id,
    required dynamic Car_Vendor_id,
    required dynamic car_Model_id,
    required dynamic Car_Color_id,
    required dynamic Model_Year,
    required dynamic Car_Lic_No,
    required dynamic Board_No,
    required dynamic is_active,
    required dynamic Last_KMs_Usages,
    required dynamic Cylinder_id,
    required dynamic Car_Fule_Type_id,
    required dynamic Vendor_name,
    required dynamic Vendor_egn_name,
    required dynamic Models_name,
    required dynamic Models_eng_name,
    required dynamic color_name,
    required dynamic color_eng_name,
    required dynamic Fule_Type_name,
    required dynamic Fule_Type_eng_name,
    required dynamic Vendors_binary_image,
    required dynamic Car_Size_ID,
  }) = _Car;

  factory Car.fromJson(Map<String, Object?> json) => _$CarFromJson(json);
}
