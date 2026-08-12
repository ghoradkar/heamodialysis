import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:shimmer/shimmer.dart';
import 'package:heamodialysis/utils/color_constants.dart';

Widget headerCard() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
    padding: EdgeInsets.all(16.w),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14.r),
      color: Colors.grey.shade300,
    ),
    child: Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Colors.grey.shade400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              box(h: 50.h, w: 50.h, radius: 10.r),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    box(h: 14.h, w: 120.w),
                    SizedBox(height: 8.h),
                    box(h: 12.h, w: 180.w),
                  ],
                ),
              ),
              box(h: 24.h, w: 24.h, radius: 12.r),
            ],
          ),
          SizedBox(height: 16.h),
          box(h: 12.h, w: 200.w),
          SizedBox(height: 10.h),
          Row(
            children: [
              box(h: 12.h, w: 80.w),
              SizedBox(width: 16.w),
              box(h: 12.h, w: 60.w),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget box({double h = 12, double w = double.infinity, double radius = 4}) {
  return Container(
    height: h,
    width: w,
    decoration: BoxDecoration(
      color: Colors.grey.shade300,
      borderRadius: BorderRadius.circular(radius),
    ),
  );
}

Widget buildShimmerLoader() {
  return ListView.builder(
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: 60,
            margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      );
    },
  );
}

