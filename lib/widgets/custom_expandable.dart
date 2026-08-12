import 'package:flutter/material.dart';

class CustomExpandableContainer extends StatefulWidget {
  final String text;
  final String? leading;
  final Widget? child;

  const CustomExpandableContainer(
      {super.key, required this.text, this.child, this.leading});

  @override
  State<CustomExpandableContainer> createState() =>
      _CustomExpandableContainerState();
}

class _CustomExpandableContainerState extends State<CustomExpandableContainer> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header Container
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: isExpanded ? Color(0xFF257BAB) : Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (widget.leading != null) ...[
                  Image.asset(widget.leading!,
                      color: isExpanded ? Colors.white : Color(0xFF07B259),
                      width: 25,
                      height: 25),
                  const SizedBox(width: 10),
                ],

                /// 🔹 Title
                Expanded(
                  child: Text(
                    widget.text,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w600,
                      color: isExpanded ? Colors.white : Colors.black,
                    ),
                  ),
                ),

                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  color: isExpanded ? Colors.white : Colors.green,
                ),
              ],
            ),
          ),
        ),
        // Expanded content
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Container(
            width: double.infinity,
            constraints: const BoxConstraints(
              minHeight: 0,
            ),
            child: widget.child ?? const SizedBox.shrink(),
          ),
          crossFadeState:
              isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 200),
        ),
      ],
    );
  }
}
