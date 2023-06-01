import 'package:flutter/foundation.dart' show immutable;

@immutable
class ApiFieldName {
  static const name = 'name';
  static const pwd = 'pwd';
  static const mobile = 'mobile';
  static const email = 'email';
  static const step1Id = 'step1id';
  static const smsCode = 'smscode';
  static const mobileNo = 'mobileno';

  static const step2Id = 'id_step2';
  static const data = 'Data';
  static const error = 'error';
  static const status = 'status';
  static const message = 'message';

  //add car
  static const carVendorId = "Car_Vendor_id";
  static const carModelId = "Car_Model_id";
  static const carColorId = "Car_Color_id";
  static const modelYear = "Model_Year";
  static const boardNo = "Board_No";
  static const carLicNo = "Car_Lic_No";
  static const lastKMsUsage = "Last_KMs_Usages";
  static const carModelsEngineId = "Car_Models_Engine_id";
  static const carFuleTypeId = "Car_Fule_Type_id";

  //retrieve car
  static const id = "id";
  static const isActive = "is_active";
  static const cylinderId = "Cylinder_id";
  static const vendorName = "Vendor_name";
  static const vendorEngName = "Vendor_egn_name";
  static const modelName = "Models_name";
  static const modelEngName = "Models_eng_name";
  static const colorName = "color_name";
  static const colorEngName = "color_eng_name";
  static const fuleTypeName = "Fule_Type_name";
  static const fuleTypeEngName = "Fule_Type_eng_name";
  static const vendorsBinaryImage = "Vendors_binary_image";
  static const colorSizeId = "Car_Size_ID";



  const ApiFieldName._();
}