class ViewApplicationShimmer extends StatelessWidget {
  const ViewApplicationShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 18.h),

          /// Tabs Shimmer
          _tabsShimmer(),

          SizedBox(height: 18.h),

          /// Expansion Cards
          _cardShimmer(),
          _cardShimmer(),
          _cardShimmer(),
          _cardShimmer(),
        ],
      ),
    );
  }

  Widget _tabsShimmer() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        children: List.generate(
          4,
          (index) => Expanded(
            child: Container(
              height: 70.h,
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Shimmer.fromColors(
                  baseColor: Colors.white,
                  highlightColor: Colors.grey.shade400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// Icon Shimmer
                      Container(
                        height: 22.h,
                        width: 22.w,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                      ),

                      SizedBox(height: 8.h),

                      /// Text Shimmer
                      Container(
                        height: 10.h,
                        width: 55.w,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _cardShimmer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.grey.shade400,
        child: Row(
          children: [
            /// Icon placeholder
            Container(
              height: 24.h,
              width: 24.w,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(6.r),
              ),
            ),

            SizedBox(width: 14.w),

            /// Text placeholder
            Expanded(
              child: Container(
                height: 14.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),

            SizedBox(width: 10.w),

            /// Arrow placeholder
            Container(
              height: 18.h,
              width: 18.w,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(4.r),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NeproCardShimmer extends StatelessWidget {
  const NeproCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _line(width: 120),
              SizedBox(height: 8.h),
              _line(width: double.infinity),
              SizedBox(height: 8.h),
              _line(width: 180),
              SizedBox(height: 8.h),
              Row(
                children: [
                  _line(width: 80),
                  SizedBox(width: 16.w),
                  _line(width: 60),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _line({required double width}) {
    return Container(
      height: 12.h,
      width: width,
      color: Colors.white,
    );
  }
}

class PatientListShimmer extends StatelessWidget {
  const PatientListShimmer({super.key});

  Widget shimmerBox({double height = 10, double width = double.infinity}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget patientCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: shimmerBox(width: 120)),
                const SizedBox(width: 10),
                Expanded(child: shimmerBox(width: 120)),
                const Spacer(),
                shimmerBox(width: 20, height: 20),
                const SizedBox(width: 10),
                shimmerBox(width: 20, height: 20),
              ],
            ),
            const SizedBox(height: 12),
            shimmerBox(width: 220),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: shimmerBox(width: 80)),
                const SizedBox(width: 20),
                Expanded(child: shimmerBox(width: 80)),
              ],
            ),
            const SizedBox(height: 12),
            shimmerBox(width: 160),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      itemBuilder: (context, index) {
        return patientCard();
      },
    );
  }
}

class PatientHistoryShimmer extends StatelessWidget {
  final bool isHeaderOnly;
  const PatientHistoryShimmer({super.key}) : isHeaderOnly = false;
  const PatientHistoryShimmer.headerCard({super.key}) : isHeaderOnly = true;

  Widget box({double h = 12, double w = double.infinity, double radius = 4}) {
    return Container(
      height: h,
      width: w,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  Widget headerCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        color: Colors.grey.shade300,
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.grey.shade400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                box(h: 50.h, w: 50.h, radius: 10.r),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      box(h: 14.h, w: 120.w),
                      SizedBox(height: 8.h),
                      box(h: 12.h, w: 180.w),
                    ],
                  ),
                ),
                box(h: 24.h, w: 24.h, radius: 12.r),
              ],
            ),
            SizedBox(height: 16.h),
            box(h: 12.h, w: 200.w),
            SizedBox(height: 10.h),
            Row(
              children: [
                box(h: 12.h, w: 80.w),
                SizedBox(width: 16.w),
                box(h: 12.h, w: 60.w),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget timelineCard() {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h, right: 16.w),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.grey.shade300,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.grey.shade400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            box(h: 38.h, w: 140.w, radius: 8.r),
            SizedBox(height: 12.h),
            box(h: 12.h, w: double.infinity),
            SizedBox(height: 10.h),
            Align(
              alignment: Alignment.centerRight,
              child: box(h: 10.h, w: 100.w),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isHeaderOnly) {
      return headerCard();
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          headerCard(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              itemBuilder: (context, index) {
                return IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.white,
                        highlightColor: Colors.grey.shade400,
                        child: Column(
                          children: [
                            box(h: 20.h, w: 1.w),
                            Container(
                              height: 22.h,
                              width: 22.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[300],
                              ),
                            ),
                            Expanded(child: box(w: 1.w)),
                          ],
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(child: timelineCard()),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BoxShimmer extends StatelessWidget {
  final double? height;
  final double? width;
  final double borderRadius;
  const BoxShimmer({super.key, this.height, this.width, this.borderRadius = 8});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFE0E0E0), // Colors.grey.shade300
      highlightColor: const Color(0xFFF5F5F5), // Colors.grey.shade100
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

class NephroDeskShimmer extends StatelessWidget {
  const NephroDeskShimmer({super.key});

  Widget box({double h = 14, double w = double.infinity}) {
    return Container(
      height: h,
      width: w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }

  /// Avatar shimmer (top left icon)
  Widget avatarShimmer() {
    return Container(
      height: 42,
      width: 42,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Container(
          height: 20,
          width: 20,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget patientCard() {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.grey.shade400,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Left Image
            avatarShimmer(),

            const SizedBox(width: 12),

            /// Text Area
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  box(w: 120),
                  const SizedBox(height: 10),
                  box(w: 180),
                  const SizedBox(height: 10),
                  box(w: 160),
                ],
              ),
            ),

            /// Right Plus Icon
            Container(
              height: 26,
              width: 26,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget gridItem() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.grey.shade400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// icon shimmer
            Container(
              height: 22,
              width: 22,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(6),
              ),
            ),

            const SizedBox(height: 8),

            /// text shimmer
            Container(
              height: 8,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sectionTile() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 55,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.grey.shade400,
        child: Row(
          children: [
            /// Left icon shimmer
            Container(
              height: 22,
              width: 22,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(6),
              ),
            ),

            const SizedBox(width: 12),

            /// Title shimmer
            Expanded(
              child: Container(
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),

            const SizedBox(width: 12),

            /// Right arrow shimmer
            Container(
              height: 16,
              width: 16,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          /// Patient Card
          patientCard(),

          const SizedBox(height: 10),

          /// Grid Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 8,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1.3,
              ),
              itemBuilder: (context, index) {
                return gridItem();
              },
            ),
          ),

          const SizedBox(height: 14),

          /// Section Tiles
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: List.generate(
                6,
                (index) => sectionTile(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TrendAnalysisShimmer extends StatelessWidget {
  const TrendAnalysisShimmer({super.key});

  Widget box({required double h, required double w, double radius = 8.0}) {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Colors.grey.shade400,
      child: Container(
        height: h,
        width: w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius.r),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerCard(),

          SizedBox(height: 16.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 8,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1.3,
              ),
              itemBuilder: (context, index) {
                return gridItem();
              },
            ),
          ),

          SizedBox(height: 20.h),

          // Tabular/Graph Buttons
          _buildViewToggleButtons(),
          // _buildViewToggleButtons(),

          SizedBox(height: 20.h),
          _buildDataTable(),
        ],
      ),
    );
  }

  Widget headerCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        color: Colors.grey.shade300,
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.grey.shade400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                box(h: 50.h, w: 50.h, radius: 10.r),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      box(h: 14.h, w: 120.w),
                      SizedBox(height: 8.h),
                      box(h: 12.h, w: 180.w),
                    ],
                  ),
                ),
                box(h: 24.h, w: 24.h, radius: 12.r),
              ],
            ),
            SizedBox(height: 16.h),
            box(h: 12.h, w: 200.w),
            SizedBox(height: 10.h),
            Row(
              children: [
                box(h: 12.h, w: 80.w),
                SizedBox(width: 16.w),
                box(h: 12.h, w: 60.w),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget gridItem() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.grey.shade400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// icon shimmer
            Container(
              height: 22,
              width: 22,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(6),
              ),
            ),

            const SizedBox(height: 8),

            /// text shimmer
            Container(
              height: 8,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildViewToggleButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        children: [
          /// Tabular Button Shimmer
          Expanded(
            child: Container(
              height: 42.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Colors.grey.shade400,
                child: Center(
                  child: Container(
                    height: 10.h,
                    width: 70.w,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(width: 12.w),

          /// Graph Button Shimmer
          Expanded(
            child: Container(
              height: 42.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Colors.grey.shade400,
                child: Center(
                  child: Container(
                    height: 10.h,
                    width: 70.w,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestNameSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Test Name Label
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: 20.h,
              width: 120.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),

          SizedBox(height: 12.h),

          // Test Name Value (Weight)
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: 24.h,
              width: 80.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataTable() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          children: [
            // Table Header
            Container(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.r),
                  topRight: Radius.circular(8.r),
                ),
              ),
              child: Row(
                children: [
                  Expanded(flex: 1, child: box(h: 16.h, w: 40.w)),
                  SizedBox(width: 5),
                  Expanded(flex: 2, child: box(h: 16.h, w: 60.w)),
                  SizedBox(width: 5),
                  Expanded(flex: 2, child: box(h: 16.h, w: 40.w)),
                  SizedBox(width: 5),
                  Expanded(flex: 1, child: box(h: 16.h, w: 50.w)),
                ],
              ),
            ),

            // Table Rows (6 rows as shown in image)
            ...List.generate(6, (index) => _buildTableRow(index)),
          ],
        ),
      ),
    );
  }

  Widget _buildTableRow(int index) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: index < 5
              ? BorderSide(color: Colors.grey.shade400)
              : BorderSide.none,
          left: const BorderSide(color: Colors.grey),
          right: const BorderSide(color: Colors.grey),
        ),
      ),
      child: Row(
        children: [
          // Sr. No.
          Expanded(
            flex: 1,
            child: box(h: 14.h, w: 20.w),
          ),
          // Test Name (Pre/Post Dialysis)
          Expanded(
            flex: 2,
            child: box(h: 14.h, w: 70.w),
          ),
          // Date
          Expanded(
            flex: 2,
            child: box(h: 14.h, w: 60.w),
          ),
          // Weight Value
          Expanded(
            flex: 1,
            child: box(h: 14.h, w: 30.w),
          ),
        ],
      ),
    );
  }
}

class PatientDetails extends StatelessWidget {
  const PatientDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          headerCard(),
          _buildViewToggleButtons(),
          applicationDetailsShimmer()
        ],
      ),
    );
  }

  Widget headerCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        color: Colors.grey.shade300,
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.grey.shade400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                box(h: 50.h, w: 50.h, radius: 10.r),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      box(h: 14.h, w: 120.w),
                      SizedBox(height: 8.h),
                      box(h: 12.h, w: 180.w),
                    ],
                  ),
                ),
                box(h: 24.h, w: 24.h, radius: 12.r),
              ],
            ),
            SizedBox(height: 16.h),
            box(h: 12.h, w: 200.w),
            SizedBox(height: 10.h),
            Row(
              children: [
                box(h: 12.h, w: 80.w),
                SizedBox(width: 16.w),
                box(h: 12.h, w: 60.w),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget box({required double h, required double w, double radius = 8.0}) {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Colors.grey.shade400,
      child: Container(
        height: h,
        width: w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius.r),
        ),
      ),
    );
  }

  Widget _buildViewToggleButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        children: [
          /// Tabular Button Shimmer
          Expanded(
            child: Container(
              height: 42.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Colors.grey.shade400,
                child: Center(
                  child: Container(
                    height: 10.h,
                    width: 70.w,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(width: 12.w),

          /// Graph Button Shimmer
          Expanded(
            child: Container(
              height: 42.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Colors.grey.shade400,
                child: Center(
                  child: Container(
                    height: 10.h,
                    width: 70.w,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget applicationDetailsShimmer() {
    return Container(
      margin: EdgeInsets.all(12.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.grey.shade400,
        child: Column(
          children: [
            /// Row 1
            Row(
              children: [
                Expanded(child: fieldShimmer()),
                SizedBox(width: 14.w),
                Expanded(child: fieldShimmer()),
              ],
            ),

            SizedBox(height: 18.h),

            /// Row 2
            Row(
              children: [
                Expanded(child: fieldShimmer()),
                SizedBox(width: 14.w),
                Expanded(child: fieldShimmer()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget fieldShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Label
        Container(
          height: 12.h,
          width: 100.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),

        SizedBox(height: 8.h),

        /// TextField Box
        Container(
          height: 42.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
          ),
        )
      ],
    );
  }
}

class ScrutinyApprovalShimmer extends StatelessWidget {
  const ScrutinyApprovalShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      padding: const EdgeInsets.all(12),
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.white,
            highlightColor: Colors.grey.shade400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _line(width: 180, height: 12),
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    )
                  ],
                ),
                _line(width: 180),
                const SizedBox(height: 10),
                _line(width: 200),
                const SizedBox(height: 10),
                _line(width: 160),
                const SizedBox(height: 10),
                _line(width: 220),
                const SizedBox(height: 10),
                _line(width: 140),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _line(width: 180, height: 12),
                    Container(
                      height: 28,
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _line({double width = double.infinity, double height = 12}) {
    return Container(
      width: width,
      height: height,
      color: Colors.white,
    );
  }
}

class BookAppointmentShimmer extends StatelessWidget {
  const BookAppointmentShimmer({super.key});

  Widget _buildShimmerBox(
      {double? height, double? width, double radius = 8.0}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(radius.r),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header Card (Patient Info)
              _buildHeaderCard(),

              SizedBox(height: 12.h),

              /// Month and Navigation
              _buildMonthSection(),

              SizedBox(height: 12.h),

              /// Calendar Days (Structural)
              _buildCalendarSection(),

              SizedBox(height: 20.h),

              /// Select Institute Label
              _buildShimmerBox(height: 16.h, width: 100.w),
              SizedBox(height: 10.h),

              /// Select Institute Dropdown
              _buildInstituteSection(),

              SizedBox(height: 24.h),

              /// Choose Slot Label
              _buildShimmerBox(height: 18.h, width: 90.w),
              SizedBox(height: 14.h),

              /// Choose Slot Options
              _buildSlotSection(),

              SizedBox(height: 20.h),

              /// Bed Status Legends
              _buildLegendSection(),

              SizedBox(height: 20.h),

              /// Bed Grid Section
              _buildBedGridSection(),

              SizedBox(height: 32.h),

              /// Book Appointment Button
              _buildBookButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade300, // Light blue background
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.grey.shade400,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildShimmerBox(height: 40.h, width: 40.h, radius: 8.0),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildShimmerBox(height: 14.h, width: 150.w),
                      SizedBox(height: 8.h),
                      _buildShimmerBox(height: 12.h, width: 180.w),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 14.h),
            Row(
              children: [
                Expanded(child: _buildShimmerBox(height: 12.h, width: 80.w)),
                SizedBox(width: 10.w),
                Expanded(child: _buildShimmerBox(height: 12.h, width: 80.w)),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Expanded(child: _buildShimmerBox(height: 12.h, width: 80.w)),
                SizedBox(width: 10.w),
                Expanded(child: _buildShimmerBox(height: 12.h, width: 80.w)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthSection() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.chevron_left, size: 24.sp),
          SizedBox(width: 20.w),
          Icon(Icons.calendar_month, size: 20.sp, color: Colors.blue),
          SizedBox(width: 8.w),
          _buildShimmerBox(height: 16.h, width: 140.w),
          SizedBox(width: 20.w),
          Icon(Icons.chevron_right, size: 24.sp),
        ],
      ),
    );
  }

  Widget _buildCalendarSection() {
    return Container(
      height: 100.h,
      decoration: BoxDecoration(
        color: Colors.grey.shade300, // Teal background
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.grey.shade400,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(7, (index) {
            bool isSelected = index == 5; // Friday 20
            if (isSelected) {
              return Container(
                width: 50.w,
                height: 80.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildShimmerBox(height: 12.h, width: 25.w),
                    SizedBox(height: 6.h),
                    _buildShimmerBox(height: 14.h, width: 20.w),
                    SizedBox(height: 6.h),
                    const Icon(Icons.check_circle_outline,
                        size: 16, color: Colors.teal),
                  ],
                ),
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildShimmerBox(height: 12.h, width: 25.w),
                SizedBox(height: 10.h),
                _buildShimmerBox(height: 14.h, width: 20.w),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildInstituteSection() {
    return Container(
      width: double.infinity,
      height: 45.h,
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildShimmerBox(height: 14.h, width: 120.w),
            const Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }

  Widget _buildSlotSection() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildTimeSlot(
              time: "8.00 am", isSelected: true, subText: "Filling Fast"),
          SizedBox(width: 12.w),
          _buildTimeSlot(time: "12.00 pm", isSelected: false),
          SizedBox(width: 12.w),
          _buildTimeSlot(time: "2.00 pm", isSelected: false),
        ],
      ),
    );
  }

  Widget _buildTimeSlot(
      {required String time, bool isSelected = false, String? subText}) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.white,
            highlightColor: Colors.grey.shade400,
            child: Row(
              children: [
                const Icon(Icons.access_time, size: 18),
                SizedBox(width: 8.w),
                _buildShimmerBox(height: 14.h, width: 60.w),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLegendSection() {
    return Wrap(
      spacing: 12.w,
      runSpacing: 8.h,
      children: [
        _buildLegendItem(color: Colors.grey.shade300, label: "Beds Allocated"),
        _buildLegendItem(color: Colors.grey.shade300, label: "HIV+"),
        _buildLegendItem(color: Colors.grey.shade300, label: "Hepatitis C+"),
        _buildLegendItem(color: Colors.grey.shade300, label: "Hepatitis B+"),
        _buildLegendItem(color: Colors.grey.shade300, label: "Negative"),
      ],
    );
  }

  Widget _buildLegendItem({required Color color, required String label}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.white,
          highlightColor: Colors.grey.shade400,
          child: Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          ),
        ),
        SizedBox(width: 4.w),
        _buildShimmerBox(height: 10.h, width: 80.w),
      ],
    );
  }

  Widget _buildBedGridSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Shimmer.fromColors(
              baseColor: Colors.white,
              highlightColor: Colors.grey.shade400,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.location_on_outlined,
                      size: 18, color: Colors.teal),
                  SizedBox(width: 8.w),
                  _buildShimmerBox(height: 14.h, width: 80.w),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.85,
            ),
            itemBuilder: (context, index) {
              return _buildBedCard(index);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBedCard(int index) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.grey.shade300,
        child: Column(
          children: [
            Container(
              height: 45.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.vertical(top: Radius.circular(10.r)),
              ),
              child: Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Colors.grey.shade400,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Icon(Icons.king_bed_outlined,
                        color: Colors.white, size: 28),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(8.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildShimmerBox(height: 10.h, width: 40.w),
                    SizedBox(height: 4.h),
                    _buildShimmerBox(height: 12.h, width: 20.w),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookButton() {
    return Container(
      width: double.infinity,
      height: 45.h,
      decoration: BoxDecoration(
        color: const Color(0xFFB2DFDB),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Center(
        child: Shimmer.fromColors(
          baseColor: Colors.white,
          highlightColor: Colors.grey.shade400,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check, color: Colors.white),
              SizedBox(width: 8.w),
              _buildShimmerBox(height: 16.h, width: 120.w),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisteredPatientsShimmer extends StatelessWidget {
  const RegisteredPatientsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      itemCount: 5,
      itemBuilder: (context, index) {
        return _patientCardShimmer();
      },
    );
  }

  Widget _patientCardShimmer() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Shimmer.fromColors(
          baseColor: Colors.white,
          highlightColor: Colors.grey.shade400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Row with Patient Id + Icons
              Row(
                children: [
                  Container(
                    height: 12.h,
                    width: 120.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  Spacer(),
                  _icon(),
                  SizedBox(width: 10.w),
                  _icon(),
                  SizedBox(width: 10.w),
                  _icon(),
                  SizedBox(width: 10.w),
                  _icon(),
                ],
              ),

              SizedBox(height: 12.h),

              _textLine(180.w),
              SizedBox(height: 10.h),

              _textLine(120.w),
              SizedBox(height: 10.h),

              _textLine(220.w),
              SizedBox(height: 10.h),

              _textLine(160.w),
              SizedBox(height: 10.h),

              _textLine(150.w),
            ],
          ),
        ),
      ),
    );
  }

  Widget _icon() {
    return Container(
      height: 18.h,
      width: 18.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }

  Widget _textLine(double width) {
    return Container(
      height: 12.h,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }
}

class SessionEndPatientsShimmer extends StatelessWidget {
  const SessionEndPatientsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      itemCount: 5,
      itemBuilder: (context, index) {
        return _patientCardShimmer();
      },
    );
  }

  Widget _patientCardShimmer() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Shimmer.fromColors(
          baseColor: Colors.white,
          highlightColor: Colors.grey.shade400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Row with Patient Id + Icons
              Row(
                children: [
                  Container(
                    height: 12.h,
                    width: 120.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  Spacer(),
                  _icon(),
                  SizedBox(width: 10.w),
                  _icon(),
                ],
              ),

              SizedBox(height: 12.h),

              _textLine(180.w),
              SizedBox(height: 10.h),

              _textLine(120.w),
              SizedBox(height: 10.h),

              _textLine(220.w),
              SizedBox(height: 10.h),

              _textLine(160.w),
              SizedBox(height: 10.h),

              _textLine(150.w),
            ],
          ),
        ),
      ),
    );
  }

  Widget _icon() {
    return Container(
      height: 18.h,
      width: 18.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }

  Widget _textLine(double width) {
    return Container(
      height: 12.h,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }
}

class DischargeShimmer extends StatelessWidget {
  const DischargeShimmer({super.key});

  Widget shimmerBox({
    double height = 20,
    double width = double.infinity,
    double radius = 8,
    Widget? child,
  }) {
    return Shimmer.fromColors(
      highlightColor: Colors.grey.shade400,
      baseColor: Colors.white,
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: child, // content yaha show hoga
      ),
    );
  }

  Widget checkboxRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          shimmerBox(height: 18, width: 18, radius: 4),
          const SizedBox(width: 10),
          shimmerBox(height: 14, width: 100),
        ],
      ),
    );
  }

  Widget button({required String text, double width = 120}) {
    return shimmerBox(
      height: 40,
      width: width,
      radius: 10,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerCard(),

          /// Patient Card

          const SizedBox(height: 20),

          /// Checkbox Container
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Shimmer.fromColors(
              baseColor: Colors.white,
              highlightColor: Colors.grey.shade400,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      checkboxRow(),
                      checkboxRow(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      checkboxRow(),
                      checkboxRow(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      checkboxRow(),
                      checkboxRow(),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          /// Terms & Conditions Title
          shimmerBox(height: 16, width: 150),

          const SizedBox(height: 10),

          Row(
            children: [
              shimmerBox(height: 18, width: 18, radius: 4),
              const SizedBox(width: 10),
              shimmerBox(height: 14, width: 220),
            ],
          ),

          const Spacer(),

          /// Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              button(text: "Cancel", width: 120),
              const SizedBox(width: 20),
              button(text: "Discharge", width: 120),
            ],
          )
        ],
      ),
    );
  }
}

class DialysisShimmer extends StatelessWidget {
  const DialysisShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.grey.shade400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Image Size Container
            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(
                "assets/preDialysis.png",
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 14),

            /// Text
            Container(
              height: 5,
              width: 40,
              color: Colors.grey.shade300,
            )
          ],
        ),
      ),
    );
  }
}

