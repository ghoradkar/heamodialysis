import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/new_registration/screen/new_registration.dart';
import 'package:heamodialysis/registered_patient_list/screen/registered_patient_list.dart';

import '../../internet/no_internet_connectivity.dart';
import '../../utils/color_constants.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_shimmer_loader.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final Connectivity _connectivity = Connectivity();
  bool _isNetworkAvailable = true;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  bool isLoading = true;

  @override
  void initState() {
    _initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
    super.initState();
  }

  Future<void> _initConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    _updateConnectionStatus(result);
  }

  // Update connection status handler
  void _updateConnectionStatus(List<ConnectivityResult> results) {
    final isConnected = results.any(
      (result) =>
          result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi,
    );

    setState(() {
      _isNetworkAvailable = isConnected;
    });
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isNetworkAvailable
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: AppColor.primaryBackgroundColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30), // adjust as needed
                ),
              ),
              title: const CustomText(
                text: 'Registration',
                fontSize: 18.0,
                fontFam: 'Lato',
                fontWeight: FontWeight.w400,
                textColor: Colors.white,
                textAlign: TextAlign.start,
              ),
              leading: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset(
                    'assets/arrow-left.png',
                    color: Colors.white,
                  )),
            ),
            body: isLoading
                ? const RegistrationShimmer()
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        GestureDetector(
                          onTap: () {
                            Get.to(() => const NewRegistration(
                                  isViewPatient: false,
                                  pageTitle: 'New Registration',
                                  isEdit: false,
                                ));
                          },
                          child: IntrinsicHeight(
                            child: Container(
                              width: 150,
                              height: 130,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF9D7),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 13),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/abha_registration.png',
                                    ),
                                    const SizedBox(height: 8),
                                    const CustomText(
                                      text: 'New Registration',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      textColor: Colors.black,
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Registered Patients Button
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const RegisteredPatientList());
                          },
                          child: Container(
                            width: 150,
                            height: 130,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFE7E7),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/team.png'),
                                const SizedBox(height: 8),
                                const CustomText(
                                  text: 'Registered Patients',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  textColor: Colors.black,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

    )
        : InternetIssue(
            onRetryPressed: () async {
              final result = await _connectivity.checkConnectivity();
              _updateConnectionStatus(result);
            },
          );
  }
}
