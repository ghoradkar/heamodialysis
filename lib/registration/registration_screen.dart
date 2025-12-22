import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/new_registration/screens/new_registration.dart';
import 'package:heamodialysis/registered_patient_list/screens/registered_patient_list.dart';

import '../utils/color_constants.dart';
import '../widgets/custom_text.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
// New Registration Button
            GestureDetector(
              onTap: () {
                Get.to(() =>  NewRegistration(
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
    );
  }
}