class DailyRoLogSheetShimmer extends StatelessWidget {
  const DailyRoLogSheetShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      itemCount: 11,
      itemBuilder: (context, index) {
        return _patientCardShimmer();
      },
    );
  }

  Widget _patientCardShimmer() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Shimmer.fromColors(
          baseColor: Colors.white,
          highlightColor: Colors.grey.shade400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Row with Patient Id + Icons
              Row(
                children: [
                  Container(
                    height: 12.h,
                    width: 120.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  Spacer(),
                  _icon(),
                ],
              ),

              SizedBox(height: 12.h),

              _textLine(180.w),
            ],
          ),
        ),
      ),
    );
  }

  Widget _icon() {
    return Container(
      height: 18.h,
      width: 18.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }

  Widget _textLine(double width) {
    return Container(
      height: 12.h,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }
}

class ROLogSheetShimmer extends StatelessWidget {
  const ROLogSheetShimmer({super.key});

  Widget shimmerBox({double h = 16, double w = double.infinity}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: h,
        width: w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }

  Widget tableRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          SizedBox(width: 30, child: shimmerBox(h: 12)),
          const SizedBox(width: 10),
          Expanded(
            flex: 3,
            child: shimmerBox(h: 12),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: shimmerBox(h: 12),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 3,
            child: shimmerBox(h: 36),
          ),
        ],
      ),
    );
  }

  Widget radioRow() {
    return Row(
      children: [
        shimmerBox(h: 14, w: 120),
        const SizedBox(width: 20),
        shimmerBox(h: 20, w: 20),
        const SizedBox(width: 6),
        shimmerBox(h: 12, w: 30),
        const SizedBox(width: 20),
        shimmerBox(h: 20, w: 20),
        const SizedBox(width: 6),
        shimmerBox(h: 12, w: 30),
      ],
    );
  }

  Widget button(double width) {
    return shimmerBox(h: 42, w: width);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          /// Table Header
          Row(
            children: [
              SizedBox(width: 30, child: shimmerBox()),
              const SizedBox(width: 10),
              Expanded(flex: 3, child: shimmerBox()),
              const SizedBox(width: 10),
              Expanded(child: shimmerBox()),
              const SizedBox(width: 10),
              Expanded(flex: 3, child: shimmerBox()),
            ],
          ),

          const SizedBox(height: 10),

          /// Table Rows
          Column(
            children: List.generate(9, (index) => tableRow()),
          ),

          const SizedBox(height: 12),

          /// Radio Section
          radioRow(),
          const SizedBox(height: 12),
          radioRow(),
          const SizedBox(height: 12),

          /// Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              button(90),
              button(90),
              button(90),
            ],
          ),
        ],
      ),
    );
  }
}

