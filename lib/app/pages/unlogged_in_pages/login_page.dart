import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sayara_tech_app/app/constants/constants_assets.dart';
import 'package:sayara_tech_app/app/constants/constants_log.dart';
import 'package:sayara_tech_app/app/pages/unlogged_in_pages/login_otp_page.dart';
import 'package:sayara_tech_app/app/pages/unlogged_in_pages/registration_page.dart';
import 'package:sayara_tech_app/app/providers/internet_connection_provider.dart';
import 'package:sayara_tech_app/app/providers/loading_notifier_provider.dart';
import 'package:sayara_tech_app/app/service/ui_services.dart';
import 'package:sayara_tech_app/app/widgets/text_style.dart';
import 'package:sayara_tech_app/app/state/models/request_status.dart';
import 'package:sayara_tech_app/app/state/auth/models/payloads/login_step1_payload.dart';
import 'package:sayara_tech_app/app/state/auth/providers/login_providers.dart';
import 'package:sayara_tech_app/app/state/auth/providers/payload_providers.dart';
import 'dart:developer' as devtools;
import 'package:sayara_tech_app/app/state/providers/user_token_provider.dart';

import 'package:sayara_tech_app/app/widgets/snack_bar_widgets.dart';

import '../../state/auth/providers/shared_providers.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final mobileController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final mobileFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final size = UIServices.getSize(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    ConstantsAssets.sayaraTechLogo,
                    fit: BoxFit.contain,
                    height: 110,
                    width: 110,
                  ),
                ),
                const Gap(24),
                Text(
                  "Login To Your Account",
                  style: GoogleFonts.ubuntu(
                    fontSize: 18,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const Gap(18),
                Text(
                  "To log in enter your phone number such as 966XXXXXXXXX",
                  style: GoogleFonts.ubuntu(
                    fontSize: 14,
                    color: const Color(0xffA1A1A1),
                  ),
                ),
                const Gap(24),
                Form(
                  key: formKey,
                  child: TextFormField(
                    controller: mobileController,
                    focusNode: mobileFocusNode,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      prefixIcon: const Icon(
                        Icons.phone,
                        size: 18,
                        color: Color(0xffA1A1A1),
                      ),
                      isDense: true,
                      hintText: "96650XXXXXXX",
                      errorStyle: textFieldErrorStyle,
                      hintStyle: textFieldHintStyle,
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
                        return 'The phone number is required';
                      } else if (!UIServices.phoneNumberIsMatchedInLoginCase(
                          value)) {
                        return 'The phone should be 9 digits after 966';
                      }
                      return null;
                    },
                    style: textFieldFontStyle,
                  ),
                ),
                const Gap(24),
                SizedBox(
                  width: size.width,
                  height: 45,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Consumer(
                      builder: (_, ref, child) {
                        final connectionStatus =
                            ref.watch(internetConnectionStatusProvider);

                        final isLoading = ref.watch(loadingNotifierProvider);
                        return ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).primaryColor,
                            ),
                          ),
                          onPressed: () async {
                            UIServices.unFocusAll([mobileFocusNode]);

                            if (formKey.currentState!.validate() &&
                                !isLoading) {
                              final loginStep1Payload = LoginStep1Payload(
                                mobileNo: mobileController.text,
                              );

                              ref
                                  .read(loadingNotifierProvider.notifier)
                                  .changeTheLoadingStatus(isLoading: true);

                              if (connectionStatus.value == true) {
                                ref
                                    .watch(loginStep1PayloadProvider.notifier)
                                    .state = loginStep1Payload;

                                final step1Response =
                                    await ref.watch(loginStep1Provider.future);

                                ref
                                    .read(loadingNotifierProvider.notifier)
                                    .changeTheLoadingStatus(isLoading: false);

                                if (step1Response.requestStatus ==
                                    RequestStatus.success) {
                                  int? step2Id = step1Response.step2Id;
                                  if (context.mounted && step2Id != null) {
                                    ref.watch(step2IdProvider.notifier).state =
                                        step2Id;

                                    ref.watch(mobileNoProvider.notifier).state =
                                        mobileController.text;
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginOtpVerificationPage(),
                                      ),
                                    );
                                  }
                                } else {
                                  if (context.mounted) {
                                    UIServices.showSnackBar(
                                      context: context,
                                      icon: SnackBarWidgets.errorIconSnackBar(),
                                      text: SnackBarWidgets.errorTextSnackBar(
                                        content: step1Response.errorMessage ??
                                            "Something went to wrong!",
                                      ),
                                    );
                                  }
                                  devtools.log(
                                      "${ConstantsLog.fromLoginPage} ${step1Response.errorMessage}");
                                }
                              } else {
                                Future.delayed(
                                  const Duration(milliseconds: 200),
                                  () {
                                    ref
                                        .read(loadingNotifierProvider.notifier)
                                        .changeTheLoadingStatus(
                                            isLoading: false);

                                    UIServices.showSnackBar(
                                      context: context,
                                      icon: SnackBarWidgets.errorIconSnackBar(),
                                      text: SnackBarWidgets.errorTextSnackBar(
                                        content:
                                            "You are offline. Please connect to the internet",
                                      ),
                                    );
                                  },
                                );
                              }
                            }
                          },
                          child: isLoading
                              ? const SpinKitThreeBounce(
                                  color: Colors.white,
                                  size: 23.0,
                                )
                              : Text(
                                  "Login",
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
                const Gap(24),
                Center(
                  child: InkWell(
                    onTap: () async {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => RegistrationPage(),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: Text(
                      "Haven't Account? Create one",
                      style: GoogleFonts.ubuntu(
                        fontSize: 14,
                        color: const Color(0xffA1A1A1),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
