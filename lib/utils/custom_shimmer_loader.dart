import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../widgets/custom_shimmer_loader.dart';

class CustomShimmerLoader{

  // Generic method for ListView shimmer loader
  static Widget listViewShimmer({
    required int itemCount,
    required Widget shimmerItem,
    EdgeInsets padding = const EdgeInsets.all(8.0),
  }) {
    return ListView.builder(
      itemCount: itemCount,
      padding: padding,
      itemBuilder: (_, __) => shimmerItem,
    );
  }

  // GridView shimmer loader
  static Widget gridViewShimmer({
    required int itemCount,
    required Widget shimmerItem,
    int crossAxisCount = 2,
    double childAspectRatio = 1.0,
    EdgeInsets padding = const EdgeInsets.all(8.0),
  }) {
    return GridView.builder(
      padding: padding,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      itemCount: itemCount,
      itemBuilder: (_, __) => shimmerItem,
    );
  }

  // Container shimmer loader
  static Widget containerShimmer({
    required double height,
    required double width,
    EdgeInsets margin = EdgeInsets.zero,
    BorderRadius borderRadius = BorderRadius.zero,
  }) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: borderRadius,
      ),
    );
  }

  // Custom card shimmer for NeproCard
  static Widget neproCardShimmerLoader({int itemCount = 6}) {
    return listViewShimmer(
      itemCount: itemCount,
      shimmerItem: const NeproCardShimmer(),
    );
  }

  // Form field shimmer
  static Widget formFieldShimmer({
    int count = 3,
    double height = 50,
    double spacing = 16,
  }) {
    return Column(
      children: List.generate(
        count,
            (index) => Padding(
          padding: EdgeInsets.only(bottom: spacing),
          child: Container(
            height: height,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}


// Add this dependency to your pubspec.yaml:
// shimmer: ^3.0.0

class DialysisPatientListShimmer extends StatelessWidget {
  const DialysisPatientListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      period: const Duration(milliseconds: 1500),
      direction: ShimmerDirection.ltr,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5, // Show 5 shimmer items while loading
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row with Patient ID and Name
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Patient ID
                    Container(
                      width: 100,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    // More icon placeholder
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Patient Name
                Container(
                  width: 180,
                  height: 18,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 16),

                // Details Grid
                Row(
                  children: [
                    // Left column
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDetailItem('Mobile No:', 120),
                          const SizedBox(height: 12),
                          _buildDetailItem('Age:', 50),
                          const SizedBox(height: 12),
                          _buildDetailItem('Slot:', 140),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Right column
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDetailItem('Mobile:', 100),
                          const SizedBox(height: 12),
                          _buildDetailItem('Gender:', 70),
                          const SizedBox(height: 12),
                          _buildDetailItem('Appointment:', 130),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Appointment Date
                Container(
                  width: 150,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),

                const SizedBox(height: 12),

                // Slot Time
                Container(
                  width: 120,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailItem(String label, double width) {
    return Row(
      children: [
        // Label
        Container(
          width: width * 0.4,
          height: 14,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        // Value
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
    );
  }
}

// Alternative simpler shimmer design
class SimplePatientListShimmer extends StatelessWidget {
  const SimplePatientListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Patient ID and Name row
                  Row(
                    children: [
                      _buildShimmerBox(width: 80, height: 20),
                      const SizedBox(width: 12),
                      _buildShimmerBox(width: 150, height: 20),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Mobile row
                  Row(
                    children: [
                      _buildShimmerBox(width: 60, height: 16),
                      const SizedBox(width: 12),
                      _buildShimmerBox(width: 100, height: 16),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Age and Gender row
                  Row(
                    children: [
                      _buildShimmerBox(width: 40, height: 16),
                      const SizedBox(width: 12),
                      _buildShimmerBox(width: 60, height: 16),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Slot and Appointment row
                  Row(
                    children: [
                      _buildShimmerBox(width: 50, height: 16),
                      const SizedBox(width: 12),
                      _buildShimmerBox(width: 120, height: 16),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Appointment Date
                  _buildShimmerBox(width: 150, height: 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildShimmerBox({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

// How to use in your app:

class PatientListPage extends StatefulWidget {
  const PatientListPage({super.key});

  @override
  State<PatientListPage> createState() => _PatientListPageState();
}

class _PatientListPageState extends State<PatientListPage> {
  bool _isLoading = true;
  List<Patient> _patients = [];

  @override
  void initState() {
    super.initState();
    _loadPatients();
  }

  Future<void> _loadPatients() async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
      _patients = [
        Patient(
          id: '2211',
          name: 'MIRABAI BALIRAM RATHOD',
          mobile: '9657478711',
          age: 50,
          gender: 'Female',
          slot: '12:30 - 16:30',
          appointmentDate: '12 March 2026',
        ),
        Patient(
          id: '1867',
          name: 'DIPAK PRAKASH SONWANE',
          mobile: '9529664254',
          age: 16,
          gender: 'Male',
          slot: '12:30 - 16:30',
          appointmentDate: '12 March 2026',
        ),
        // Add more patients
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dialysis Patient List'),
      ),
      body: _isLoading
          ? const DialysisPatientListShimmer()
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _patients.length,
        itemBuilder: (context, index) {
          final patient = _patients[index];
          return PatientCard(patient: patient);
        },
      ),
    );
  }
}

class Patient {
  final String id;
  final String name;
  final String mobile;
  final int age;
  final String gender;
  final String slot;
  final String appointmentDate;

  Patient({
    required this.id,
    required this.name,
    required this.mobile,
    required this.age,
    required this.gender,
    required this.slot,
    required this.appointmentDate,
  });
}

class PatientCard extends StatelessWidget {
  final Patient patient;

  const PatientCard({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Patient ID: ${patient.id}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Icon(Icons.more_vert),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              patient.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Mobile No: ${patient.mobile}'),
                      const SizedBox(height: 4),
                      Text('Age: ${patient.age}'),
                      const SizedBox(height: 4),
                      Text('Slot: ${patient.slot}'),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Gender: ${patient.gender}'),
                      const SizedBox(height: 4),
                      Text('Appointment Date: ${patient.appointmentDate}'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class DashboardShimmer extends StatelessWidget {
  const DashboardShimmer({super.key});

  Widget shimmerBox({double height = 20, double width = double.infinity}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget dashboardCardShimmer() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            shimmerBox(height: 20, width: 120),
            const SizedBox(height: 10),
            shimmerBox(height: 40),
            const SizedBox(height: 8),
            shimmerBox(height: 12, width: 80),
          ],
        ),
      ),
    );
  }

  Widget ongoingSessionShimmer() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          shimmerBox(height: 16, width: 200),
          const SizedBox(height: 10),
          shimmerBox(height: 14, width: 150),
          const SizedBox(height: 10),
          shimmerBox(height: 14, width: 180),
          const SizedBox(height: 10),
          shimmerBox(height: 14, width: 140),
        ],
      ),
    );
  }

  Widget chartShimmer() {
    return Container(
      height: 250,
      alignment: Alignment.center,
      child: Container(
        height: 180,
        width: 180,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [

          /// Dashboard Cards Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.3,
            ),
            itemBuilder: (context, index) {
              return dashboardCardShimmer();
            },
          ),

          const SizedBox(height: 20),

          /// Chart shimmer
          chartShimmer(),

          const SizedBox(height: 20),

          /// Ongoing session shimmer
          ongoingSessionShimmer(),
        ],
      ),
    );
  }
}



class DialysisQueueShimmer extends StatelessWidget {
  const DialysisQueueShimmer({super.key});

  Widget shimmerBox({double h = 12, double w = double.infinity}) {
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

  Widget tabShimmer() {
    return Row(
      children: [
        Expanded(child: shimmerBox(h: 40)),
        const SizedBox(width: 6),
        Expanded(child: shimmerBox(h: 40)),
        const SizedBox(width: 6),
        Expanded(child: shimmerBox(h: 40)),
        const SizedBox(width: 6),
        Expanded(child: shimmerBox(h: 40)),
      ],
    );
  }

  Widget timelineDot() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: 18,
        width: 18,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget historyCard() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade300,
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.grey.shade300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            shimmerBox(h: 35, w: 180),
            const SizedBox(height: 10),
            shimmerBox(h: 35, w: 200),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: shimmerBox(w: 120),
            )
          ],
        ),
      ),
    );
  }

  Widget timelineSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            timelineDot(),
            Container(width: 2, height: 160, color: Colors.white),
            timelineDot(),
            Container(width: 2, height: 160, color: Colors.white),
            timelineDot(),
          ],
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            children: [
              historyCard(),
              historyCard(),
              historyCard(),
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        children: [
          const SizedBox(height: 10),

          /// Tab bar shimmer
          tabShimmer(),

          const SizedBox(height: 20),

          /// Timeline shimmer
          Expanded(
            child: SingleChildScrollView(
              child: timelineSection(),
            ),
          )
        ],
      ),
    );
  }
}