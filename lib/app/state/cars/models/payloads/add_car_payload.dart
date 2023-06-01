// Vendor = Model = Cylinder = Fuel

// {
// "Car_Vendor_id": 0,
// "Car_Model_id": 0,
// "Car_Color_id": 0,
// "Model_Year": 0,
// "Board_No": "string",
// "Car_Lic_No": "string",
// "Last_KMs_Usages": 0,
// "Car_Models_Engine_id": 0,
// "Car_Fule_Type_id": 0
// }

// Fetch Vendors
// Fetch Colors

// Fetch Cars Models of Vendor by ID
// SKIP years
// SKIP Board
// SKIP LicNo
// SKIP KMs
// Fetch Fuel Types
// Fetch Cyilinder
//
// }
import 'dart:collection';

import 'package:sayara_tech_app/app/state/constants/api_fields_name.dart';

class AddCarPayload extends MapView<String, dynamic> {
  AddCarPayload({
    required dynamic carVendorId,
    required dynamic carModelId,
    required dynamic carColorId,
    required dynamic modelYear,
    required dynamic boardNo,
    required dynamic carLicNo,
    required dynamic lastKMsUsage,
    required dynamic carModelsEngineId,
    required dynamic carFuleTypeId,
  }) : super(
          {
            ApiFieldName.carVendorId: carVendorId,
            ApiFieldName.carModelId: carModelId,
            ApiFieldName.carColorId: carColorId,
            ApiFieldName.modelYear: modelYear,
            ApiFieldName.boardNo: boardNo,
            ApiFieldName.carLicNo: lastKMsUsage,
            ApiFieldName.lastKMsUsage: lastKMsUsage,
            ApiFieldName.carModelsEngineId: carModelsEngineId,
            ApiFieldName.carFuleTypeId: carFuleTypeId,
          },
        );
}
