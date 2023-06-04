import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sayara_tech_app/app/constants/constants_assets.dart';
import 'package:sayara_tech_app/app/constants/constants_log.dart';
import 'package:sayara_tech_app/app/pages/logged_in_pages/add_car_page.dart';
import 'package:sayara_tech_app/app/providers/internet_connection_provider.dart';
import 'package:sayara_tech_app/app/providers/loading_notifier_provider.dart';
import 'package:sayara_tech_app/app/service/providers_services.dart';
import 'package:sayara_tech_app/app/service/ui_services.dart';
import 'package:sayara_tech_app/app/state/cars/models/car.dart';
import 'package:sayara_tech_app/app/state/cars/providers/fetch_cars_provider.dart';
import 'package:sayara_tech_app/app/state/models/request_status.dart';
import 'package:sayara_tech_app/app/widgets/snack_bar_widgets.dart';

class MyCarsPage extends ConsumerWidget {
  const MyCarsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = UIServices.getSize(context);

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
          "My Cars",
          style: GoogleFonts.ubuntu(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            FontAwesomeIcons.circlePlus,
            size: 24,
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AddCarPage(),
              ),
            );
          },
        ),
      ),
      body: ref.watch(fetchCarsProvider).when(
        data: (data) {
          if (data.requestStatus == RequestStatus.success) {
            List<Car> cars = data.cars ?? [];

            if (cars.isNotEmpty) {
              return ListView.builder(
                itemCount: cars.length,
                itemBuilder: (context, index) {
                  Uint8List bytesImage = const Base64Decoder()
                      .convert(cars[index].Vendors_binary_image);

                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    margin: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          spreadRadius: 2,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              cars[index].Vendor_egn_name.toString(),
                              style: GoogleFonts.ubuntu(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                            const Spacer(),
                            Image.memory(
                              bytesImage,
                              width: 80,
                              height: 50,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                        const Gap(12),
                        Container(
                          width: size.width * 0.75,
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                cars[index].Board_No ?? '-',
                                style: GoogleFonts.ubuntu(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              const Gap(12),
                              const Image(
                                image: AssetImage(
                                  ConstantsAssets.boardLogo,
                                ),
                                height: 20,
                                fit: BoxFit.contain,
                              ),
                            ],
                          ),
                        ),
                        const Gap(24),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  height: 36,
                                  child: Center(
                                    child: Text(
                                      "Delete",
                                      style: GoogleFonts.ubuntu(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Gap(24),
                            Expanded(
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  height: 36,
                                  child: Center(
                                    child: Text(
                                      "Edit",
                                      style: GoogleFonts.ubuntu(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Gap(6),
                      ],
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "You Don't Have Cars!",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.ubuntu(
                          fontSize: 16,
                          color: Colors.teal,
                          height: 1.3,
                        ),
                      ),
                      const Gap(12),
                      Text(
                        "Looks like you haven't added any car, add your first car by clicking PLUS button in the top",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.ubuntu(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          } else {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Oops!",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.ubuntu(
                        fontSize: 24,
                        color: Colors.teal,
                        height: 1.3,
                      ),
                    ),
                    const Gap(12),
                    Text(
                      "Something Went Wrong",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.ubuntu(
                        fontSize: 16,
                        color: Colors.black,
                        height: 1.3,
                      ),
                    ),
                    const Gap(24),
                    Consumer(
                      builder: (context, ref, child) {
                        final connectionStatus =
                        ref.watch(internetConnectionStatusProvider);
                        final isLoading = ref.watch(loadingNotifierProvider);

                        return SizedBox(
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
                                ref
                                    .read(loadingNotifierProvider.notifier)
                                    .changeTheLoadingStatus(isLoading: true);

                                if (connectionStatus.value == true) {
                                  ref
                                      .read(loadingNotifierProvider.notifier)
                                      .changeTheLoadingStatus(isLoading: false);
                                  ProvidersServices
                                      .refreshAutoDisposeFutureProvider(
                                    ref: ref,
                                    provider: fetchCarsProvider,
                                    providerName: "fetchCarsProvider",
                                    fromPage: ConstantsLog.fromCarsPage,
                                  );
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
                              },
                              child: isLoading
                                  ? const SpinKitThreeBounce(
                                color: Colors.white,
                                size: 23.0,
                              )
                                  : Text(
                                'Try Again!',
                                style: GoogleFonts.ubuntu(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
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
                    "Oops!",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.ubuntu(
                      fontSize: 24,
                      color: Colors.teal,
                      height: 1.3,
                    ),
                  ),
                  const Gap(12),
                  Text(
                    "Something Went Wrong",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.ubuntu(
                      fontSize: 16,
                      color: Colors.black,
                      height: 1.3,
                    ),
                  ),
                  const Gap(24),
                  Consumer(
                    builder: (context, ref, child) {
                      final connectionStatus =
                          ref.watch(internetConnectionStatusProvider);
                      final isLoading = ref.watch(loadingNotifierProvider);

                      return SizedBox(
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
                              ref
                                  .read(loadingNotifierProvider.notifier)
                                  .changeTheLoadingStatus(isLoading: true);

                              if (connectionStatus.value == true) {
                                ref
                                    .read(loadingNotifierProvider.notifier)
                                    .changeTheLoadingStatus(isLoading: false);
                                ProvidersServices
                                    .refreshAutoDisposeFutureProvider(
                                  ref: ref,
                                  provider: fetchCarsProvider,
                                  providerName: "fetchCarsProvider",
                                  fromPage: ConstantsLog.fromCarsPage,
                                );
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
                            },
                            child: isLoading
                                ? const SpinKitThreeBounce(
                                    color: Colors.white,
                                    size: 23.0,
                                  )
                                : Text(
                                    'Try Again!',
                                    style: GoogleFonts.ubuntu(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      );
                    },
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
