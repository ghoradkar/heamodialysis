import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/new_registration/controller/new_registration_controller.dart';
import 'package:heamodialysis/new_registration/model/blood_group/blood_data.dart';
import 'package:heamodialysis/new_registration/model/dialysis_freq_model.dart';
import 'package:heamodialysis/new_registration/model/dialysis_mode/dialysis_data.dart';
import 'package:heamodialysis/new_registration/model/district/district_data.dart';
import 'package:heamodialysis/new_registration/model/division/division_data.dart';
import 'package:heamodialysis/new_registration/model/id_proof/Id_proof_data.dart';
import 'package:heamodialysis/new_registration/model/marital_status/marital_data.dart';
import 'package:heamodialysis/new_registration/model/refferedBy/referred_by_data.dart';
import 'package:heamodialysis/new_registration/model/relation/relation_data.dart';
import 'package:heamodialysis/new_registration/model/schema_adopted/schema_data.dart';
import 'package:heamodialysis/new_registration/model/state/state_data.dart';
import 'package:heamodialysis/new_registration/model/taluka/taluka_data.dart';
import 'package:heamodialysis/new_registration/model/town/town_data.dart';
import 'package:heamodialysis/new_registration/model/viral_status/viral_data.dart';
import 'package:heamodialysis/new_registration/screens/demographic_info_tab.dart';
import 'package:heamodialysis/new_registration/screens/history_of_dialysis.dart';
import 'package:heamodialysis/new_registration/screens/personal_info_tab.dart';
import 'package:heamodialysis/new_registration/screens/upload_document_tab.dart';
import 'package:heamodialysis/registered_patient_list/model/already_regidtered_patient/patient_data.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:intl/intl.dart';

import '../../widgets/custom_shimmer_loader.dart';

class NewRegistration extends StatefulWidget {
  final bool isViewPatient;
  final bool isEdit;
  final PatientData? patientData;
  final String pageTitle;

  const NewRegistration(
      {super.key,
      required this.isViewPatient,
      this.patientData,
      required this.pageTitle,
      required this.isEdit});

  @override
  State<NewRegistration> createState() => _NewRegistrationState();
}