class MachineCounterShimmer extends StatelessWidget {
  const MachineCounterShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      itemCount: 11,
      itemBuilder: (context, index) {
        return _patientCardShimmer();
      },
    );
  }

  Widget _patientCardShimmer() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Shimmer.fromColors(
          baseColor: Colors.white,
          highlightColor: Colors.grey.shade400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Row with Patient Id + Icons
              Row(
                children: [
                  Container(
                    height: 12.h,
                    width: 120.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  Spacer(),
                  _icon(),
                ],
              ),

              SizedBox(height: 12.h),

              _textLine(180.w),
              SizedBox(height: 12.h),
              _textLine(180.w),
              SizedBox(height: 12.h),
              _textLine(180.w),
              SizedBox(height: 12.h),
              _textLine(180.w),
              SizedBox(height: 12.h),
              _textLine(180.w),
              SizedBox(height: 12.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _icon() {
    return Container(
      height: 18.h,
      width: 18.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }

  Widget _textLine(double width) {
    return Container(
      height: 12.h,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }
}

class AddMachineCounterShimmer extends StatelessWidget {
  const AddMachineCounterShimmer({super.key});

  Widget shimmerBox({double h = 14, double w = double.infinity, double r = 6}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: h,
        width: w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(r),
        ),
      ),
    );
  }

  Widget machineCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Machine Name
          shimmerBox(w: 220),

          const SizedBox(height: 8),

          /// Serial Number
          shimmerBox(w: 260),

          const SizedBox(height: 12),

          /// Current Reading Label
          shimmerBox(w: 180),

          const SizedBox(height: 8),

          /// Input Field
          shimmerBox(h: 44),

          const SizedBox(height: 12),

          /// Last Reading Label
          shimmerBox(w: 200),

          const SizedBox(height: 8),

          /// Input Field
          shimmerBox(h: 44),
        ],
      ),
    );
  }

  Widget numberCircle() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: 26,
        width: 26,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          /// Machine Cards
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    numberCircle(),
                    const SizedBox(height: 8),
                    machineCard(),
                  ],
                );
              },
            ),
          ),

          /// Save Button
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: 46,
              width: 140,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class PatientHealthTrendsShimmer extends StatelessWidget {
  const PatientHealthTrendsShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(10),
      child: Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.grey.shade400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              height: 10,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 6),
            Container(
              height: 10,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PatientDialysisInvestShimmer extends StatelessWidget {
  const PatientDialysisInvestShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Container(
          height: 210,
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: const Color(0xffF8F8F8),
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(0, 0.5),
              ),
            ],
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 6, top: 12, bottom: 12, right: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                          6,
                          (index) => Row(
                                children: [
                                  Container(
                                    height: 14,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Container(
                                      height: 14,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                    ),
                  ),
                ),
                Container(
                  width: 70,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(6),
                      bottomRight: Radius.circular(6),
                    ),
                  ),
                  child: Center(
                    child: Container(
                      width: 26,
                      height: 26,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class PatientDialysisInvestDetailsShimmer extends StatelessWidget {
  const PatientDialysisInvestDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Patient Detail Card Shimmer
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Colors.grey.shade400,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(height: 14, width: 120, color: Colors.white),
                        const Spacer(),
                        Container(
                          width: 24,
                          height: 24,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const SizedBox(width: 57),
                        Container(height: 14, width: 180, color: Colors.white),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const SizedBox(width: 57),
                        Container(height: 14, width: 220, color: Colors.white),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const SizedBox(width: 57),
                        Container(height: 14, width: 80, color: Colors.white),
                        const SizedBox(width: 40),
                        Container(height: 14, width: 60, color: Colors.white),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Date Selection Card Shimmer
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Colors.grey.shade400,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  height: 12, width: 80, color: Colors.white),
                              const SizedBox(height: 8),
                              Container(
                                height: 45,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  height: 12, width: 80, color: Colors.white),
                              const SizedBox(height: 8),
                              Container(
                                height: 45,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Vital Parameters Header
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 12),
            child: Shimmer.fromColors(
              baseColor: Colors.white,
              highlightColor: Colors.grey.shade400,
              child: Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                      height: 16, width: 120, color: Colors.grey.shade300),
                ],
              ),
            ),
          ),

          // Vital Parameter List Items
          ...List.generate(
              5,
              (index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 18, horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      height: 14,
                                      width: 140,
                                      color: Colors.white),
                                  const SizedBox(height: 8),
                                  Container(
                                      height: 10,
                                      width: 100,
                                      color: Colors.white),
                                ],
                              ),
                            ),
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              width: 16,
                              height: 16,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
        ],
      ),
    );
  }
}

