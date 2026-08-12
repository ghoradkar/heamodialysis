import 'package:flutter/material.dart';

void showCustomSnackBar({
  required String title,
  String? img,
  String? buttonTitle,
  String? topTitle,
  String? buttonTitle2,
  VoidCallback? onPress1,
  VoidCallback? onPress2,
  required BuildContext context,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 30),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Close Button
            Row(
              children: [
                // Left empty space (same width as close button)
                const SizedBox(width: 40),

                // Center Title
                Expanded(
                  child: Text(
                    topTitle!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                // Close Button (Right)
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close, color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),


            /// Image (dynamic)
            Container(
              height: 100,
              width: 100,
              decoration: img == null
                  ? BoxDecoration(
                color: Colors.green.shade100, // ✅ only default image
                shape: BoxShape.circle,
              )
                  : null,
              child: Center(
                child: Image.asset(
                  img ?? "assets/images/check.png", // ✅ default image
                  height: 60,
                  width: 60,
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 25),


            /// Buttons (dynamic)
            if (buttonTitle != null || buttonTitle2 != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    /// NO Button (First)
                    if (buttonTitle != null)
                      Expanded(
                        child: ElevatedButton(
                          onPressed: onPress1,
                          style: _buttonStyle(), // blue / safe
                          child: Text(buttonTitle!),
                        ),
                      ),

                    if (buttonTitle != null && buttonTitle2 != null)
                      const SizedBox(width: 12),

                    /// YES Button (Second - DeepPurple)
                    if (buttonTitle2 != null)
                      Expanded(
                        child: ElevatedButton(
                          onPressed: onPress2,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple, // ✅ Yes button
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            // elevation: 3,
                          ),
                          child: Text(buttonTitle2!),
                        ),
                      ),
                  ],
                ),
              ),

          ],
        ),
      ),
    ),
  );
}

/// Common Button Style
ButtonStyle _buttonStyle() {
  return ElevatedButton.styleFrom(
    backgroundColor: Colors.deepPurple.shade50,
    foregroundColor: Colors.deepPurple,
    padding: const EdgeInsets.symmetric(vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    // elevation: 3,
  );
}