class _NewRegistrationState extends State<NewRegistration>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final NewRegistrationController newRegistrationController =
      Get.put(NewRegistrationController());
  bool hasInternet = true;

  var userData;

  // final mediaStorePlugin = MediaStore();
  // int? _platformSDKVersion;

  @override
  void initState() {
    // initPermission();
    // initPlatformState();
    newRegistrationController.patientProfilePhoto = null;
    newRegistrationController.image = null;
    newRegistrationController.abhaNoController.text = "";
    newRegistrationController.firstNameController.text = "";
    newRegistrationController.lastNameController.text = "";
    newRegistrationController.middleNameController.text = "";
    newRegistrationController.mobileController.text = "";
    newRegistrationController.emailController.text = "";
    newRegistrationController.dboController.text = "";
    newRegistrationController.addressController.text = '';
    newRegistrationController.pincodeController.text = "";
    newRegistrationController.refByNameController.text = "";
    newRegistrationController.nephrologyController.text = "";
    newRegistrationController.nephrologyContactNoController.text = "";
    newRegistrationController.relativeNameController.text = "";
    newRegistrationController.identificationNoController.text = "";
    newRegistrationController.heightFeetController.text = "";
    newRegistrationController.weightController.text = "";
    newRegistrationController.reffContactNoController.text = "";
    newRegistrationController.reffContactNoController.text = "";
    newRegistrationController.mjpjayEnrollNoController.text = "";
    newRegistrationController.heightCmController.text = "";
    newRegistrationController.contactNoController.text = "";
    newRegistrationController.prefixVal = null;
    newRegistrationController.selectedGender = null;
    newRegistrationController.selectedMaritalVal = null;
    newRegistrationController.selectedTownVal = null;
    newRegistrationController.selectedPerTown = null;
    newRegistrationController.selectedPerTaluka = null;
    newRegistrationController.selectedTalukaVal = null;
    newRegistrationController.selectedDistVal = null;
    newRegistrationController.selectedPerDist = null;
    newRegistrationController.selectedPerDivision = null;
    newRegistrationController.selectedDivVal = null;
    newRegistrationController.selectedPerDivision = null;
    newRegistrationController.selectedPerState = null;
    newRegistrationController.selectedStateVal = null;
    newRegistrationController.isChecked = false;
    newRegistrationController.selectedSchema = null;
    newRegistrationController.selectedViralStat = null;
    newRegistrationController.selectedDialysisMode = null;
    newRegistrationController.selectedIdProof = null;
    newRegistrationController.selectedPerCountry = null;
    newRegistrationController.selectedNationa = null;
    newRegistrationController.selectedBlood = null;
    newRegistrationController.selectedReferredBy = null;
    newRegistrationController.selectedDiaModeFreq = null;
    newRegistrationController.selectedRelation = null;
    newRegistrationController.perPincodeController.text = '';
    newRegistrationController.perAddressController.text = '';
    newRegistrationController.dialysisDate.text = '';
    newRegistrationController.hospitalName.text = '';
    newRegistrationController.lastDialysisDate.text = '';
    newRegistrationController.selectedOccu = null;
    newRegistrationController.selectedEdu = null;
    newRegistrationController.socEcoStat = '';
    newRegistrationController.selectedReligion = null;
    newRegistrationController.groupVal = CustomRadioButtons.yes;
    newRegistrationController.items.clear();
    newRegistrationController.relativeDoc = FileDetails(
        name: 'Document', key: 'relativeDoc', isSelected: false, isReq: false);

    newRegistrationController.historyOfDialysis = FileDetails(
        name: 'Upload Document',
        key: 'previousHospitalDocument',
        isSelected: false,
        isReq: false);
    checkInternetAndLoadData();

    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      // setState(() {}); // Update the UI when the tab changes
      newRegistrationController.refreshUi();
    });
    super.initState();
  }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
    newRegistrationController.refreshUi();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  checkInternetAndLoadData() async {
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();
    // setState(() {
    hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));
    // });
    newRegistrationController.refreshUi();
    if (hasInternet) {
      await getUserData();
      await newRegistrationController
          .checkScrutinyDefinedOrNot(userData['unitId'].toString());
      await newRegistrationController.getRefferedBy();
      await newRegistrationController.getIdProofList();
      await newRegistrationController.getInstituteList();
      await newRegistrationController.getViralStatueList();
      await newRegistrationController.getDialysisModeList();
      await newRegistrationController.getSchemaAdoptedList();
      await newRegistrationController.getRelationList();
      await newRegistrationController.getDialysisFreq();
      await newRegistrationController.getMaritalStatus();
      await newRegistrationController.getPrefixList();
      await newRegistrationController.getBloodGroupList();
      await newRegistrationController.getMonthlyIncome();

      await newRegistrationController.getDocList(widget.isViewPatient,
          widget.isEdit, widget.patientData?.patientId ?? 0);
      await newRegistrationController.getEduSocOccuReligDropDown();
      if (widget.isViewPatient == true ||
          widget.pageTitle == "Edit Patient Details") {
        await newRegistrationController
            .viewPatientData(widget.patientData?.patientId);
        await newRegistrationController
            .getProfilePhoto(widget.patientData?.patientId);

        await newRegistrationController
            .getRelativeInfoDoc(widget.patientData?.patientId);
        setValuesToProfile();
        setValuesDemographicInfo();
        setValuesHistoryOfDailysis();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:AppColor.primaryBackgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30),  // adjust as needed
          ),
        ),
        title: CustomText(
          text: widget.pageTitle,
          fontSize: 18.0,
          fontFam: 'Lato',
          fontWeight: FontWeight.w400,
          textColor: Colors.white,
          textAlign: TextAlign.start,
        ),
        leading: InkWell(
            onTap: () {
              newRegistrationController.abhaNoController.text = "";
              newRegistrationController.firstNameController.text = "";
              newRegistrationController.lastNameController.text = "";
              newRegistrationController.middleNameController.text = "";
              newRegistrationController.mobileController.text = "";
              newRegistrationController.emailController.text = "";
              newRegistrationController.dboController.text = "";
              newRegistrationController.pincodeController.text = "";
              Get.back();
            },
            child: Image.asset('assets/arrow-left.png',color: Colors.white,)),
      ),
      body: GetBuilder<NewRegistrationController>(
          init: newRegistrationController,
          builder: (controller) {
            return hasInternet
                ? controller.isLoading
                    ?  Center(child: buildShimmerLoader())
                    : Column(
                        children: [
                          TabBar(
                            controller: tabController,
                            dividerColor: Colors.transparent,
                            indicatorColor: Colors.transparent,
                            padding: EdgeInsets.zero,
                            indicatorPadding: EdgeInsets.zero,
                            labelPadding: EdgeInsets.zero,
                            tabs: [
                              buildTab(0, "assets/user_textfield.png",
                                  "Personal\nInfo"),
                              buildTab(1, "assets/line-chart.png",
                                  "Demographic\nInfo"),
                              buildTab(2, "assets/refresh.png",
                                  "History Of\nDialysis"),
                              buildTab(3, "assets/upload_file.png",
                                  "Upload\nDocument"),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: tabController,
                              children: [
                                PersonalInfoScreen(
                                  pageTitle: widget.pageTitle,
                                  isViewPatient: widget.isViewPatient,
                                  viewPatientModel: newRegistrationController
                                      .viewPatientModel,
                                  callB: () {
                                    tabController.index = 1;
                                  },
                                ),
                                DemographicInfo(
                                  pageTitle: widget.pageTitle,
                                  isViewPatient: widget.isViewPatient,
                                  viewPatientModel: newRegistrationController
                                      .viewPatientModel,
                                  callB: () {
                                    tabController.index = 2;
                                  },
                                  idProofListModel: newRegistrationController
                                          .idProofListModel?.data ??
                                      [],
                                  viralStatusList: newRegistrationController
                                          .viralStatusModel?.data ??
                                      [],
                                ),
                                HistoryOfDialysis(
                                  pageTitle: widget.pageTitle,
                                  isViewPatient: widget.isViewPatient,
                                  viewPatientModel: newRegistrationController
                                      .viewPatientModel,
                                  callB: () {
                                    tabController.index = 3;
                                  },
                                ),
                                UploadDocument(
                                    pageTitle: widget.pageTitle,
                                    isViewPatient: widget.isViewPatient,
                                    viewPatientModel: newRegistrationController
                                        .viewPatientModel),
                              ],
                            ),
                          )
                        ],
                      ).paddingSymmetric(horizontal: 6)
                : InternetIssue(
                    onRetryPressed: () {
                      checkInternetAndLoadData();
                    },
                  );
          }),
    );
  }

  void setValuesToProfile() {
    if (newRegistrationController.viewPatientModel != null) {
      newRegistrationController.abhaNoController.text =
          newRegistrationController.viewPatientModel?.data?.abhaNo ?? '';
      newRegistrationController.prefixVal =
          newRegistrationController.viewPatientModel?.data?.prefix;
      newRegistrationController.firstNameController.text =
          newRegistrationController.viewPatientModel?.data?.fName ?? "";
      newRegistrationController.middleNameController.text =
          newRegistrationController.viewPatientModel?.data?.mName ?? "";
      newRegistrationController.lastNameController.text =
          newRegistrationController.viewPatientModel?.data?.lName ?? "";
      newRegistrationController.selectedGender =
          newRegistrationController.viewPatientModel?.data?.gender;
      newRegistrationController.mobileController.text =
          newRegistrationController.viewPatientModel?.data?.mobile ?? "";
      newRegistrationController.emailController.text =
          newRegistrationController.viewPatientModel?.data?.emailId ?? "";

      if (newRegistrationController.viewPatientModel?.data?.occupation !=
              null &&
          newRegistrationController
              .viewPatientModel!.data!.occupation!.isNotEmpty) {
        newRegistrationController.selectedOccu = newRegistrationController
            .commomDropdownList?.occupationList
            .firstWhere((e) =>
                e.lookupDetId ==
                int.parse(newRegistrationController
                    .viewPatientModel!.data!.occupation!))
            .lookupDetDescEn;
      }

      if (newRegistrationController.viewPatientModel?.data?.education != null &&
          newRegistrationController
              .viewPatientModel!.data!.education!.isNotEmpty) {
        newRegistrationController.selectedEdu = newRegistrationController
            .commomDropdownList?.educationList
            .firstWhere((e) =>
                e.lookupDetId ==
                int.parse(newRegistrationController
                    .viewPatientModel!.data!.education!))
            .lookupDetDescEn;
      }

      if (newRegistrationController.viewPatientModel?.data?.religion != null &&
          newRegistrationController
              .viewPatientModel!.data!.religion!.isNotEmpty) {
        newRegistrationController.selectedReligion = newRegistrationController
            .commomDropdownList?.religionList
            .firstWhere((e) =>
                e.lookupDetId ==
                int.parse(newRegistrationController
                    .viewPatientModel!.data!.religion!))
            .lookupDetDescEn;
      }

      // newRegistrationController.selectedEdu =
      //     newRegistrationController.viewPatientModel?.data?.education ?? '';
      newRegistrationController.socEcoStat = newRegistrationController
              .viewPatientModel?.data?.economicStatus ??
          '';

      if (newRegistrationController.viewPatientModel?.data?.monthlyIncome !=
          null) {
        newRegistrationController.selectedMonthlyIncome =
            newRegistrationController.getMonthyIncomeList?.monthlyIncomeList
                    .firstWhere((e) =>
                        e.lookupId ==
                        newRegistrationController
                            .viewPatientModel?.data?.monthlyIncome)
                    .lookupDescEn ??
                '';
      }

      if (newRegistrationController.viewPatientModel?.data?.dob != null &&
          newRegistrationController.viewPatientModel!.data!.dob != '') {
        try {
          var haveSlash = newRegistrationController.viewPatientModel!.data!.dob!
              .contains('-');
          if (haveSlash) {
            newRegistrationController.dboController.text =
                newRegistrationController.viewPatientModel!.data!.dob!
                    .replaceAll("-", '/');

            newRegistrationController.formattedDateDBO =
                newRegistrationController.viewPatientModel!.data!.dob!
                    .replaceAll("-", '/');
          } else {
            // Set the formatted date in the controller
            newRegistrationController.dboController.text =
                newRegistrationController.viewPatientModel!.data!.dob!;

            // Optionally update formattedDateDBO for consistency
            newRegistrationController.formattedDateDBO =
                newRegistrationController.viewPatientModel?.data?.dob;
          }
        } catch (e) {
          debugPrint("Error parsing or formatting DOB: $e");
        }
      } else {
        newRegistrationController.dboController.text = '';
      }

      if (newRegistrationController.viewPatientModel?.data?.dob != null) {
        calculateAge(newRegistrationController.dboController.text);
      }
      newRegistrationController.addressController.text =
          newRegistrationController.viewPatientModel?.data?.address ?? "";
      newRegistrationController.pincodeController.text =
          newRegistrationController.viewPatientModel?.data?.areaCode
                  .toString() ??
              "";

      MaritalData? maritalData =
          newRegistrationController.maritalStatusModel?.data?.firstWhere(
              (e) =>
                  e.lookupDetId ==
                  newRegistrationController
                      .viewPatientModel?.data?.maritalStatusId,
              orElse: () => MaritalData());
      newRegistrationController.selectedMaritalVal =
          maritalData?.lookupDetDescEn;
      newRegistrationController.selectedMarriedObj = maritalData;
      TownData? town = newRegistrationController.townModel?.data?.firstWhere(
          (e) =>
              e.cityId ==
              newRegistrationController.viewPatientModel?.data?.townId,
          orElse: () => TownData());

      if (town?.cityId !=
          newRegistrationController.viewPatientModel?.data?.townId) {
        town = null;
      }
      newRegistrationController.selectedTownVal = town?.cityName;

      TalukaData? taluka = newRegistrationController.talukaModel?.data
          ?.firstWhere(
              (e) =>
                  e.talukaID ==
                  newRegistrationController.viewPatientModel?.data?.talukaId,
              orElse: () => TalukaData());
      if (taluka?.talukaID !=
          newRegistrationController.viewPatientModel?.data?.talukaId) {
        taluka = null;
      }
      newRegistrationController.selectedTalukaVal = taluka?.talukaName;

      DistrictData? district = newRegistrationController.districtModel?.data
          ?.firstWhere(
              (e) =>
                  e.districtID ==
                  newRegistrationController.viewPatientModel?.data?.districtId,
              orElse: () => DistrictData());
      newRegistrationController.selectedDistVal = district?.districtName;

      DivisionData? division = newRegistrationController.divisionModel?.data
          ?.firstWhere(
              (e) =>
                  e.divId ==
                  newRegistrationController.viewPatientModel?.data?.divisionId,
              orElse: () => DivisionData());
      newRegistrationController.selectedDivVal = division?.divName;

      StateData? state = newRegistrationController.stateModel?.data?.firstWhere(
          (e) =>
              e.stateID ==
              newRegistrationController.viewPatientModel?.data?.stateId,
          orElse: () => StateData());
      newRegistrationController.selectedStateVal = state?.stateName;

      newRegistrationController.selectedCountryVal =
          newRegistrationController.selectedCountry[0];

      newRegistrationController.perAddressController.text =
          newRegistrationController.viewPatientModel?.data?.perAddress ?? "";
      newRegistrationController.perPincodeController.text =
          newRegistrationController.viewPatientModel?.data?.perareaCode
                  .toString() ??
              "";

      TownData? perTown = newRegistrationController.townModel?.data?.firstWhere(
          (e) =>
              e.cityId ==
              newRegistrationController.viewPatientModel?.data?.pertownId,
          orElse: () => TownData());
      newRegistrationController.selectedPerTown = perTown?.cityName;

      TalukaData? perTaluka = newRegistrationController.talukaModel?.data
          ?.firstWhere(
              (e) =>
                  e.talukaID ==
                  newRegistrationController.viewPatientModel?.data?.pertalukaId,
              orElse: () => TalukaData());
      newRegistrationController.selectedPerTaluka = perTaluka?.talukaName;

      DistrictData? perDistrict = newRegistrationController.districtModel?.data
          ?.firstWhere(
              (e) =>
                  e.districtID ==
                  newRegistrationController
                      .viewPatientModel?.data?.perdistrictId,
              orElse: () => DistrictData());
      newRegistrationController.selectedPerDist = perDistrict?.districtName;

      DivisionData? perDivision = newRegistrationController.divisionModel?.data
          ?.firstWhere(
              (e) =>
                  e.divId ==
                  newRegistrationController
                      .viewPatientModel?.data?.perDivisionId,
              orElse: () => DivisionData());
      newRegistrationController.selectedPerDivision = perDivision?.divName;

      StateData? perState = newRegistrationController.stateModel?.data
          ?.firstWhere(
              (e) =>
                  e.stateID ==
                  newRegistrationController.viewPatientModel?.data?.perstateId,
              orElse: () => StateData());
      newRegistrationController.selectedPerState = perState?.stateName;

      newRegistrationController.selectedPerCountry =
          newRegistrationController.perSelectedCountry[0];
    }
  }

  void setValuesDemographicInfo() {
    SchemaData? schemAdpt = newRegistrationController.schemaAdoptedModel?.data
        ?.firstWhere(
            (e) =>
                e.lookupDetId ==
                newRegistrationController
                    .viewPatientModel?.data?.lookupDetIdPatientType,
            orElse: () => SchemaData());

    newRegistrationController.selectedSchema = schemAdpt?.lookupDetDescEn;
    newRegistrationController.selectedSchemeObj = schemAdpt;
    DialysisFrequency? diaFreq = newRegistrationController
        .dialysisFreqModel?.dialysisFrequency
        ?.firstWhere(
            (e) =>
                e.lookupDescEn ==
                newRegistrationController
                    .viewPatientModel?.data?.lookupDetIdDialysisFrequencyInWeek
                    ?.toString(), orElse: () {
      // Check if the list is not null and has elements before accessing it
      if (newRegistrationController.dialysisFreqModel?.dialysisFrequency !=
              null &&
          newRegistrationController
              .dialysisFreqModel!.dialysisFrequency!.isNotEmpty) {
        return newRegistrationController.dialysisFreqModel!.dialysisFrequency!
            .firstWhere(
                (e) =>
                    e.lookupId ==
                    newRegistrationController.viewPatientModel!.data!
                        .lookupDetIdDialysisFrequencyInWeek,
                orElse: () =>
                    DialysisFrequency()); // Return a default DialysisFrequency object
      } else {
        return DialysisFrequency(); // Return a default object if the list is empty or null
      }
    });

    newRegistrationController.selectedDiaModeFreq = diaFreq?.lookupDescEn;
    // selectedDiaModeFreq = widget.viewPatientModel?.data?.lookupDetIdDialysisFrequencyInWeek.toString();
    newRegistrationController.selectedProcedureType =
        newRegistrationController.viralStatusModel?.data?.firstWhere(
            (e) =>
                e.lookupDetId ==
                newRegistrationController.viewPatientModel?.data
                    ?.lookupDetIdHaemodialysisProcedureType,
            orElse: () => ViralData());
    newRegistrationController.selectedViralStat =
        newRegistrationController.selectedProcedureType?.lookupDetDescEn;

    newRegistrationController.mjpjayEnrollNoController.text =
        newRegistrationController.viewPatientModel?.data?.mjpjayenrollmentNo ??
            "";

    DialysisModeData? dialysisMode =
        newRegistrationController.dialysisMode?.data?.firstWhere(
            (e) =>
                e.lookupDetId ==
                newRegistrationController
                    .viewPatientModel?.data?.lookupDetIdDialysisMode,
            orElse: () => DialysisModeData());

    newRegistrationController.selectedDialysisMode =
        dialysisMode?.lookupDetDescEn;
    newRegistrationController.selectedDialysisModeObj = dialysisMode;

    IdProofData? idProof = newRegistrationController.idProofListModel?.data
        ?.firstWhere(
            (e) =>
                e.lookupDetId ==
                newRegistrationController
                    .viewPatientModel?.data?.identityProofId,
            orElse: () => IdProofData());

    newRegistrationController.selectedIdProof = idProof?.lookupDetDescEn;
    newRegistrationController.selectedIdProfObj = idProof;
    newRegistrationController.identificationNoController.text =
        newRegistrationController
                .viewPatientModel?.data?.identificationNumber ??
            "";
    newRegistrationController.selectedNationa =
        newRegistrationController.nationality[0];
    BloodData? blood = newRegistrationController.bloodGroupModel?.data
        ?.firstWhere(
            (e) =>
                e.bloodGroupId ==
                newRegistrationController.viewPatientModel?.data?.bloodGroupId,
            orElse: () => BloodData());
    newRegistrationController.selectedBlood = blood?.bloodGrouptName;
    newRegistrationController.selectedBloodObj = blood;
    convertCmHeightToFeet();
    newRegistrationController.heightCmController.text =
        newRegistrationController.viewPatientModel?.data?.pheight.toString() ??
            '';
    newRegistrationController.weightController.text =
        newRegistrationController.viewPatientModel?.data?.pweight.toString() ??
            "";
    ReferredByData? refBy = newRegistrationController.referredByModel?.data
        ?.firstWhere(
            (e) =>
                e.lookupDetValue ==
                newRegistrationController.viewPatientModel?.data?.refByName,
            orElse: () => ReferredByData());
    newRegistrationController.selectedRefBy = refBy?.lookupDetDescEn;

    ReferredByData? referredBy = newRegistrationController.referredByModel?.data
        ?.firstWhere(
            (e) =>
                e.lookupDetId ==
                newRegistrationController
                    .viewPatientModel?.data?.lookupDetIdRefByRef,
            orElse: () => ReferredByData());
    newRegistrationController.selectedReferredBy = referredBy?.lookupDetDescEn;
    newRegistrationController.refByNameController.text =
        newRegistrationController.viewPatientModel?.data?.refByName ?? "";
    newRegistrationController.nephrologyController.text =
        newRegistrationController.viewPatientModel?.data?.nephrologistName ??
            '';
    newRegistrationController.nephrologyContactNoController.text =
        newRegistrationController
                .viewPatientModel?.data?.nephrologistContactNo ??
            '';
    newRegistrationController.relativeNameController.text =
        newRegistrationController.relativedocInfo?.realtiveName ?? "";
    newRegistrationController.reffContactNoController.text =
        newRegistrationController
                .viewPatientModel?.data?.referredContactNumber ??
            "";
    RelationData? relation = newRegistrationController.relationModel?.data
        ?.firstWhere(
            (e) =>
                e.lookupDetId ==
                newRegistrationController.relativedocInfo?.realtionId,
            orElse: () => RelationData());

    newRegistrationController.selectedRelation = relation?.lookupDetDescEn;
    newRegistrationController.selectedRelationObj = relation;
    newRegistrationController.contactNoController.text =
        newRegistrationController.relativedocInfo?.realtiveMobile ?? "";
    // selectedViralStat = widget.viewPatientModel?.data?.procedureType ?? "";
  }

  void calculateAge(String birthDate) {
    DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(birthDate);
    DateTime today = DateTime.now();

    newRegistrationController.years = today.year - parsedDate.year;
    newRegistrationController.months = today.month - parsedDate.month;
    newRegistrationController.days = today.day - parsedDate.day;

    if (newRegistrationController.days < 0) {
      newRegistrationController.months -= 1;
      newRegistrationController.days +=
          DateTime(today.year, today.month, 0).day; // Previous month's days
    }

    if (newRegistrationController.months < 0) {
      newRegistrationController.years -= 1;
      newRegistrationController.months += 12;
    }

    // Parse the date in "dd-MM-yyyy" format
    // DateTime parsedDate = DateFormat('dd-MM-yyyy').parse(birthDate);
    // DateTime today = DateTime.now();
    //
    // newRegistrationController.years = today.year - parsedDate.year;
    // newRegistrationController.months = today.month - parsedDate.month;
    // newRegistrationController.days = today.day - parsedDate.day;
    //
    // if (newRegistrationController.days < 0) {
    //   newRegistrationController.months -= 1;
    //   newRegistrationController.days +=
    //       DateTime(today.year, today.month, 0).day; // Previous month's days
    // }
    //
    // if (newRegistrationController.months < 0) {
    //   newRegistrationController.years -= 1;
    //   newRegistrationController.months += 12;
    // }
  }

  convertCmHeightToFeet() {
    final cmText =
        newRegistrationController.viewPatientModel?.data?.pheight.toString();
    if (cmText != null) {
      final cm = double.tryParse(cmText);

      if (cm != null) {
        final totalInches = cm / 2.54;
        final feet = totalInches ~/ 12;
        final inches = totalInches % 12;

        newRegistrationController.isCmChanging = true;
        newRegistrationController.heightFeetController.text =
            "$feet'${inches.toStringAsFixed(0)}";
        newRegistrationController.isCmChanging = false;
      }
    } else {
      newRegistrationController.heightFeetController.text = '';
    }
  }

  void setValuesHistoryOfDailysis() {
    if (newRegistrationController
                .viewPatientModel?.data?.firstTimeDialysisFlag ==
            null ||
        newRegistrationController
                .viewPatientModel?.data?.firstTimeDialysisFlag ==
            "Y") {
      newRegistrationController.groupVal = CustomRadioButtons.yes;
    } else {
      newRegistrationController.groupVal = CustomRadioButtons.no;
      newRegistrationController.hospitalName.text = newRegistrationController
              .viewPatientModel?.data?.previoushospitalName ??
          "";
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
          newRegistrationController.viewPatientModel?.data?.sstartSessionDate);

      // Format the DateTime to "dd/MM/yy"
      String formattedDate = DateFormat('dd/MM/yy').format(dateTime);
      newRegistrationController.dialysisDate.text = formattedDate;

      DateTime dateTime1 = DateTime.fromMillisecondsSinceEpoch(
          newRegistrationController
              .viewPatientModel?.data?.hospitalsessionDate);

      // Format the DateTime to "dd/MM/yy"
      String formattedDate1 = DateFormat('dd/MM/yy').format(dateTime1);
      newRegistrationController.lastDialysisDate.text = formattedDate1;
    }
  }

  Widget buildTab(int index, String path, String text) {
    bool isSelected = tabController.index == index;
    return Container(
      width: 210,
      // height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 0.8, vertical: 6),
      decoration: BoxDecoration(
          // color: isSelected ? Colors.blue.shade200 : Colors.transparent,
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    AppColor.primaryBackgroundColor,
                    AppColor.secondaryColor
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomCenter,
                )
              : const LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomCenter,
                ),
          borderRadius: setBorderRadiusIndexWise(index),
          border: Border.all(color: const Color(0xffE1E1E1))),
      // padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        children: [
          Image.asset(
            path,
            color: isSelected ? Colors.white : const Color(0xff777777),
          ),
          CustomText(
            text: text,
            fontSize: 12.0,
            fontFam: 'Lato',
            fontWeight: FontWeight.normal,
            textColor: isSelected ? Colors.white : const Color(0xff777777),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  setBorderRadiusIndexWise(index) {
    if (index == 0) {
      return const BorderRadius.only(
          topLeft: Radius.circular(10), bottomLeft: Radius.circular(10));
    } else if (index == 1) {
      return BorderRadius.zero;
    } else if (index == 3) {
      return const BorderRadius.only(
          topRight: Radius.circular(10), bottomRight: Radius.circular(10));
    }
  }
}
