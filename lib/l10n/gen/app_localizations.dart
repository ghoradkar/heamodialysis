import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('en', 'FR'),
    Locale('fr')
  ];

  /// Application name shown in the OS task switcher. Brand name - kept identical in every language.
  ///
  /// In en, this message translates to:
  /// **'MahaDialysis'**
  String get appTitle;

  /// No description provided for @languageLabel.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageLabel;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageFrench.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get languageFrench;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change language'**
  String get changeLanguage;

  /// No description provided for @languageTooltip.
  ///
  /// In en, this message translates to:
  /// **'Change language'**
  String get languageTooltip;

  /// No description provided for @commonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// No description provided for @commonSubmit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get commonSubmit;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get commonClose;

  /// No description provided for @commonConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get commonConfirm;

  /// No description provided for @commonNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get commonNext;

  /// No description provided for @commonPrevious.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get commonPrevious;

  /// No description provided for @commonBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get commonBack;

  /// No description provided for @commonEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get commonEdit;

  /// No description provided for @commonDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

  /// No description provided for @commonAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get commonAdd;

  /// No description provided for @commonUpdate.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get commonUpdate;

  /// No description provided for @commonView.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get commonView;

  /// No description provided for @commonSearch.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get commonSearch;

  /// No description provided for @commonClear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get commonClear;

  /// No description provided for @commonReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get commonReset;

  /// No description provided for @commonApply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get commonApply;

  /// No description provided for @commonRefresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get commonRefresh;

  /// No description provided for @commonRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get commonRetry;

  /// No description provided for @commonProceed.
  ///
  /// In en, this message translates to:
  /// **'Proceed'**
  String get commonProceed;

  /// No description provided for @commonGoBack.
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get commonGoBack;

  /// No description provided for @commonDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get commonDone;

  /// No description provided for @commonSelect.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get commonSelect;

  /// No description provided for @commonUpload.
  ///
  /// In en, this message translates to:
  /// **'Upload'**
  String get commonUpload;

  /// No description provided for @commonDownload.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get commonDownload;

  /// No description provided for @commonYes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get commonYes;

  /// No description provided for @commonNo.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get commonNo;

  /// No description provided for @commonOk.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get commonOk;

  /// No description provided for @commonLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading…'**
  String get commonLoading;

  /// No description provided for @commonNoData.
  ///
  /// In en, this message translates to:
  /// **'No data'**
  String get commonNoData;

  /// No description provided for @commonNoDataFound.
  ///
  /// In en, this message translates to:
  /// **'No data found'**
  String get commonNoDataFound;

  /// No description provided for @commonNoRecordsFound.
  ///
  /// In en, this message translates to:
  /// **'No records found'**
  String get commonNoRecordsFound;

  /// No description provided for @commonSomethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get commonSomethingWentWrong;

  /// No description provided for @commonSuccess.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get commonSuccess;

  /// No description provided for @commonError.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get commonError;

  /// No description provided for @commonWarning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get commonWarning;

  /// No description provided for @commonNote.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get commonNote;

  /// No description provided for @commonPleaseSelect.
  ///
  /// In en, this message translates to:
  /// **'Please select'**
  String get commonPleaseSelect;

  /// No description provided for @commonPleaseWait.
  ///
  /// In en, this message translates to:
  /// **'Please wait…'**
  String get commonPleaseWait;

  /// No description provided for @commonSessionExpired.
  ///
  /// In en, this message translates to:
  /// **'Session expired. Please log in again.'**
  String get commonSessionExpired;

  /// No description provided for @commonNoInternet.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get commonNoInternet;

  /// No description provided for @commonCheckConnection.
  ///
  /// In en, this message translates to:
  /// **'Please check your connection and try again'**
  String get commonCheckConnection;

  /// No description provided for @noInternetHeadline.
  ///
  /// In en, this message translates to:
  /// **'Oh No'**
  String get noInternetHeadline;

  /// No description provided for @noInternetMessage.
  ///
  /// In en, this message translates to:
  /// **'No internet connection found.'**
  String get noInternetMessage;

  /// No description provided for @noInternetHint.
  ///
  /// In en, this message translates to:
  /// **'Check your connection or try again.'**
  String get noInternetHint;

  /// No description provided for @commonRequiredField.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get commonRequiredField;

  /// Validation message for an empty required input.
  ///
  /// In en, this message translates to:
  /// **'{field} is required'**
  String fieldRequired(String field);

  /// No description provided for @fieldInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid {field}'**
  String fieldInvalid(String field);

  /// No description provided for @validationInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get validationInvalidEmail;

  /// No description provided for @validationInvalidPan.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid PAN'**
  String get validationInvalidPan;

  /// No description provided for @validationDigits.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid {count}-digit number'**
  String validationDigits(int count);

  /// No description provided for @validationMinDigits.
  ///
  /// In en, this message translates to:
  /// **'Please enter {count} digits'**
  String validationMinDigits(int count);

  /// No description provided for @validationMaxLength.
  ///
  /// In en, this message translates to:
  /// **'Maximum {max} characters allowed'**
  String validationMaxLength(int max);

  /// No description provided for @charactersRemaining.
  ///
  /// In en, this message translates to:
  /// **'{count} characters remaining'**
  String charactersRemaining(int count);

  /// No description provided for @validationHeightFormat.
  ///
  /// In en, this message translates to:
  /// **'Please enter height as e.g. 5\'8'**
  String get validationHeightFormat;

  /// No description provided for @validationInvalidNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid number'**
  String get validationInvalidNumber;

  /// No description provided for @validationMaxLitres.
  ///
  /// In en, this message translates to:
  /// **'{field} should not be greater than {max} ltrs'**
  String validationMaxLitres(String field, String max);

  /// No description provided for @validationDateFormat.
  ///
  /// In en, this message translates to:
  /// **'Please enter the date in the format dd/MM/yyyy'**
  String get validationDateFormat;

  /// No description provided for @validationInvalidDate.
  ///
  /// In en, this message translates to:
  /// **'Invalid date. Please check the format'**
  String get validationInvalidDate;

  /// No description provided for @unitFahrenheit.
  ///
  /// In en, this message translates to:
  /// **'Fahrenheit'**
  String get unitFahrenheit;

  /// No description provided for @unitCelsius.
  ///
  /// In en, this message translates to:
  /// **'Celsius'**
  String get unitCelsius;

  /// No description provided for @commonDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get commonDate;

  /// No description provided for @commonTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get commonTime;

  /// No description provided for @selectTime.
  ///
  /// In en, this message translates to:
  /// **'Select Time'**
  String get selectTime;

  /// No description provided for @commonLogout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get commonLogout;

  /// No description provided for @drawerDashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get drawerDashboard;

  /// No description provided for @drawerRegistration.
  ///
  /// In en, this message translates to:
  /// **'Registration'**
  String get drawerRegistration;

  /// No description provided for @drawerDialysisScheduler.
  ///
  /// In en, this message translates to:
  /// **'Dialysis Scheduler'**
  String get drawerDialysisScheduler;

  /// No description provided for @drawerDialysisQueue.
  ///
  /// In en, this message translates to:
  /// **'Dialysis Queue'**
  String get drawerDialysisQueue;

  /// No description provided for @drawerSessionEnd.
  ///
  /// In en, this message translates to:
  /// **'Session End'**
  String get drawerSessionEnd;

  /// No description provided for @drawerRoMaintenance.
  ///
  /// In en, this message translates to:
  /// **'RO Maintenance'**
  String get drawerRoMaintenance;

  /// No description provided for @drawerMachineStatus.
  ///
  /// In en, this message translates to:
  /// **'Machine Status'**
  String get drawerMachineStatus;

  /// No description provided for @drawerNephrologistDesk.
  ///
  /// In en, this message translates to:
  /// **'Nephrologist Desk'**
  String get drawerNephrologistDesk;

  /// No description provided for @drawerDoctorDesk.
  ///
  /// In en, this message translates to:
  /// **'Doctor Desk'**
  String get drawerDoctorDesk;

  /// No description provided for @drawerApplicationApproval.
  ///
  /// In en, this message translates to:
  /// **'Application Approval'**
  String get drawerApplicationApproval;

  /// No description provided for @drawerApplicationScrutiny.
  ///
  /// In en, this message translates to:
  /// **'Application Scrutiny'**
  String get drawerApplicationScrutiny;

  /// No description provided for @drawerUploadDocuments.
  ///
  /// In en, this message translates to:
  /// **'Upload Documents'**
  String get drawerUploadDocuments;

  /// No description provided for @drawerBilling.
  ///
  /// In en, this message translates to:
  /// **'Billing'**
  String get drawerBilling;

  /// No description provided for @drawerInvoiceApprovalSecondLevel.
  ///
  /// In en, this message translates to:
  /// **'Invoice Approval (2nd Level)'**
  String get drawerInvoiceApprovalSecondLevel;

  /// No description provided for @drawerInvoiceGeneration.
  ///
  /// In en, this message translates to:
  /// **'Invoice Generation'**
  String get drawerInvoiceGeneration;

  /// No description provided for @drawerVersion.
  ///
  /// In en, this message translates to:
  /// **'Version: {version}'**
  String drawerVersion(String version);

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginTitle;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// No description provided for @loginUsername.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get loginUsername;

  /// No description provided for @loginPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get loginPassword;

  /// No description provided for @loginForgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get loginForgotPassword;

  /// No description provided for @loginCaptchaHint.
  ///
  /// In en, this message translates to:
  /// **'Enter the captcha as shown above'**
  String get loginCaptchaHint;

  /// No description provided for @loginIndiaOnlyMessage.
  ///
  /// In en, this message translates to:
  /// **'This app is only available in the Indian region'**
  String get loginIndiaOnlyMessage;

  /// No description provided for @loginSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Login successful'**
  String get loginSuccessful;

  /// No description provided for @loginRunningEnv.
  ///
  /// In en, this message translates to:
  /// **'Running in {env} environment'**
  String loginRunningEnv(String env);

  /// No description provided for @loginUnknownRole.
  ///
  /// In en, this message translates to:
  /// **'Unknown user role: {role}'**
  String loginUnknownRole(String role);

  /// No description provided for @loginInvalidUser.
  ///
  /// In en, this message translates to:
  /// **'Invalid User'**
  String get loginInvalidUser;

  /// No description provided for @logoutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get logoutConfirm;

  /// No description provided for @otpVerifyTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify OTP'**
  String get otpVerifyTitle;

  /// No description provided for @otpSentTo.
  ///
  /// In en, this message translates to:
  /// **'OTP has been sent to registered mobile number:'**
  String get otpSentTo;

  /// No description provided for @otpYourNumber.
  ///
  /// In en, this message translates to:
  /// **'your registered number'**
  String get otpYourNumber;

  /// No description provided for @otpValidLimited.
  ///
  /// In en, this message translates to:
  /// **'This OTP is valid for a limited time'**
  String get otpValidLimited;

  /// No description provided for @otpCanResendNow.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t get it? You can resend now.'**
  String get otpCanResendNow;

  /// No description provided for @otpDidntReceive.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive the code?'**
  String get otpDidntReceive;

  /// No description provided for @otpResend.
  ///
  /// In en, this message translates to:
  /// **'Resend OTP'**
  String get otpResend;

  /// No description provided for @otpResendIn.
  ///
  /// In en, this message translates to:
  /// **'Resend in {time}'**
  String otpResendIn(String time);

  /// No description provided for @otpEnterDigits.
  ///
  /// In en, this message translates to:
  /// **'Please enter the {count}-digit OTP'**
  String otpEnterDigits(int count);

  /// No description provided for @otpResent.
  ///
  /// In en, this message translates to:
  /// **'OTP resent'**
  String get otpResent;

  /// No description provided for @otpInvalidOrExpired.
  ///
  /// In en, this message translates to:
  /// **'Invalid or Expired OTP'**
  String get otpInvalidOrExpired;

  /// No description provided for @otpResendFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not resend OTP. Please login again.'**
  String get otpResendFailed;

  /// No description provided for @commonFrom.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get commonFrom;

  /// No description provided for @commonTo.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get commonTo;

  /// No description provided for @commonStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get commonStatus;

  /// No description provided for @commonActions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get commonActions;

  /// No description provided for @commonAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get commonAll;

  /// No description provided for @commonCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get commonCompleted;

  /// No description provided for @commonName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get commonName;

  /// No description provided for @commonAge.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get commonAge;

  /// No description provided for @commonGender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get commonGender;

  /// No description provided for @commonMobileNo.
  ///
  /// In en, this message translates to:
  /// **'Mobile No'**
  String get commonMobileNo;

  /// No description provided for @commonAddress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get commonAddress;

  /// No description provided for @commonRemarks.
  ///
  /// In en, this message translates to:
  /// **'Remarks'**
  String get commonRemarks;

  /// No description provided for @colSrNo.
  ///
  /// In en, this message translates to:
  /// **'Sr. No'**
  String get colSrNo;

  /// No description provided for @colPatientId.
  ///
  /// In en, this message translates to:
  /// **'Patient ID'**
  String get colPatientId;

  /// No description provided for @colPatientName.
  ///
  /// In en, this message translates to:
  /// **'Patient Name'**
  String get colPatientName;

  /// No description provided for @colAbhaNo.
  ///
  /// In en, this message translates to:
  /// **'ABHA No'**
  String get colAbhaNo;

  /// No description provided for @colDistrictName.
  ///
  /// In en, this message translates to:
  /// **'District Name'**
  String get colDistrictName;

  /// No description provided for @colInstituteName.
  ///
  /// In en, this message translates to:
  /// **'Institute Name'**
  String get colInstituteName;

  /// No description provided for @colMachineCount.
  ///
  /// In en, this message translates to:
  /// **'Machine Count'**
  String get colMachineCount;

  /// No description provided for @colCommencementDate.
  ///
  /// In en, this message translates to:
  /// **'Commencement Date'**
  String get colCommencementDate;

  /// No description provided for @colPatientRegistered.
  ///
  /// In en, this message translates to:
  /// **'Patients Registered'**
  String get colPatientRegistered;

  /// No description provided for @colSessionDone.
  ///
  /// In en, this message translates to:
  /// **'Sessions Done'**
  String get colSessionDone;

  /// No description provided for @colScheme.
  ///
  /// In en, this message translates to:
  /// **'Scheme'**
  String get colScheme;

  /// No description provided for @colSessionCount.
  ///
  /// In en, this message translates to:
  /// **'Session Count'**
  String get colSessionCount;

  /// No description provided for @colViewPatient.
  ///
  /// In en, this message translates to:
  /// **'View Patient'**
  String get colViewPatient;

  /// No description provided for @colUnitName.
  ///
  /// In en, this message translates to:
  /// **'Unit Name'**
  String get colUnitName;

  /// No description provided for @colTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get colTotal;

  /// No description provided for @colTotalCount.
  ///
  /// In en, this message translates to:
  /// **'Total Count'**
  String get colTotalCount;

  /// No description provided for @colTotalPatientRegister.
  ///
  /// In en, this message translates to:
  /// **'Total Patient Register'**
  String get colTotalPatientRegister;

  /// No description provided for @colType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get colType;

  /// No description provided for @colCount.
  ///
  /// In en, this message translates to:
  /// **'Count'**
  String get colCount;

  /// No description provided for @colEventName.
  ///
  /// In en, this message translates to:
  /// **'Event Name'**
  String get colEventName;

  /// No description provided for @colEventCount.
  ///
  /// In en, this message translates to:
  /// **'Event Count'**
  String get colEventCount;

  /// No description provided for @colTreatmentId.
  ///
  /// In en, this message translates to:
  /// **'Treatment ID'**
  String get colTreatmentId;

  /// No description provided for @colSchemeName.
  ///
  /// In en, this message translates to:
  /// **'Scheme Name'**
  String get colSchemeName;

  /// No description provided for @colViralLoadStatus.
  ///
  /// In en, this message translates to:
  /// **'Viral Load Status'**
  String get colViralLoadStatus;

  /// No description provided for @colInvoiceAmount.
  ///
  /// In en, this message translates to:
  /// **'Invoice Amount'**
  String get colInvoiceAmount;

  /// No description provided for @colMonthYear.
  ///
  /// In en, this message translates to:
  /// **'Month-Year'**
  String get colMonthYear;

  /// No description provided for @colMjpjayCount.
  ///
  /// In en, this message translates to:
  /// **'MJPJAY Count'**
  String get colMjpjayCount;

  /// No description provided for @colNonMjpjayCount.
  ///
  /// In en, this message translates to:
  /// **'Non-MJPJAY Count'**
  String get colNonMjpjayCount;

  /// No description provided for @colTicketTypeDataCorrection.
  ///
  /// In en, this message translates to:
  /// **'Ticket Types\nData Correction'**
  String get colTicketTypeDataCorrection;

  /// No description provided for @colTicketTypeNewRequirement.
  ///
  /// In en, this message translates to:
  /// **'Ticket Types\nNew Requirement'**
  String get colTicketTypeNewRequirement;

  /// No description provided for @colTicketTypeOperatorIssue.
  ///
  /// In en, this message translates to:
  /// **'Ticket Types\nOperator Issue'**
  String get colTicketTypeOperatorIssue;

  /// No description provided for @colTicketTypeSoftwareServices.
  ///
  /// In en, this message translates to:
  /// **'Ticket Types\nSoftware Services'**
  String get colTicketTypeSoftwareServices;

  /// No description provided for @colTicketTypeBug.
  ///
  /// In en, this message translates to:
  /// **'Ticket Types\nBug'**
  String get colTicketTypeBug;

  /// No description provided for @colTicketTypeEnhancement.
  ///
  /// In en, this message translates to:
  /// **'Ticket Types\nEnhancement'**
  String get colTicketTypeEnhancement;

  /// No description provided for @colComplaintTypeDenialOfService.
  ///
  /// In en, this message translates to:
  /// **'Complaint Types\nDenial of Service'**
  String get colComplaintTypeDenialOfService;

  /// No description provided for @colComplaintTypeMoneyTaken.
  ///
  /// In en, this message translates to:
  /// **'Complaint Types\nMoney Taken Against Treat'**
  String get colComplaintTypeMoneyTaken;

  /// No description provided for @colTestTypePending.
  ///
  /// In en, this message translates to:
  /// **'Test Types\nPending'**
  String get colTestTypePending;

  /// No description provided for @colTestTypeComplete.
  ///
  /// In en, this message translates to:
  /// **'Test Types\nComplete'**
  String get colTestTypeComplete;

  /// No description provided for @dashShowData.
  ///
  /// In en, this message translates to:
  /// **'Show Data'**
  String get dashShowData;

  /// No description provided for @dashPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get dashPending;

  /// No description provided for @dashComplete.
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get dashComplete;

  /// No description provided for @dashTotalPending.
  ///
  /// In en, this message translates to:
  /// **'Total Pending'**
  String get dashTotalPending;

  /// No description provided for @dashTotalComplete.
  ///
  /// In en, this message translates to:
  /// **'Total Complete'**
  String get dashTotalComplete;

  /// No description provided for @dashSchemeMjpjay.
  ///
  /// In en, this message translates to:
  /// **'MJPJAY'**
  String get dashSchemeMjpjay;

  /// No description provided for @dashSchemeNonMjpjay.
  ///
  /// In en, this message translates to:
  /// **'Non-MJPJAY'**
  String get dashSchemeNonMjpjay;

  /// No description provided for @dashToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get dashToday;

  /// No description provided for @dashFromDate.
  ///
  /// In en, this message translates to:
  /// **'From Date'**
  String get dashFromDate;

  /// No description provided for @dashToDate.
  ///
  /// In en, this message translates to:
  /// **'To Date'**
  String get dashToDate;

  /// No description provided for @dashSelectDate.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get dashSelectDate;

  /// No description provided for @dashCurrentDate.
  ///
  /// In en, this message translates to:
  /// **'Current Date'**
  String get dashCurrentDate;

  /// No description provided for @dashCurrentDay.
  ///
  /// In en, this message translates to:
  /// **'Current Day'**
  String get dashCurrentDay;

  /// No description provided for @dashTillDate.
  ///
  /// In en, this message translates to:
  /// **'Till Date'**
  String get dashTillDate;

  /// No description provided for @dashDateWise.
  ///
  /// In en, this message translates to:
  /// **'Date Wise'**
  String get dashDateWise;

  /// No description provided for @dashWorking.
  ///
  /// In en, this message translates to:
  /// **'Working'**
  String get dashWorking;

  /// No description provided for @dashSchemePerformance.
  ///
  /// In en, this message translates to:
  /// **'Scheme Performance'**
  String get dashSchemePerformance;

  /// No description provided for @dashPatientRegistration.
  ///
  /// In en, this message translates to:
  /// **'Patient Registration'**
  String get dashPatientRegistration;

  /// No description provided for @dashPatientAddedList.
  ///
  /// In en, this message translates to:
  /// **'Patient Added List'**
  String get dashPatientAddedList;

  /// No description provided for @dashAbhaRegistration.
  ///
  /// In en, this message translates to:
  /// **'ABHA Registration'**
  String get dashAbhaRegistration;

  /// No description provided for @dashDialysisSessions.
  ///
  /// In en, this message translates to:
  /// **'Dialysis Sessions'**
  String get dashDialysisSessions;

  /// No description provided for @dashDialysisSession.
  ///
  /// In en, this message translates to:
  /// **'Dialysis Session'**
  String get dashDialysisSession;

  /// No description provided for @dashDialysisCancelled.
  ///
  /// In en, this message translates to:
  /// **'Dialysis Cancelled'**
  String get dashDialysisCancelled;

  /// No description provided for @dashDialysisCancel.
  ///
  /// In en, this message translates to:
  /// **'Dialysis Cancel'**
  String get dashDialysisCancel;

  /// No description provided for @dashTotalDialysisCancelled.
  ///
  /// In en, this message translates to:
  /// **'Total Dialysis Cancelled'**
  String get dashTotalDialysisCancelled;

  /// No description provided for @dashOnlineComplaints.
  ///
  /// In en, this message translates to:
  /// **'Online Complaints'**
  String get dashOnlineComplaints;

  /// No description provided for @dashTotalOnlineComplaints.
  ///
  /// In en, this message translates to:
  /// **'Total Online Complaints'**
  String get dashTotalOnlineComplaints;

  /// No description provided for @dashOnlineTickets.
  ///
  /// In en, this message translates to:
  /// **'Online Tickets'**
  String get dashOnlineTickets;

  /// No description provided for @dashFeedbackTitle.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get dashFeedbackTitle;

  /// No description provided for @dashDateWiseFeedback.
  ///
  /// In en, this message translates to:
  /// **'Date Wise Feedback'**
  String get dashDateWiseFeedback;

  /// No description provided for @dashLabTestAssigned.
  ///
  /// In en, this message translates to:
  /// **'Laboratory Test Assigned'**
  String get dashLabTestAssigned;

  /// No description provided for @dashDateWiseLabTest.
  ///
  /// In en, this message translates to:
  /// **'Date Wise Laboratory Test Assigned'**
  String get dashDateWiseLabTest;

  /// No description provided for @dashTotalLabTestAssigned.
  ///
  /// In en, this message translates to:
  /// **'Total Laboratory Test Assigned'**
  String get dashTotalLabTestAssigned;

  /// No description provided for @dashEventOccurred.
  ///
  /// In en, this message translates to:
  /// **'Event Occurred'**
  String get dashEventOccurred;

  /// No description provided for @dashDateWiseEvents.
  ///
  /// In en, this message translates to:
  /// **'Date Wise Events'**
  String get dashDateWiseEvents;

  /// No description provided for @dashTotalAdverseEvent.
  ///
  /// In en, this message translates to:
  /// **'Total Adverse Event'**
  String get dashTotalAdverseEvent;

  /// No description provided for @dashComplaintDashboardDown.
  ///
  /// In en, this message translates to:
  /// **'Dashboard Down'**
  String get dashComplaintDashboardDown;

  /// No description provided for @dashComplaintMachineNotWorking.
  ///
  /// In en, this message translates to:
  /// **'Machine Not Working'**
  String get dashComplaintMachineNotWorking;

  /// No description provided for @dashComplaintDenialOfServices.
  ///
  /// In en, this message translates to:
  /// **'Denial of Services'**
  String get dashComplaintDenialOfServices;

  /// No description provided for @dashComplaintMoneyTaken.
  ///
  /// In en, this message translates to:
  /// **'Money taken against treatment'**
  String get dashComplaintMoneyTaken;

  /// No description provided for @dashTicketDataCorrection.
  ///
  /// In en, this message translates to:
  /// **'Data Correction'**
  String get dashTicketDataCorrection;

  /// No description provided for @dashTicketNewRequirement.
  ///
  /// In en, this message translates to:
  /// **'New Requirement'**
  String get dashTicketNewRequirement;

  /// No description provided for @dashTicketOperatorIssue.
  ///
  /// In en, this message translates to:
  /// **'Operator Issue'**
  String get dashTicketOperatorIssue;

  /// No description provided for @dashTicketSoftwareServices.
  ///
  /// In en, this message translates to:
  /// **'Software Services'**
  String get dashTicketSoftwareServices;

  /// No description provided for @dashTicketBug.
  ///
  /// In en, this message translates to:
  /// **'Bug'**
  String get dashTicketBug;

  /// No description provided for @dashTicketEnhancement.
  ///
  /// In en, this message translates to:
  /// **'Enhancement'**
  String get dashTicketEnhancement;

  /// No description provided for @dashCentralDashboard.
  ///
  /// In en, this message translates to:
  /// **'Central Dashboard'**
  String get dashCentralDashboard;

  /// No description provided for @dashTotalFunctionalUnit.
  ///
  /// In en, this message translates to:
  /// **'Total Functional Unit'**
  String get dashTotalFunctionalUnit;

  /// No description provided for @dashTotalProjectedCenter.
  ///
  /// In en, this message translates to:
  /// **'Total Projected Center'**
  String get dashTotalProjectedCenter;

  /// No description provided for @dashFunctionalCenter.
  ///
  /// In en, this message translates to:
  /// **'Functional Center'**
  String get dashFunctionalCenter;

  /// No description provided for @dashTotalDialysisPatient.
  ///
  /// In en, this message translates to:
  /// **'Total Dialysis Patient'**
  String get dashTotalDialysisPatient;

  /// No description provided for @dashTotalPatient.
  ///
  /// In en, this message translates to:
  /// **'Total Patient'**
  String get dashTotalPatient;

  /// No description provided for @dashTotalPatientRegistration.
  ///
  /// In en, this message translates to:
  /// **'Total Patient Registration'**
  String get dashTotalPatientRegistration;

  /// No description provided for @dashTotalAbhaPatient.
  ///
  /// In en, this message translates to:
  /// **'Total ABHA Patient'**
  String get dashTotalAbhaPatient;

  /// No description provided for @dashTotalAbhaRegistration.
  ///
  /// In en, this message translates to:
  /// **'Total ABHA Registration'**
  String get dashTotalAbhaRegistration;

  /// No description provided for @dashTotalDialysisSessions.
  ///
  /// In en, this message translates to:
  /// **'Total Dialysis Sessions'**
  String get dashTotalDialysisSessions;

  /// No description provided for @dashTotalMachines.
  ///
  /// In en, this message translates to:
  /// **'Total Machines'**
  String get dashTotalMachines;

  /// No description provided for @dashAdverseEvents.
  ///
  /// In en, this message translates to:
  /// **'Adverse Events'**
  String get dashAdverseEvents;

  /// No description provided for @dashAdverseEvent.
  ///
  /// In en, this message translates to:
  /// **'Adverse Event'**
  String get dashAdverseEvent;

  /// No description provided for @dashTickets.
  ///
  /// In en, this message translates to:
  /// **'Tickets'**
  String get dashTickets;

  /// No description provided for @dashTotalTickets.
  ///
  /// In en, this message translates to:
  /// **'Total Tickets'**
  String get dashTotalTickets;

  /// No description provided for @dashTotalFeedback.
  ///
  /// In en, this message translates to:
  /// **'Total Feedback'**
  String get dashTotalFeedback;

  /// No description provided for @dashTotalInvoiceAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Invoice Amount'**
  String get dashTotalInvoiceAmount;

  /// No description provided for @dashCurrentMonth.
  ///
  /// In en, this message translates to:
  /// **'Current Month'**
  String get dashCurrentMonth;

  /// No description provided for @dashTotalPayment.
  ///
  /// In en, this message translates to:
  /// **'Total Payment'**
  String get dashTotalPayment;

  /// No description provided for @dashDialysisPerformance.
  ///
  /// In en, this message translates to:
  /// **'Dialysis Performance'**
  String get dashDialysisPerformance;

  /// No description provided for @dashClusterDistrictDashboard.
  ///
  /// In en, this message translates to:
  /// **'Cluster District Dashboard'**
  String get dashClusterDistrictDashboard;

  /// No description provided for @dashClusterDivisionDashboard.
  ///
  /// In en, this message translates to:
  /// **'Cluster Division Dashboard'**
  String get dashClusterDivisionDashboard;

  /// No description provided for @dashCurrentDatePatientRegistered.
  ///
  /// In en, this message translates to:
  /// **'Current Date Patient Registered'**
  String get dashCurrentDatePatientRegistered;

  /// No description provided for @dashDateWisePatientRegistered.
  ///
  /// In en, this message translates to:
  /// **'Date Wise Patient Registered Count'**
  String get dashDateWisePatientRegistered;

  /// No description provided for @dashCurrentDateAbhaRegistration.
  ///
  /// In en, this message translates to:
  /// **'Current Date ABHA Registration'**
  String get dashCurrentDateAbhaRegistration;

  /// No description provided for @dashDateWiseAbhaPatient.
  ///
  /// In en, this message translates to:
  /// **'Date Wise ABHA Patient Count'**
  String get dashDateWiseAbhaPatient;

  /// No description provided for @dashCurrentDateDialysisSession.
  ///
  /// In en, this message translates to:
  /// **'Current Date Dialysis Session'**
  String get dashCurrentDateDialysisSession;

  /// No description provided for @dashDateWiseDialysisSession.
  ///
  /// In en, this message translates to:
  /// **'Date Wise Dialysis Session Count'**
  String get dashDateWiseDialysisSession;

  /// No description provided for @dashCurrentDateDialysisCancelled.
  ///
  /// In en, this message translates to:
  /// **'Current Date Dialysis Cancelled'**
  String get dashCurrentDateDialysisCancelled;

  /// No description provided for @dashDateWiseDialysisCancel.
  ///
  /// In en, this message translates to:
  /// **'Date Wise Dialysis Cancel Count'**
  String get dashDateWiseDialysisCancel;

  /// No description provided for @dashCurrentDateLabTest.
  ///
  /// In en, this message translates to:
  /// **'Current Date Laboratory Test Assigned'**
  String get dashCurrentDateLabTest;

  /// No description provided for @dashDateWiseTestAssign.
  ///
  /// In en, this message translates to:
  /// **'Date Wise Test Assign Count'**
  String get dashDateWiseTestAssign;

  /// No description provided for @dashCurrentDateAdverseEvent.
  ///
  /// In en, this message translates to:
  /// **'Current Date Adverse Event'**
  String get dashCurrentDateAdverseEvent;

  /// No description provided for @dashDateWiseAdverseEvent.
  ///
  /// In en, this message translates to:
  /// **'Date Wise Adverse Event Count'**
  String get dashDateWiseAdverseEvent;

  /// No description provided for @dashCurrentDateFeedback.
  ///
  /// In en, this message translates to:
  /// **'Current Date Feedback'**
  String get dashCurrentDateFeedback;

  /// No description provided for @dashMisDashboard.
  ///
  /// In en, this message translates to:
  /// **'MIS Dashboard'**
  String get dashMisDashboard;

  /// No description provided for @misFunctionalInstitute.
  ///
  /// In en, this message translates to:
  /// **'Functional Institute'**
  String get misFunctionalInstitute;

  /// No description provided for @misNumberOfPatients.
  ///
  /// In en, this message translates to:
  /// **'Number of Patients'**
  String get misNumberOfPatients;

  /// No description provided for @misDialysisUnderMjpjay.
  ///
  /// In en, this message translates to:
  /// **'Dialysis Treatment Under MJPJAY'**
  String get misDialysisUnderMjpjay;

  /// No description provided for @misDialysisUnderNonMjpjay.
  ///
  /// In en, this message translates to:
  /// **'Dialysis Treatment Under Non MJPJAY'**
  String get misDialysisUnderNonMjpjay;

  /// No description provided for @misSeroPositive.
  ///
  /// In en, this message translates to:
  /// **'Sero Positive Patients'**
  String get misSeroPositive;

  /// No description provided for @misSeroNegative.
  ///
  /// In en, this message translates to:
  /// **'Sero Negative Patients'**
  String get misSeroNegative;

  /// No description provided for @misLabTestsSentToMahaLabs.
  ///
  /// In en, this message translates to:
  /// **'Number of Laboratory Test sent to MAHA LABS'**
  String get misLabTestsSentToMahaLabs;

  /// No description provided for @dashTotalDialysis.
  ///
  /// In en, this message translates to:
  /// **'Total Dialysis'**
  String get dashTotalDialysis;

  /// No description provided for @dashPatientVerification.
  ///
  /// In en, this message translates to:
  /// **'Patient Verification'**
  String get dashPatientVerification;

  /// No description provided for @dashTotalEventOccurred.
  ///
  /// In en, this message translates to:
  /// **'Total Event Occurred'**
  String get dashTotalEventOccurred;

  /// No description provided for @dashTotalActiveMachines.
  ///
  /// In en, this message translates to:
  /// **'Total Active Machines'**
  String get dashTotalActiveMachines;

  /// No description provided for @dashTotalOnlineTickets.
  ///
  /// In en, this message translates to:
  /// **'Total Online Tickets'**
  String get dashTotalOnlineTickets;

  /// No description provided for @scrutinyApproval.
  ///
  /// In en, this message translates to:
  /// **'Scrutiny Approval'**
  String get scrutinyApproval;

  /// No description provided for @commonSearchBy.
  ///
  /// In en, this message translates to:
  /// **'Search By'**
  String get commonSearchBy;

  /// No description provided for @searchHintAppNoDateIdName.
  ///
  /// In en, this message translates to:
  /// **'Application no, date, patient id, name'**
  String get searchHintAppNoDateIdName;

  /// No description provided for @commonNoDataFoundDescription.
  ///
  /// In en, this message translates to:
  /// **'We are unable to find the data you are looking for.'**
  String get commonNoDataFoundDescription;

  /// No description provided for @patientDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Patient Details'**
  String get patientDetailsTitle;

  /// No description provided for @viewApplication.
  ///
  /// In en, this message translates to:
  /// **'View Application'**
  String get viewApplication;

  /// No description provided for @tabApplicationDetails.
  ///
  /// In en, this message translates to:
  /// **'Application Details'**
  String get tabApplicationDetails;

  /// No description provided for @tabServiceDescription.
  ///
  /// In en, this message translates to:
  /// **'Service Description'**
  String get tabServiceDescription;

  /// No description provided for @colApplicationNo.
  ///
  /// In en, this message translates to:
  /// **'Application No'**
  String get colApplicationNo;

  /// No description provided for @colApplicationDate.
  ///
  /// In en, this message translates to:
  /// **'Application Date'**
  String get colApplicationDate;

  /// No description provided for @colApplicationNumber.
  ///
  /// In en, this message translates to:
  /// **'Application Number'**
  String get colApplicationNumber;

  /// No description provided for @colApplicantName.
  ///
  /// In en, this message translates to:
  /// **'Applicant Name'**
  String get colApplicantName;

  /// No description provided for @colServiceName.
  ///
  /// In en, this message translates to:
  /// **'Service Name'**
  String get colServiceName;

  /// No description provided for @colBloodGroup.
  ///
  /// In en, this message translates to:
  /// **'Blood Group'**
  String get colBloodGroup;

  /// No description provided for @colHeight.
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get colHeight;

  /// No description provided for @colWeight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get colWeight;

  /// No description provided for @colDateOfRegistration.
  ///
  /// In en, this message translates to:
  /// **'Date Of Registration'**
  String get colDateOfRegistration;

  /// No description provided for @colNephrologistName.
  ///
  /// In en, this message translates to:
  /// **'Nephrologist Name'**
  String get colNephrologistName;

  /// No description provided for @colRelativeName.
  ///
  /// In en, this message translates to:
  /// **'Relative Name'**
  String get colRelativeName;

  /// No description provided for @colRelativeContact.
  ///
  /// In en, this message translates to:
  /// **'Relative Contact'**
  String get colRelativeContact;

  /// No description provided for @colAbhaNumber.
  ///
  /// In en, this message translates to:
  /// **'ABHA Number'**
  String get colAbhaNumber;

  /// No description provided for @colTreatmentUnderScheme.
  ///
  /// In en, this message translates to:
  /// **'Treatment Under Scheme'**
  String get colTreatmentUnderScheme;

  /// No description provided for @nephroOngoingDialysisSession.
  ///
  /// In en, this message translates to:
  /// **'Ongoing Dialysis Session'**
  String get nephroOngoingDialysisSession;

  /// No description provided for @nephroAnswer.
  ///
  /// In en, this message translates to:
  /// **'Answer'**
  String get nephroAnswer;

  /// No description provided for @nephroAction.
  ///
  /// In en, this message translates to:
  /// **'Action'**
  String get nephroAction;

  /// No description provided for @nephroDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get nephroDescription;

  /// No description provided for @nephroRemark.
  ///
  /// In en, this message translates to:
  /// **'Remark'**
  String get nephroRemark;

  /// No description provided for @nephroEnterHint.
  ///
  /// In en, this message translates to:
  /// **'Enter'**
  String get nephroEnterHint;

  /// No description provided for @nephroApprove.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get nephroApprove;

  /// No description provided for @nephroReject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get nephroReject;

  /// No description provided for @nephroSendBack.
  ///
  /// In en, this message translates to:
  /// **'Send Back'**
  String get nephroSendBack;

  /// No description provided for @nephroLevel1.
  ///
  /// In en, this message translates to:
  /// **'Level 1'**
  String get nephroLevel1;

  /// No description provided for @nephroLevel2.
  ///
  /// In en, this message translates to:
  /// **'Level 2'**
  String get nephroLevel2;

  /// No description provided for @nephroFillMandatory.
  ///
  /// In en, this message translates to:
  /// **'Please fill mandatory field'**
  String get nephroFillMandatory;

  /// No description provided for @chartMjpjayCounts.
  ///
  /// In en, this message translates to:
  /// **'MJPJAY Counts'**
  String get chartMjpjayCounts;

  /// No description provided for @chartNonMjpjayCounts.
  ///
  /// In en, this message translates to:
  /// **'Non-MJPJAY Counts'**
  String get chartNonMjpjayCounts;

  /// No description provided for @commonInfo.
  ///
  /// In en, this message translates to:
  /// **'Info'**
  String get commonInfo;

  /// No description provided for @commonDocument.
  ///
  /// In en, this message translates to:
  /// **'Document'**
  String get commonDocument;

  /// No description provided for @regNewRegistration.
  ///
  /// In en, this message translates to:
  /// **'New Registration'**
  String get regNewRegistration;

  /// No description provided for @regEditPatientDetails.
  ///
  /// In en, this message translates to:
  /// **'Edit Patient Details'**
  String get regEditPatientDetails;

  /// No description provided for @regViewPatientDetails.
  ///
  /// In en, this message translates to:
  /// **'View Patient Details'**
  String get regViewPatientDetails;

  /// No description provided for @tabPersonalInfo.
  ///
  /// In en, this message translates to:
  /// **'Personal Info'**
  String get tabPersonalInfo;

  /// No description provided for @tabDemographicInfo.
  ///
  /// In en, this message translates to:
  /// **'Demographic Info'**
  String get tabDemographicInfo;

  /// No description provided for @tabHistoryOfDialysis.
  ///
  /// In en, this message translates to:
  /// **'History Of Dialysis'**
  String get tabHistoryOfDialysis;

  /// No description provided for @tabUploadDocument.
  ///
  /// In en, this message translates to:
  /// **'Upload Document'**
  String get tabUploadDocument;

  /// No description provided for @regPatientInformation.
  ///
  /// In en, this message translates to:
  /// **'Patient Information'**
  String get regPatientInformation;

  /// No description provided for @regPermanentAddress.
  ///
  /// In en, this message translates to:
  /// **'Permanent Address'**
  String get regPermanentAddress;

  /// No description provided for @regResidentialAddress.
  ///
  /// In en, this message translates to:
  /// **'Residential Address'**
  String get regResidentialAddress;

  /// No description provided for @regSocioEcoStatus.
  ///
  /// In en, this message translates to:
  /// **'Socio-Eco Status'**
  String get regSocioEcoStatus;

  /// No description provided for @regEmergencyRelativeInfo.
  ///
  /// In en, this message translates to:
  /// **'Emergency Relative Info'**
  String get regEmergencyRelativeInfo;

  /// No description provided for @regSameAsResidential.
  ///
  /// In en, this message translates to:
  /// **'Per. Address Is Same As Res. Address'**
  String get regSameAsResidential;

  /// No description provided for @regFirstTimeDialysis.
  ///
  /// In en, this message translates to:
  /// **'First Time Dialysis?'**
  String get regFirstTimeDialysis;

  /// No description provided for @regPatientName.
  ///
  /// In en, this message translates to:
  /// **'Patient Name'**
  String get regPatientName;

  /// No description provided for @regPrefix.
  ///
  /// In en, this message translates to:
  /// **'Prefix'**
  String get regPrefix;

  /// No description provided for @regFirstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get regFirstName;

  /// No description provided for @regMiddleName.
  ///
  /// In en, this message translates to:
  /// **'Middle Name'**
  String get regMiddleName;

  /// No description provided for @regLastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get regLastName;

  /// No description provided for @regDob.
  ///
  /// In en, this message translates to:
  /// **'DOB'**
  String get regDob;

  /// No description provided for @regEmailId.
  ///
  /// In en, this message translates to:
  /// **'Email Id'**
  String get regEmailId;

  /// No description provided for @regContactNo.
  ///
  /// In en, this message translates to:
  /// **'Contact No'**
  String get regContactNo;

  /// No description provided for @regContactNumber.
  ///
  /// In en, this message translates to:
  /// **'Contact Number'**
  String get regContactNumber;

  /// No description provided for @regHeightFt.
  ///
  /// In en, this message translates to:
  /// **'Height (In Ft.)'**
  String get regHeightFt;

  /// No description provided for @regHeightCm.
  ///
  /// In en, this message translates to:
  /// **'Height (In cm.)'**
  String get regHeightCm;

  /// No description provided for @regWeight.
  ///
  /// In en, this message translates to:
  /// **'Weight (Kg-Grams)'**
  String get regWeight;

  /// No description provided for @regMaritalStatus.
  ///
  /// In en, this message translates to:
  /// **'Marital Status'**
  String get regMaritalStatus;

  /// No description provided for @regReligion.
  ///
  /// In en, this message translates to:
  /// **'Religion'**
  String get regReligion;

  /// No description provided for @regEducation.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get regEducation;

  /// No description provided for @regOccupation.
  ///
  /// In en, this message translates to:
  /// **'Occupation'**
  String get regOccupation;

  /// No description provided for @regMonthlyIncome.
  ///
  /// In en, this message translates to:
  /// **'Monthly Income'**
  String get regMonthlyIncome;

  /// No description provided for @regNationality.
  ///
  /// In en, this message translates to:
  /// **'Nationality'**
  String get regNationality;

  /// No description provided for @regCountry.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get regCountry;

  /// No description provided for @regAbhaId.
  ///
  /// In en, this message translates to:
  /// **'ABHA ID'**
  String get regAbhaId;

  /// No description provided for @regAbhaNo.
  ///
  /// In en, this message translates to:
  /// **'ABHA NO'**
  String get regAbhaNo;

  /// No description provided for @regAbhaAddress.
  ///
  /// In en, this message translates to:
  /// **'ABHA Address'**
  String get regAbhaAddress;

  /// No description provided for @regIdProof.
  ///
  /// In en, this message translates to:
  /// **'Id Proof'**
  String get regIdProof;

  /// No description provided for @regIdentificationNumber.
  ///
  /// In en, this message translates to:
  /// **'Identification Number'**
  String get regIdentificationNumber;

  /// No description provided for @regSchemeAdopted.
  ///
  /// In en, this message translates to:
  /// **'Scheme Adopted'**
  String get regSchemeAdopted;

  /// No description provided for @regMjpjayEnrollmentNo.
  ///
  /// In en, this message translates to:
  /// **'MJPJAY Enrollment No'**
  String get regMjpjayEnrollmentNo;

  /// No description provided for @regViralMarkerStatus.
  ///
  /// In en, this message translates to:
  /// **'Viral Marker Status'**
  String get regViralMarkerStatus;

  /// No description provided for @regAddress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get regAddress;

  /// No description provided for @regPinCode.
  ///
  /// In en, this message translates to:
  /// **'Pin Code'**
  String get regPinCode;

  /// No description provided for @regState.
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get regState;

  /// No description provided for @regDistrict.
  ///
  /// In en, this message translates to:
  /// **'District'**
  String get regDistrict;

  /// No description provided for @regDivision.
  ///
  /// In en, this message translates to:
  /// **'Division'**
  String get regDivision;

  /// No description provided for @regTaluka.
  ///
  /// In en, this message translates to:
  /// **'Taluka'**
  String get regTaluka;

  /// No description provided for @regTown.
  ///
  /// In en, this message translates to:
  /// **'Town'**
  String get regTown;

  /// No description provided for @regReferredBy.
  ///
  /// In en, this message translates to:
  /// **'Referred By'**
  String get regReferredBy;

  /// No description provided for @regReferenceByName.
  ///
  /// In en, this message translates to:
  /// **'Reference By Name'**
  String get regReferenceByName;

  /// No description provided for @regReferredContactNumber.
  ///
  /// In en, this message translates to:
  /// **'Referred Contact Number'**
  String get regReferredContactNumber;

  /// No description provided for @regNephrologistName.
  ///
  /// In en, this message translates to:
  /// **'Nephrologist Name'**
  String get regNephrologistName;

  /// No description provided for @regNephrologistContactNo.
  ///
  /// In en, this message translates to:
  /// **'Nephrologist Contact No'**
  String get regNephrologistContactNo;

  /// No description provided for @regRelation.
  ///
  /// In en, this message translates to:
  /// **'Relation'**
  String get regRelation;

  /// No description provided for @regRelativeName.
  ///
  /// In en, this message translates to:
  /// **'Relative Name'**
  String get regRelativeName;

  /// No description provided for @regDialysisMode.
  ///
  /// In en, this message translates to:
  /// **'Dialysis Mode'**
  String get regDialysisMode;

  /// No description provided for @regDialysisFreqWeek.
  ///
  /// In en, this message translates to:
  /// **'Dialysis Frequency in Week'**
  String get regDialysisFreqWeek;

  /// No description provided for @regFirstDialysisSessionDate.
  ///
  /// In en, this message translates to:
  /// **'First Dialysis Session Date'**
  String get regFirstDialysisSessionDate;

  /// No description provided for @regLastDialysisSessionDate.
  ///
  /// In en, this message translates to:
  /// **'Last Dialysis Session Date'**
  String get regLastDialysisSessionDate;

  /// No description provided for @regLastDialysisHospitalName.
  ///
  /// In en, this message translates to:
  /// **'Last Dialysis Hospital Name'**
  String get regLastDialysisHospitalName;

  /// No description provided for @regHintSelect.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get regHintSelect;

  /// No description provided for @regHintSelectTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Title'**
  String get regHintSelectTitle;

  /// No description provided for @regHintEnter.
  ///
  /// In en, this message translates to:
  /// **'Enter'**
  String get regHintEnter;

  /// No description provided for @regHintEnterName.
  ///
  /// In en, this message translates to:
  /// **'Enter name'**
  String get regHintEnterName;

  /// No description provided for @regHintEnterFirstName.
  ///
  /// In en, this message translates to:
  /// **'Enter first name'**
  String get regHintEnterFirstName;

  /// No description provided for @regHintEnterMiddleName.
  ///
  /// In en, this message translates to:
  /// **'Enter middle name'**
  String get regHintEnterMiddleName;

  /// No description provided for @regHintEnterLastName.
  ///
  /// In en, this message translates to:
  /// **'Enter last name'**
  String get regHintEnterLastName;

  /// No description provided for @regHintEnterAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter address'**
  String get regHintEnterAddress;

  /// No description provided for @regHintEnterPinCode.
  ///
  /// In en, this message translates to:
  /// **'Enter pin code'**
  String get regHintEnterPinCode;

  /// No description provided for @regHintEnterContactNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter contact number'**
  String get regHintEnterContactNumber;

  /// No description provided for @regHintEnterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter Email address'**
  String get regHintEnterEmail;

  /// No description provided for @regHintEnterNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter number'**
  String get regHintEnterNumber;

  /// No description provided for @regHintFeetInches.
  ///
  /// In en, this message translates to:
  /// **'Enter In Feet and Inches'**
  String get regHintFeetInches;

  /// No description provided for @regUploadDocument.
  ///
  /// In en, this message translates to:
  /// **'Upload Document'**
  String get regUploadDocument;

  /// No description provided for @regBrowseChooseFiles.
  ///
  /// In en, this message translates to:
  /// **'Browse and choose the files you want to upload'**
  String get regBrowseChooseFiles;

  /// No description provided for @regMaxFileSize.
  ///
  /// In en, this message translates to:
  /// **'Max File Size : 10 MB'**
  String get regMaxFileSize;

  /// No description provided for @regSupportedFormats.
  ///
  /// In en, this message translates to:
  /// **'Supported Formats : JPEG, PNG, PDF'**
  String get regSupportedFormats;

  /// No description provided for @regSaveNext.
  ///
  /// In en, this message translates to:
  /// **'Save & Next'**
  String get regSaveNext;

  /// No description provided for @regCompleteDemographicFirst.
  ///
  /// In en, this message translates to:
  /// **'Please complete Demographic Information first'**
  String get regCompleteDemographicFirst;

  /// No description provided for @regCompleteHistoryFirst.
  ///
  /// In en, this message translates to:
  /// **'Please complete History of Dialysis first'**
  String get regCompleteHistoryFirst;

  /// No description provided for @regCompletePersonalFirst.
  ///
  /// In en, this message translates to:
  /// **'Please complete Personal Information first'**
  String get regCompletePersonalFirst;

  /// No description provided for @regFillMandatory.
  ///
  /// In en, this message translates to:
  /// **'Please fill mandatory details'**
  String get regFillMandatory;

  /// No description provided for @regSelectDocument.
  ///
  /// In en, this message translates to:
  /// **'Please select document'**
  String get regSelectDocument;

  /// No description provided for @regUploadRequiredDocuments.
  ///
  /// In en, this message translates to:
  /// **'Please upload Required Documents'**
  String get regUploadRequiredDocuments;

  /// No description provided for @regUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Updated Successfully'**
  String get regUpdatedSuccessfully;

  /// No description provided for @regMobileExists.
  ///
  /// In en, this message translates to:
  /// **'Mobile number already exists'**
  String get regMobileExists;

  /// No description provided for @regUploadFailed.
  ///
  /// In en, this message translates to:
  /// **'Upload failed'**
  String get regUploadFailed;

  /// No description provided for @regUploadPhotoSize.
  ///
  /// In en, this message translates to:
  /// **'Upload photo below 500KB'**
  String get regUploadPhotoSize;

  /// No description provided for @regPleaseNotePatientId.
  ///
  /// In en, this message translates to:
  /// **'Please note Patient Id {id}'**
  String regPleaseNotePatientId(String id);

  /// No description provided for @regPrintReport.
  ///
  /// In en, this message translates to:
  /// **'Print Report?'**
  String get regPrintReport;

  /// No description provided for @regRegistrationCompleted.
  ///
  /// In en, this message translates to:
  /// **'Registration Completed Successfully'**
  String get regRegistrationCompleted;

  /// No description provided for @regRegisteredPatients.
  ///
  /// In en, this message translates to:
  /// **'Registered Patients'**
  String get regRegisteredPatients;

  /// No description provided for @regSelectScheme.
  ///
  /// In en, this message translates to:
  /// **'Select Scheme'**
  String get regSelectScheme;

  /// No description provided for @regSearchPatientHint.
  ///
  /// In en, this message translates to:
  /// **'Patient Id, name, mobile no etc.'**
  String get regSearchPatientHint;

  /// No description provided for @regDialysisCenter.
  ///
  /// In en, this message translates to:
  /// **'Dialysis Center'**
  String get regDialysisCenter;

  /// No description provided for @regPatientAge.
  ///
  /// In en, this message translates to:
  /// **'Patient Age'**
  String get regPatientAge;

  /// No description provided for @patientCardRefBy.
  ///
  /// In en, this message translates to:
  /// **'Ref. By'**
  String get patientCardRefBy;

  /// No description provided for @commonValue.
  ///
  /// In en, this message translates to:
  /// **'Value'**
  String get commonValue;

  /// No description provided for @commonPrint.
  ///
  /// In en, this message translates to:
  /// **'Print'**
  String get commonPrint;

  /// No description provided for @commonProcessing.
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get commonProcessing;

  /// No description provided for @commonStart.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get commonStart;

  /// No description provided for @patientCardDob.
  ///
  /// In en, this message translates to:
  /// **'Date Of Birth'**
  String get patientCardDob;

  /// No description provided for @schedAddSchedular.
  ///
  /// In en, this message translates to:
  /// **'Add Dialysis Scheduler'**
  String get schedAddSchedular;

  /// No description provided for @schedBookAppointment.
  ///
  /// In en, this message translates to:
  /// **'Book Appointment'**
  String get schedBookAppointment;

  /// No description provided for @schedVisitorEntry.
  ///
  /// In en, this message translates to:
  /// **'Visitor Entry'**
  String get schedVisitorEntry;

  /// No description provided for @schedPatientHistory.
  ///
  /// In en, this message translates to:
  /// **'Patient History'**
  String get schedPatientHistory;

  /// No description provided for @schedDialysisScheduleChart.
  ///
  /// In en, this message translates to:
  /// **'Dialysis Schedule Chart'**
  String get schedDialysisScheduleChart;

  /// No description provided for @schedDialysisPatientList.
  ///
  /// In en, this message translates to:
  /// **'Dialysis Patient List'**
  String get schedDialysisPatientList;

  /// No description provided for @schedCaseHistory.
  ///
  /// In en, this message translates to:
  /// **'Case History'**
  String get schedCaseHistory;

  /// No description provided for @schedDialysisDetails.
  ///
  /// In en, this message translates to:
  /// **'Dialysis Details'**
  String get schedDialysisDetails;

  /// No description provided for @schedPatientDocuments.
  ///
  /// In en, this message translates to:
  /// **'Patient Documents'**
  String get schedPatientDocuments;

  /// No description provided for @schedSearchPatient.
  ///
  /// In en, this message translates to:
  /// **'Search Patient'**
  String get schedSearchPatient;

  /// No description provided for @schedSlot.
  ///
  /// In en, this message translates to:
  /// **'Slot'**
  String get schedSlot;

  /// No description provided for @schedSlotTime.
  ///
  /// In en, this message translates to:
  /// **'Slot Time'**
  String get schedSlotTime;

  /// No description provided for @schedBedsAllocated.
  ///
  /// In en, this message translates to:
  /// **'Beds Allocated'**
  String get schedBedsAllocated;

  /// No description provided for @schedBedNo.
  ///
  /// In en, this message translates to:
  /// **'Bed No.'**
  String get schedBedNo;

  /// No description provided for @schedMachineName.
  ///
  /// In en, this message translates to:
  /// **'Machine Name'**
  String get schedMachineName;

  /// No description provided for @schedAppointmentDate.
  ///
  /// In en, this message translates to:
  /// **'Appointment Date'**
  String get schedAppointmentDate;

  /// No description provided for @schedVisitDate.
  ///
  /// In en, this message translates to:
  /// **'Visit Date'**
  String get schedVisitDate;

  /// No description provided for @schedVisitTime.
  ///
  /// In en, this message translates to:
  /// **'Visit Time'**
  String get schedVisitTime;

  /// No description provided for @schedIpNumber.
  ///
  /// In en, this message translates to:
  /// **'IP Number'**
  String get schedIpNumber;

  /// No description provided for @schedMjpjayCaseNumber.
  ///
  /// In en, this message translates to:
  /// **'MJPJAY Case Number'**
  String get schedMjpjayCaseNumber;

  /// No description provided for @schedMjpjayClaimNumber.
  ///
  /// In en, this message translates to:
  /// **'MJPJAY Claim Number'**
  String get schedMjpjayClaimNumber;

  /// No description provided for @schedMjpjayEnrollmentId.
  ///
  /// In en, this message translates to:
  /// **'MJPJAY Enrollment Id'**
  String get schedMjpjayEnrollmentId;

  /// No description provided for @schedPreAuthApprovalDate.
  ///
  /// In en, this message translates to:
  /// **'Pre Auth Approval Date'**
  String get schedPreAuthApprovalDate;

  /// No description provided for @schedPreAuthNumber.
  ///
  /// In en, this message translates to:
  /// **'Pre Auth Number'**
  String get schedPreAuthNumber;

  /// No description provided for @schedDocumentName.
  ///
  /// In en, this message translates to:
  /// **'Document Name:'**
  String get schedDocumentName;

  /// No description provided for @schedNoDocuments.
  ///
  /// In en, this message translates to:
  /// **'No documents available'**
  String get schedNoDocuments;

  /// No description provided for @schedDataSaved.
  ///
  /// In en, this message translates to:
  /// **'Data Saved Successfully'**
  String get schedDataSaved;

  /// No description provided for @schedDataSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Data Save Failed'**
  String get schedDataSaveFailed;

  /// No description provided for @schedDischargeSummary.
  ///
  /// In en, this message translates to:
  /// **'Discharge Summary'**
  String get schedDischargeSummary;

  /// No description provided for @schedSessionEndReport.
  ///
  /// In en, this message translates to:
  /// **'Session End Report'**
  String get schedSessionEndReport;

  /// No description provided for @schedHbsagPositive.
  ///
  /// In en, this message translates to:
  /// **'HBsAg Positive'**
  String get schedHbsagPositive;

  /// No description provided for @schedHcvPositive.
  ///
  /// In en, this message translates to:
  /// **'HCV Positive'**
  String get schedHcvPositive;

  /// No description provided for @schedHivPositive.
  ///
  /// In en, this message translates to:
  /// **'HIV Positive'**
  String get schedHivPositive;

  /// No description provided for @schedHhhNegative.
  ///
  /// In en, this message translates to:
  /// **'HHH Negative'**
  String get schedHhhNegative;

  /// No description provided for @clinAccessSite.
  ///
  /// In en, this message translates to:
  /// **'Access Site'**
  String get clinAccessSite;

  /// No description provided for @clinActualFbv.
  ///
  /// In en, this message translates to:
  /// **'Actual FBV'**
  String get clinActualFbv;

  /// No description provided for @clinBloodPressure.
  ///
  /// In en, this message translates to:
  /// **'Blood Pressure'**
  String get clinBloodPressure;

  /// No description provided for @clinBloodTubingBarcode.
  ///
  /// In en, this message translates to:
  /// **'Blood Tubing Barcode No./Sr. No'**
  String get clinBloodTubingBarcode;

  /// No description provided for @clinBloodTubingReuseNo.
  ///
  /// In en, this message translates to:
  /// **'Blood Tubing Reuse No'**
  String get clinBloodTubingReuseNo;

  /// No description provided for @clinCaseNarration.
  ///
  /// In en, this message translates to:
  /// **'Case Narration'**
  String get clinCaseNarration;

  /// No description provided for @clinDialyserType.
  ///
  /// In en, this message translates to:
  /// **'Dialyser Type'**
  String get clinDialyserType;

  /// No description provided for @clinDialyzerType.
  ///
  /// In en, this message translates to:
  /// **'Dialyzer Type'**
  String get clinDialyzerType;

  /// No description provided for @clinDialysisDuration.
  ///
  /// In en, this message translates to:
  /// **'Dialysis Duration'**
  String get clinDialysisDuration;

  /// No description provided for @clinDialysisStartDateTime.
  ///
  /// In en, this message translates to:
  /// **'Dialysis Start Date and Time'**
  String get clinDialysisStartDateTime;

  /// No description provided for @clinDialysisStopDateTime.
  ///
  /// In en, this message translates to:
  /// **'Dialysis Stop Date and Time'**
  String get clinDialysisStopDateTime;

  /// No description provided for @clinDialysisType.
  ///
  /// In en, this message translates to:
  /// **'Dialysis Type'**
  String get clinDialysisType;

  /// No description provided for @clinDialyzerBarcode.
  ///
  /// In en, this message translates to:
  /// **'Dialyzer Barcode No./Sr. No'**
  String get clinDialyzerBarcode;

  /// No description provided for @clinDialyzerDiscarded.
  ///
  /// In en, this message translates to:
  /// **'Dialyzer Discarded'**
  String get clinDialyzerDiscarded;

  /// No description provided for @clinDialyzerRemark.
  ///
  /// In en, this message translates to:
  /// **'Dialyzer Remark'**
  String get clinDialyzerRemark;

  /// No description provided for @clinDialyzerReuseNo.
  ///
  /// In en, this message translates to:
  /// **'Dialyzer Reuse No'**
  String get clinDialyzerReuseNo;

  /// No description provided for @clinDryWeight.
  ///
  /// In en, this message translates to:
  /// **'Dry Weight'**
  String get clinDryWeight;

  /// No description provided for @clinHeparin.
  ///
  /// In en, this message translates to:
  /// **'Heparin'**
  String get clinHeparin;

  /// No description provided for @clinInterdialyticGain.
  ///
  /// In en, this message translates to:
  /// **'Interdialytic Gain'**
  String get clinInterdialyticGain;

  /// No description provided for @clinOxygenLevel.
  ///
  /// In en, this message translates to:
  /// **'Oxygen Level'**
  String get clinOxygenLevel;

  /// No description provided for @clinPostDialysisInjection.
  ///
  /// In en, this message translates to:
  /// **'Post Dialysis Injection/Medicine'**
  String get clinPostDialysisInjection;

  /// No description provided for @clinPostDialysisInvestigation.
  ///
  /// In en, this message translates to:
  /// **'Post Dialysis Investigation'**
  String get clinPostDialysisInvestigation;

  /// No description provided for @clinPostDialysisWeight.
  ///
  /// In en, this message translates to:
  /// **'Post Dialysis Weight'**
  String get clinPostDialysisWeight;

  /// No description provided for @clinPreDialysisInvestigation.
  ///
  /// In en, this message translates to:
  /// **'Pre Dialysis Investigation'**
  String get clinPreDialysisInvestigation;

  /// No description provided for @clinPreDialysisVitals.
  ///
  /// In en, this message translates to:
  /// **'Pre Dialysis Vitals'**
  String get clinPreDialysisVitals;

  /// No description provided for @clinPreDialysisWeight.
  ///
  /// In en, this message translates to:
  /// **'Pre Dialysis Weight'**
  String get clinPreDialysisWeight;

  /// No description provided for @clinPreHdCondition.
  ///
  /// In en, this message translates to:
  /// **'Pre HD Condition'**
  String get clinPreHdCondition;

  /// No description provided for @clinPulse.
  ///
  /// In en, this message translates to:
  /// **'Pulse'**
  String get clinPulse;

  /// No description provided for @clinRespiratoryRate.
  ///
  /// In en, this message translates to:
  /// **'Respiratory Rate'**
  String get clinRespiratoryRate;

  /// No description provided for @clinSpecialDialysis.
  ///
  /// In en, this message translates to:
  /// **'Special Dialysis'**
  String get clinSpecialDialysis;

  /// No description provided for @clinTemperature.
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get clinTemperature;

  /// No description provided for @clinBloodTubingRemark.
  ///
  /// In en, this message translates to:
  /// **'Blood Tubing Remark'**
  String get clinBloodTubingRemark;

  /// No description provided for @clinCurrentSessionWeightDiff.
  ///
  /// In en, this message translates to:
  /// **'Current Dialysis Session Weight Difference'**
  String get clinCurrentSessionWeightDiff;

  /// No description provided for @clinKtv.
  ///
  /// In en, this message translates to:
  /// **'kt/v'**
  String get clinKtv;

  /// No description provided for @clinUfAchieved.
  ///
  /// In en, this message translates to:
  /// **'UF Achieved'**
  String get clinUfAchieved;

  /// No description provided for @clinUfr.
  ///
  /// In en, this message translates to:
  /// **'UFR'**
  String get clinUfr;

  /// No description provided for @clinTmp.
  ///
  /// In en, this message translates to:
  /// **'TMP'**
  String get clinTmp;

  /// No description provided for @clinVp.
  ///
  /// In en, this message translates to:
  /// **'VP'**
  String get clinVp;

  /// No description provided for @clinAp.
  ///
  /// In en, this message translates to:
  /// **'AP'**
  String get clinAp;

  /// No description provided for @clinBfr.
  ///
  /// In en, this message translates to:
  /// **'BFR'**
  String get clinBfr;

  /// No description provided for @clinCbv.
  ///
  /// In en, this message translates to:
  /// **'CBV'**
  String get clinCbv;

  /// No description provided for @clinCond.
  ///
  /// In en, this message translates to:
  /// **'Cond'**
  String get clinCond;

  /// No description provided for @clinTsat.
  ///
  /// In en, this message translates to:
  /// **'TSAT (%)'**
  String get clinTsat;

  /// No description provided for @clinEpoDose.
  ///
  /// In en, this message translates to:
  /// **'EPO Dose'**
  String get clinEpoDose;

  /// No description provided for @clinEpoAdministered.
  ///
  /// In en, this message translates to:
  /// **'EPO Administered'**
  String get clinEpoAdministered;

  /// No description provided for @clinBolusDose.
  ///
  /// In en, this message translates to:
  /// **'Bolus Dose'**
  String get clinBolusDose;

  /// No description provided for @clinInfusionDose.
  ///
  /// In en, this message translates to:
  /// **'Infusion Dose'**
  String get clinInfusionDose;

  /// No description provided for @clinBpMmhg.
  ///
  /// In en, this message translates to:
  /// **'BP(mmHg)'**
  String get clinBpMmhg;

  /// No description provided for @clinBloodPressureMmhg.
  ///
  /// In en, this message translates to:
  /// **'Blood Pressure\n(mmHg)'**
  String get clinBloodPressureMmhg;

  /// No description provided for @clinPreDialysisDate.
  ///
  /// In en, this message translates to:
  /// **'Pre Dialysis Date'**
  String get clinPreDialysisDate;

  /// No description provided for @clinDiscardedRemarks.
  ///
  /// In en, this message translates to:
  /// **'Discarded Remarks'**
  String get clinDiscardedRemarks;

  /// No description provided for @clinNewDialyzer.
  ///
  /// In en, this message translates to:
  /// **'New Dialyzer'**
  String get clinNewDialyzer;

  /// No description provided for @dqHdChart.
  ///
  /// In en, this message translates to:
  /// **'HD Chart'**
  String get dqHdChart;

  /// No description provided for @dqHdChartList.
  ///
  /// In en, this message translates to:
  /// **'HD Chart List'**
  String get dqHdChartList;

  /// No description provided for @dqPreDialysisDetails.
  ///
  /// In en, this message translates to:
  /// **'Pre Dialysis Details'**
  String get dqPreDialysisDetails;

  /// No description provided for @dqPostDialysisDetails.
  ///
  /// In en, this message translates to:
  /// **'Post Dialysis Details'**
  String get dqPostDialysisDetails;

  /// No description provided for @dqEditPreDialysisDetails.
  ///
  /// In en, this message translates to:
  /// **'Edit Pre Dialysis Details'**
  String get dqEditPreDialysisDetails;

  /// No description provided for @dqPreDialysisPatientList.
  ///
  /// In en, this message translates to:
  /// **'Pre Dialysis Patient List'**
  String get dqPreDialysisPatientList;

  /// No description provided for @dqPostDialysisPatientList.
  ///
  /// In en, this message translates to:
  /// **'Post Dialysis Patient List'**
  String get dqPostDialysisPatientList;

  /// No description provided for @dqDialysisEventDetails.
  ///
  /// In en, this message translates to:
  /// **'Dialysis Event Details'**
  String get dqDialysisEventDetails;

  /// No description provided for @dqEventQueuedPatientList.
  ///
  /// In en, this message translates to:
  /// **'Event Queued Patient List'**
  String get dqEventQueuedPatientList;

  /// No description provided for @dqInvestigationQueue.
  ///
  /// In en, this message translates to:
  /// **'Investigation Queue'**
  String get dqInvestigationQueue;

  /// No description provided for @dqAllTest.
  ///
  /// In en, this message translates to:
  /// **'All Test'**
  String get dqAllTest;

  /// No description provided for @dqTrendAnalysis.
  ///
  /// In en, this message translates to:
  /// **'Trend Analysis'**
  String get dqTrendAnalysis;

  /// No description provided for @dqWeightTrendAnalysis.
  ///
  /// In en, this message translates to:
  /// **'Weight Trend Analysis'**
  String get dqWeightTrendAnalysis;

  /// No description provided for @dqTemperatureTrendAnalysis.
  ///
  /// In en, this message translates to:
  /// **'Temperature Trend Analysis'**
  String get dqTemperatureTrendAnalysis;

  /// No description provided for @dqCoverSheet.
  ///
  /// In en, this message translates to:
  /// **'Cover Sheet'**
  String get dqCoverSheet;

  /// No description provided for @dqSafetyChecks.
  ///
  /// In en, this message translates to:
  /// **'Safety Checks'**
  String get dqSafetyChecks;

  /// No description provided for @dqClinicalHistory.
  ///
  /// In en, this message translates to:
  /// **'Clinical History'**
  String get dqClinicalHistory;

  /// No description provided for @dqClinicalCondition.
  ///
  /// In en, this message translates to:
  /// **'Clinical Condition'**
  String get dqClinicalCondition;

  /// No description provided for @dqDiagnosticInv.
  ///
  /// In en, this message translates to:
  /// **'Diagnostic Inv'**
  String get dqDiagnosticInv;

  /// No description provided for @dqDiet.
  ///
  /// In en, this message translates to:
  /// **'Diet'**
  String get dqDiet;

  /// No description provided for @dqDietDetails.
  ///
  /// In en, this message translates to:
  /// **'Diet Details'**
  String get dqDietDetails;

  /// No description provided for @dqInstruction.
  ///
  /// In en, this message translates to:
  /// **'Instruction'**
  String get dqInstruction;

  /// No description provided for @dqInstructionDetails.
  ///
  /// In en, this message translates to:
  /// **'Instruction Details'**
  String get dqInstructionDetails;

  /// No description provided for @dqPrescription.
  ///
  /// In en, this message translates to:
  /// **'Prescription'**
  String get dqPrescription;

  /// No description provided for @dqPrescriptionDetails.
  ///
  /// In en, this message translates to:
  /// **'Prescription Details'**
  String get dqPrescriptionDetails;

  /// No description provided for @dqLaboratoryInvestigation.
  ///
  /// In en, this message translates to:
  /// **'Laboratory Investigation'**
  String get dqLaboratoryInvestigation;

  /// No description provided for @dqPhysicalEntryConsumable.
  ///
  /// In en, this message translates to:
  /// **'Physical Entry of Consumable Used'**
  String get dqPhysicalEntryConsumable;

  /// No description provided for @dqAddEntryConsumable.
  ///
  /// In en, this message translates to:
  /// **'Add New Entry of Consumable Used'**
  String get dqAddEntryConsumable;

  /// No description provided for @dqHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get dqHistory;

  /// No description provided for @dqPrePostEventInvestigation.
  ///
  /// In en, this message translates to:
  /// **'Pre-Post-Event Investigation'**
  String get dqPrePostEventInvestigation;

  /// No description provided for @dqStartDialysis.
  ///
  /// In en, this message translates to:
  /// **'Start Dialysis'**
  String get dqStartDialysis;

  /// No description provided for @dqStopDialysis.
  ///
  /// In en, this message translates to:
  /// **'Stop Dialysis'**
  String get dqStopDialysis;

  /// No description provided for @dqAnalyze.
  ///
  /// In en, this message translates to:
  /// **'Analyze'**
  String get dqAnalyze;

  /// No description provided for @dqAddBarcodeNo.
  ///
  /// In en, this message translates to:
  /// **'Add Barcode No.'**
  String get dqAddBarcodeNo;

  /// No description provided for @dqInvalidInput.
  ///
  /// In en, this message translates to:
  /// **'Invalid Input'**
  String get dqInvalidInput;

  /// No description provided for @dqSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Save Failed'**
  String get dqSaveFailed;

  /// No description provided for @dqFailSaveMachineReading.
  ///
  /// In en, this message translates to:
  /// **'Failed to save machine reading'**
  String get dqFailSaveMachineReading;

  /// No description provided for @dqProductShouldNotSame.
  ///
  /// In en, this message translates to:
  /// **'Product should not be the same'**
  String get dqProductShouldNotSame;

  /// No description provided for @dqPreDialysisTab.
  ///
  /// In en, this message translates to:
  /// **'Pre-dialysis'**
  String get dqPreDialysisTab;

  /// No description provided for @dqPostDialysisTab.
  ///
  /// In en, this message translates to:
  /// **'Post-dialysis'**
  String get dqPostDialysisTab;

  /// No description provided for @dqActionTaken.
  ///
  /// In en, this message translates to:
  /// **'Action Taken'**
  String get dqActionTaken;

  /// No description provided for @dqAvailableQuantity.
  ///
  /// In en, this message translates to:
  /// **'Available Quantity'**
  String get dqAvailableQuantity;

  /// No description provided for @dqBarcodeNo.
  ///
  /// In en, this message translates to:
  /// **'Barcode No'**
  String get dqBarcodeNo;

  /// No description provided for @dqBatchNo.
  ///
  /// In en, this message translates to:
  /// **'Batch No'**
  String get dqBatchNo;

  /// No description provided for @dqConsumedQuantity.
  ///
  /// In en, this message translates to:
  /// **'Consumed Quantity'**
  String get dqConsumedQuantity;

  /// No description provided for @dqDialysisIncidentType.
  ///
  /// In en, this message translates to:
  /// **'Dialysis Incident Type'**
  String get dqDialysisIncidentType;

  /// No description provided for @dqDialysisIncidentSubType.
  ///
  /// In en, this message translates to:
  /// **'Dialysis Incident sub Type'**
  String get dqDialysisIncidentSubType;

  /// No description provided for @dqDuration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get dqDuration;

  /// No description provided for @dqEventDescription.
  ///
  /// In en, this message translates to:
  /// **'Event Description'**
  String get dqEventDescription;

  /// No description provided for @dqExpiryDate.
  ///
  /// In en, this message translates to:
  /// **'Expiry Date'**
  String get dqExpiryDate;

  /// No description provided for @dqOrderId.
  ///
  /// In en, this message translates to:
  /// **'Order Id'**
  String get dqOrderId;

  /// No description provided for @dqProductName.
  ///
  /// In en, this message translates to:
  /// **'Product Name'**
  String get dqProductName;

  /// No description provided for @dqQuantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get dqQuantity;

  /// No description provided for @dqTestId.
  ///
  /// In en, this message translates to:
  /// **'Test ID'**
  String get dqTestId;

  /// No description provided for @dqTestName.
  ///
  /// In en, this message translates to:
  /// **'Test Name'**
  String get dqTestName;

  /// No description provided for @dqCounter.
  ///
  /// In en, this message translates to:
  /// **'Counter'**
  String get dqCounter;

  /// No description provided for @commonActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get commonActive;

  /// No description provided for @commonComments.
  ///
  /// In en, this message translates to:
  /// **'Comments'**
  String get commonComments;

  /// No description provided for @commonReason.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get commonReason;

  /// No description provided for @commonQuantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get commonQuantity;

  /// No description provided for @commonDays.
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get commonDays;

  /// No description provided for @commonUnit.
  ///
  /// In en, this message translates to:
  /// **'Unit'**
  String get commonUnit;

  /// No description provided for @clinBloodGlucose.
  ///
  /// In en, this message translates to:
  /// **'Blood Glucose'**
  String get clinBloodGlucose;

  /// No description provided for @clinPastSurgicalHistory.
  ///
  /// In en, this message translates to:
  /// **'Past Surgical History'**
  String get clinPastSurgicalHistory;

  /// No description provided for @clinMedicationMethod.
  ///
  /// In en, this message translates to:
  /// **'Medication Method'**
  String get clinMedicationMethod;

  /// No description provided for @clinAlcoholConsumption.
  ///
  /// In en, this message translates to:
  /// **'Alcohol Consumption'**
  String get clinAlcoholConsumption;

  /// No description provided for @clinAlcoholCurrentStat.
  ///
  /// In en, this message translates to:
  /// **'Alcohol Current Stat'**
  String get clinAlcoholCurrentStat;

  /// No description provided for @clinAlcoholDuration.
  ///
  /// In en, this message translates to:
  /// **'Alcohol Duration'**
  String get clinAlcoholDuration;

  /// No description provided for @clinDrugCurrentStat.
  ///
  /// In en, this message translates to:
  /// **'Drug Current Stat'**
  String get clinDrugCurrentStat;

  /// No description provided for @clinDrugDuration.
  ///
  /// In en, this message translates to:
  /// **'Drug Duration'**
  String get clinDrugDuration;

  /// No description provided for @clinIllicitDrug.
  ///
  /// In en, this message translates to:
  /// **'Illicit Drug'**
  String get clinIllicitDrug;

  /// No description provided for @clinSmoking.
  ///
  /// In en, this message translates to:
  /// **'Smoking'**
  String get clinSmoking;

  /// No description provided for @clinSmokingCurrentStat.
  ///
  /// In en, this message translates to:
  /// **'Smoking Current Stat'**
  String get clinSmokingCurrentStat;

  /// No description provided for @clinSmokingDuration.
  ///
  /// In en, this message translates to:
  /// **'Smoking Duration'**
  String get clinSmokingDuration;

  /// No description provided for @clinTobaccoConsumption.
  ///
  /// In en, this message translates to:
  /// **'Tobacco Consumption'**
  String get clinTobaccoConsumption;

  /// No description provided for @clinTobaccoCurrentStat.
  ///
  /// In en, this message translates to:
  /// **'Tobacco Current Stat'**
  String get clinTobaccoCurrentStat;

  /// No description provided for @clinTobaccoDuration.
  ///
  /// In en, this message translates to:
  /// **'Tobacco Duration'**
  String get clinTobaccoDuration;

  /// No description provided for @nephroClinicalNotes.
  ///
  /// In en, this message translates to:
  /// **'Clinical Notes'**
  String get nephroClinicalNotes;

  /// No description provided for @nephroDiagnosisDescription.
  ///
  /// In en, this message translates to:
  /// **'Diagnosis & Description'**
  String get nephroDiagnosisDescription;

  /// No description provided for @nephroDosage.
  ///
  /// In en, this message translates to:
  /// **'Dosage'**
  String get nephroDosage;

  /// No description provided for @nephroFrequency.
  ///
  /// In en, this message translates to:
  /// **'Frequency'**
  String get nephroFrequency;

  /// No description provided for @nephroRoute.
  ///
  /// In en, this message translates to:
  /// **'Route'**
  String get nephroRoute;

  /// No description provided for @nephroPrep.
  ///
  /// In en, this message translates to:
  /// **'Prep'**
  String get nephroPrep;

  /// No description provided for @nephroTemplate.
  ///
  /// In en, this message translates to:
  /// **'Template'**
  String get nephroTemplate;

  /// No description provided for @nephroIcd10Code.
  ///
  /// In en, this message translates to:
  /// **'ICD10 Code'**
  String get nephroIcd10Code;

  /// No description provided for @nephroInstructions.
  ///
  /// In en, this message translates to:
  /// **'Instructions'**
  String get nephroInstructions;

  /// No description provided for @nephroInstructionEnglish.
  ///
  /// In en, this message translates to:
  /// **'Instruction in English'**
  String get nephroInstructionEnglish;

  /// No description provided for @nephroInstructionMarathi.
  ///
  /// In en, this message translates to:
  /// **'Instruction in Marathi'**
  String get nephroInstructionMarathi;

  /// No description provided for @nephroInstructionHindi.
  ///
  /// In en, this message translates to:
  /// **'Instruction in Hindi'**
  String get nephroInstructionHindi;

  /// No description provided for @nephroOtherLanguage1.
  ///
  /// In en, this message translates to:
  /// **'Other Language 1'**
  String get nephroOtherLanguage1;

  /// No description provided for @nephroOtherLanguage2.
  ///
  /// In en, this message translates to:
  /// **'Other Language 2'**
  String get nephroOtherLanguage2;

  /// No description provided for @nephroOtherLanguage3.
  ///
  /// In en, this message translates to:
  /// **'Other Language 3'**
  String get nephroOtherLanguage3;

  /// No description provided for @nephroDiagnosisType.
  ///
  /// In en, this message translates to:
  /// **'Diagnosis Type'**
  String get nephroDiagnosisType;

  /// No description provided for @nephroDiet.
  ///
  /// In en, this message translates to:
  /// **'Diet'**
  String get nephroDiet;

  /// No description provided for @nephroSpecialInstructions.
  ///
  /// In en, this message translates to:
  /// **'Special Instructions'**
  String get nephroSpecialInstructions;

  /// No description provided for @nephroTreatmentPlan.
  ///
  /// In en, this message translates to:
  /// **'Treatment Plan'**
  String get nephroTreatmentPlan;

  /// No description provided for @nephroAddDetails.
  ///
  /// In en, this message translates to:
  /// **'Add Details'**
  String get nephroAddDetails;

  /// No description provided for @nephroAddNewInstruction.
  ///
  /// In en, this message translates to:
  /// **'Add New Instruction'**
  String get nephroAddNewInstruction;

  /// No description provided for @nephroAddToTest.
  ///
  /// In en, this message translates to:
  /// **'Add to Test'**
  String get nephroAddToTest;

  /// No description provided for @nephroViewReport.
  ///
  /// In en, this message translates to:
  /// **'View Report'**
  String get nephroViewReport;

  /// No description provided for @nephroChooseTest.
  ///
  /// In en, this message translates to:
  /// **'Choose Test'**
  String get nephroChooseTest;

  /// No description provided for @nephroMedicineName.
  ///
  /// In en, this message translates to:
  /// **'Medicine Name'**
  String get nephroMedicineName;

  /// No description provided for @nephroTestName.
  ///
  /// In en, this message translates to:
  /// **'Test Name'**
  String get nephroTestName;

  /// No description provided for @nephroDiagnosis.
  ///
  /// In en, this message translates to:
  /// **'Diagnosis'**
  String get nephroDiagnosis;

  /// No description provided for @nephroClinicalHistory.
  ///
  /// In en, this message translates to:
  /// **'Clinical History'**
  String get nephroClinicalHistory;

  /// No description provided for @nephroClinicalHistoryStatus.
  ///
  /// In en, this message translates to:
  /// **'Clinical History Status'**
  String get nephroClinicalHistoryStatus;

  /// No description provided for @nephroInvestigationScheduling.
  ///
  /// In en, this message translates to:
  /// **'Investigation Test Scheduling Details'**
  String get nephroInvestigationScheduling;

  /// No description provided for @nephroNoPrescriptions.
  ///
  /// In en, this message translates to:
  /// **'No prescriptions found'**
  String get nephroNoPrescriptions;

  /// No description provided for @nephroGeneralInfo.
  ///
  /// In en, this message translates to:
  /// **'General Info'**
  String get nephroGeneralInfo;

  /// No description provided for @nephroOnExamination.
  ///
  /// In en, this message translates to:
  /// **'ON EXAMINATION'**
  String get nephroOnExamination;

  /// No description provided for @nephroSystematicExaminations.
  ///
  /// In en, this message translates to:
  /// **'SYSTEMATIC EXAMINATIONS'**
  String get nephroSystematicExaminations;

  /// No description provided for @nephroSelectFileToUpload.
  ///
  /// In en, this message translates to:
  /// **'Select File to Upload'**
  String get nephroSelectFileToUpload;

  /// No description provided for @nephroEnterComments.
  ///
  /// In en, this message translates to:
  /// **'Enter Comments'**
  String get nephroEnterComments;

  /// No description provided for @nephroDeleteInstructionConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this instruction?'**
  String get nephroDeleteInstructionConfirm;

  /// No description provided for @nephroConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get nephroConfirmed;

  /// No description provided for @nephroProvisional.
  ///
  /// In en, this message translates to:
  /// **'Provisional'**
  String get nephroProvisional;

  /// No description provided for @nephroUrgent.
  ///
  /// In en, this message translates to:
  /// **'Urgent'**
  String get nephroUrgent;

  /// No description provided for @nephroBmi.
  ///
  /// In en, this message translates to:
  /// **'BMI'**
  String get nephroBmi;

  /// No description provided for @nephroMachineNo.
  ///
  /// In en, this message translates to:
  /// **'Machine No.'**
  String get nephroMachineNo;

  /// No description provided for @nephroNephrologistName.
  ///
  /// In en, this message translates to:
  /// **'Nephrologist Name'**
  String get nephroNephrologistName;

  /// No description provided for @nephroRegistrationDate.
  ///
  /// In en, this message translates to:
  /// **'Registration Date'**
  String get nephroRegistrationDate;

  /// No description provided for @nephroPatientMobileNo.
  ///
  /// In en, this message translates to:
  /// **'Patient Mobile No'**
  String get nephroPatientMobileNo;

  /// No description provided for @nephroRelativeName.
  ///
  /// In en, this message translates to:
  /// **'Relative Name'**
  String get nephroRelativeName;

  /// No description provided for @nephroAssignedToTechnician.
  ///
  /// In en, this message translates to:
  /// **'Assigned To Technician'**
  String get nephroAssignedToTechnician;

  /// No description provided for @nephroClinicalConditionSaved.
  ///
  /// In en, this message translates to:
  /// **'Clinical Condition Saved'**
  String get nephroClinicalConditionSaved;

  /// No description provided for @nephroDocumentDeleted.
  ///
  /// In en, this message translates to:
  /// **'Document Deleted'**
  String get nephroDocumentDeleted;

  /// No description provided for @nephroEnterTest.
  ///
  /// In en, this message translates to:
  /// **'Enter Test'**
  String get nephroEnterTest;

  /// No description provided for @nephroSelectCheckbox.
  ///
  /// In en, this message translates to:
  /// **'Please select checkbox'**
  String get nephroSelectCheckbox;

  /// No description provided for @nephroRecordUpdated.
  ///
  /// In en, this message translates to:
  /// **'Record Updated Successfully'**
  String get nephroRecordUpdated;

  /// No description provided for @nephroTestAdded.
  ///
  /// In en, this message translates to:
  /// **'Test Added'**
  String get nephroTestAdded;

  /// No description provided for @nephroTestAddFail.
  ///
  /// In en, this message translates to:
  /// **'Test Adding Failed'**
  String get nephroTestAddFail;

  /// No description provided for @nephroDiagnosisDeleted.
  ///
  /// In en, this message translates to:
  /// **'Diagnosis Deleted Successfully'**
  String get nephroDiagnosisDeleted;

  /// No description provided for @nephroErrorSavingDiet.
  ///
  /// In en, this message translates to:
  /// **'Error saving diet'**
  String get nephroErrorSavingDiet;

  /// No description provided for @nephroFailedSaveDiet.
  ///
  /// In en, this message translates to:
  /// **'Failed to save diet'**
  String get nephroFailedSaveDiet;

  /// No description provided for @nephroRecordsDeleted.
  ///
  /// In en, this message translates to:
  /// **'Records Deleted Successfully'**
  String get nephroRecordsDeleted;

  /// No description provided for @nephroUnauthorized.
  ///
  /// In en, this message translates to:
  /// **'Unauthorized request'**
  String get nephroUnauthorized;

  /// No description provided for @nephroAddTestsPackages.
  ///
  /// In en, this message translates to:
  /// **'Add Tests/Packages'**
  String get nephroAddTestsPackages;

  /// No description provided for @nephroSelectPackage.
  ///
  /// In en, this message translates to:
  /// **'Select Package'**
  String get nephroSelectPackage;

  /// No description provided for @nephroUploadError.
  ///
  /// In en, this message translates to:
  /// **'Upload error: {error}'**
  String nephroUploadError(Object error);

  /// No description provided for @commonApprove.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get commonApprove;

  /// No description provided for @commonGenerate.
  ///
  /// In en, this message translates to:
  /// **'Generate'**
  String get commonGenerate;

  /// No description provided for @dischTermsConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get dischTermsConditions;

  /// No description provided for @dischDischarge.
  ///
  /// In en, this message translates to:
  /// **'Discharge'**
  String get dischDischarge;

  /// No description provided for @dischSessionEndPatientList.
  ///
  /// In en, this message translates to:
  /// **'Session End Patient List'**
  String get dischSessionEndPatientList;

  /// No description provided for @dischApprovalStatus.
  ///
  /// In en, this message translates to:
  /// **'Approval Status'**
  String get dischApprovalStatus;

  /// No description provided for @dischDialysisDate.
  ///
  /// In en, this message translates to:
  /// **'Dialysis Date'**
  String get dischDialysisDate;

  /// No description provided for @machMachineCounter.
  ///
  /// In en, this message translates to:
  /// **'Machine Counter'**
  String get machMachineCounter;

  /// No description provided for @machMachineFilter.
  ///
  /// In en, this message translates to:
  /// **'Machine Filter'**
  String get machMachineFilter;

  /// No description provided for @machAddMachineCounter.
  ///
  /// In en, this message translates to:
  /// **'Add Machine Counter'**
  String get machAddMachineCounter;

  /// No description provided for @machMachineName.
  ///
  /// In en, this message translates to:
  /// **'Machine Name'**
  String get machMachineName;

  /// No description provided for @billInvoiceApprovalSecondLevel.
  ///
  /// In en, this message translates to:
  /// **'INVOICE APPROVAL (2nd LEVEL)'**
  String get billInvoiceApprovalSecondLevel;

  /// No description provided for @billInvoiceGeneration.
  ///
  /// In en, this message translates to:
  /// **'INVOICE Generation'**
  String get billInvoiceGeneration;

  /// No description provided for @billFilterInvoice.
  ///
  /// In en, this message translates to:
  /// **'Filter Invoice'**
  String get billFilterInvoice;

  /// No description provided for @billServiceCertificate.
  ///
  /// In en, this message translates to:
  /// **'Service Certificate'**
  String get billServiceCertificate;

  /// No description provided for @billViewServiceCertificate.
  ///
  /// In en, this message translates to:
  /// **'View Service Certificate'**
  String get billViewServiceCertificate;

  /// No description provided for @billServiceCertificateDetails.
  ///
  /// In en, this message translates to:
  /// **'Service Certificate\'s Details'**
  String get billServiceCertificateDetails;

  /// No description provided for @billMonth.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get billMonth;

  /// No description provided for @billYear.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get billYear;

  /// No description provided for @bookChooseSlot.
  ///
  /// In en, this message translates to:
  /// **'Choose Slot'**
  String get bookChooseSlot;

  /// No description provided for @bookSelectInstitute.
  ///
  /// In en, this message translates to:
  /// **'Select Institute'**
  String get bookSelectInstitute;

  /// No description provided for @bookBookingFailed.
  ///
  /// In en, this message translates to:
  /// **'Booking failed'**
  String get bookBookingFailed;

  /// No description provided for @bookHivPositive.
  ///
  /// In en, this message translates to:
  /// **'HIV+'**
  String get bookHivPositive;

  /// No description provided for @bookHepatitisCPositive.
  ///
  /// In en, this message translates to:
  /// **'Hepatitis C+'**
  String get bookHepatitisCPositive;

  /// No description provided for @bookNegative.
  ///
  /// In en, this message translates to:
  /// **'Negative'**
  String get bookNegative;

  /// No description provided for @photoTakePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take Photo'**
  String get photoTakePhoto;

  /// No description provided for @photoCapturePhoto.
  ///
  /// In en, this message translates to:
  /// **'Capture Photo'**
  String get photoCapturePhoto;

  /// No description provided for @photoDataSaved.
  ///
  /// In en, this message translates to:
  /// **'Data saved successfully'**
  String get photoDataSaved;

  /// No description provided for @photoUploadFailed.
  ///
  /// In en, this message translates to:
  /// **'Upload failed: {reason}'**
  String photoUploadFailed(Object reason);

  /// No description provided for @cctvCameraDetails.
  ///
  /// In en, this message translates to:
  /// **'CCTV Camera Details'**
  String get cctvCameraDetails;

  /// No description provided for @cctvCamera.
  ///
  /// In en, this message translates to:
  /// **'CCTV Camera'**
  String get cctvCamera;

  /// No description provided for @uploadDocuments.
  ///
  /// In en, this message translates to:
  /// **'Upload Documents'**
  String get uploadDocuments;

  /// No description provided for @uploadNoDocument.
  ///
  /// In en, this message translates to:
  /// **'No document available'**
  String get uploadNoDocument;

  /// No description provided for @uploadUploading.
  ///
  /// In en, this message translates to:
  /// **'Uploading...'**
  String get uploadUploading;

  /// No description provided for @uploadCropPhoto.
  ///
  /// In en, this message translates to:
  /// **'Crop Photo'**
  String get uploadCropPhoto;

  /// No description provided for @uploadFeedback.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get uploadFeedback;

  /// No description provided for @uploadHdChart.
  ///
  /// In en, this message translates to:
  /// **'HD Chart'**
  String get uploadHdChart;

  /// No description provided for @uploadTreatmentDate.
  ///
  /// In en, this message translates to:
  /// **'Treatment Date'**
  String get uploadTreatmentDate;

  /// No description provided for @uploadUploadedOn.
  ///
  /// In en, this message translates to:
  /// **'Uploaded on: {dateTime}'**
  String uploadUploadedOn(Object dateTime);

  /// No description provided for @roDisinfectionDetails.
  ///
  /// In en, this message translates to:
  /// **'RO Disinfection Details'**
  String get roDisinfectionDetails;

  /// No description provided for @roLogSheet.
  ///
  /// In en, this message translates to:
  /// **'RO Log Sheet'**
  String get roLogSheet;

  /// No description provided for @roAddLogSheet.
  ///
  /// In en, this message translates to:
  /// **'Add RO Log Sheet'**
  String get roAddLogSheet;

  /// No description provided for @roDailyLogSheet.
  ///
  /// In en, this message translates to:
  /// **'Daily RO Log Sheet'**
  String get roDailyLogSheet;

  /// No description provided for @roMachineIssueLogs.
  ///
  /// In en, this message translates to:
  /// **'RO Machine Issue Logs'**
  String get roMachineIssueLogs;

  /// No description provided for @roBackwash.
  ///
  /// In en, this message translates to:
  /// **'Backwash'**
  String get roBackwash;

  /// No description provided for @roRinse.
  ///
  /// In en, this message translates to:
  /// **'Rinse'**
  String get roRinse;

  /// No description provided for @roCallAttendedBy.
  ///
  /// In en, this message translates to:
  /// **'Call Attended By'**
  String get roCallAttendedBy;

  /// No description provided for @roCheckedBy.
  ///
  /// In en, this message translates to:
  /// **'Checked By'**
  String get roCheckedBy;

  /// No description provided for @roCorrectionAction.
  ///
  /// In en, this message translates to:
  /// **'Correction Action'**
  String get roCorrectionAction;

  /// No description provided for @roDifference.
  ///
  /// In en, this message translates to:
  /// **'Difference'**
  String get roDifference;

  /// No description provided for @roDoneBy.
  ///
  /// In en, this message translates to:
  /// **'Done By'**
  String get roDoneBy;

  /// No description provided for @roImageName.
  ///
  /// In en, this message translates to:
  /// **'Image Name'**
  String get roImageName;

  /// No description provided for @roInformationDate.
  ///
  /// In en, this message translates to:
  /// **'Information Date'**
  String get roInformationDate;

  /// No description provided for @roInformedBy.
  ///
  /// In en, this message translates to:
  /// **'Informed By'**
  String get roInformedBy;

  /// No description provided for @roInformedTo.
  ///
  /// In en, this message translates to:
  /// **'Informed To'**
  String get roInformedTo;

  /// No description provided for @roInspectionDate.
  ///
  /// In en, this message translates to:
  /// **'Inspection Date'**
  String get roInspectionDate;

  /// No description provided for @roIssueDate.
  ///
  /// In en, this message translates to:
  /// **'Issue Date'**
  String get roIssueDate;

  /// No description provided for @roIssueDescription.
  ///
  /// In en, this message translates to:
  /// **'Issue Description'**
  String get roIssueDescription;

  /// No description provided for @roNextInspectionDate.
  ///
  /// In en, this message translates to:
  /// **'Next Inspection Date'**
  String get roNextInspectionDate;

  /// No description provided for @roProblemResolved.
  ///
  /// In en, this message translates to:
  /// **'Problem Resolved'**
  String get roProblemResolved;

  /// No description provided for @roRange.
  ///
  /// In en, this message translates to:
  /// **'Range'**
  String get roRange;

  /// No description provided for @roSpecialNo.
  ///
  /// In en, this message translates to:
  /// **'Please enter special no.'**
  String get roSpecialNo;

  /// No description provided for @roTypeOfDisinfection.
  ///
  /// In en, this message translates to:
  /// **'Type of Disinfection Used'**
  String get roTypeOfDisinfection;

  /// No description provided for @roImageUpload.
  ///
  /// In en, this message translates to:
  /// **'Image Upload'**
  String get roImageUpload;

  /// No description provided for @roSoftenerRegistration.
  ///
  /// In en, this message translates to:
  /// **'Softener Registration'**
  String get roSoftenerRegistration;

  /// No description provided for @roLooplineTds.
  ///
  /// In en, this message translates to:
  /// **'Loopline TDS (ppm)'**
  String get roLooplineTds;

  /// No description provided for @roPostCarbonChlorine.
  ///
  /// In en, this message translates to:
  /// **'Post Carbon Filter Chlorine (ppm)'**
  String get roPostCarbonChlorine;

  /// No description provided for @roPostMembraneTds.
  ///
  /// In en, this message translates to:
  /// **'Post Membrane TDS (ppm)'**
  String get roPostMembraneTds;

  /// No description provided for @roPostMixbedTds.
  ///
  /// In en, this message translates to:
  /// **'Post Mixbed TDS (ppm)'**
  String get roPostMixbedTds;

  /// No description provided for @roPostSoftenerHardness.
  ///
  /// In en, this message translates to:
  /// **'Post Softener Hardness (ppm)'**
  String get roPostSoftenerHardness;

  /// No description provided for @roPostSoftenerTds.
  ///
  /// In en, this message translates to:
  /// **'Post Softener TDS (ppm)'**
  String get roPostSoftenerTds;

  /// No description provided for @roProductPermeateFlow.
  ///
  /// In en, this message translates to:
  /// **'Product / Permeate Flow (lph)'**
  String get roProductPermeateFlow;

  /// No description provided for @roRawWaterTdsPpm.
  ///
  /// In en, this message translates to:
  /// **'Raw Water TDS (ppm)'**
  String get roRawWaterTdsPpm;

  /// No description provided for @roRejectFlowLph.
  ///
  /// In en, this message translates to:
  /// **'Reject Flow (lph)'**
  String get roRejectFlowLph;

  /// No description provided for @roCarbonFilterPressure.
  ///
  /// In en, this message translates to:
  /// **'Carbon Filter Pressure (PSI)'**
  String get roCarbonFilterPressure;

  /// No description provided for @roRoWaterTds.
  ///
  /// In en, this message translates to:
  /// **'RO Water TDS (PPM)'**
  String get roRoWaterTds;

  /// No description provided for @roRawWaterTds.
  ///
  /// In en, this message translates to:
  /// **'Raw Water TDS (PPM)'**
  String get roRawWaterTds;

  /// No description provided for @roReturnLoopPressure.
  ///
  /// In en, this message translates to:
  /// **'Return Loop Pressure (PSI)'**
  String get roReturnLoopPressure;

  /// No description provided for @roSoftenerPressure.
  ///
  /// In en, this message translates to:
  /// **'Softener Pressure (PSI)'**
  String get roSoftenerPressure;

  /// No description provided for @roPre.
  ///
  /// In en, this message translates to:
  /// **'Pre'**
  String get roPre;

  /// No description provided for @roPost.
  ///
  /// In en, this message translates to:
  /// **'Post'**
  String get roPost;

  /// No description provided for @roPump.
  ///
  /// In en, this message translates to:
  /// **'Pump'**
  String get roPump;

  /// No description provided for @roWater.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get roWater;

  /// No description provided for @roSand.
  ///
  /// In en, this message translates to:
  /// **'Sand'**
  String get roSand;

  /// No description provided for @roSandFilter.
  ///
  /// In en, this message translates to:
  /// **'Sand Filter'**
  String get roSandFilter;

  /// No description provided for @roCarbon.
  ///
  /// In en, this message translates to:
  /// **'Carbon'**
  String get roCarbon;

  /// No description provided for @roCarbonFilter.
  ///
  /// In en, this message translates to:
  /// **'Carbon Filter'**
  String get roCarbonFilter;

  /// No description provided for @roSoftner.
  ///
  /// In en, this message translates to:
  /// **'Softener'**
  String get roSoftner;

  /// No description provided for @roRawWaterPump.
  ///
  /// In en, this message translates to:
  /// **'Raw Water Pump'**
  String get roRawWaterPump;

  /// No description provided for @roTransferPump.
  ///
  /// In en, this message translates to:
  /// **'Transfer Pump'**
  String get roTransferPump;

  /// No description provided for @roUvLamp.
  ///
  /// In en, this message translates to:
  /// **'UV Lamp'**
  String get roUvLamp;

  /// No description provided for @roSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Save Failed'**
  String get roSaveFailed;

  /// No description provided for @roSavedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Saved Successfully'**
  String get roSavedSuccessfully;

  /// No description provided for @phtPatientHealthTrends.
  ///
  /// In en, this message translates to:
  /// **'Patient Health Trends'**
  String get phtPatientHealthTrends;

  /// No description provided for @phtHaemoglobinTracking.
  ///
  /// In en, this message translates to:
  /// **'Haemoglobin Tracking Report'**
  String get phtHaemoglobinTracking;

  /// No description provided for @phtInvestigationResultChart.
  ///
  /// In en, this message translates to:
  /// **'Patient Dialysis Investigation Result Chart'**
  String get phtInvestigationResultChart;

  /// No description provided for @phtVitalChart.
  ///
  /// In en, this message translates to:
  /// **'Patient Dialysis Vital Chart'**
  String get phtVitalChart;

  /// No description provided for @phtPatientVitalChart.
  ///
  /// In en, this message translates to:
  /// **'Patient Vital Chart'**
  String get phtPatientVitalChart;

  /// No description provided for @phtGenerateReport.
  ///
  /// In en, this message translates to:
  /// **'Generate Report'**
  String get phtGenerateReport;

  /// No description provided for @phtShowRecord.
  ///
  /// In en, this message translates to:
  /// **'Show Record'**
  String get phtShowRecord;

  /// No description provided for @phtShowReport.
  ///
  /// In en, this message translates to:
  /// **'Show Report'**
  String get phtShowReport;

  /// No description provided for @phtVitalParameters.
  ///
  /// In en, this message translates to:
  /// **'Vital Parameters'**
  String get phtVitalParameters;

  /// No description provided for @phtValuesByDate.
  ///
  /// In en, this message translates to:
  /// **'Values By Date'**
  String get phtValuesByDate;

  /// No description provided for @phtSelectDateRange.
  ///
  /// In en, this message translates to:
  /// **'Select Date Range'**
  String get phtSelectDateRange;

  /// No description provided for @phtSearchPatient.
  ///
  /// In en, this message translates to:
  /// **'Search Patient'**
  String get phtSearchPatient;

  /// No description provided for @phtSelectDateRangeTap.
  ///
  /// In en, this message translates to:
  /// **'Select a date range and tap'**
  String get phtSelectDateRangeTap;

  /// No description provided for @phtNoVitalData.
  ///
  /// In en, this message translates to:
  /// **'No Vital Data Available'**
  String get phtNoVitalData;

  /// No description provided for @phtNoChartData.
  ///
  /// In en, this message translates to:
  /// **'No chart data available'**
  String get phtNoChartData;

  /// No description provided for @phtNoValidDataPoints.
  ///
  /// In en, this message translates to:
  /// **'No valid data points to display'**
  String get phtNoValidDataPoints;

  /// No description provided for @phtDataNotFound.
  ///
  /// In en, this message translates to:
  /// **'Data Not Found'**
  String get phtDataNotFound;

  /// No description provided for @phtLatestValue.
  ///
  /// In en, this message translates to:
  /// **'Latest Value: {value}'**
  String phtLatestValue(Object value);

  /// No description provided for @phtLatest.
  ///
  /// In en, this message translates to:
  /// **'Latest: {value}'**
  String phtLatest(Object value);

  /// No description provided for @phtSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search by patient name or id'**
  String get phtSearchHint;

  /// No description provided for @dqPreDialysis.
  ///
  /// In en, this message translates to:
  /// **'Pre Dialysis'**
  String get dqPreDialysis;

  /// No description provided for @dqPostDialysis.
  ///
  /// In en, this message translates to:
  /// **'Post Dialysis'**
  String get dqPostDialysis;

  /// No description provided for @dqDialysisEvent.
  ///
  /// In en, this message translates to:
  /// **'Dialysis Event'**
  String get dqDialysisEvent;

  /// No description provided for @dqInvestigation.
  ///
  /// In en, this message translates to:
  /// **'Investigation'**
  String get dqInvestigation;

  /// No description provided for @dqConsumableEntry.
  ///
  /// In en, this message translates to:
  /// **'Consumable Entry'**
  String get dqConsumableEntry;

  /// No description provided for @roMachineLogSheet.
  ///
  /// In en, this message translates to:
  /// **'RO Machine Log Sheet'**
  String get roMachineLogSheet;

  /// No description provided for @phtMenuVitalChart.
  ///
  /// In en, this message translates to:
  /// **'Dialysis Vital Chart'**
  String get phtMenuVitalChart;

  /// No description provided for @phtMenuInvestChart.
  ///
  /// In en, this message translates to:
  /// **'Dialysis Investigation Result Chart'**
  String get phtMenuInvestChart;

  /// No description provided for @colParticulars.
  ///
  /// In en, this message translates to:
  /// **'Particulars'**
  String get colParticulars;

  /// No description provided for @colReport.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get colReport;

  /// No description provided for @colDrugs.
  ///
  /// In en, this message translates to:
  /// **'Drugs'**
  String get colDrugs;

  /// No description provided for @colFreq.
  ///
  /// In en, this message translates to:
  /// **'Freq'**
  String get colFreq;

  /// No description provided for @colPackageName.
  ///
  /// In en, this message translates to:
  /// **'Package Name'**
  String get colPackageName;

  /// No description provided for @colClinicalHistoryDate.
  ///
  /// In en, this message translates to:
  /// **'Clinical History Date'**
  String get colClinicalHistoryDate;

  /// No description provided for @colInstructionName.
  ///
  /// In en, this message translates to:
  /// **'Instruction Name'**
  String get colInstructionName;

  /// No description provided for @colComorbidities.
  ///
  /// In en, this message translates to:
  /// **'Comorbidities'**
  String get colComorbidities;

  /// No description provided for @colYesNo.
  ///
  /// In en, this message translates to:
  /// **'Yes/No'**
  String get colYesNo;

  /// No description provided for @nephroAddClinicalCondition.
  ///
  /// In en, this message translates to:
  /// **'Add Clinical Condition'**
  String get nephroAddClinicalCondition;

  /// No description provided for @nephroEditClinicalCondition.
  ///
  /// In en, this message translates to:
  /// **'Edit Clinical Condition'**
  String get nephroEditClinicalCondition;

  /// No description provided for @nephroConsultantName.
  ///
  /// In en, this message translates to:
  /// **'Consultant Name'**
  String get nephroConsultantName;

  /// No description provided for @nephroEvent.
  ///
  /// In en, this message translates to:
  /// **'Event'**
  String get nephroEvent;

  /// No description provided for @nephroChoosePackages.
  ///
  /// In en, this message translates to:
  /// **'Choose Packages'**
  String get nephroChoosePackages;

  /// No description provided for @nephroDeleteTest.
  ///
  /// In en, this message translates to:
  /// **'Delete Test'**
  String get nephroDeleteTest;

  /// No description provided for @nephroDeleteTestConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this test?'**
  String get nephroDeleteTestConfirm;

  /// No description provided for @nephroTestAlreadyAssigned.
  ///
  /// In en, this message translates to:
  /// **'This test is already assigned to the patient'**
  String get nephroTestAlreadyAssigned;

  /// No description provided for @nephroAddPrescription.
  ///
  /// In en, this message translates to:
  /// **'Add Prescription'**
  String get nephroAddPrescription;

  /// No description provided for @nephroEditPrescription.
  ///
  /// In en, this message translates to:
  /// **'Edit Prescription'**
  String get nephroEditPrescription;

  /// No description provided for @nephroMorning.
  ///
  /// In en, this message translates to:
  /// **'Morning'**
  String get nephroMorning;

  /// No description provided for @nephroAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Afternoon'**
  String get nephroAfternoon;

  /// No description provided for @nephroEvening.
  ///
  /// In en, this message translates to:
  /// **'Evening'**
  String get nephroEvening;

  /// No description provided for @nephroNight.
  ///
  /// In en, this message translates to:
  /// **'Night'**
  String get nephroNight;

  /// No description provided for @nephroStrength.
  ///
  /// In en, this message translates to:
  /// **'Strength'**
  String get nephroStrength;

  /// No description provided for @nephroDose.
  ///
  /// In en, this message translates to:
  /// **'Dose'**
  String get nephroDose;

  /// No description provided for @nephroPrescribedBy.
  ///
  /// In en, this message translates to:
  /// **'Prescribed by'**
  String get nephroPrescribedBy;

  /// No description provided for @nephroAddDiet.
  ///
  /// In en, this message translates to:
  /// **'Add Diet'**
  String get nephroAddDiet;

  /// No description provided for @nephroEditDiet.
  ///
  /// In en, this message translates to:
  /// **'Edit Diet'**
  String get nephroEditDiet;

  /// No description provided for @nephroIndividualInstructions.
  ///
  /// In en, this message translates to:
  /// **'Individual Instructions'**
  String get nephroIndividualInstructions;

  /// No description provided for @nephroDeleteInstruction.
  ///
  /// In en, this message translates to:
  /// **'Delete Instruction'**
  String get nephroDeleteInstruction;

  /// No description provided for @nephroSaveInstructions.
  ///
  /// In en, this message translates to:
  /// **'Save Instructions'**
  String get nephroSaveInstructions;

  /// No description provided for @schedDialysisCenter.
  ///
  /// In en, this message translates to:
  /// **'Dialysis Center'**
  String get schedDialysisCenter;

  /// No description provided for @schedState.
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get schedState;

  /// No description provided for @schedApprovalInProcess.
  ///
  /// In en, this message translates to:
  /// **'Approval from {type} is in process'**
  String schedApprovalInProcess(String type);

  /// No description provided for @schedFrequencyScheduleMismatch.
  ///
  /// In en, this message translates to:
  /// **'Please schedule according to the selected frequency'**
  String get schedFrequencyScheduleMismatch;

  /// No description provided for @schedSelectDateAndSlot.
  ///
  /// In en, this message translates to:
  /// **'Please select date and slot'**
  String get schedSelectDateAndSlot;

  /// No description provided for @schedAlreadyBooked.
  ///
  /// In en, this message translates to:
  /// **'Already Booked'**
  String get schedAlreadyBooked;

  /// No description provided for @schedAppointmentAlreadyGiven.
  ///
  /// In en, this message translates to:
  /// **'Appointment already given on {date}'**
  String schedAppointmentAlreadyGiven(String date);

  /// No description provided for @schedSlotNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Slot Not Available'**
  String get schedSlotNotAvailable;

  /// No description provided for @schedOnThisDate.
  ///
  /// In en, this message translates to:
  /// **'On this date {date}'**
  String schedOnThisDate(String date);

  /// No description provided for @schedScheduleConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Schedule Confirmed'**
  String get schedScheduleConfirmed;

  /// No description provided for @schedScheduleConfirmedMsg.
  ///
  /// In en, this message translates to:
  /// **'Your schedule has been successfully confirmed.'**
  String get schedScheduleConfirmedMsg;

  /// No description provided for @schedAddSchedularFailed.
  ///
  /// In en, this message translates to:
  /// **'Add Schedular Failed'**
  String get schedAddSchedularFailed;

  /// No description provided for @schedViewLabInvest.
  ///
  /// In en, this message translates to:
  /// **'View Lab Invest'**
  String get schedViewLabInvest;

  /// No description provided for @schedAppointmentCancelled.
  ///
  /// In en, this message translates to:
  /// **'Appointment Cancelled'**
  String get schedAppointmentCancelled;

  /// No description provided for @schedAppointmentCancelledMsg.
  ///
  /// In en, this message translates to:
  /// **'Appointment Cancelled Successfully'**
  String get schedAppointmentCancelledMsg;

  /// No description provided for @schedCancelAppointmentConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure? Do you want to cancel the appointment?'**
  String get schedCancelAppointmentConfirm;

  /// No description provided for @clinFinalUfv.
  ///
  /// In en, this message translates to:
  /// **'Final UFV'**
  String get clinFinalUfv;

  /// No description provided for @clinVenousPressure.
  ///
  /// In en, this message translates to:
  /// **'Venous Pressure'**
  String get clinVenousPressure;

  /// No description provided for @clinBloodFlowQb.
  ///
  /// In en, this message translates to:
  /// **'Blood Flow (QB)'**
  String get clinBloodFlowQb;

  /// No description provided for @clinDialysateFlowQd.
  ///
  /// In en, this message translates to:
  /// **'Dialysate Flow (QD)'**
  String get clinDialysateFlowQd;

  /// No description provided for @clinRrfUrineVolume.
  ///
  /// In en, this message translates to:
  /// **'RRF Urine Volume (ml/Day)'**
  String get clinRrfUrineVolume;

  /// No description provided for @clinPercentOfFbv.
  ///
  /// In en, this message translates to:
  /// **'% of FBV'**
  String get clinPercentOfFbv;

  /// No description provided for @commonNoConsultationDetails.
  ///
  /// In en, this message translates to:
  /// **'No consultation details available.'**
  String get commonNoConsultationDetails;

  /// No description provided for @commonChooseFile.
  ///
  /// In en, this message translates to:
  /// **'Choose File'**
  String get commonChooseFile;

  /// No description provided for @schedOxygenSupplyAvailable.
  ///
  /// In en, this message translates to:
  /// **'Enough Oxygen Supply Available At The Bed'**
  String get schedOxygenSupplyAvailable;

  /// No description provided for @schedFuelAvailableGenset.
  ///
  /// In en, this message translates to:
  /// **'Enough Fuel Available for GenSet at the Hospital'**
  String get schedFuelAvailableGenset;

  /// No description provided for @schedIronSucrose.
  ///
  /// In en, this message translates to:
  /// **'Iron Sucrose'**
  String get schedIronSucrose;

  /// No description provided for @schedCurrentSessionUnderScheme.
  ///
  /// In en, this message translates to:
  /// **'Current Dialysis Session Under The Scheme'**
  String get schedCurrentSessionUnderScheme;

  /// No description provided for @schedLastSessionUnderScheme.
  ///
  /// In en, this message translates to:
  /// **'Last Dialysis Session Under The Scheme'**
  String get schedLastSessionUnderScheme;

  /// No description provided for @schedReasonNotRegisteredMjpjay.
  ///
  /// In en, this message translates to:
  /// **'Reason for not registered on MJPJAY'**
  String get schedReasonNotRegisteredMjpjay;

  /// No description provided for @schedPendingSession.
  ///
  /// In en, this message translates to:
  /// **'Pending Session {count}'**
  String schedPendingSession(String count);

  /// No description provided for @schedEffectiveDatePendingSession.
  ///
  /// In en, this message translates to:
  /// **'Effective Date {date} and Pending Session {count}'**
  String schedEffectiveDatePendingSession(String date, String count);

  /// No description provided for @bookConfirmBookAppointment.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?\nDo you want to book appointment'**
  String get bookConfirmBookAppointment;

  /// No description provided for @bookSelectBed.
  ///
  /// In en, this message translates to:
  /// **'Please Select Bed'**
  String get bookSelectBed;

  /// No description provided for @schedDieticianConsultationDone.
  ///
  /// In en, this message translates to:
  /// **'Dietician Consultation Done'**
  String get schedDieticianConsultationDone;

  /// No description provided for @schedNephrologistComment.
  ///
  /// In en, this message translates to:
  /// **'Nephrologist\'s Comment'**
  String get schedNephrologistComment;

  /// No description provided for @schedPatientAbsent.
  ///
  /// In en, this message translates to:
  /// **'Patient Absent'**
  String get schedPatientAbsent;

  /// No description provided for @dqLastDialysisSession.
  ///
  /// In en, this message translates to:
  /// **'Last dialysis session'**
  String get dqLastDialysisSession;

  /// No description provided for @clinAccessType.
  ///
  /// In en, this message translates to:
  /// **'Access Type'**
  String get clinAccessType;

  /// No description provided for @clinExpectedFiberBundleVolume.
  ///
  /// In en, this message translates to:
  /// **'Expected Fiber Bundle Volume'**
  String get clinExpectedFiberBundleVolume;

  /// No description provided for @clinDialyzerBarcodeNo.
  ///
  /// In en, this message translates to:
  /// **'Dialyzer Barcode No'**
  String get clinDialyzerBarcodeNo;

  /// No description provided for @clinTubeBarcodeNo.
  ///
  /// In en, this message translates to:
  /// **'Tube Barcode No'**
  String get clinTubeBarcodeNo;

  /// No description provided for @clinTubeReuseNo.
  ///
  /// In en, this message translates to:
  /// **'Tube Reuse No'**
  String get clinTubeReuseNo;

  /// No description provided for @clinBloodTubeRemark.
  ///
  /// In en, this message translates to:
  /// **'Blood Tube Remark'**
  String get clinBloodTubeRemark;

  /// No description provided for @clinNewBloodTubing.
  ///
  /// In en, this message translates to:
  /// **'New Blood Tubing'**
  String get clinNewBloodTubing;

  /// No description provided for @clinPulseBeatsMin.
  ///
  /// In en, this message translates to:
  /// **'Pulse\n(Beats/min)'**
  String get clinPulseBeatsMin;

  /// No description provided for @clinOxygenLevelPercent.
  ///
  /// In en, this message translates to:
  /// **'Oxygen Level (%)'**
  String get clinOxygenLevelPercent;

  /// No description provided for @clinRespiratoryRateBreathsMin.
  ///
  /// In en, this message translates to:
  /// **'Respiratory Rate (Breaths/min)'**
  String get clinRespiratoryRateBreathsMin;

  /// No description provided for @commonBottom.
  ///
  /// In en, this message translates to:
  /// **'Bottom'**
  String get commonBottom;

  /// No description provided for @commonTop.
  ///
  /// In en, this message translates to:
  /// **'Top'**
  String get commonTop;

  /// No description provided for @dqViewHistory.
  ///
  /// In en, this message translates to:
  /// **'View History'**
  String get dqViewHistory;

  /// No description provided for @dqDiscardedRemarksWarning.
  ///
  /// In en, this message translates to:
  /// **'Kindly enter discarded remarks before using new dialyser and blood tubing'**
  String get dqDiscardedRemarksWarning;

  /// No description provided for @dqDialysisHistory.
  ///
  /// In en, this message translates to:
  /// **'Dialysis History'**
  String get dqDialysisHistory;

  /// No description provided for @dqTubeHistory.
  ///
  /// In en, this message translates to:
  /// **'Tube History'**
  String get dqTubeHistory;

  /// No description provided for @clinCurrentWgtDiff.
  ///
  /// In en, this message translates to:
  /// **'Current Wgt Diff'**
  String get clinCurrentWgtDiff;

  /// No description provided for @clinTotalHeparinUsed.
  ///
  /// In en, this message translates to:
  /// **'Total Heparin Used'**
  String get clinTotalHeparinUsed;

  /// No description provided for @clinFinalKtv.
  ///
  /// In en, this message translates to:
  /// **'Final KT/V'**
  String get clinFinalKtv;

  /// No description provided for @clinActualFiberBundleVolume.
  ///
  /// In en, this message translates to:
  /// **'Actual Fiber Bundle Volume'**
  String get clinActualFiberBundleVolume;

  /// No description provided for @clinPercentageFiberBundle.
  ///
  /// In en, this message translates to:
  /// **'Percentage Fiber Bundle'**
  String get clinPercentageFiberBundle;

  /// No description provided for @clinLastHgb.
  ///
  /// In en, this message translates to:
  /// **'Last Hgb (Hemoglobin):'**
  String get clinLastHgb;

  /// No description provided for @clinIronPreparation.
  ///
  /// In en, this message translates to:
  /// **'Iron Preparation'**
  String get clinIronPreparation;

  /// No description provided for @clinIronDose.
  ///
  /// In en, this message translates to:
  /// **'Iron Dose'**
  String get clinIronDose;

  /// No description provided for @clinIronFrequency.
  ///
  /// In en, this message translates to:
  /// **'Iron Frequency'**
  String get clinIronFrequency;

  /// No description provided for @clinIronRoute.
  ///
  /// In en, this message translates to:
  /// **'Iron Route'**
  String get clinIronRoute;

  /// No description provided for @clinIronStartDate.
  ///
  /// In en, this message translates to:
  /// **'Iron Start Date'**
  String get clinIronStartDate;

  /// No description provided for @clinIronProtocolUsed.
  ///
  /// In en, this message translates to:
  /// **'Iron Protocol Used'**
  String get clinIronProtocolUsed;

  /// No description provided for @clinFerritinLevel.
  ///
  /// In en, this message translates to:
  /// **'Ferritin Level'**
  String get clinFerritinLevel;

  /// No description provided for @clinBloodTransfusionPost.
  ///
  /// In en, this message translates to:
  /// **'Blood Transfusion (Post Dialysis)'**
  String get clinBloodTransfusionPost;

  /// No description provided for @clinVolumeMl.
  ///
  /// In en, this message translates to:
  /// **'Volume (mL)'**
  String get clinVolumeMl;

  /// No description provided for @clinDialysisDurationRemark.
  ///
  /// In en, this message translates to:
  /// **'Dialysis Duration Remark'**
  String get clinDialysisDurationRemark;

  /// No description provided for @clinDialysisDurationDescription.
  ///
  /// In en, this message translates to:
  /// **'Dialysis Duration Description'**
  String get clinDialysisDurationDescription;

  /// No description provided for @clinEpoBrandName.
  ///
  /// In en, this message translates to:
  /// **'EPO Brand Name'**
  String get clinEpoBrandName;

  /// No description provided for @clinEpoFrequency.
  ///
  /// In en, this message translates to:
  /// **'EPO Frequency'**
  String get clinEpoFrequency;

  /// No description provided for @clinEpoRoute.
  ///
  /// In en, this message translates to:
  /// **'EPO Route'**
  String get clinEpoRoute;

  /// No description provided for @clinEpoStartDate.
  ///
  /// In en, this message translates to:
  /// **'EPO Start Date'**
  String get clinEpoStartDate;

  /// No description provided for @clinEpoIndication.
  ///
  /// In en, this message translates to:
  /// **'EPO Indication'**
  String get clinEpoIndication;

  /// No description provided for @dqHdTreatmentCount.
  ///
  /// In en, this message translates to:
  /// **'Hd Treatment Count'**
  String get dqHdTreatmentCount;

  /// No description provided for @clinPreDialysisWeightKgs.
  ///
  /// In en, this message translates to:
  /// **'Pre-Dialysis Weight (kgs)'**
  String get clinPreDialysisWeightKgs;

  /// No description provided for @clinPostDialysisWeightKgs.
  ///
  /// In en, this message translates to:
  /// **'Post Dialysis Weight (kgs)'**
  String get clinPostDialysisWeightKgs;

  /// No description provided for @clinIntradialyticWeightKgs.
  ///
  /// In en, this message translates to:
  /// **'Intradialytic Weight (kgs)'**
  String get clinIntradialyticWeightKgs;

  /// No description provided for @clinDryWeightKgs.
  ///
  /// In en, this message translates to:
  /// **'Dry Weight (kgs)'**
  String get clinDryWeightKgs;

  /// No description provided for @clinWeightLoss.
  ///
  /// In en, this message translates to:
  /// **'Weight Loss'**
  String get clinWeightLoss;

  /// No description provided for @clinUfTarget.
  ///
  /// In en, this message translates to:
  /// **'UF Target (Ltrs)'**
  String get clinUfTarget;

  /// No description provided for @clinUfTargetAchieved.
  ///
  /// In en, this message translates to:
  /// **'UF Target Achieved (Ltrs)'**
  String get clinUfTargetAchieved;

  /// No description provided for @clinAirDetectorLineClamp.
  ///
  /// In en, this message translates to:
  /// **'Air Detector / Line Clamp'**
  String get clinAirDetectorLineClamp;

  /// No description provided for @clinAlarmLimitSet.
  ///
  /// In en, this message translates to:
  /// **'Alarm Limit Set'**
  String get clinAlarmLimitSet;

  /// No description provided for @clinHeparinPumpOn.
  ///
  /// In en, this message translates to:
  /// **'Heparin Pump on'**
  String get clinHeparinPumpOn;

  /// No description provided for @clinDialysateFlowMlMin.
  ///
  /// In en, this message translates to:
  /// **'Dialysate Flow (ml/min)'**
  String get clinDialysateFlowMlMin;

  /// No description provided for @clinPulseBpm.
  ///
  /// In en, this message translates to:
  /// **'Pulse (bpm)'**
  String get clinPulseBpm;

  /// No description provided for @clinInjectionEpoIron.
  ///
  /// In en, this message translates to:
  /// **'Injection EPO / Iron'**
  String get clinInjectionEpoIron;

  /// No description provided for @clinDialysateTempC.
  ///
  /// In en, this message translates to:
  /// **'Dialysate Temp (°C)'**
  String get clinDialysateTempC;

  /// No description provided for @clinRespiratoryRateRpm.
  ///
  /// In en, this message translates to:
  /// **'Respiratory Rate (rpm)'**
  String get clinRespiratoryRateRpm;

  /// No description provided for @clinConcentrateNa.
  ///
  /// In en, this message translates to:
  /// **'Concentrate Na+ (mmol / L)'**
  String get clinConcentrateNa;

  /// No description provided for @clinTemperatureF.
  ///
  /// In en, this message translates to:
  /// **'Temperature (°F)'**
  String get clinTemperatureF;

  /// No description provided for @clinPtTemperatureF.
  ///
  /// In en, this message translates to:
  /// **'Pt. Temperature (°F)'**
  String get clinPtTemperatureF;

  /// No description provided for @clinConductivityMho.
  ///
  /// In en, this message translates to:
  /// **'Conductivity (mho)'**
  String get clinConductivityMho;

  /// No description provided for @clinHdStartedBy.
  ///
  /// In en, this message translates to:
  /// **'HD Started By'**
  String get clinHdStartedBy;

  /// No description provided for @clinHdCompletedBy.
  ///
  /// In en, this message translates to:
  /// **'HD Completed By'**
  String get clinHdCompletedBy;

  /// No description provided for @dischDietician.
  ///
  /// In en, this message translates to:
  /// **'Dietician'**
  String get dischDietician;

  /// No description provided for @dischTermsVerified.
  ///
  /// In en, this message translates to:
  /// **'I have verified all dialysis stages and patient details'**
  String get dischTermsVerified;

  /// No description provided for @roMachineName.
  ///
  /// In en, this message translates to:
  /// **'RO Machine Name'**
  String get roMachineName;

  /// No description provided for @commonUploadImage.
  ///
  /// In en, this message translates to:
  /// **'Upload Image'**
  String get commonUploadImage;

  /// No description provided for @roAddDisinfectionDetails.
  ///
  /// In en, this message translates to:
  /// **'Add RO Disinfection Details'**
  String get roAddDisinfectionDetails;

  /// No description provided for @roEditDisinfectionDetails.
  ///
  /// In en, this message translates to:
  /// **'Edit RO Disinfection Details'**
  String get roEditDisinfectionDetails;

  /// No description provided for @roNextInspectionBeforeError.
  ///
  /// In en, this message translates to:
  /// **'Next Inspection Date should not be before Inspection Date'**
  String get roNextInspectionBeforeError;

  /// No description provided for @roAddMachineIssueLog.
  ///
  /// In en, this message translates to:
  /// **'Add RO Machine Issue Logs'**
  String get roAddMachineIssueLog;

  /// No description provided for @roEditMachineIssueLog.
  ///
  /// In en, this message translates to:
  /// **'Edit RO Machine Issue Logs'**
  String get roEditMachineIssueLog;

  /// No description provided for @roSandFilterPressure.
  ///
  /// In en, this message translates to:
  /// **'Sand Filter Pressure'**
  String get roSandFilterPressure;

  /// No description provided for @commonInactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get commonInactive;

  /// No description provided for @roSandFilterPressurePsi.
  ///
  /// In en, this message translates to:
  /// **'Sand Filter Pressure (PSI)'**
  String get roSandFilterPressurePsi;

  /// No description provided for @roSoftenerAvailable.
  ///
  /// In en, this message translates to:
  /// **'Softener Available'**
  String get roSoftenerAvailable;

  /// No description provided for @roHardnessPostSoftenerPpm.
  ///
  /// In en, this message translates to:
  /// **'Hardness of Post Softener Water (PPM)'**
  String get roHardnessPostSoftenerPpm;

  /// No description provided for @roBeforeRegenerationHardnessPpm.
  ///
  /// In en, this message translates to:
  /// **'Before Regeneration Hardness (PPM)'**
  String get roBeforeRegenerationHardnessPpm;

  /// No description provided for @roAfterRegenerationHardnessPpm.
  ///
  /// In en, this message translates to:
  /// **'After Regeneration Hardness (PPM)'**
  String get roAfterRegenerationHardnessPpm;

  /// No description provided for @roPreMembranePressure.
  ///
  /// In en, this message translates to:
  /// **'Pre Membrane Pressure'**
  String get roPreMembranePressure;

  /// No description provided for @roRejectPressure.
  ///
  /// In en, this message translates to:
  /// **'Reject Pressure'**
  String get roRejectPressure;

  /// No description provided for @roPermeateFlowLph.
  ///
  /// In en, this message translates to:
  /// **'Permeate Flow (LPH)'**
  String get roPermeateFlowLph;

  /// No description provided for @roCarbonChlorideWaterConductivity.
  ///
  /// In en, this message translates to:
  /// **'Carbon Chloride and Water Conductivity'**
  String get roCarbonChlorideWaterConductivity;

  /// No description provided for @roPostCarbonChloridePpm.
  ///
  /// In en, this message translates to:
  /// **'Post Carbon Chloride (PPM)'**
  String get roPostCarbonChloridePpm;

  /// No description provided for @roRoWaterConductivity.
  ///
  /// In en, this message translates to:
  /// **'RO Water Conductivity'**
  String get roRoWaterConductivity;

  /// No description provided for @roHighPressurePump.
  ///
  /// In en, this message translates to:
  /// **'High Pressure Pump'**
  String get roHighPressurePump;

  /// No description provided for @roUfMicronFilter.
  ///
  /// In en, this message translates to:
  /// **'UF/Micron Filter'**
  String get roUfMicronFilter;

  /// No description provided for @roDosingSystem.
  ///
  /// In en, this message translates to:
  /// **'Dosing System'**
  String get roDosingSystem;

  /// No description provided for @roValueLessThan.
  ///
  /// In en, this message translates to:
  /// **'Value must be less than {value}'**
  String roValueLessThan(String value);

  /// No description provided for @roValueGreaterThan.
  ///
  /// In en, this message translates to:
  /// **'Value must be greater than {value}'**
  String roValueGreaterThan(String value);

  /// No description provided for @roValueBetween.
  ///
  /// In en, this message translates to:
  /// **'Value must be between {min} and {max}'**
  String roValueBetween(String min, String max);

  /// No description provided for @roEnterValidNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid number'**
  String get roEnterValidNumber;

  /// No description provided for @roMachine.
  ///
  /// In en, this message translates to:
  /// **'RO Machine'**
  String get roMachine;

  /// No description provided for @roAddDailyLogSheet.
  ///
  /// In en, this message translates to:
  /// **'Add Daily RO Log Sheet'**
  String get roAddDailyLogSheet;

  /// No description provided for @roEditDailyLogSheet.
  ///
  /// In en, this message translates to:
  /// **'Edit Daily RO Log Sheet'**
  String get roEditDailyLogSheet;

  /// No description provided for @commonParameter.
  ///
  /// In en, this message translates to:
  /// **'Parameter'**
  String get commonParameter;

  /// No description provided for @commonUnits.
  ///
  /// In en, this message translates to:
  /// **'Units'**
  String get commonUnits;

  /// No description provided for @commonValues.
  ///
  /// In en, this message translates to:
  /// **'Values'**
  String get commonValues;

  /// No description provided for @roRawWaterTdsLabel.
  ///
  /// In en, this message translates to:
  /// **'Raw Water TDS'**
  String get roRawWaterTdsLabel;

  /// No description provided for @roPostSoftenerTdsLabel.
  ///
  /// In en, this message translates to:
  /// **'Post Softener TDS'**
  String get roPostSoftenerTdsLabel;

  /// No description provided for @roPostMembraneTdsLabel.
  ///
  /// In en, this message translates to:
  /// **'Post Membrane TDS'**
  String get roPostMembraneTdsLabel;

  /// No description provided for @roPostMixbedTdsLabel.
  ///
  /// In en, this message translates to:
  /// **'Post Mixbed TDS'**
  String get roPostMixbedTdsLabel;

  /// No description provided for @roLooplineTdsLabel.
  ///
  /// In en, this message translates to:
  /// **'Loopline TDS'**
  String get roLooplineTdsLabel;

  /// No description provided for @roPostSoftenerHardnessLabel.
  ///
  /// In en, this message translates to:
  /// **'Post Softener Hardness'**
  String get roPostSoftenerHardnessLabel;

  /// No description provided for @roPostCarbonFilterChlorineLabel.
  ///
  /// In en, this message translates to:
  /// **'Post Carbon Filter Chlorine'**
  String get roPostCarbonFilterChlorineLabel;

  /// No description provided for @roRejectFlowLabel.
  ///
  /// In en, this message translates to:
  /// **'Reject Flow'**
  String get roRejectFlowLabel;

  /// No description provided for @roProductPermeateFlowLabel.
  ///
  /// In en, this message translates to:
  /// **'Product / Permeate Flow'**
  String get roProductPermeateFlowLabel;

  /// No description provided for @machMachineSerialNo.
  ///
  /// In en, this message translates to:
  /// **'Machine Serial No.'**
  String get machMachineSerialNo;

  /// No description provided for @uploadFeedbackForm.
  ///
  /// In en, this message translates to:
  /// **'FeedBack Form'**
  String get uploadFeedbackForm;

  /// No description provided for @machTodaysReadingHours.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Reading (Hours)'**
  String get machTodaysReadingHours;

  /// No description provided for @machLastReadingHours.
  ///
  /// In en, this message translates to:
  /// **'Last Reading (Hours)'**
  String get machLastReadingHours;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'en':
      {
        switch (locale.countryCode) {
          case 'FR':
            return AppLocalizationsEnFr();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