class HemoglobinTrackingReportShimmer extends StatelessWidget {
  const HemoglobinTrackingReportShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      itemCount: 5,
      itemBuilder: (context, index) {
        return _patientCardShimmer();
      },
    );
  }

  Widget _patientCardShimmer() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Shimmer.fromColors(
          baseColor: Colors.white,
          highlightColor: Colors.grey.shade400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Row with Patient Id + Icons
              Row(
                children: [
                  Container(
                    height: 12.h,
                    width: 120.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  Spacer(),
                  _icon(),
                ],
              ),

              SizedBox(height: 12.h),

              _textLine(180.w),
              SizedBox(height: 10.h),

              _textLine(120.w),
              SizedBox(height: 10.h),

              _textLine(220.w),
              SizedBox(height: 10.h),

              _textLine(160.w),
              SizedBox(height: 10.h),

              _textLine(150.w),
            ],
          ),
        ),
      ),
    );
  }

  Widget _icon() {
    return Container(
      height: 18.h,
      width: 18.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }

  Widget _textLine(double width) {
    return Container(
      height: 12.h,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }
}

class RegistrationShimmer extends StatelessWidget {
  const RegistrationShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 150,
            height: 130,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Shimmer.fromColors(
              baseColor: Colors.white,
              highlightColor: Colors.grey.shade400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle)),
                  const SizedBox(height: 12),
                  Container(
                      height: 16,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4))),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 150,
            height: 130,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Shimmer.fromColors(
              baseColor: Colors.white,
              highlightColor: Colors.grey.shade400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle)),
                  const SizedBox(height: 12),
                  Container(
                      height: 16,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VisitorEntryShimmer extends StatelessWidget {
  const VisitorEntryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 8.h),
          Center(
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: 35.w,
                  height: 35.h,
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                ),
              ),
              SizedBox(width: 6.w),
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: 35.w,
                  height: 35.h,
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10)),
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Column(
                  children: [
                    SizedBox(height: 8.h),
                    _shimmerField(),
                    SizedBox(height: 8.h),
                    _shimmerField(),
                    SizedBox(height: 8.h),
                    _shimmerField(),
                    SizedBox(height: 8.h),
                    _shimmerField(),
                    SizedBox(height: 8.h),
                    _shimmerField(),
                    SizedBox(height: 8.h),
                    _shimmerField(),
                    SizedBox(height: 16.h),
                    _shimmerCheckboxRow(),
                    SizedBox(height: 8.h),
                    _shimmerCheckboxRow(),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 40.h,
                          width: 140.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Container(
                          height: 40.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _shimmerField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 14.h,
          width: 100.w,
          color: Colors.white,
        ),
        SizedBox(height: 6.h),
        Container(
          height: 45.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ],
    );
  }

  Widget _shimmerCheckboxRow() {
    return Row(
      children: [
        Container(
          height: 20.h,
          width: 20.w,
          decoration:
              const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        ),
        SizedBox(width: 8.w),
        Container(
          height: 14.h,
          width: 150.w,
          color: Colors.white,
        ),
      ],
    );
  }
}

