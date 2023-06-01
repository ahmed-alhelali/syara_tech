import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:sayara_tech_app/app/constants/constants_log.dart';
import 'package:sayara_tech_app/app/pages/logged_in_pages/navigation_bar_page.dart';
import 'package:sayara_tech_app/app/providers/loading_notifier_provider.dart';
import 'package:sayara_tech_app/app/widgets/text_style.dart';
import 'package:sayara_tech_app/app/state/models/request_status.dart';
import 'package:sayara_tech_app/app/state/auth/models/payloads/login_step2_payload.dart';
import 'package:sayara_tech_app/app/state/auth/providers/login_providers.dart';
import 'package:sayara_tech_app/app/state/auth/providers/payload_providers.dart';
import 'package:sayara_tech_app/app/state/auth/providers/shared_providers.dart';
import 'package:sayara_tech_app/app/state/providers/user_token_provider.dart';
import 'dart:developer' as devtools;
import '../../service/ui_services.dart';

class LoginOtpVerificationPage extends StatelessWidget {
  const LoginOtpVerificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FractionallySizedBox(widthFactor: 1, child: LoginPinPut())),
    );
  }
}

class LoginPinPut extends ConsumerWidget {
  LoginPinPut({super.key});

  final pinController = TextEditingController();
  final focusNode = FocusNode();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final isLoading = ref.watch(loadingNotifierProvider);

    final defaultPinTheme = PinTheme(
      width: 48,
      height: 48,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
    );

    final size = UIServices.getSize(context);
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(size.height * 0.15),
              Text(
                "One Time Password",
                style: GoogleFonts.ubuntu(
                  fontSize: 22,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const Gap(24),
              Text(
                "To access the app in a safe way, please enter the code that you received on your mobile",
                style: GoogleFonts.ubuntu(
                  fontSize: 16,
                  color: const Color(0xffA1A1A1),
                ),
              ),
              const Gap(24),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Pinput(
                  autofocus: false,
                  pinputAutovalidateMode: PinputAutovalidateMode.disabled,
                  controller: pinController,
                  focusNode: focusNode,
                  androidSmsAutofillMethod:
                      AndroidSmsAutofillMethod.smsUserConsentApi,
                  listenForMultipleSmsOnAndroid: true,
                  defaultPinTheme: defaultPinTheme,
                  errorTextStyle: textFieldErrorStyle,
                  validator: (value) {
                    final userToken =
                        ref.watch(userTokenNotifierProvider.notifier).userToken;

                    if (userToken != null) {
                      devtools.log(
                          "${ConstantsLog.fromLoginOtpPage} user token update to: $userToken");
                      return null;
                    } else {
                      devtools.log(
                          "${ConstantsLog.fromLoginOtpPage} user token still null");
                      return 'Invalid SMS Verification Code';
                    }
                  },
                  hapticFeedbackType: HapticFeedbackType.lightImpact,
                  onCompleted: (pin) {
                    ref.watch(otpProvider.notifier).state = pin;
                  },
                  closeKeyboardWhenCompleted: false,
                  cursor: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 9),
                        width: 22,
                        height: 1,
                        color: focusedBorderColor,
                      ),
                    ],
                  ),
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: focusedBorderColor),
                    ),
                  ),
                  submittedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      color: fillColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: focusedBorderColor),
                    ),
                  ),
                  errorPinTheme: defaultPinTheme.copyBorderWith(
                    border: Border.all(color: Colors.redAccent),
                  ),
                ),
              ),
              const Gap(24),
              SizedBox(
                width: size.width,
                height: 45,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                    onPressed: () async {
                      if (isLoading == false && pinController.text.isNotEmpty) {
                        ref
                            .read(loadingNotifierProvider.notifier)
                            .changeTheLoadingStatus(isLoading: true);

                        final step2Id = ref.read(step2IdProvider);
                        final otpCode = ref.read(otpProvider);
                        final mobileNo = ref.read(mobileNoProvider);
                        ref.watch(loginStep2PayloadProvider.notifier).state =
                            LoginStep2Payload(
                          mobileNo: mobileNo,
                          step1Id: step2Id,
                          smsCode: otpCode,
                        );

                        final step2Response =
                            await ref.watch(loginStep2Provider.future);
                        ref
                            .read(loadingNotifierProvider.notifier)
                            .changeTheLoadingStatus(isLoading: false);

                        if (step2Response.requestStatus ==
                            RequestStatus.success) {
                          ref
                              .read(userTokenNotifierProvider.notifier)
                              .updateTheUserToken(
                                  userToken: step2Response.userToken);
                          focusNode.unfocus();
                          formKey.currentState!.validate();

                          if (context.mounted) {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => const NavigationBarPage(),
                              ),
                              (Route<dynamic> route) => false,
                            );
                          }
                        } else {
                          focusNode.unfocus();
                          formKey.currentState!.validate();
                        }
                      }
                    },
                    child: isLoading
                        ? const SpinKitThreeBounce(
                            color: Colors.white,
                            size: 23.0,
                          )
                        : Text(
                            'Validate',
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
      ),
    );
  }
}
