import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sayara_tech_app/app/constants/constants_log.dart';
import 'package:sayara_tech_app/app/providers/car_model_notifier_provider.dart';
import 'package:sayara_tech_app/app/providers/loading_notifier_provider.dart';
import 'package:sayara_tech_app/app/providers/models_notifier_provider.dart';
import 'package:sayara_tech_app/app/providers/vendor_notifier_provider.dart';
import 'package:sayara_tech_app/app/service/providers_services.dart';
import 'package:sayara_tech_app/app/service/ui_services.dart';
import 'package:sayara_tech_app/app/state/cars/models/payloads/add_car_payload.dart';
import 'package:sayara_tech_app/app/state/cars/providers/add_car_provider.dart';
import 'package:sayara_tech_app/app/state/cars/providers/fetch_cars_provider.dart';
import 'package:sayara_tech_app/app/state/cars/providers/fetch_color_provider.dart';
import 'package:sayara_tech_app/app/state/cars/providers/fetch_cylinders_provider.dart';
import 'package:sayara_tech_app/app/state/cars/providers/fetch_fuels_types_provider.dart';
import 'package:sayara_tech_app/app/state/cars/providers/fetch_models_provider.dart';
import 'package:sayara_tech_app/app/state/cars/providers/fetch_vendors_provider.dart';
import 'package:sayara_tech_app/app/state/models/request_status.dart';
import 'package:sayara_tech_app/app/state/providers/user_token_provider.dart';
import 'package:sayara_tech_app/app/widgets/snack_bar_widgets.dart';
import 'dart:developer' as devtools;
import 'package:sayara_tech_app/app/widgets/text_style.dart';

final defaultCarModelDropDownValueProvider = StateProvider<String>((ref) => "");
final defaultCylinderDropDownValueProvider = StateProvider<String>((ref) => "");

class AddCarPage extends ConsumerStatefulWidget {
  const AddCarPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _XState();
  }
}