class BookBedShimmer extends StatelessWidget {
  const BookBedShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          Row(
            children: [
              _shimmerLegend(),
              _shimmerLegend(),
              _shimmerLegend(),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              _shimmerLegend(),
              _shimmerLegend(),
            ],
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                childAspectRatio: 5 / 6,
              ),
              itemCount: 15, // Number of shimmer bed items
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            height: 60.h,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            height: 12.h,
                            margin: EdgeInsets.symmetric(horizontal: 10.w),
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            height: 10.h,
                            margin: EdgeInsets.symmetric(horizontal: 20.w),
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _shimmerLegend() {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.w, right: 8.w),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: 12.w,
              height: 12.h,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: 12.h,
            width: 50.w,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class AddSchedularShimmer extends StatelessWidget {
  const AddSchedularShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.darkBlue.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.white54,
                          highlightColor: Colors.white,
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Shimmer.fromColors(
                          baseColor: Colors.white54,
                          highlightColor: Colors.white,
                          child: Container(
                            width: 120.w,
                            height: 16.sp,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        Shimmer.fromColors(
                          baseColor: Colors.white54,
                          highlightColor: Colors.white,
                          child: const Icon(Icons.arrow_drop_down,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h),
                        _shimmerDropdownField(),
                        SizedBox(height: 14.h),
                        _shimmerDropdownField(),
                        SizedBox(height: 14.h),
                        _shimmerDropdownField(),
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                width: 100.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(width: 14.w),
                            Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                width: 100.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _shimmerDropdownField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            width: 80.w,
            height: 14.sp,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4.h),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: 45.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(color: Colors.grey.shade300),
            ),
          ),
        ),
      ],
    );
  }
}

