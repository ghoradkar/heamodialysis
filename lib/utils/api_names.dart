class ApiNames {
  static const String login = "/verifyLogin";
  static const String verifyLoginOtp = "/verifyLoginOtp";
  static const String generateAckReport = "pdfcontroller/generateAckReport";
  static const String sessionEndReport = "pdfcontroller/generate";
  static const String slotList = "hemodialysis-api/unit-slots";
  static const String getCaptcha = "/generateCaptcha";
  static const String getUnitByUserName = "/getUnitByUserName";
  static const String invoiceView = "/invoice-view-inv-dept";
  static const String sendForApproval = "/sendForAccountant";
  static const String invoiceSummaryReportUrl =
      "pdfcontroller/invoiceSummaryReportUrl";
  static const String invoiceNewReportUrl = "pdfcontroller/invoiceNewReportUrl";
  static const String mAVCalculationReport =
      "pdfcontroller/MAVCalculationReport";
  static const String showBillApprovalData = "/showBillApprovalData";
  static const String chartData = "/chart-data";
  static const String patientStage = "patient-track-history/patient-stage";
  static const String sendTOSecondLvl = "common-scrutiny/appSendToNextLVL";
  static const String getAllDropDownList = "dropdown/getAllDropDownList";
  static const String getInstitutesByFilters =
      "dropdown/getInstitutesByFilters";
  static const String getCctvConfiguration = "dropdown/getCctvConfiguration";
  static const String getCentralDashboarCount = "/getCentralDashboarCount";
  static const String getScrutinyApplication =
      "common-scrutiny/getScrutinyApplication";
  static const String checkScrutinyDefinedOrNot =
      "common-scrutiny/isScrutinyDefineOrNot";
  static const String getInvestigationData = "/getInvestigationData";
  static const String deleteIpdServicesAdvised = "/deleteIpdServicesAdvised";
  static const String getAllRoutesForPrescription =
      "/getAllRoutesForPrescription";
  static const String getAlltest = "/getAlltest";
  static const String pkgTestName = "/pkgTestName";
  static const String viewOpdDocuments = "/viewOpdDocuments";
  static const String ctReport = "/Ctreport";
  static const String getTemplateListByDepartmentId =
      "/getTemplateListByDepartmentId";
  static const String updateDignosisStatus = "/updateDignosisStatus";
  static const String getOPDHistoryNewData = "nephrology/getOPDHistoryNewData";
  static const String getPatientSubServiceDetailsOnIPD =
      "/getPatientSubServiceDetailsOnIPD";
  static const String getTestReportByPatientId =
      "/getTestReportByPatientId";

  static const String saveIndividualTreatmentInstruction =
      "/saveIndividualTreatmentInstruction";
  static const String saveIndivisualInstruction = "/saveIndivisualInstruction";
  static const String getAllPrescriptionsByTreatmentId =
      "/getAllPrescriptionsByTreatmentId";
  static const String fetchpreparationmaster = "/fetchpreparationmaster";
  static const String getMedicationMethod = "/getMedicationMethod";
  static const String fetchAllUnits = "/fetchAllUnits";
  static const String getMedicinesWithGeneric = "/getMedicinesWithGeneric";
  static const String fetchinstruction = "/fetchinstruction";
  static const String getMedicineById = "/getMedicineById";
  static const String getTreatmentId = "nephrology/checkTreatmentIdTMC";
  static const String getIntsructionsForPrescriptions =
      "/getIntsructionsForPrescriptions";
  static const String getAllOPDDocuments = "/getAllOPDDocuments";
  static const String deleteOPDDocuments = "/deleteOPDDocuments";
  static const String getOPDDietListByTreatmentId =
      "/getOPDDietListByTreatmentId";
  static const String deleteOPDDiet = "/deleteOPDDiet";
  static const String deleteOPDPrescription = "/deleteOPDPrescription";
  static const String deleteInstruction = "/deleteInstruction";
  static const String deleteIndivisualInstruction =
      "/deleteIndivisualInstruction";
  static const String deleteDiagonosis = "/deleteDiagonosis";
  static const String editOPDDiet = "/editOPDDiet";
  static const String getDetailsById = "/getDetailsById";
  static const String getRoDisDocById = "/getRoDisDocById";
  static const String getAnswerList =
      "common-scrutiny/getQueastionAnswerAgainstApplication";
  static const String getApprovalStatus = "/getApprovalStatus";
  static const String questionList =
      "common-scrutiny/comp-scruitny-service-level-question";
  static const String getNewDashboardCount = "/getNewDashboardCount";
  static const String getInvoiceAmountDet = "/getInvoiceAmountDet";
  static const String misCount = "/MisCount";
  static const String nephroCount = "/nephroCount";
  static const String save = "/save";
  static const String patientList = "/patientList";
  static const String saveInvestQWithTest = "/saveInvestQWithTest";
  static const String centralpatientList = "/CentralpatientList";
  static const String nephroPatientUnitWiseCount =
      "/nephroPatientUnitWiseCount";
  static const String getpatientListByunitId = "/getpatientListByunitId";
  static const String nephroPatientByUnitIdCount =
      "/nephroPatientByUnitIdCount";
  static const String getMjpDailysisCancelpat = "/getMjpDailysisCancelpat";
  static const String getDiaSessionSchemeWise = "/getDiaSessionSchemeWise";
  static const String getEventDetById = "/getEventDetById";
  static const String getEventDetailsInstituteWise =
      "/getEventDetailsInstituteWise";
  static const String abhaPatientById = "/AbhaPatientById";
  static const String getDialysisSessionDataByID =
      "/getDialysisSessionDataByID";
  static const String nephroDialSessionPatDetailsById =
      "/nephroDialSessionPatDetailsById";
  static const String nephroDialCancelPatDetailsById =
      "/nephroDialCancelPatDetailsById";
  static const String getUnitInfo = "/getUnitInfo";
  static const String getEventDetailsCount = "/getEventDetailsCount";
  static const String getcancelDialysisDetails = "/getcancelDialysisDetails";
  static const String getCancelDialsisDet = "/getCancelDialsisDet";
  static const String centralMachineDetailsCount =
      "/centralMachineDetailsCount";
  static const String centralTicketDetailsCount = "/centralTicketDetailsCount";
  static const String getInvoicestatusUnitwise = "/getInvoicestatusUnitwise";
  static const String centralComplaintDetailsCount =
      "/centralComplaintDetailsCount";
  static const String getComplaintDetails = "/getComplaintDetails";
  static const String getTicketDetails = "/getTicketDetails";
  static const String gettestDetailsUnitwise = "/gettestDetailsUnitwise";
  static const String getTestDetails = "/getTestDetails";
  static const String getDialSessiondetailsCOunt =
      "/getDialSessiondetailsCOunt";
  static const String centralDilSessionCount = "/centralDilSessionCount";
  static const String nephroDialSessionCount = "/nephroDialSessionCount";
  static const String nephroDialCancelCount = "/nephroDialCancelCount";
  static const String abhaPatientList = "/AbhaPatientList";
  static const String nephroEventDet = "/nephroEventDet";
  static const String centralAbhaPatientList = "/CentralAbhaPatientList";
  static const String getTopInstitute = "/getTopInstitute";
  static const String getOngoingDialysis = "/getOngoingDialysis";
  static const String getviralStatusCount = "/getviralStatusCount";
  static const String getProdNameList = "/getProdNameList";
  static const String getBatchNoList = "/getBatchNoList";
  static const String getExpiryDateList = "/getExpiryDateList";
  static const String getProductOrderId = "/getProductOrderId";
  static const String roMachineDisinfectionDelete =
      "/roMachineDisinfectionDelete";
  static const String roMachineLogSheetDelete = "/roMachineLogSheetDelete";
  static const String getROMachineLogNewById = "/getROMachineLogNewById";
  static const String roMachineIssueLogDelete = "/roMachineIssueLogDelete";
  static const String getTopAbhaInstitute = "/getTopAbhaInstitute";
  static const String getSchemePreformance = "/getSchemePreformance";
  static const String saveOPDiet = "/saveOPDiet";
  static const String searchByDropDownListApi = "/getSerachByList";
  static const String searchByDropDown = "nephrology/dropdown-list";
  static const String visitPatient = "/visitPatient";
  static const String getPostDiaList = "/getPostDiaList";
  static const String viewPatientDetailsNew = "/viewPatientDetailsNew";
  static const String savePostDai = "/savePostDai";
  static const String searchRegisteredPatientApi = "/getAutoSuggetionDetails";
  static const String nephroList = "nephrology/search-nrephro-patientlist";
  static const String doctorDeskPatientList = "api/mobile/getPreDialysisQueueList";
  static const String savediagonosis = "/savediagonosis";
  static const String saveOPDPrescription = "/saveOPDPrescription";
  static const String getDiagNosisList = "/diagosAutoSuggestion";
  static const String digoById = "/digoById";
  static const String getPreHistory = "/getPreHistory";
  static const String clinicalConditionList = "nephrology/clinical-condition";
  static const String incidentSubType = "/incidentSubType";
  static const String incidentType = "/incidentType";
  static const String cancelAppointment = "/cancelAppointment";
  static const String getIdProofList = "/getLookupDetList";
  static const String getDocCheckLIst = "/getDocCheckLIst";
  static const String getPincodeData = "/getPincodeData";
  static const String saveMachineLogsNew = "/saveMachineLogsNew";
  static const String getInstituteList = "/getUnitNameList";
  static const String getUserAccessFlag = "/getUserAccessFlag";
  static const String getPrefixList = "/getallpatienttitles";
  static const String getGenderList = "/getGenderList";
  static const String getViralStatus = "/getHaemodialysisProcedureTypeList";
  static const String getDialysisList = "/getDialysisModeList";
  static const String eventDataTable = "/eventDataTable";
  static const String getClinicalHistoryFlag = "/getClinicalHistoryFlag";
  static const String patientDetailsbyid = "/patientDetailsbyid";
  static const String getPreDialysisQueueList = "/getPreDialysisQueueList";
  static const String getPatientRecordsbypatientId =
      "/getPatientRecordsbypatientId";
  static const String dieticianDoneStage = "/dieticianDoneStage";
  static const String saveDischarge = "/saveDischarge";
  static const String savePatientRegDetails = "/savePatientRegDetails";
  static const String saveDoctorDeskDocument = "/saveDoctorDeskDocument";
  static const String saveIpd = "/saveIpd";
  static const String savePatientDocuments = "/savePatientDocuments";
  static const String getSlotList = "/getSlotList";
  static const String getSchemaAdoptedList = "/getPatientTypeList";
  static const String getStateList = "/getStateList";
  static const String getDivisionList = "/getDivisionList";
  static const String getDistrictList = "/getDistrictList";
  static const String getTalukaList = "/getTalukaList";
  static const String getTownList = "/getTownList";
  static const String getRelation = "/getRelation";
  static const String getRefferedBy = "/getRefferedBy";
  static const String capturePhoto = "/capturePhoto";
  static const String viewRelativeDoc = "/viewRelativeDoc";
  static const String getMaritalStatus = "/getMaritalStatus";
  static const String getBloodGroup =  "/getBloodGroup";
  static const String viewPatientDetails = "/viewPatientDetails";
  static const String getAvailableBedList = "/getAvailableBedList";
  static const String bookBedApi = "/bookBedApi";
  static const String saveCapturedPhoto = "/uploadPhoto";
  static const String getCapturedPhotoList = "/capturePhoto";
  static const String deletedPhoto = "/deletedPhoto";
  static const String getPreDiaList = "/getPreDiaList";
  static const String updateTreatmentData = "/updateTreatmentData";
  static const String visitDocumentUpload = "/visitDocumentUpload";
  static const String savePhysicalDet = "/savePhysicalDet";
  static const String getallROMachineDisBySearch =
      "/getallROMachineDisBySearch";
  static const String getRoAllData =
      "/getRoAllData";
  static const String getRoAllDataById =
      "/getRoAllDataById";

  static const String getallROMachineLogBySearch =
      "/getallROMachineLogBySearch";
  static const String getallROMachineLogSheetBySearch =
      "/getallROMachineLogSheetBySearch";
  static const String getMachineNameList = "/getMachineNameList";
  static const String consultationDetails =
      "patient-track-history/consultation-details";
  static const String schedularPreDialysisHistory =
      "patient-track-history/pre-dialysis";
  static const String schedularPostDialysisHistory =
      "patient-track-history/post-dialysis";
  static const String getPatientDisHist = "/getPatientDisHist";
  static const String getTrendAnalysisData = "/getTrendAnalysisData";
  static const String formShortCode = "/formShortCode";
  static const String getDocumentChecklistList = "/getDocumentChecklistList";
  static const String getallservices = "/getallservices";
  static const String getSandFilterPrePost = "/getSandFilterPrePost";
  static const String getSoftnerAvl = "/getSoftnerAvl";
  static const String getBeforeAfterRegHard = "/getBeforeAfterRegHard";
  static const String getBackWashRinse = "/getBackWashRinse";
  static const String getDisinfectionDet = "/getDisinfectionDet";
  static const String getUsersByUnit = "/getUsersByUnit";
  static const String saveRODisDet = "/saveRODisDet";
  static const String saveLogSheet = "/saveLogSheet";
  static const String saveROMachineIssueLog = "/saveROMachineIssueLog";
  static const String getProbResolved = "/getProbResolved";
  static const String getDialysisType = "/getDialysisType";
  static const String getAccessType = "/getAccessType";
  static const String getAccessSite = "/getAccessSite";
  static const String getDialyserType = "/getDialyserType";
  static const String getDialysisDetails = "/getDialysisDetails";
  static const String getSpecialDailysis = "/getSpecialDailysis";
  static const String savePreDailysis = "predialysisqueue/savePreDailysis";
  static const String getPostFlag = "/getPostFlag";
  static const String getPreWeight = "/getPreWeight";
  static const String getIntermediateWait = "/getIntermediateWait";
  static const String getFibreBundle = "/getFibreBundle";
  static const String getRawWaterTDS = "/getRawWaterTDS";
  static const String getROWaterTDS = "/getROWaterTDS";
  static const String getPostCarbonCl = "/getPostCarbonCl";
  static const String getROWaterCond = "/getROWaterCond";
  static const String getReturnLoopP = "/getReturnLoopP";
  static const String getDocumentList = "/getDocumentList";
  static const String getStageByPatientId = "/getStageByPatientId";
  static const String getDailBookings = "/getDailBookings";
  static const String saveSchedular = "/saveSchedular";
  static const String getSlotListForscheduler = "/getSlotListForscheduler";
  static const String getavailableslots = "/getavailableslots";
  static const String getSuggestionList = "/getAuto-suggetion-details";
  static const String saveOPDHistoryNew = "/saveOPDHistoryNew";
  static const String getClinicalHistoryData = "/getClinicalHistoryData";
  static const String getIndivisualInstructions = "/getIndivisualInstructions";
  static const String coverSheetNephro = "nephrology/cover-sheet";
  static const String choosePackageList =
      "nephrology/labratory-investigation-eventlist";
  static const String checkDateAppointmentSchedule =
      "/checkDateAppointmentSchedule";
  static const String clusterWiseTotalPatientReg = "central-patient-list";
  static const String lisofDiagonosis = "/lisofDiagonosis";
  static const String getPackageList = "/getPackageList";
  static const String sendToPhlebotomyFromSave = "/sendToPhlebotomyFromSave";
  static const String getAllConsumableItems = "/getAllConsumableItems";
  static const String getSpecialDialysis = "/getSpecialDialysis";
  static const String getNewDropdownList = "/getNewDropdownList";
  static const String checkMobileNo = "/checkMobileNo";
  static const String getDashboardShortCode = "/get-dashboardcard-shortcode";
  static const String getSavedMachineReading = "/getSavedMachineReading";
  static const String getMachineListreading = "/getMachineListreading";
  static const String chechSavedBarcode = "/chechSavedBarcode";
  static const String saveBarcodeNew = "/saveBarcodeNew";
  static const String updateTestStatus = "/updateTestStatus";
  static const String saveMachineReading = "/saveMachineReading";
  static const String getDataForHdChartGrid = "/getDataForHdChartGrid";
  static const String getHdChartSafetyChecksDetails = "/getHdChartSafetyChecksDetails";
  static const String getHdChartTreatmentDetails = "/getHdChartTreatmentDetails";
  static const String getDetailsForHemodialysisChartById = "/getDetailsForHemodialysisChartById";
  static const String savePatientHdChartPrm = "/savePatientHdChartPrm";
  static const String savePatientHdChart = "/savePatientHdChart";
  static const String deleteTreatDetById = "/deleteTreatDetById";
  static const String getPostDropdownList = "/getPostDropdownList";
  static const String getVitalPatDetails = "/getVitalPatDetails";
  static const String getVitalPatChart = "/getVitalPatChart";
  static const String downloadViralChart = "pdfcontroller/vital-chart-report";
  static const String downloadInvetsChart = "pdfcontroller/investigation_chart_report";
  static const String getInvestigationChart = "/getInvestigationChart";
  static const String getInvestigationResultData = "/getInvestigationResultData";
  static const String getAllUnitDetails = "/getAllUnitDetails";
  static const String cehckSavedTestUrl = "/cehckSavedTestUrl";
  static const String checkPackgeSavedUrl = "/checkPackgeSavedUrl";
  static const String prescriptionReport = "pdfcontroller/prescriptionReport";
  static const String getDropForOPDHistory = "/getDropForOPDHistory";
  static const String getDiseaseDetails = "/getDiseaseDetails";
  static const String getPatientHdChartDocuments = "/getPatientHdChartDocuments";
  static const String uploadPatientHdChartDocument = "/uploadPatientHdChartDocument";
  static const String getFeedbackDocuments = "/getFeedbackDocuments";
  static const String uploadFeedbackDocument = "/uploadFeedbackDocument";
}
