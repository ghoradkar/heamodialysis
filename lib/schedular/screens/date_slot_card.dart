import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/schedular/model/add_schedular_request.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';

class DateSlotCard extends StatelessWidget {

  final Function(String)? isSlotSelected;
  final Function selectFromDate;
  final Function addCard;
  final Function removeCard;
  final int? index;
  final String? selectedSlot;
  final List<dynamic>? dropDownList;
  final AddSchedularRequest? cardData;

  const DateSlotCard(
      {super.key,

      this.isSlotSelected,
      required this.selectFromDate,
      required this.addCard,
      required this.removeCard,
      this.index,
      this.selectedSlot,
      this.dropDownList, this.cardData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.symmetric(vertical: 8.h,horizontal: 8.w),
      decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColor.borderColor)),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CustomDateField(
                  key: UniqueKey(),
                  initialValue: cardData?.bedAllocationDate,
                  labelText: 'From Date',
                  hint: 'Select Date',
                  isRequired: false,
                  callB: () {
                    selectFromDate();
                  },
                  // selectedDate: fromDateController,
                  filledColor: Colors.white,
                  dontDhowPrefix: false,
                ),
              ),
              Expanded(
                child: MyCustomDropdown(
                  key: UniqueKey(),
                  isViewProfile: false,
                  selectedItem:selectedSlot,
                  labelText: 'Slot Time',
                  items: dropDownList ?? [],
                  hint: "Select",
                  isRequired: false,
                  senValue: (value) {
                    if(cardData?.bedAllocationDate != ""){
                      if (isSlotSelected != null) {
                        isSlotSelected!(value);
                      }
                    }

                  },
                  filledColor: Colors.white,
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  addCard();
                },
                icon: const Icon(Icons.add_circle_outline),
                color: Colors.green,
              ),
              IconButton(
                onPressed: () {
                  removeCard();
                },
                icon: const Icon(Icons.remove_circle_outline),
                color: AppColor.red,
              )
            ],
          )
        ],
      ),
    ).paddingSymmetric(vertical: 10.h, horizontal: 10.w);
  }
}