class EditPreDialysisDetailsShimmer extends StatelessWidget {
  const EditPreDialysisDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          children: [
            // Patient details card
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color:Colors.grey.shade300, // light greenish background for this card based on the screenshot
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.white,
                    highlightColor: Colors.grey.shade400,
                    child: Container(
                      width: 60.w,
                      height: 60.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.white,
                          highlightColor: Colors.grey.shade400,
                          child: Container(
                              height: 14.h, width: 100.w, color: Colors.white),
                        ),
                        SizedBox(height: 8.h),
                        Shimmer.fromColors(
                          baseColor: Colors.white,
                          highlightColor: Colors.grey.shade400,
                          child: Container(
                              height: 14.h, width: 180.w, color: Colors.white),
                        ),
                        SizedBox(height: 8.h),
                        Shimmer.fromColors(
                          baseColor: Colors.white,
                          highlightColor: Colors.grey.shade400,
                          child: Container(
                              height: 14.h, width: 140.w, color: Colors.white),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            Shimmer.fromColors(
                              baseColor: Colors.white,
                              highlightColor: Colors.grey.shade400,
                              child: Container(
                                  height: 14.h,
                                  width: 80.w,
                                  color: Colors.white),
                            ),
                            SizedBox(width: 20.w),
                            Shimmer.fromColors(
                              baseColor: Colors.white,
                              highlightColor: Colors.grey.shade400,
                              child: Container(
                                  height: 14.h,
                                  width: 50.w,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.white,
                    highlightColor: Colors.grey.shade400,
                    child: Container(
                        height: 20.w,
                        width: 20.w,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),

            // Pre Dialysis Details Tile
            _shimmerTile(),
            SizedBox(height: 12.h),

            // Pre Dialysis Vitals Tile
            _shimmerTile(),
            SizedBox(height: 12.h),

            // Start Dialysis Card
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                        height: 16.h, width: 120.w, color: Colors.white),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Expanded(child: _shimmerField()),
                      SizedBox(width: 16.w),
                      Expanded(child: _shimmerField()),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade400,
                      child: Container(
                        height: 40.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.h),

            // 3 Bottom Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _shimmerButton(),
                _shimmerButton(),
                _shimmerButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _shimmerTile() {
    return Container(
      height: 55.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.grey.shade400,
        child: Row(
          children: [
            Container(height: 20.w, width: 20.w, color: Colors.white),
            SizedBox(width: 12.w),
            Container(height: 14.h, width: 120.w, color: Colors.white),
            const Spacer(),
            const Icon(Icons.keyboard_arrow_down, color: Colors.white),
          ],
        ),
      ),
    );
  }

  Widget _shimmerField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(width: 60.w, height: 12.h, color: Colors.white),
        ),
        SizedBox(height: 8.h),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: 45.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: Colors.grey.shade300),
            ),
          ),
        ),
      ],
    );
  }

  Widget _shimmerButton() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor:Colors.grey.shade400,
      child: Container(
        height: 40.h,
        width: 100.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }
}

class AdminDashboardShimmer extends StatelessWidget {
  final int totalCards;
  const AdminDashboardShimmer({Key? key, required this.totalCards}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> rows = [];
    for (int i = 0; i < totalCards; i += 2) {
      if (i + 1 < totalCards) {
        rows.add(
          Row(
            children: [
              Expanded(child: _shimmerDashCard()),
              Expanded(child: _shimmerDashCard()),
            ],
          ),
        );
      } else {
        rows.add(_shimmerDashCard());
      }
    }
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: rows,
      ).paddingOnly(left: 4.w, right: 4.w),
    );
  }

  Widget _shimmerDashCard() {
    return Card(
      elevation: 3,
      shadowColor: Colors.black26,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Container(
        height: 80.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  height: 30.h,
                  width: 30.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Container(height: 20.h, width: 40.w, color: Colors.white),
              SizedBox(height: 10.h),
              Container(height: 14.h, width: double.infinity, color: Colors.white),
              SizedBox(height: 4.h),
              Container(height: 14.h, width: 80.w, color: Colors.white),
            ],
          ).paddingSymmetric(vertical: 8.h, horizontal: 8.w),
        ),
      ),
    );
  }
}

class MISDashboardShimmer extends StatelessWidget {
  const MISDashboardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AdminDashboardShimmer(totalCards: 4);
  }
}

class SuperAdminDashboardShimmer extends StatelessWidget {
  const SuperAdminDashboardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AdminDashboardShimmer(totalCards: 5);
  }
}

class OperationalHeadDashboardShimmer extends StatelessWidget {
  const OperationalHeadDashboardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AdminDashboardShimmer(totalCards: 5);
  }
}

class NephroSecondLevelShimmer extends StatelessWidget {
  const NephroSecondLevelShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(children: [Expanded(child: _shimmerDashCard()), Expanded(child: _shimmerDashCard())]),
          Row(children: [Expanded(child: _shimmerDashCard()), Expanded(child: _shimmerDashCard())]),
          Row(children: [Expanded(child: _shimmerDashCard()), Expanded(child: _shimmerDashCard())]),
          Row(children: [Expanded(child: _shimmerDashCard()), Expanded(child: _shimmerDashCard())]),
          Row(children: [Expanded(child: _shimmerDashCard()), Expanded(child: _shimmerDashCard())]),
          
          // Tabs
          Padding(
            padding: EdgeInsets.only(top: 8.h, left: 8.w, bottom: 0, right: 8.w),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Row(
                children: [
                   Container(width: 130.w, height: 40.h, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16))),
                   SizedBox(width: 8.w),
                   Container(width: 130.w, height: 40.h, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16))),
                ],
              ),
            ),
          ),
          // Chart
          Padding(
            padding:  EdgeInsets.only(top: 8.h, left: 8.w, bottom: 8.h, right: 8.w),
            child: _shimmerChart(),
          ),
          
          // Ongoing Dialysis Text
          Padding(
            padding: EdgeInsets.only(top: 8.h, left: 8.w, bottom: 8.h, right: 8.w),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(width: 200.w, height: 20.h, color: Colors.white),
            )
          ),
          // Carousel
          Padding(
            padding: EdgeInsets.only(top: 8.h, left: 8.w, bottom: 8.h, right: 8.w),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(height: 150.h, width: double.infinity, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12))),
            )
          )
        ],
      ).paddingOnly(left: 4.w, right: 4.w),
    );
  }

  Widget _shimmerDashCard() {
    return Card(
      elevation: 3,
      shadowColor: Colors.black26,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Container(
        height: 80.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  height: 30.h,
                  width: 30.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Container(height: 20.h, width: 40.w, color: Colors.white),
              SizedBox(height: 10.h),
              Container(height: 14.h, width: double.infinity, color: Colors.white),
              SizedBox(height: 4.h),
              Container(height: 14.h, width: 80.w, color: Colors.white),
            ],
          ).paddingSymmetric(vertical: 8.h, horizontal: 8.w),
        ),
      ),
    );
  }

  Widget _shimmerChart() {
    return Container(
      height: 340.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: 340.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          )
        )
      )
    );
  }
}

