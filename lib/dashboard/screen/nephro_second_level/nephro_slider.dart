import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heamodialysis/dashboard/model/bar_chart_model.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

class ImageCarouselWithIndicator extends StatefulWidget {
  final List<BarChartModel>? list;

  const ImageCarouselWithIndicator({super.key, this.list});

  @override
  ImageCarouselWithIndicatorState createState() =>
      ImageCarouselWithIndicatorState();
}

class ImageCarouselWithIndicatorState
    extends State<ImageCarouselWithIndicator> {
  // int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 160.h,
            autoPlay: true,
            enlargeCenterPage: false,
            onPageChanged: (index, reason) {
              setState(() {
                // _currentIndex = index;
              });
            },
          ),
          items: widget.list?.map((url) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  alignment: Alignment.center,
                  padding:  EdgeInsets.symmetric(vertical: 8.h,horizontal: 8.w),
                  width: MediaQuery.of(context).size.width,
                  margin:  EdgeInsets.symmetric(horizontal: 5.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [
                        AppColor.primaryBackgroundColor.withValues(alpha: 0.2),
                        AppColor.secondaryColor.withValues(alpha: 0.2),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                           CustomText(
                            text: "Patient Name :",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal,
                            textColor: Colors.black,
                            textAlign: TextAlign.start,
                          ),
                          Expanded(
                            child: CustomText(
                              text: "${url.fName + url.lName}",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.normal,
                              textColor: Colors.grey,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                           CustomText(
                            text: "ABHA Number :",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal,
                            textColor: Colors.black,
                            textAlign: TextAlign.start,
                          ),
                          CustomText(
                            text: "${url.abhNo ?? ""}",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal,
                            textColor: Colors.grey,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                           CustomText(
                            text: "Viral Load Status :",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal,
                            textColor: Colors.black,
                            textAlign: TextAlign.start,
                          ),
                          CustomText(
                            text: url.viralLoadStatus ?? "",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal,
                            textColor: Colors.grey,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                           CustomText(
                            text: "Treatment Under Scheme :",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal,
                            textColor: Colors.black,
                            textAlign: TextAlign.start,
                          ),
                          Expanded(
                            child: CustomText(
                              text: url.schemeName ?? "",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.normal,
                              textColor: Colors.grey,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }).toList(),
        ),
         SizedBox(height: 20.h),

      ],
    );
  }
}