class _XState extends ConsumerState<AddCarPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? _dropDownMenuCity = null;

  int? vendorId = null;
  int? modelId = null;
  int? colorId = null;
  int? fuelId = null;
  int? cylinderId = null;

  final licenseNoController = TextEditingController();
  final licenseNoFocusNode = FocusNode();

  final boardNoController = TextEditingController();
  final boardNoFocusNode = FocusNode();

  final lastUsageKMsController = TextEditingController();
  final lastUsageKMsFocusNode = FocusNode();

  final modelYearController = TextEditingController();
  final modelYearFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final size = UIServices.getSize(context);

    List<Map<String, dynamic>>? list =
        ref.watch(fetchCarClyinderProvider).value?.detail;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0.0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(size.height * 0.035),
          child: Container(),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25.0),
          ),
        ),
        centerTitle: true,
        title: Text(
          "Add a New Car",
          style: GoogleFonts.ubuntu(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            FontAwesomeIcons.circleArrowLeft,
            size: 24,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ref.watch(fetchVendorsProvider).when(
        data: (data) {
          List<Map<String, dynamic>> vendors = data.detail ?? [];
          if (vendors.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(12),
                      Text(
                        "Car Info",
                        style: GoogleFonts.ubuntu(
                          fontSize: 18,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Gap(24),
                      Text(
                        "Type Of Car",
                        style: GoogleFonts.ubuntu(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                      const Gap(12),
                      DropdownButtonFormField2(
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        isExpanded: true,
                        isDense: true,
                        hint: const Text(
                          'Select cae type',
                          style: TextStyle(fontSize: 14),
                        ),
                        // value: ref
                        //     .read(fetchVendorsProvider)
                        //     .value
                        //     ?.detail!
                        //     .first["eng_name"],
                        items: ref
                            .read(fetchVendorsProvider)
                            .value
                            ?.detail!
                            .map((item) {
                          var i = item;
                          return DropdownMenuItem<String>(
                            value: i["eng_name"],
                            child: Text(
                              i["eng_name"],
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          );
                        }).toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select car type';
                          }
                          return null;
                        },
                        onChanged: (value) async {
                          //get current vendor ID form drop-down list
                          final vendor = ref
                              .read(fetchVendorsProvider)
                              .value
                              ?.detail!
                              .where((element) => element["eng_name"] == value);

                          //change the notifierProvider state with the current vendorId
                          ref
                              .read(vendorNotifierProvider.notifier)
                              .changeTheVendorId(id: vendor!.first["id"]);

                          setState(() {
                            vendorId = vendor.first["id"];
                          });

                          final result =
                              await ref.watch(fetchModelsProvider.future);
                          List<Map<String, dynamic>> subModels = [];

                          //extract data from result
                          final models = result.detail ?? [];

                          //looping and get the specific models
                          for (var model in models) {
                            if (model["car_vendor_id"] ==
                                ref.read(vendorNotifierProvider.notifier).id) {
                              ref
                                  .read(defaultCarModelDropDownValueProvider
                                      .notifier)
                                  .state = models[0]["eng_name"];

                              //add the model if it's belong to this vendor
                              subModels.add(model);
                            }
                          }
                          //change the modelsNotifierProvider state with the local subModels list
                          //TODO
                          ref
                              .read(modelsNotifierProvider.notifier)
                              .changeTheModels(modelsList: subModels);
                          ref
                              .read(
                                  defaultCarModelDropDownValueProvider.notifier)
                              .state = subModels[0]["eng_name"];
                        },
                        onSaved: (value) {},
                        buttonStyleData: const ButtonStyleData(
                          height: 60,
                          padding: EdgeInsets.only(left: 20, right: 10),
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black45,
                          ),
                          iconSize: 30,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      const Gap(24),
                      Text(
                        "Car Model",
                        style: GoogleFonts.ubuntu(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      const Gap(12),
                      DropdownButtonFormField2(
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        isExpanded: true,
                        isDense: true,
                        hint: const Text(
                          'Select car model',
                          style: TextStyle(fontSize: 14),
                        ),
                        value: ref
                            .read(defaultCarModelDropDownValueProvider.notifier)
                            .state,
                        items: ref.watch(modelsNotifierProvider).map(
                          (model) {
                            return DropdownMenuItem<String>(
                              value: model["eng_name"].toString(),
                              child: Text(
                                model["eng_name"].toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            );
                          },
                        ).toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select car model';
                          }
                          return null;
                        },
                        onChanged: (value) async {
                          final model = ref
                              .watch(modelsNotifierProvider)
                              .where((element) => element["eng_name"] == value);

                          setState(() {
                            modelId = model.first["id"];
                          });

                          devtools.log(
                              "${ConstantsLog.fromAddCarPage} current chosen car model is ${model.first}");
                          ref
                              .read(
                                  defaultCarModelDropDownValueProvider.notifier)
                              .state = value ?? "";

                          ref
                              .read(carModelIdNotifierProvider.notifier)
                              .changeTheModels(id: model.first["id"]);

                          setState(() {
                            _dropDownMenuCity = null;
                          });

                          ProvidersServices.refreshFutureProvider(
                            ref: ref,
                            provider: fetchCarClyinderProvider,
                            providerName: "fetchCarClyinderProvider",
                            fromPage: ConstantsLog.fromAddCarPage,
                          );
                        },
                        onSaved: (value) {},
                        buttonStyleData: const ButtonStyleData(
                          height: 60,
                          padding: EdgeInsets.only(left: 20, right: 10),
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black45,
                          ),
                          iconSize: 30,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      const Gap(24),
                      Text(
                        "Car Fuel Type",
                        style: GoogleFonts.ubuntu(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      const Gap(12),
                      DropdownButtonFormField2(
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        isExpanded: true,
                        isDense: true,
                        hint: const Text(
                          'Select fuel type',
                          style: TextStyle(fontSize: 14),
                        ),
                        items: ref
                            .read(fetchFuelsProvider)
                            .value
                            ?.detail
                            ?.map((item) {
                          var i = item;
                          return DropdownMenuItem<String>(
                            value: i["eng_name"],
                            child: Text(
                              i["eng_name"],
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          );
                        }).toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select fuel type';
                          }
                          return null;
                        },
                        onChanged: (value) async {
                          final fuel = ref
                              .read(fetchFuelsProvider)
                              .value
                              ?.detail!
                              .where((element) => element["eng_name"] == value);

                          setState(() {
                            fuelId = fuel?.first["id"];
                          });
                        },
                        onSaved: (value) {},
                        buttonStyleData: const ButtonStyleData(
                          height: 60,
                          padding: EdgeInsets.only(left: 20, right: 10),
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black45,
                          ),
                          iconSize: 30,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      const Gap(24),
                      Text(
                        "Car Color",
                        style: GoogleFonts.ubuntu(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      const Gap(12),
                      DropdownButtonFormField2(
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        isExpanded: true,
                        isDense: true,
                        hint: const Text(
                          'Select car color',
                          style: TextStyle(fontSize: 14),
                        ),
                        items: ref
                            .watch(fetchColorsProvider)
                            .value
                            ?.detail
                            ?.map((item) {
                          var i = item;
                          return DropdownMenuItem<String>(
                            value: i["eng_name"].toString(),
                            child: Text(
                              i["eng_name"].toString(),
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          );
                        }).toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select color';
                          }
                          return null;
                        },
                        onChanged: (value) async {
                          final color = ref
                              .read(fetchColorsProvider)
                              .value
                              ?.detail!
                              .where((element) => element["eng_name"] == value);

                          setState(() {
                            colorId = color?.first["id"];
                          });
                        },
                        onSaved: (value) {},
                        buttonStyleData: const ButtonStyleData(
                          height: 60,
                          padding: EdgeInsets.only(left: 20, right: 10),
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black45,
                          ),
                          iconSize: 30,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      const Gap(24),
                      Text(
                        "Car Cylinders",
                        style: GoogleFonts.ubuntu(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      const Gap(12),
                      DropdownButtonFormField2(
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        isExpanded: true,
                        value: _dropDownMenuCity,
                        isDense: true,
                        hint: const Text(
                          'Select car cylinder',
                          style: TextStyle(fontSize: 14),
                        ),
                        items: list?.map(
                          (item) {
                            var i = item;
                            return DropdownMenuItem<String>(
                              value: i["name"].toString(),
                              child: Text(
                                i["name"].toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            );
                          },
                        ).toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select cylinders';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _dropDownMenuCity = value;
                          });

                          final color = list!.where((element) =>
                              element["name"] == int.parse(value!));

                          print(list);

                          setState(() {
                            cylinderId = color.first["id"];
                          });
                        },
                        onSaved: (value) {},
                        buttonStyleData: const ButtonStyleData(
                          height: 60,
                          padding: EdgeInsets.only(left: 20, right: 10),
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black45,
                          ),
                          iconSize: 30,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      const Gap(24),
                      Text(
                        "Registration Info",
                        style: GoogleFonts.ubuntu(
                          fontSize: 18,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const Gap(24),
                      Text(
                        "Car License No",
                        style: GoogleFonts.ubuntu(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      const Gap(12),
                      TextFormField(
                        controller: licenseNoController,
                        focusNode: licenseNoFocusNode,
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: "XXXXXXXXXXXX",
                          errorStyle: textFieldErrorStyle,
                          hintStyle: textFieldHintStyle.copyWith(fontSize: 14),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xffA1A1A1),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.trim().isEmpty) {
                            return 'The license no is required';
                          }
                          return null;
                        },
                        style: textFieldFontStyle.copyWith(fontSize: 14),
                      ),
                      const Gap(24),
                      Text(
                        "Car Board No",
                        style: GoogleFonts.ubuntu(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      const Gap(12),
                      TextFormField(
                        controller: boardNoController,
                        focusNode: boardNoFocusNode,
                        maxLength: 7,
                        decoration: InputDecoration(
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                          isDense: true,
                          hintText: "XXX-XXXX",
                          errorStyle: textFieldErrorStyle,
                          hintStyle: textFieldHintStyle.copyWith(fontSize: 14),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xffA1A1A1),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          // counter: Container(),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.trim().isEmpty) {
                            return 'The license no is required';
                          }
                          return null;
                        },
                        style: textFieldFontStyle.copyWith(fontSize: 14),
                      ),
                      const Gap(24),
                      Text(
                        "Additional",
                        style: GoogleFonts.ubuntu(
                          fontSize: 18,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const Gap(24),
                      Text(
                        "Last usage KMs",
                        style: GoogleFonts.ubuntu(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      const Gap(12),
                      TextFormField(
                        controller: lastUsageKMsController,
                        focusNode: lastUsageKMsFocusNode,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: "100000",
                          errorStyle: textFieldErrorStyle,
                          hintStyle: textFieldHintStyle.copyWith(fontSize: 14),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xffA1A1A1),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.trim().isEmpty) {
                            return 'The Kms usage is required';
                          }
                          return null;
                        },
                        style: textFieldFontStyle.copyWith(fontSize: 14),
                      ),
                      const Gap(24),
                      Text(
                        "Model Year",
                        style: GoogleFonts.ubuntu(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      const Gap(12),
                      TextFormField(
                        controller: modelYearController,
                        focusNode: modelYearFocusNode,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                          isDense: true,
                          hintText: "2015",
                          errorStyle: textFieldErrorStyle,
                          hintStyle: textFieldHintStyle.copyWith(fontSize: 14),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xffA1A1A1),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          // counter: Container(),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.trim().isEmpty) {
                            return 'The model year is required';
                          }
                          return null;
                        },
                        style: textFieldFontStyle.copyWith(fontSize: 14),
                      ),
                      const Gap(24),
                      SizedBox(
                        width: size.width,
                        height: 45,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Consumer(
                            builder: (_, ref, child) {
                              final isLoading =
                                  ref.watch(loadingNotifierProvider);
                              return ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Theme.of(context).primaryColor,
                                  ),
                                ),
                                onPressed: () async {
                                  UIServices.unFocusAll([
                                    boardNoFocusNode,
                                    licenseNoFocusNode,
                                    lastUsageKMsFocusNode,
                                    modelYearFocusNode,
                                  ]);

                                  if (formKey.currentState!.validate() &&
                                      !isLoading) {
                                    ref
                                        .read(loadingNotifierProvider.notifier)
                                        .changeTheLoadingStatus(
                                            isLoading: true);
                                    final carPayload = AddCarPayload(
                                      carVendorId: vendorId,
                                      carModelId: modelId,
                                      carColorId: colorId,
                                      modelYear:
                                          int.parse(modelYearController.text),
                                      boardNo: boardNoController.text,
                                      carLicNo: licenseNoController.text,
                                      lastKMsUsage: int.parse(
                                          lastUsageKMsController.text),
                                      carModelsEngineId: cylinderId,
                                      carFuleTypeId: fuelId,
                                    );

                                    print(carPayload);
                                    ref
                                        .read(
                                            carPayloadNotifierProvider.notifier)
                                        .updateTheCarPayload(
                                            carPayload: carPayload);

                                    final addCarResponse =
                                        await ref.watch(addCarProvider.future);

                                    ref
                                        .read(loadingNotifierProvider.notifier)
                                        .changeTheLoadingStatus(
                                            isLoading: false);

                                    if (addCarResponse.requestStatus ==
                                        RequestStatus.success) {
                                      ProvidersServices
                                          .refreshAutoDisposeFutureProvider(
                                        ref: ref,
                                        provider: fetchCarsProvider,
                                        providerName: "fetchCarsProvider",
                                        fromPage: ConstantsLog.fromAddCarPage,
                                      );

                                      if (context.mounted) {
                                        UIServices.showSnackBar(
                                          context: context,
                                          icon: SnackBarWidgets
                                              .successIconSnackBar(),
                                          text: SnackBarWidgets
                                              .successTextSnackBar(
                                            content: "Car Added Successfully",
                                          ),
                                        );

                                        Navigator.of(context).pop();
                                      }
                                    } else {
                                      if (context.mounted) {
                                        UIServices.showSnackBar(
                                          context: context,
                                          icon: SnackBarWidgets
                                              .errorIconSnackBar(),
                                          text:
                                              SnackBarWidgets.errorTextSnackBar(
                                            content:
                                                addCarResponse.errorMessage ??
                                                    "Something went to wrong!",
                                          ),
                                        );
                                      }
                                      devtools.log(
                                          "${ConstantsLog.fromLoginPage} ${addCarResponse.errorMessage}");
                                    }
                                  }
                                },
                                child: isLoading
                                    ? const SpinKitThreeBounce(
                                        color: Colors.white,
                                        size: 23.0,
                                      )
                                    : Text(
                                        "Add Car",
                                        style: GoogleFonts.ubuntu(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Something Went Wrong!",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.ubuntu(
                        fontSize: 16,
                        color: Colors.black,
                        height: 1.3,
                      ),
                    ),
                    const Gap(24),
                    SizedBox(
                      width: size.width,
                      height: 45,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.teal.shade200,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Go Back',
                            style: GoogleFonts.ubuntu(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
        error: (error, stack) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Something Went Wrong!",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.ubuntu(
                      fontSize: 16,
                      color: Colors.black,
                      height: 1.3,
                    ),
                  ),
                  const Gap(24),
                  SizedBox(
                    width: size.width,
                    height: 45,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.teal.shade200,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Go Back',
                          style: GoogleFonts.ubuntu(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