class ClusterDashboardShimmer extends StatelessWidget {
  const ClusterDashboardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _shimmerNewDashCard(),
          _shimmerNewDashCard(),
          _shimmerNewDashCard(),
          _shimmerNewDashCard(),
          _shimmerNewDashCard(),
          Row(children: [Expanded(child: _shimmerDashCardCol()), Expanded(child: _shimmerDashCardCol())]),
          _shimmerNewDashCard(),
          _shimmerNewDashCard(),
          Row(children: [Expanded(child: _shimmerDashCardCol()), Expanded(child: _shimmerDashCardCol())]),
          
          // Tabs
          Padding(
            padding: EdgeInsets.only(top: 8.h, left: 8.w, bottom: 0, right: 8.w),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Row(
                children: [
                   Container(width: 130.w, height: 40.h, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16))),
                   SizedBox(width: 8.w),
                   Container(width: 130.w, height: 40.h, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16))),
                ],
              ),
            ),
          ),
          // Chart
          Padding(
            padding:  EdgeInsets.only(top: 8.h, left: 8.w, bottom: 8.h, right: 8.w),
            child: _shimmerChart(),
          ),
          
          // Radial chart
          Padding(
            padding: EdgeInsets.only(top: 8.h, left: 8.w, bottom: 8.h, right: 8.w),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(height: 300.h, width: double.infinity, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12))),
            )
          )
        ],
      ).paddingOnly(left: 4.w, right: 4.w),
    );
  }

  Widget _shimmerNewDashCard() {
    return Card(
      elevation: 3,
      shadowColor: Colors.black26,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Container(
        height: 140.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  height: 30.h,
                  width: 30.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Container(height: 20.h, width: 40.w, color: Colors.white),
              SizedBox(height: 10.h),
              Container(height: 14.h, width: double.infinity, color: Colors.white),
              SizedBox(height: 4.h),
              Container(height: 14.h, width: 80.w, color: Colors.white),
            ],
          ).paddingSymmetric(vertical: 8.h, horizontal: 8.w),
        ),
      ),
    );
  }

  Widget _shimmerDashCardCol() {
    return Card(
      elevation: 3,
      shadowColor: Colors.black26,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Container(
        height: 210.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 40.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r), // Circle
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Align(
                alignment: Alignment.center,
                child: Container(height: 24.h, width: 60.w, color: Colors.white),
              ),
              SizedBox(height: 10.h),
              Container(height: 14.h, width: double.infinity, color: Colors.white),
              SizedBox(height: 4.h),
              Container(height: 14.h, width: 80.w, color: Colors.white),
            ],
          ).paddingSymmetric(vertical: 8.h, horizontal: 8.w),
        ),
      ),
    );
  }

  Widget _shimmerChart() {
    return Container(
      height: 340.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: 340.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          )
        )
      )
    );
  }
}

class ClusterDivisionDashShimmer extends StatelessWidget {
  const ClusterDivisionDashShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ClusterDashboardShimmer();
  }
}

class ClusterDistrictWiseDashShimmer extends StatelessWidget {
  const ClusterDistrictWiseDashShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ClusterDashboardShimmer();
  }
}

class AddRoDesinfectionDetailsShimmer extends StatelessWidget {
  const AddRoDesinfectionDetailsShimmer({Key? key}) : super(key: key);

  Widget shimmerBox({double h = 14, double w = double.infinity, double radius = 8}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: h,
        width: w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }

  Widget _buildFieldShimmer() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          shimmerBox(h: 14.h, w: 120.w),
          SizedBox(height: 8.h),
          shimmerBox(h: 50.h, w: double.infinity, radius: 10.r),
        ],
      ),
    );
  }

  Widget _buildMultiLineFieldShimmer() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           shimmerBox(h: 14.h, w: 100.w),
           SizedBox(height: 8.h),
           shimmerBox(h: 90.h, w: double.infinity, radius: 10.r),
        ],
      ),
    );
  }

  Widget _buildImageUploadShimmer() {
    return Padding(
       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
       child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            shimmerBox(h: 16.h, w: 100.w),
            SizedBox(height: 8.h),
            Container(
               padding: EdgeInsets.all(12.w),
               decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(0, 0.5),
                    )
                  ]
               ),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                    shimmerBox(h: 14.h, w: 90.w),
                    SizedBox(height: 8.h),
                    shimmerBox(h: 45.h, w: double.infinity, radius: 8.r),
                    SizedBox(height: 12.h),
                    shimmerBox(h: 55.h, w: double.infinity, radius: 8.r),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                         shimmerBox(h: 24.h, w: 24.h, radius: 12.r),
                         SizedBox(width: 8.w),
                         shimmerBox(h: 24.h, w: 24.h, radius: 12.r),
                      ],
                    )
                 ],
               )
            )
          ],
       )
    );
  }
  
  Widget _buildButtonsShimmer() {
     return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
           children: [
              shimmerBox(h: 40.h, w: 100.w, radius: 25.r),
              shimmerBox(h: 40.h, w: 100.w, radius: 25.r),
              shimmerBox(h: 40.h, w: 100.w, radius: 25.r),
           ]
        )
     );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),
          _buildFieldShimmer(),
          _buildFieldShimmer(),
          _buildFieldShimmer(),
          _buildFieldShimmer(),
          _buildFieldShimmer(),
          _buildMultiLineFieldShimmer(),
          _buildFieldShimmer(),
          _buildImageUploadShimmer(),
          _buildButtonsShimmer(),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}
