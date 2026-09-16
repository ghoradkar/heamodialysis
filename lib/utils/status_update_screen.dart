import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';

class CommonStatusScreen extends StatelessWidget {
  final String title;
  final String img;
  final String description;

  // Primary Button
  final String buttonText;
  final VoidCallback onPressed;
  final List<Color>? primaryGradient;
  final Color? primaryTextColor;

  // Secondary Button (Optional)
  final String? secondButtonText;
  final VoidCallback? secondOnPressed;
  final List<Color>? secondaryGradient;
  final Color? secondaryTextColor;

  const CommonStatusScreen({
    super.key,
    required this.title,
    required this.description,
    required this.img,
    required this.buttonText,
    required this.onPressed,
    this.primaryGradient,
    this.primaryTextColor = Colors.white,
    this.secondButtonText,
    this.secondOnPressed,
    this.secondaryGradient,
    this.secondaryTextColor = Colors.white,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),

            Center(
              child: Image.asset(
                img,
                height: 300,
                width: 300,
              ),
            ),

            // SizedBox(height: 50,),
            // ⚪ White Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                        fontFamily: "Inter", // font-family: Inter
                        fontSize: 24, // font-size: 24px
                        fontWeight: FontWeight.w700, // font-weight: 700 (Bold)
                        fontStyle: FontStyle
                            .normal, // font-style: normal (Bold is set by weight)
                        height: 1.0, // line-height: 100%
                        letterSpacing: 0, // letter-spacing: 0%
                        textBaseline: TextBaseline.alphabetic,
                        color: Color(0xFF333333)),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 50),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: "Inter",
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      height: 1.0,
                      letterSpacing: 0,
                      textBaseline: TextBaseline.alphabetic,
                      color: Color(0xFF666666),
                    ),
                  ),
                  // const SizedBox(height: 50),
                  const SizedBox(height: 60),
                  // 🔹 If 2 buttons → Yes / No layout
                  if (secondButtonText != null && secondOnPressed != null)
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: primaryGradient!.toList()),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ElevatedButton(
                                onPressed: onPressed,
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(150, 50),
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    buttonText,
                                    style: TextStyle(color: primaryTextColor),
                                  ),
                                ), // YES
                              ),
                            ),
                          ),
                          const SizedBox(width: 30),
                          Expanded(
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xFF27A9E3), // start color
                                    Color(0xFF07B259), // end color
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ElevatedButton(
                                onPressed: secondOnPressed,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.transparent, // make transparent
                                  shadowColor: Colors.transparent,
                                  fixedSize: Size(150, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    secondButtonText!,
                                    style: TextStyle(color: secondaryTextColor),
                                  ),
                                ), // NO
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  // 🔹 If 1 button
                  // 🔹 If 1 button
                  if (secondButtonText == null)
                    Container(
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xFF27A9E3), // start color
                            Color(0xFF07B259), // end color
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ElevatedButton(
                        onPressed: onPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent, // important!
                          shadowColor:
                              Colors.transparent, // remove default shadow
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 21),
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.arrow_back, color: Colors.white),
                              const SizedBox(width: 8),
                              Text(
                                context.l10n.commonGoBack,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white, // text white
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
