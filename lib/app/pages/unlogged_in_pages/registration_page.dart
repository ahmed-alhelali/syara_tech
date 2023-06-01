import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sayara_tech_app/app/constants/constants_assets.dart';
import 'package:sayara_tech_app/app/constants/constants_log.dart';
import 'package:sayara_tech_app/app/providers/loading_notifier_provider.dart';
import 'package:sayara_tech_app/app/providers/onscure_notifier_provider.dart';
import 'package:sayara_tech_app/app/service/ui_services.dart';
import 'package:sayara_tech_app/app/widgets/text_style.dart';
import 'package:sayara_tech_app/app/state/models/request_status.dart';
import 'package:sayara_tech_app/app/state/auth/models/payloads/registration_step1_payload.dart';
import 'package:sayara_tech_app/app/state/auth/providers/payload_providers.dart';
import 'package:sayara_tech_app/app/state/auth/providers/registration_providers.dart';
import 'package:sayara_tech_app/app/pages/unlogged_in_pages/registration_otp_page.dart';
import 'dart:developer' as devtools;
import 'package:sayara_tech_app/app/widgets/snack_bar_widgets.dart';
import 'package:sayara_tech_app/app/state/auth/providers/shared_providers.dart';
import 'package:sayara_tech_app/app/state/providers/user_token_provider.dart';
import 'package:sayara_tech_app/app/pages/unlogged_in_pages/login_page.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({super.key});

  final nameController = TextEditingController();
  final pwdController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final nameFocusNode = FocusNode();
  final pwdFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
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
                  "Create an Account",
                  style: GoogleFonts.ubuntu(
                    fontSize: 18,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const Gap(18),
                Text(
                  "Create your account using the fields below and make sure the phone is correct",
                  style: GoogleFonts.ubuntu(
                    fontSize: 14,
                    color: const Color(0xffA1A1A1),
                  ),
                ),
                const Gap(24),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        focusNode: nameFocusNode,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'The name is required';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          prefixIcon: const Icon(
                            Icons.person,
                            size: 18,
                            color: Color(0xffA1A1A1),
                          ),
                          isDense: true,
                          hintText: "Name",
                          hintStyle: textFieldHintStyle,
                          errorStyle: textFieldErrorStyle,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xffA1A1A1),
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
                        style: textFieldFontStyle,
                      ),
                      const Gap(8),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        focusNode: emailFocusNode,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.trim().isEmpty) {
                            return 'The email is required';
                          } else if (!UIServices.emailIsMatched(value)) {
                            return 'The email is not valid';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          prefixIcon: const Icon(
                            Icons.email,
                            size: 18,
                            color: Color(0xffA1A1A1),
                          ),
                          isDense: true,
                          hintText: "Email",
                          hintStyle: textFieldHintStyle,
                          errorStyle: textFieldErrorStyle,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xffA1A1A1),
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
                        style: textFieldFontStyle,
                      ),
                      const Gap(8),
                      Consumer(
                        builder: (_, ref, child) {
                          final isObscurePassword =
                              ref.watch(passwordVisibilityProvider);

                          return TextFormField(
                            obscureText: isObscurePassword,
                            controller: pwdController,
                            focusNode: pwdFocusNode,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.trim().isEmpty) {
                                return 'The password is required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              prefixIcon: const Icon(
                                Icons.vpn_key_rounded,
                                size: 18,
                                color: Color(0xffA1A1A1),
                              ),
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    isObscurePassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    ref
                                        .read(
                                            passwordVisibilityProvider.notifier)
                                        .changeTheObscureStatus();
                                  }),
                              isDense: true,
                              hintText: "Password",
                              hintStyle: textFieldHintStyle,
                              errorStyle: textFieldErrorStyle,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xffA1A1A1),
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
                            style: textFieldFontStyle,
                          );
                        },
                      ),
                      const Gap(8),
                      TextFormField(
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
                          hintText: "50XXXXXXX",
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
                          } else if (!UIServices
                              .phoneNumberIsMatchedInRegistrationCase(value)) {
                            return 'The phone should be 9 digits';
                          }
                          return null;
                        },
                        style: textFieldFontStyle,
                      ),
                    ],
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
                        final isLoading = ref.watch(loadingNotifierProvider);
                        return ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).primaryColor,
                            ),
                          ),
                          onPressed: () async {

                            UIServices.unFocusAll([
                              nameFocusNode,
                              emailFocusNode,
                              pwdFocusNode,
                              mobileFocusNode
                            ]);

                            if (formKey.currentState!.validate() &&
                                !isLoading) {
                              final registrationStep1Payload =
                                  RegistrationStep1Payload(
                                name: nameController.text,
                                pwd: pwdController.text,
                                email: emailController.text,
                                mobile: mobileController.text,
                              );

                              ref
                                  .read(loadingNotifierProvider.notifier)
                                  .changeTheLoadingStatus(isLoading: true);

                              ref
                                  .watch(
                                      registrationStep1PayloadProvider.notifier)
                                  .state = registrationStep1Payload;

                              final step1Response = await ref
                                  .watch(registrationStep1Provider.future);

                              ref
                                  .read(loadingNotifierProvider.notifier)
                                  .changeTheLoadingStatus(isLoading: false);

                              if (step1Response.requestStatus ==
                                  RequestStatus.success) {
                                int? step2Id = step1Response.step2Id;

                                if (context.mounted && step2Id != null) {
                                  ref.watch(step2IdProvider.notifier).state =
                                      step2Id;
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const RegistrationOtpVerificationPage(),
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
                                devtools
                                    .log("${ConstantsLog.fromRegistrationPage} ${step1Response.errorMessage}");
                              }
                            }
                          },
                          child: isLoading
                              ? const SpinKitThreeBounce(
                                  color: Colors.white,
                                  size: 23.0,
                                )
                              : Text(
                                  "Create",
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
                          builder: (context) => LoginPage(),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: Text(
                      "Already have an account? Login",
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
