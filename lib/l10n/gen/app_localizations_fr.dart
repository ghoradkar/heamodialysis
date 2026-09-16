// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'MahaDialysis';

  @override
  String get languageLabel => 'Langue';

  @override
  String get languageEnglish => 'Anglais';

  @override
  String get languageFrench => 'Français';

  @override
  String get changeLanguage => 'Changer de langue';

  @override
  String get languageTooltip => 'Changer de langue';

  @override
  String get commonSave => 'Enregistrer';

  @override
  String get commonSubmit => 'Valider';

  @override
  String get commonCancel => 'Annuler';

  @override
  String get commonClose => 'Fermer';

  @override
  String get commonConfirm => 'Confirmer';

  @override
  String get commonNext => 'Suivant';

  @override
  String get commonPrevious => 'Précédent';

  @override
  String get commonBack => 'Retour';

  @override
  String get commonEdit => 'Modifier';

  @override
  String get commonDelete => 'Supprimer';

  @override
  String get commonAdd => 'Ajouter';

  @override
  String get commonUpdate => 'Mettre à jour';

  @override
  String get commonView => 'Voir';

  @override
  String get commonSearch => 'Rechercher';

  @override
  String get commonClear => 'Effacer';

  @override
  String get commonReset => 'Réinitialiser';

  @override
  String get commonApply => 'Appliquer';

  @override
  String get commonRefresh => 'Actualiser';

  @override
  String get commonRetry => 'Réessayer';

  @override
  String get commonProceed => 'Continuer';

  @override
  String get commonGoBack => 'Retour';

  @override
  String get commonDone => 'Terminé';

  @override
  String get commonSelect => 'Sélectionner';

  @override
  String get commonUpload => 'Téléverser';

  @override
  String get commonDownload => 'Télécharger';

  @override
  String get commonYes => 'Oui';

  @override
  String get commonNo => 'Non';

  @override
  String get commonOk => 'OK';

  @override
  String get commonLoading => 'Chargement…';

  @override
  String get commonNoData => 'Aucune donnée';

  @override
  String get commonNoDataFound => 'Aucune donnée trouvée';

  @override
  String get commonNoRecordsFound => 'Aucun enregistrement trouvé';

  @override
  String get commonSomethingWentWrong => 'Une erreur s\'est produite';

  @override
  String get commonSuccess => 'Succès';

  @override
  String get commonError => 'Erreur';

  @override
  String get commonWarning => 'Avertissement';

  @override
  String get commonNote => 'Remarque';

  @override
  String get commonPleaseSelect => 'Veuillez sélectionner';

  @override
  String get commonPleaseWait => 'Veuillez patienter…';

  @override
  String get commonSessionExpired =>
      'Session expirée. Veuillez vous reconnecter.';

  @override
  String get commonNoInternet => 'Pas de connexion Internet';

  @override
  String get commonCheckConnection =>
      'Veuillez vérifier votre connexion et réessayer';

  @override
  String get noInternetHeadline => 'Oh non';

  @override
  String get noInternetMessage => 'Aucune connexion Internet détectée.';

  @override
  String get noInternetHint => 'Vérifiez votre connexion ou réessayez.';

  @override
  String get commonRequiredField => 'Ce champ est obligatoire';

  @override
  String fieldRequired(String field) {
    return '$field est obligatoire';
  }

  @override
  String fieldInvalid(String field) {
    return 'Veuillez saisir un(e) $field valide';
  }

  @override
  String get validationInvalidEmail =>
      'Veuillez saisir une adresse e-mail valide';

  @override
  String get validationInvalidPan => 'Veuillez saisir un PAN valide';

  @override
  String validationDigits(int count) {
    return 'Veuillez saisir un nombre valide de $count chiffres';
  }

  @override
  String validationMinDigits(int count) {
    return 'Veuillez saisir $count chiffres';
  }

  @override
  String validationMaxLength(int max) {
    return 'Maximum $max caractères autorisés';
  }

  @override
  String charactersRemaining(int count) {
    return '$count caractères restants';
  }

  @override
  String get validationHeightFormat => 'Veuillez saisir la taille, p. ex. 5\'8';

  @override
  String get validationInvalidNumber => 'Saisissez un nombre valide';

  @override
  String validationMaxLitres(String field, String max) {
    return '$field ne doit pas dépasser $max L';
  }

  @override
  String get validationDateFormat =>
      'Veuillez saisir la date au format jj/MM/aaaa';

  @override
  String get validationInvalidDate =>
      'Date invalide. Veuillez vérifier le format';

  @override
  String get unitFahrenheit => 'Fahrenheit';

  @override
  String get unitCelsius => 'Celsius';

  @override
  String get commonDate => 'Date';

  @override
  String get commonTime => 'Heure';

  @override
  String get selectTime => 'Sélectionner l\'heure';

  @override
  String get commonLogout => 'Déconnexion';

  @override
  String get drawerDashboard => 'Tableau de bord';

  @override
  String get drawerRegistration => 'Enregistrement';

  @override
  String get drawerDialysisScheduler => 'Planificateur de dialyse';

  @override
  String get drawerDialysisQueue => 'File d\'attente de dialyse';

  @override
  String get drawerSessionEnd => 'Fin de séance';

  @override
  String get drawerRoMaintenance => 'Maintenance RO';

  @override
  String get drawerMachineStatus => 'État des machines';

  @override
  String get drawerNephrologistDesk => 'Bureau du néphrologue';

  @override
  String get drawerDoctorDesk => 'Bureau du médecin';

  @override
  String get drawerApplicationApproval => 'Approbation des demandes';

  @override
  String get drawerApplicationScrutiny => 'Examen des demandes';

  @override
  String get drawerUploadDocuments => 'Téléverser des documents';

  @override
  String get drawerBilling => 'Facturation';

  @override
  String get drawerInvoiceApprovalSecondLevel =>
      'Approbation de facture (2e niveau)';

  @override
  String get drawerInvoiceGeneration => 'Génération de factures';

  @override
  String drawerVersion(String version) {
    return 'Version: $version';
  }

  @override
  String get loginTitle => 'Connexion';

  @override
  String get loginButton => 'Se connecter';

  @override
  String get loginUsername => 'Nom d\'utilisateur';

  @override
  String get loginPassword => 'Mot de passe';

  @override
  String get loginForgotPassword => 'Mot de passe oublié ?';

  @override
  String get loginCaptchaHint => 'Saisissez le code affiché ci-dessus';

  @override
  String get loginIndiaOnlyMessage =>
      'Cette application n\'est disponible que dans la région indienne';

  @override
  String get loginSuccessful => 'Connexion réussie';

  @override
  String loginRunningEnv(String env) {
    return 'Exécution dans l\'environnement $env';
  }

  @override
  String loginUnknownRole(String role) {
    return 'Rôle d\'utilisateur inconnu : $role';
  }

  @override
  String get loginInvalidUser => 'Utilisateur invalide';

  @override
  String get logoutConfirm => 'Êtes-vous sûr de vouloir vous déconnecter ?';

  @override
  String get otpVerifyTitle => 'Vérifier le code OTP';

  @override
  String get otpSentTo =>
      'Le code OTP a été envoyé au numéro de mobile enregistré :';

  @override
  String get otpYourNumber => 'votre numéro enregistré';

  @override
  String get otpValidLimited =>
      'Ce code OTP n\'est valable que pour une durée limitée';

  @override
  String get otpCanResendNow =>
      'Pas reçu ? Vous pouvez le renvoyer maintenant.';

  @override
  String get otpDidntReceive => 'Vous n\'avez pas reçu le code ?';

  @override
  String get otpResend => 'Renvoyer le code OTP';

  @override
  String otpResendIn(String time) {
    return 'Renvoyer dans $time';
  }

  @override
  String otpEnterDigits(int count) {
    return 'Veuillez saisir le code OTP à $count chiffres';
  }

  @override
  String get otpResent => 'Code OTP renvoyé';

  @override
  String get otpInvalidOrExpired => 'Code OTP invalide ou expiré';

  @override
  String get otpResendFailed =>
      'Impossible de renvoyer le code OTP. Veuillez vous reconnecter.';

  @override
  String get commonFrom => 'Du';

  @override
  String get commonTo => 'Au';

  @override
  String get commonStatus => 'Statut';

  @override
  String get commonActions => 'Actions';

  @override
  String get commonAll => 'Tout';

  @override
  String get commonCompleted => 'Terminé';

  @override
  String get commonName => 'Nom';

  @override
  String get commonAge => 'Âge';

  @override
  String get commonGender => 'Sexe';

  @override
  String get commonMobileNo => 'N° de portable';

  @override
  String get commonAddress => 'Adresse';

  @override
  String get commonRemarks => 'Remarques';

  @override
  String get colSrNo => 'N°';

  @override
  String get colPatientId => 'N° patient';

  @override
  String get colPatientName => 'Nom du patient';

  @override
  String get colAbhaNo => 'N° ABHA';

  @override
  String get colDistrictName => 'District';

  @override
  String get colInstituteName => 'Établissement';

  @override
  String get colMachineCount => 'Nombre de machines';

  @override
  String get colCommencementDate => 'Date de mise en service';

  @override
  String get colPatientRegistered => 'Patients enregistrés';

  @override
  String get colSessionDone => 'Séances effectuées';

  @override
  String get colScheme => 'Régime';

  @override
  String get colSessionCount => 'Nombre de séances';

  @override
  String get colViewPatient => 'Voir le patient';

  @override
  String get colUnitName => 'Nom de l\'unité';

  @override
  String get colTotal => 'Total';

  @override
  String get colTotalCount => 'Nombre total';

  @override
  String get colTotalPatientRegister => 'Total patients enregistrés';

  @override
  String get colType => 'Type';

  @override
  String get colCount => 'Nombre';

  @override
  String get colEventName => 'Nom de l\'événement';

  @override
  String get colEventCount => 'Nombre d\'événements';

  @override
  String get colTreatmentId => 'N° de traitement';

  @override
  String get colSchemeName => 'Nom du régime';

  @override
  String get colViralLoadStatus => 'Statut de charge virale';

  @override
  String get colInvoiceAmount => 'Montant de la facture';

  @override
  String get colMonthYear => 'Mois-Année';

  @override
  String get colMjpjayCount => 'Nombre MJPJAY';

  @override
  String get colNonMjpjayCount => 'Nombre hors MJPJAY';

  @override
  String get colTicketTypeDataCorrection =>
      'Types de ticket\nCorrection de données';

  @override
  String get colTicketTypeNewRequirement =>
      'Types de ticket\nNouvelle exigence';

  @override
  String get colTicketTypeOperatorIssue =>
      'Types de ticket\nProblème opérateur';

  @override
  String get colTicketTypeSoftwareServices =>
      'Types de ticket\nServices logiciels';

  @override
  String get colTicketTypeBug => 'Types de ticket\nAnomalie';

  @override
  String get colTicketTypeEnhancement => 'Types de ticket\nAmélioration';

  @override
  String get colComplaintTypeDenialOfService =>
      'Types de plainte\nRefus de service';

  @override
  String get colComplaintTypeMoneyTaken =>
      'Types de plainte\nArgent perçu pour le traitement';

  @override
  String get colTestTypePending => 'Types de test\nEn attente';

  @override
  String get colTestTypeComplete => 'Types de test\nTerminé';

  @override
  String get dashShowData => 'Afficher les données';

  @override
  String get dashPending => 'En attente';

  @override
  String get dashComplete => 'Terminé';

  @override
  String get dashTotalPending => 'Total en attente';

  @override
  String get dashTotalComplete => 'Total terminé';

  @override
  String get dashSchemeMjpjay => 'MJPJAY';

  @override
  String get dashSchemeNonMjpjay => 'Hors MJPJAY';

  @override
  String get dashToday => 'Aujourd\'hui';

  @override
  String get dashFromDate => 'Date de début';

  @override
  String get dashToDate => 'Date de fin';

  @override
  String get dashSelectDate => 'Sélectionner une date';

  @override
  String get dashCurrentDate => 'Date du jour';

  @override
  String get dashCurrentDay => 'Jour en cours';

  @override
  String get dashTillDate => 'À ce jour';

  @override
  String get dashDateWise => 'Par date';

  @override
  String get dashWorking => 'En service';

  @override
  String get dashSchemePerformance => 'Performance du régime';

  @override
  String get dashPatientRegistration => 'Enregistrement des patients';

  @override
  String get dashPatientAddedList => 'Liste des patients ajoutés';

  @override
  String get dashAbhaRegistration => 'Enregistrement ABHA';

  @override
  String get dashDialysisSessions => 'Séances de dialyse';

  @override
  String get dashDialysisSession => 'Séance de dialyse';

  @override
  String get dashDialysisCancelled => 'Dialyses annulées';

  @override
  String get dashDialysisCancel => 'Annulation de dialyse';

  @override
  String get dashTotalDialysisCancelled => 'Total des dialyses annulées';

  @override
  String get dashOnlineComplaints => 'Plaintes en ligne';

  @override
  String get dashTotalOnlineComplaints => 'Total des plaintes en ligne';

  @override
  String get dashOnlineTickets => 'Tickets en ligne';

  @override
  String get dashFeedbackTitle => 'Retour d\'information';

  @override
  String get dashDateWiseFeedback => 'Retours par date';

  @override
  String get dashLabTestAssigned => 'Tests de laboratoire assignés';

  @override
  String get dashDateWiseLabTest => 'Tests de laboratoire assignés par date';

  @override
  String get dashTotalLabTestAssigned =>
      'Total des tests de laboratoire assignés';

  @override
  String get dashEventOccurred => 'Événements survenus';

  @override
  String get dashDateWiseEvents => 'Événements par date';

  @override
  String get dashTotalAdverseEvent => 'Total des événements indésirables';

  @override
  String get dashComplaintDashboardDown => 'Tableau de bord hors service';

  @override
  String get dashComplaintMachineNotWorking => 'Machine en panne';

  @override
  String get dashComplaintDenialOfServices => 'Refus de services';

  @override
  String get dashComplaintMoneyTaken => 'Argent perçu pour le traitement';

  @override
  String get dashTicketDataCorrection => 'Correction de données';

  @override
  String get dashTicketNewRequirement => 'Nouvelle exigence';

  @override
  String get dashTicketOperatorIssue => 'Problème opérateur';

  @override
  String get dashTicketSoftwareServices => 'Services logiciels';

  @override
  String get dashTicketBug => 'Anomalie';

  @override
  String get dashTicketEnhancement => 'Amélioration';

  @override
  String get dashCentralDashboard => 'Tableau de bord central';

  @override
  String get dashTotalFunctionalUnit => 'Total des unités fonctionnelles';

  @override
  String get dashTotalProjectedCenter => 'Total des centres prévus';

  @override
  String get dashFunctionalCenter => 'Centre fonctionnel';

  @override
  String get dashTotalDialysisPatient => 'Total des patients dialysés';

  @override
  String get dashTotalPatient => 'Total des patients';

  @override
  String get dashTotalPatientRegistration =>
      'Total des enregistrements de patients';

  @override
  String get dashTotalAbhaPatient => 'Total des patients ABHA';

  @override
  String get dashTotalAbhaRegistration => 'Total des enregistrements ABHA';

  @override
  String get dashTotalDialysisSessions => 'Total des séances de dialyse';

  @override
  String get dashTotalMachines => 'Total des machines';

  @override
  String get dashAdverseEvents => 'Événements indésirables';

  @override
  String get dashAdverseEvent => 'Événement indésirable';

  @override
  String get dashTickets => 'Tickets';

  @override
  String get dashTotalTickets => 'Total des tickets';

  @override
  String get dashTotalFeedback => 'Total des retours';

  @override
  String get dashTotalInvoiceAmount => 'Montant total des factures';

  @override
  String get dashCurrentMonth => 'Mois en cours';

  @override
  String get dashTotalPayment => 'Paiement total';

  @override
  String get dashDialysisPerformance => 'Performance de dialyse';

  @override
  String get dashClusterDistrictDashboard => 'Tableau de bord du district';

  @override
  String get dashClusterDivisionDashboard => 'Tableau de bord de la division';

  @override
  String get dashCurrentDatePatientRegistered =>
      'Patients enregistrés à la date du jour';

  @override
  String get dashDateWisePatientRegistered =>
      'Nombre de patients enregistrés par date';

  @override
  String get dashCurrentDateAbhaRegistration =>
      'Enregistrements ABHA à la date du jour';

  @override
  String get dashDateWiseAbhaPatient => 'Nombre de patients ABHA par date';

  @override
  String get dashCurrentDateDialysisSession =>
      'Séances de dialyse à la date du jour';

  @override
  String get dashDateWiseDialysisSession =>
      'Nombre de séances de dialyse par date';

  @override
  String get dashCurrentDateDialysisCancelled =>
      'Dialyses annulées à la date du jour';

  @override
  String get dashDateWiseDialysisCancel =>
      'Nombre de dialyses annulées par date';

  @override
  String get dashCurrentDateLabTest =>
      'Tests de laboratoire assignés à la date du jour';

  @override
  String get dashDateWiseTestAssign => 'Nombre de tests assignés par date';

  @override
  String get dashCurrentDateAdverseEvent =>
      'Événements indésirables à la date du jour';

  @override
  String get dashDateWiseAdverseEvent =>
      'Nombre d\'événements indésirables par date';

  @override
  String get dashCurrentDateFeedback => 'Retours à la date du jour';

  @override
  String get dashMisDashboard => 'Tableau de bord MIS';

  @override
  String get misFunctionalInstitute => 'Établissements fonctionnels';

  @override
  String get misNumberOfPatients => 'Nombre de patients';

  @override
  String get misDialysisUnderMjpjay => 'Traitements de dialyse sous MJPJAY';

  @override
  String get misDialysisUnderNonMjpjay => 'Traitements de dialyse hors MJPJAY';

  @override
  String get misSeroPositive => 'Patients séropositifs';

  @override
  String get misSeroNegative => 'Patients séronégatifs';

  @override
  String get misLabTestsSentToMahaLabs =>
      'Nombre de tests de laboratoire envoyés à MAHA LABS';

  @override
  String get dashTotalDialysis => 'Total dialyses';

  @override
  String get dashPatientVerification => 'Vérification des patients';

  @override
  String get dashTotalEventOccurred => 'Total des événements survenus';

  @override
  String get dashTotalActiveMachines => 'Total des machines actives';

  @override
  String get dashTotalOnlineTickets => 'Total des tickets en ligne';

  @override
  String get scrutinyApproval => 'Approbation du contrôle';

  @override
  String get commonSearchBy => 'Rechercher par';

  @override
  String get searchHintAppNoDateIdName =>
      'N° de demande, date, ID patient, nom';

  @override
  String get commonNoDataFoundDescription =>
      'Nous ne trouvons pas les données que vous recherchez.';

  @override
  String get patientDetailsTitle => 'Détails du patient';

  @override
  String get viewApplication => 'Voir la demande';

  @override
  String get tabApplicationDetails => 'Détails de la demande';

  @override
  String get tabServiceDescription => 'Description du service';

  @override
  String get colApplicationNo => 'N° de demande';

  @override
  String get colApplicationDate => 'Date de la demande';

  @override
  String get colApplicationNumber => 'Numéro de demande';

  @override
  String get colApplicantName => 'Nom du demandeur';

  @override
  String get colServiceName => 'Nom du service';

  @override
  String get colBloodGroup => 'Groupe sanguin';

  @override
  String get colHeight => 'Taille';

  @override
  String get colWeight => 'Poids';

  @override
  String get colDateOfRegistration => 'Date d\'enregistrement';

  @override
  String get colNephrologistName => 'Nom du néphrologue';

  @override
  String get colRelativeName => 'Nom du proche';

  @override
  String get colRelativeContact => 'Contact du proche';

  @override
  String get colAbhaNumber => 'Numéro ABHA';

  @override
  String get colTreatmentUnderScheme => 'Traitement dans le cadre du régime';

  @override
  String get nephroOngoingDialysisSession => 'Séance de dialyse en cours';

  @override
  String get nephroAnswer => 'Réponse';

  @override
  String get nephroAction => 'Action';

  @override
  String get nephroDescription => 'Description';

  @override
  String get nephroRemark => 'Remarque';

  @override
  String get nephroEnterHint => 'Saisir';

  @override
  String get nephroApprove => 'Approuver';

  @override
  String get nephroReject => 'Rejeter';

  @override
  String get nephroSendBack => 'Renvoyer';

  @override
  String get nephroLevel1 => 'Niveau 1';

  @override
  String get nephroLevel2 => 'Niveau 2';

  @override
  String get nephroFillMandatory => 'Veuillez remplir les champs obligatoires';

  @override
  String get chartMjpjayCounts => 'Nombre MJPJAY';

  @override
  String get chartNonMjpjayCounts => 'Nombre hors MJPJAY';

  @override
  String get commonInfo => 'Info';

  @override
  String get commonDocument => 'Document';

  @override
  String get regNewRegistration => 'Nouvel enregistrement';

  @override
  String get regEditPatientDetails => 'Modifier les détails du patient';

  @override
  String get regViewPatientDetails => 'Voir les détails du patient';

  @override
  String get tabPersonalInfo => 'Infos personnelles';

  @override
  String get tabDemographicInfo => 'Infos démographiques';

  @override
  String get tabHistoryOfDialysis => 'Historique de dialyse';

  @override
  String get tabUploadDocument => 'Téléverser un document';

  @override
  String get regPatientInformation => 'Informations sur le patient';

  @override
  String get regPermanentAddress => 'Adresse permanente';

  @override
  String get regResidentialAddress => 'Adresse résidentielle';

  @override
  String get regSocioEcoStatus => 'Statut socio-économique';

  @override
  String get regEmergencyRelativeInfo =>
      'Coordonnées du proche en cas d\'urgence';

  @override
  String get regSameAsResidential =>
      'L\'adresse permanente est identique à l\'adresse résidentielle';

  @override
  String get regFirstTimeDialysis => 'Première dialyse ?';

  @override
  String get regPatientName => 'Nom du patient';

  @override
  String get regPrefix => 'Civilité';

  @override
  String get regFirstName => 'Prénom';

  @override
  String get regMiddleName => 'Deuxième prénom';

  @override
  String get regLastName => 'Nom';

  @override
  String get regDob => 'Date de naissance';

  @override
  String get regEmailId => 'Adresse e-mail';

  @override
  String get regContactNo => 'N° de contact';

  @override
  String get regContactNumber => 'Numéro de contact';

  @override
  String get regHeightFt => 'Taille (en pieds)';

  @override
  String get regHeightCm => 'Taille (en cm)';

  @override
  String get regWeight => 'Poids (kg-g)';

  @override
  String get regMaritalStatus => 'État civil';

  @override
  String get regReligion => 'Religion';

  @override
  String get regEducation => 'Niveau d\'études';

  @override
  String get regOccupation => 'Profession';

  @override
  String get regMonthlyIncome => 'Revenu mensuel';

  @override
  String get regNationality => 'Nationalité';

  @override
  String get regCountry => 'Pays';

  @override
  String get regAbhaId => 'Identifiant ABHA';

  @override
  String get regAbhaNo => 'N° ABHA';

  @override
  String get regAbhaAddress => 'Adresse ABHA';

  @override
  String get regIdProof => 'Pièce d\'identité';

  @override
  String get regIdentificationNumber => 'Numéro d\'identification';

  @override
  String get regSchemeAdopted => 'Régime adopté';

  @override
  String get regMjpjayEnrollmentNo => 'N° d\'inscription MJPJAY';

  @override
  String get regViralMarkerStatus => 'Statut des marqueurs viraux';

  @override
  String get regAddress => 'Adresse';

  @override
  String get regPinCode => 'Code postal';

  @override
  String get regState => 'État';

  @override
  String get regDistrict => 'District';

  @override
  String get regDivision => 'Division';

  @override
  String get regTaluka => 'Taluka';

  @override
  String get regTown => 'Ville';

  @override
  String get regReferredBy => 'Référé par';

  @override
  String get regReferenceByName => 'Nom du référent';

  @override
  String get regReferredContactNumber => 'Numéro de contact du référent';

  @override
  String get regNephrologistName => 'Nom du néphrologue';

  @override
  String get regNephrologistContactNo => 'N° de contact du néphrologue';

  @override
  String get regRelation => 'Lien de parenté';

  @override
  String get regRelativeName => 'Nom du proche';

  @override
  String get regDialysisMode => 'Mode de dialyse';

  @override
  String get regDialysisFreqWeek => 'Fréquence de dialyse par semaine';

  @override
  String get regFirstDialysisSessionDate =>
      'Date de la première séance de dialyse';

  @override
  String get regLastDialysisSessionDate =>
      'Date de la dernière séance de dialyse';

  @override
  String get regLastDialysisHospitalName => 'Nom du dernier hôpital de dialyse';

  @override
  String get regHintSelect => 'Sélectionner';

  @override
  String get regHintSelectTitle => 'Sélectionner la civilité';

  @override
  String get regHintEnter => 'Saisir';

  @override
  String get regHintEnterName => 'Saisir le nom';

  @override
  String get regHintEnterFirstName => 'Saisir le prénom';

  @override
  String get regHintEnterMiddleName => 'Saisir le deuxième prénom';

  @override
  String get regHintEnterLastName => 'Saisir le nom';

  @override
  String get regHintEnterAddress => 'Saisir l\'adresse';

  @override
  String get regHintEnterPinCode => 'Saisir le code postal';

  @override
  String get regHintEnterContactNumber => 'Saisir le numéro de contact';

  @override
  String get regHintEnterEmail => 'Saisir l\'adresse e-mail';

  @override
  String get regHintEnterNumber => 'Saisir le numéro';

  @override
  String get regHintFeetInches => 'Saisir en pieds et pouces';

  @override
  String get regUploadDocument => 'Téléverser un document';

  @override
  String get regBrowseChooseFiles =>
      'Parcourez et choisissez les fichiers à téléverser';

  @override
  String get regMaxFileSize => 'Taille max. du fichier : 10 Mo';

  @override
  String get regSupportedFormats => 'Formats pris en charge : JPEG, PNG, PDF';

  @override
  String get regSaveNext => 'Enregistrer et continuer';

  @override
  String get regCompleteDemographicFirst =>
      'Veuillez d\'abord compléter les informations démographiques';

  @override
  String get regCompleteHistoryFirst =>
      'Veuillez d\'abord compléter l\'historique de dialyse';

  @override
  String get regCompletePersonalFirst =>
      'Veuillez d\'abord compléter les informations personnelles';

  @override
  String get regFillMandatory => 'Veuillez renseigner les champs obligatoires';

  @override
  String get regSelectDocument => 'Veuillez sélectionner un document';

  @override
  String get regUploadRequiredDocuments =>
      'Veuillez téléverser les documents requis';

  @override
  String get regUpdatedSuccessfully => 'Mise à jour réussie';

  @override
  String get regMobileExists => 'Ce numéro de mobile existe déjà';

  @override
  String get regUploadFailed => 'Échec du téléversement';

  @override
  String get regUploadPhotoSize => 'Téléversez une photo de moins de 500 Ko';

  @override
  String regPleaseNotePatientId(String id) {
    return 'Veuillez noter l\'identifiant patient $id';
  }

  @override
  String get regPrintReport => 'Imprimer le rapport ?';

  @override
  String get regRegistrationCompleted => 'Enregistrement terminé avec succès';

  @override
  String get regRegisteredPatients => 'Patients enregistrés';

  @override
  String get regSelectScheme => 'Sélectionner le régime';

  @override
  String get regSearchPatientHint => 'N° patient, nom, n° de mobile, etc.';

  @override
  String get regDialysisCenter => 'Centre de dialyse';

  @override
  String get regPatientAge => 'Âge du patient';

  @override
  String get patientCardRefBy => 'Réf. par';

  @override
  String get commonValue => 'Valeur';

  @override
  String get commonPrint => 'Imprimer';

  @override
  String get commonProcessing => 'Traitement en cours';

  @override
  String get commonStart => 'Démarrer';

  @override
  String get patientCardDob => 'Date de naissance';

  @override
  String get schedAddSchedular => 'Ajouter une planification de dialyse';

  @override
  String get schedBookAppointment => 'Prendre rendez-vous';

  @override
  String get schedVisitorEntry => 'Entrée du visiteur';

  @override
  String get schedPatientHistory => 'Historique du patient';

  @override
  String get schedDialysisScheduleChart =>
      'Tableau de planification des dialyses';

  @override
  String get schedDialysisPatientList => 'Liste des patients dialysés';

  @override
  String get schedCaseHistory => 'Antécédents médicaux';

  @override
  String get schedDialysisDetails => 'Détails de la dialyse';

  @override
  String get schedPatientDocuments => 'Documents du patient';

  @override
  String get schedSearchPatient => 'Rechercher un patient';

  @override
  String get schedSlot => 'Créneau';

  @override
  String get schedSlotTime => 'Heure du créneau';

  @override
  String get schedBedsAllocated => 'Lits attribués';

  @override
  String get schedBedNo => 'N° de lit';

  @override
  String get schedMachineName => 'Nom de la machine';

  @override
  String get schedAppointmentDate => 'Date du rendez-vous';

  @override
  String get schedVisitDate => 'Date de la visite';

  @override
  String get schedVisitTime => 'Heure de la visite';

  @override
  String get schedIpNumber => 'Numéro d\'hospitalisation';

  @override
  String get schedMjpjayCaseNumber => 'Numéro de dossier MJPJAY';

  @override
  String get schedMjpjayClaimNumber => 'Numéro de demande MJPJAY';

  @override
  String get schedMjpjayEnrollmentId => 'Identifiant d\'inscription MJPJAY';

  @override
  String get schedPreAuthApprovalDate =>
      'Date d\'approbation de la pré-autorisation';

  @override
  String get schedPreAuthNumber => 'Numéro de pré-autorisation';

  @override
  String get schedDocumentName => 'Nom du document :';

  @override
  String get schedNoDocuments => 'Aucun document disponible';

  @override
  String get schedDataSaved => 'Données enregistrées avec succès';

  @override
  String get schedDataSaveFailed => 'Échec de l\'enregistrement des données';

  @override
  String get schedDischargeSummary => 'Résumé de sortie';

  @override
  String get schedSessionEndReport => 'Rapport de fin de séance';

  @override
  String get schedHbsagPositive => 'AgHBs positif';

  @override
  String get schedHcvPositive => 'VHC positif';

  @override
  String get schedHivPositive => 'VIH positif';

  @override
  String get schedHhhNegative => 'HHH négatif';

  @override
  String get clinAccessSite => 'Site d\'accès';

  @override
  String get clinActualFbv => 'VFB réel';

  @override
  String get clinBloodPressure => 'Tension artérielle';

  @override
  String get clinBloodTubingBarcode =>
      'Code-barres/N° de série de la tubulure sanguine';

  @override
  String get clinBloodTubingReuseNo =>
      'N° de réutilisation de la tubulure sanguine';

  @override
  String get clinCaseNarration => 'Description du cas';

  @override
  String get clinDialyserType => 'Type de dialyseur';

  @override
  String get clinDialyzerType => 'Type de dialyseur';

  @override
  String get clinDialysisDuration => 'Durée de la dialyse';

  @override
  String get clinDialysisStartDateTime =>
      'Date et heure de début de la dialyse';

  @override
  String get clinDialysisStopDateTime => 'Date et heure de fin de la dialyse';

  @override
  String get clinDialysisType => 'Type de dialyse';

  @override
  String get clinDialyzerBarcode => 'Code-barres/N° de série du dialyseur';

  @override
  String get clinDialyzerDiscarded => 'Dialyseur jeté';

  @override
  String get clinDialyzerRemark => 'Remarque sur le dialyseur';

  @override
  String get clinDialyzerReuseNo => 'N° de réutilisation du dialyseur';

  @override
  String get clinDryWeight => 'Poids sec';

  @override
  String get clinHeparin => 'Héparine';

  @override
  String get clinInterdialyticGain => 'Prise interdialytique';

  @override
  String get clinOxygenLevel => 'Niveau d\'oxygène';

  @override
  String get clinPostDialysisInjection => 'Injection/médicament post-dialyse';

  @override
  String get clinPostDialysisInvestigation => 'Examens post-dialyse';

  @override
  String get clinPostDialysisWeight => 'Poids post-dialyse';

  @override
  String get clinPreDialysisInvestigation => 'Examens pré-dialyse';

  @override
  String get clinPreDialysisVitals => 'Constantes pré-dialyse';

  @override
  String get clinPreDialysisWeight => 'Poids pré-dialyse';

  @override
  String get clinPreHdCondition => 'État pré-HD';

  @override
  String get clinPulse => 'Pouls';

  @override
  String get clinRespiratoryRate => 'Fréquence respiratoire';

  @override
  String get clinSpecialDialysis => 'Dialyse spéciale';

  @override
  String get clinTemperature => 'Température';

  @override
  String get clinBloodTubingRemark => 'Remarque sur la tubulure sanguine';

  @override
  String get clinCurrentSessionWeightDiff =>
      'Différence de poids de la séance de dialyse en cours';

  @override
  String get clinKtv => 'kt/v';

  @override
  String get clinUfAchieved => 'UF atteinte';

  @override
  String get clinUfr => 'TUF';

  @override
  String get clinTmp => 'PTM';

  @override
  String get clinVp => 'PV';

  @override
  String get clinAp => 'PA';

  @override
  String get clinBfr => 'DSP';

  @override
  String get clinCbv => 'VSC';

  @override
  String get clinCond => 'Cond';

  @override
  String get clinTsat => 'TSAT (%)';

  @override
  String get clinEpoDose => 'Dose d\'EPO';

  @override
  String get clinEpoAdministered => 'EPO administrée';

  @override
  String get clinBolusDose => 'Dose de bolus';

  @override
  String get clinInfusionDose => 'Dose de perfusion';

  @override
  String get clinBpMmhg => 'TA (mmHg)';

  @override
  String get clinBloodPressureMmhg => 'Pression artérielle\n(mmHg)';

  @override
  String get clinPreDialysisDate => 'Date pré-dialyse';

  @override
  String get clinDiscardedRemarks => 'Remarques sur le rejet';

  @override
  String get clinNewDialyzer => 'Nouveau dialyseur';

  @override
  String get dqHdChart => 'Fiche HD';

  @override
  String get dqHdChartList => 'Liste des fiches HD';

  @override
  String get dqPreDialysisDetails => 'Détails pré-dialyse';

  @override
  String get dqPostDialysisDetails => 'Détails post-dialyse';

  @override
  String get dqEditPreDialysisDetails => 'Modifier les détails pré-dialyse';

  @override
  String get dqPreDialysisPatientList => 'Liste des patients pré-dialyse';

  @override
  String get dqPostDialysisPatientList => 'Liste des patients post-dialyse';

  @override
  String get dqDialysisEventDetails => 'Détails de l\'événement de dialyse';

  @override
  String get dqEventQueuedPatientList =>
      'Liste des patients en file d\'attente d\'événement';

  @override
  String get dqInvestigationQueue => 'File d\'attente des examens';

  @override
  String get dqAllTest => 'Tous les tests';

  @override
  String get dqTrendAnalysis => 'Analyse des tendances';

  @override
  String get dqWeightTrendAnalysis => 'Analyse des tendances du poids';

  @override
  String get dqTemperatureTrendAnalysis =>
      'Analyse des tendances de la température';

  @override
  String get dqCoverSheet => 'Feuille de couverture';

  @override
  String get dqSafetyChecks => 'Contrôles de sécurité';

  @override
  String get dqClinicalHistory => 'Antécédents cliniques';

  @override
  String get dqClinicalCondition => 'État clinique';

  @override
  String get dqDiagnosticInv => 'Examens diagnostiques';

  @override
  String get dqDiet => 'Régime alimentaire';

  @override
  String get dqDietDetails => 'Détails du régime alimentaire';

  @override
  String get dqInstruction => 'Consigne';

  @override
  String get dqInstructionDetails => 'Détails de la consigne';

  @override
  String get dqPrescription => 'Prescription';

  @override
  String get dqPrescriptionDetails => 'Détails de la prescription';

  @override
  String get dqLaboratoryInvestigation => 'Examens de laboratoire';

  @override
  String get dqPhysicalEntryConsumable =>
      'Saisie physique des consommables utilisés';

  @override
  String get dqAddEntryConsumable =>
      'Ajouter une entrée de consommable utilisé';

  @override
  String get dqHistory => 'Historique';

  @override
  String get dqPrePostEventInvestigation => 'Examens pré/post-événement';

  @override
  String get dqStartDialysis => 'Démarrer la dialyse';

  @override
  String get dqStopDialysis => 'Arrêter la dialyse';

  @override
  String get dqAnalyze => 'Analyser';

  @override
  String get dqAddBarcodeNo => 'Ajouter un code-barres';

  @override
  String get dqInvalidInput => 'Saisie invalide';

  @override
  String get dqSaveFailed => 'Échec de l\'enregistrement';

  @override
  String get dqFailSaveMachineReading =>
      'Échec de l\'enregistrement du relevé de la machine';

  @override
  String get dqProductShouldNotSame => 'Le produit ne doit pas être le même';

  @override
  String get dqPreDialysisTab => 'Pré-dialyse';

  @override
  String get dqPostDialysisTab => 'Post-dialyse';

  @override
  String get dqActionTaken => 'Mesure prise';

  @override
  String get dqAvailableQuantity => 'Quantité disponible';

  @override
  String get dqBarcodeNo => 'N° de code-barres';

  @override
  String get dqBatchNo => 'N° de lot';

  @override
  String get dqConsumedQuantity => 'Quantité consommée';

  @override
  String get dqDialysisIncidentType => 'Type d\'incident de dialyse';

  @override
  String get dqDialysisIncidentSubType => 'Sous-type d\'incident de dialyse';

  @override
  String get dqDuration => 'Durée';

  @override
  String get dqEventDescription => 'Description de l\'événement';

  @override
  String get dqExpiryDate => 'Date d\'expiration';

  @override
  String get dqOrderId => 'N° de commande';

  @override
  String get dqProductName => 'Nom du produit';

  @override
  String get dqQuantity => 'Quantité';

  @override
  String get dqTestId => 'N° de test';

  @override
  String get dqTestName => 'Nom du test';

  @override
  String get dqCounter => 'Compteur';

  @override
  String get commonActive => 'Actif';

  @override
  String get commonComments => 'Commentaires';

  @override
  String get commonReason => 'Motif';

  @override
  String get commonQuantity => 'Quantité';

  @override
  String get commonDays => 'Jours';

  @override
  String get commonUnit => 'Unité';

  @override
  String get clinBloodGlucose => 'Glycémie';

  @override
  String get clinPastSurgicalHistory => 'Antécédents chirurgicaux';

  @override
  String get clinMedicationMethod => 'Mode d\'administration';

  @override
  String get clinAlcoholConsumption => 'Consommation d\'alcool';

  @override
  String get clinAlcoholCurrentStat => 'Statut actuel (alcool)';

  @override
  String get clinAlcoholDuration => 'Durée (alcool)';

  @override
  String get clinDrugCurrentStat => 'Statut actuel (drogue)';

  @override
  String get clinDrugDuration => 'Durée (drogue)';

  @override
  String get clinIllicitDrug => 'Drogue illicite';

  @override
  String get clinSmoking => 'Tabagisme';

  @override
  String get clinSmokingCurrentStat => 'Statut actuel (tabac)';

  @override
  String get clinSmokingDuration => 'Durée (tabac)';

  @override
  String get clinTobaccoConsumption => 'Consommation de tabac';

  @override
  String get clinTobaccoCurrentStat => 'Statut actuel (tabac)';

  @override
  String get clinTobaccoDuration => 'Durée (tabac)';

  @override
  String get nephroClinicalNotes => 'Notes cliniques';

  @override
  String get nephroDiagnosisDescription => 'Diagnostic et description';

  @override
  String get nephroDosage => 'Posologie';

  @override
  String get nephroFrequency => 'Fréquence';

  @override
  String get nephroRoute => 'Voie d\'administration';

  @override
  String get nephroPrep => 'Préparation';

  @override
  String get nephroTemplate => 'Modèle';

  @override
  String get nephroIcd10Code => 'Code CIM-10';

  @override
  String get nephroInstructions => 'Consignes';

  @override
  String get nephroInstructionEnglish => 'Consigne en anglais';

  @override
  String get nephroInstructionMarathi => 'Consigne en marathi';

  @override
  String get nephroInstructionHindi => 'Consigne en hindi';

  @override
  String get nephroOtherLanguage1 => 'Autre langue 1';

  @override
  String get nephroOtherLanguage2 => 'Autre langue 2';

  @override
  String get nephroOtherLanguage3 => 'Autre langue 3';

  @override
  String get nephroDiagnosisType => 'Type de diagnostic';

  @override
  String get nephroDiet => 'Régime alimentaire';

  @override
  String get nephroSpecialInstructions => 'Consignes particulières';

  @override
  String get nephroTreatmentPlan => 'Plan de traitement';

  @override
  String get nephroAddDetails => 'Ajouter des détails';

  @override
  String get nephroAddNewInstruction => 'Ajouter une nouvelle consigne';

  @override
  String get nephroAddToTest => 'Ajouter au test';

  @override
  String get nephroViewReport => 'Voir le rapport';

  @override
  String get nephroChooseTest => 'Choisir un test';

  @override
  String get nephroMedicineName => 'Nom du médicament';

  @override
  String get nephroTestName => 'Nom du test';

  @override
  String get nephroDiagnosis => 'Diagnostic';

  @override
  String get nephroClinicalHistory => 'Antécédents cliniques';

  @override
  String get nephroClinicalHistoryStatus => 'Statut des antécédents cliniques';

  @override
  String get nephroInvestigationScheduling =>
      'Détails de planification des examens';

  @override
  String get nephroNoPrescriptions => 'Aucune prescription trouvée';

  @override
  String get nephroGeneralInfo => 'Informations générales';

  @override
  String get nephroOnExamination => 'À L\'EXAMEN';

  @override
  String get nephroSystematicExaminations => 'EXAMENS SYSTÉMATIQUES';

  @override
  String get nephroSelectFileToUpload => 'Sélectionner un fichier à téléverser';

  @override
  String get nephroEnterComments => 'Saisir des commentaires';

  @override
  String get nephroDeleteInstructionConfirm =>
      'Êtes-vous sûr de vouloir supprimer cette consigne ?';

  @override
  String get nephroConfirmed => 'Confirmé';

  @override
  String get nephroProvisional => 'Provisoire';

  @override
  String get nephroUrgent => 'Urgent';

  @override
  String get nephroBmi => 'IMC';

  @override
  String get nephroMachineNo => 'N° de machine';

  @override
  String get nephroNephrologistName => 'Nom du néphrologue';

  @override
  String get nephroRegistrationDate => 'Date d\'enregistrement';

  @override
  String get nephroPatientMobileNo => 'N° de mobile du patient';

  @override
  String get nephroRelativeName => 'Nom du proche';

  @override
  String get nephroAssignedToTechnician => 'Attribué au technicien';

  @override
  String get nephroClinicalConditionSaved => 'État clinique enregistré';

  @override
  String get nephroDocumentDeleted => 'Document supprimé';

  @override
  String get nephroEnterTest => 'Saisir un test';

  @override
  String get nephroSelectCheckbox => 'Veuillez cocher une case';

  @override
  String get nephroRecordUpdated => 'Enregistrement mis à jour avec succès';

  @override
  String get nephroTestAdded => 'Test ajouté';

  @override
  String get nephroTestAddFail => 'Échec de l\'ajout du test';

  @override
  String get nephroDiagnosisDeleted => 'Diagnostic supprimé avec succès';

  @override
  String get nephroErrorSavingDiet =>
      'Erreur lors de l\'enregistrement du régime';

  @override
  String get nephroFailedSaveDiet => 'Échec de l\'enregistrement du régime';

  @override
  String get nephroRecordsDeleted => 'Enregistrements supprimés avec succès';

  @override
  String get nephroUnauthorized => 'Requête non autorisée';

  @override
  String get nephroAddTestsPackages => 'Ajouter des tests/forfaits';

  @override
  String get nephroSelectPackage => 'Sélectionner un forfait';

  @override
  String nephroUploadError(Object error) {
    return 'Erreur de téléversement : $error';
  }

  @override
  String get commonApprove => 'Approuver';

  @override
  String get commonGenerate => 'Générer';

  @override
  String get dischTermsConditions => 'Conditions générales';

  @override
  String get dischDischarge => 'Sortie';

  @override
  String get dischSessionEndPatientList =>
      'Liste des patients en fin de séance';

  @override
  String get dischApprovalStatus => 'Statut d\'approbation';

  @override
  String get dischDialysisDate => 'Date de dialyse';

  @override
  String get machMachineCounter => 'Compteur de machine';

  @override
  String get machMachineFilter => 'Filtre de machine';

  @override
  String get machAddMachineCounter => 'Ajouter un compteur de machine';

  @override
  String get machMachineName => 'Nom de la machine';

  @override
  String get billInvoiceApprovalSecondLevel =>
      'APPROBATION DE FACTURE (2e NIVEAU)';

  @override
  String get billInvoiceGeneration => 'Génération de factures';

  @override
  String get billFilterInvoice => 'Filtrer les factures';

  @override
  String get billServiceCertificate => 'Certificat de service';

  @override
  String get billViewServiceCertificate => 'Voir le certificat de service';

  @override
  String get billServiceCertificateDetails =>
      'Détails du certificat de service';

  @override
  String get billMonth => 'Mois';

  @override
  String get billYear => 'Année';

  @override
  String get bookChooseSlot => 'Choisir un créneau';

  @override
  String get bookSelectInstitute => 'Sélectionner un établissement';

  @override
  String get bookBookingFailed => 'Échec de la réservation';

  @override
  String get bookHivPositive => 'VIH+';

  @override
  String get bookHepatitisCPositive => 'Hépatite C+';

  @override
  String get bookNegative => 'Négatif';

  @override
  String get photoTakePhoto => 'Prendre une photo';

  @override
  String get photoCapturePhoto => 'Capturer une photo';

  @override
  String get photoDataSaved => 'Données enregistrées avec succès';

  @override
  String photoUploadFailed(Object reason) {
    return 'Échec du téléversement : $reason';
  }

  @override
  String get cctvCameraDetails => 'Détails de la caméra CCTV';

  @override
  String get cctvCamera => 'Caméra CCTV';

  @override
  String get uploadDocuments => 'Téléverser des documents';

  @override
  String get uploadNoDocument => 'Aucun document disponible';

  @override
  String get uploadUploading => 'Téléversement…';

  @override
  String get uploadCropPhoto => 'Recadrer la photo';

  @override
  String get uploadFeedback => 'Retour d\'information';

  @override
  String get uploadHdChart => 'Fiche HD';

  @override
  String get uploadTreatmentDate => 'Date de traitement';

  @override
  String uploadUploadedOn(Object dateTime) {
    return 'Téléversé le : $dateTime';
  }

  @override
  String get roDisinfectionDetails => 'Détails de désinfection RO';

  @override
  String get roLogSheet => 'Feuille de relevé RO';

  @override
  String get roAddLogSheet => 'Ajouter une feuille de relevé RO';

  @override
  String get roDailyLogSheet => 'Feuille de relevé RO quotidienne';

  @override
  String get roMachineIssueLogs => 'Journaux des incidents de machine RO';

  @override
  String get roBackwash => 'Contre-lavage';

  @override
  String get roRinse => 'Rinçage';

  @override
  String get roCallAttendedBy => 'Appel traité par';

  @override
  String get roCheckedBy => 'Vérifié par';

  @override
  String get roCorrectionAction => 'Mesure corrective';

  @override
  String get roDifference => 'Différence';

  @override
  String get roDoneBy => 'Effectué par';

  @override
  String get roImageName => 'Nom de l\'image';

  @override
  String get roInformationDate => 'Date d\'information';

  @override
  String get roInformedBy => 'Informé par';

  @override
  String get roInformedTo => 'Informé à';

  @override
  String get roInspectionDate => 'Date d\'inspection';

  @override
  String get roIssueDate => 'Date de l\'incident';

  @override
  String get roIssueDescription => 'Description de l\'incident';

  @override
  String get roNextInspectionDate => 'Date de la prochaine inspection';

  @override
  String get roProblemResolved => 'Problème résolu';

  @override
  String get roRange => 'Plage';

  @override
  String get roSpecialNo => 'Veuillez saisir le n° spécial';

  @override
  String get roTypeOfDisinfection => 'Type de désinfection utilisé';

  @override
  String get roImageUpload => 'Téléversement d\'image';

  @override
  String get roSoftenerRegistration => 'Enregistrement de l\'adoucisseur';

  @override
  String get roLooplineTds => 'TDS boucle (ppm)';

  @override
  String get roPostCarbonChlorine => 'Chlore post-filtre à charbon (ppm)';

  @override
  String get roPostMembraneTds => 'TDS post-membrane (ppm)';

  @override
  String get roPostMixbedTds => 'TDS post-lit mixte (ppm)';

  @override
  String get roPostSoftenerHardness => 'Dureté post-adoucisseur (ppm)';

  @override
  String get roPostSoftenerTds => 'TDS post-adoucisseur (ppm)';

  @override
  String get roProductPermeateFlow => 'Débit produit/perméat (l/h)';

  @override
  String get roRawWaterTdsPpm => 'TDS eau brute (ppm)';

  @override
  String get roRejectFlowLph => 'Débit de rejet (l/h)';

  @override
  String get roCarbonFilterPressure => 'Pression du filtre à charbon (PSI)';

  @override
  String get roRoWaterTds => 'TDS eau RO (PPM)';

  @override
  String get roRawWaterTds => 'TDS eau brute (PPM)';

  @override
  String get roReturnLoopPressure => 'Pression de la boucle de retour (PSI)';

  @override
  String get roSoftenerPressure => 'Pression de l\'adoucisseur (PSI)';

  @override
  String get roPre => 'Avant';

  @override
  String get roPost => 'Après';

  @override
  String get roPump => 'Pompe';

  @override
  String get roWater => 'Eau';

  @override
  String get roSand => 'Sable';

  @override
  String get roSandFilter => 'Filtre à sable';

  @override
  String get roCarbon => 'Charbon';

  @override
  String get roCarbonFilter => 'Filtre à charbon';

  @override
  String get roSoftner => 'Adoucisseur';

  @override
  String get roRawWaterPump => 'Pompe d\'eau brute';

  @override
  String get roTransferPump => 'Pompe de transfert';

  @override
  String get roUvLamp => 'Lampe UV';

  @override
  String get roSaveFailed => 'Échec de l\'enregistrement';

  @override
  String get roSavedSuccessfully => 'Enregistré avec succès';

  @override
  String get phtPatientHealthTrends => 'Tendances de santé du patient';

  @override
  String get phtHaemoglobinTracking => 'Rapport de suivi de l\'hémoglobine';

  @override
  String get phtInvestigationResultChart =>
      'Graphique des résultats d\'examens de dialyse du patient';

  @override
  String get phtVitalChart => 'Graphique des constantes de dialyse du patient';

  @override
  String get phtPatientVitalChart => 'Graphique des constantes du patient';

  @override
  String get phtGenerateReport => 'Générer le rapport';

  @override
  String get phtShowRecord => 'Afficher l\'enregistrement';

  @override
  String get phtShowReport => 'Afficher le rapport';

  @override
  String get phtVitalParameters => 'Paramètres vitaux';

  @override
  String get phtValuesByDate => 'Valeurs par date';

  @override
  String get phtSelectDateRange => 'Sélectionner une plage de dates';

  @override
  String get phtSearchPatient => 'Rechercher un patient';

  @override
  String get phtSelectDateRangeTap =>
      'Sélectionnez une plage de dates et appuyez';

  @override
  String get phtNoVitalData => 'Aucune donnée vitale disponible';

  @override
  String get phtNoChartData => 'Aucune donnée de graphique disponible';

  @override
  String get phtNoValidDataPoints => 'Aucun point de données valide à afficher';

  @override
  String get phtDataNotFound => 'Données introuvables';

  @override
  String phtLatestValue(Object value) {
    return 'Dernière valeur : $value';
  }

  @override
  String phtLatest(Object value) {
    return 'Dernière : $value';
  }

  @override
  String get phtSearchHint => 'Rechercher par nom ou identifiant du patient';

  @override
  String get dqPreDialysis => 'Pré-dialyse';

  @override
  String get dqPostDialysis => 'Post-dialyse';

  @override
  String get dqDialysisEvent => 'Événement de dialyse';

  @override
  String get dqInvestigation => 'Examen';

  @override
  String get dqConsumableEntry => 'Saisie des consommables';

  @override
  String get roMachineLogSheet => 'Feuille de relevé de machine RO';

  @override
  String get phtMenuVitalChart => 'Graphique des constantes de dialyse';

  @override
  String get phtMenuInvestChart =>
      'Graphique des résultats d\'examens de dialyse';

  @override
  String get colParticulars => 'Détails';

  @override
  String get colReport => 'Rapport';

  @override
  String get colDrugs => 'Médicaments';

  @override
  String get colFreq => 'Fréq.';

  @override
  String get colPackageName => 'Nom du forfait';

  @override
  String get colClinicalHistoryDate => 'Date des antécédents cliniques';

  @override
  String get colInstructionName => 'Nom de la consigne';

  @override
  String get colComorbidities => 'Comorbidités';

  @override
  String get colYesNo => 'Oui/Non';

  @override
  String get nephroAddClinicalCondition => 'Ajouter un état clinique';

  @override
  String get nephroEditClinicalCondition => 'Modifier l\'état clinique';

  @override
  String get nephroConsultantName => 'Nom du consultant';

  @override
  String get nephroEvent => 'Événement';

  @override
  String get nephroChoosePackages => 'Choisir des forfaits';

  @override
  String get nephroDeleteTest => 'Supprimer le test';

  @override
  String get nephroDeleteTestConfirm =>
      'Êtes-vous sûr de vouloir supprimer ce test ?';

  @override
  String get nephroTestAlreadyAssigned =>
      'Ce test est déjà attribué au patient';

  @override
  String get nephroAddPrescription => 'Ajouter une prescription';

  @override
  String get nephroEditPrescription => 'Modifier la prescription';

  @override
  String get nephroMorning => 'Matin';

  @override
  String get nephroAfternoon => 'Après-midi';

  @override
  String get nephroEvening => 'Soir';

  @override
  String get nephroNight => 'Nuit';

  @override
  String get nephroStrength => 'Concentration';

  @override
  String get nephroDose => 'Dose';

  @override
  String get nephroPrescribedBy => 'Prescrit par';

  @override
  String get nephroAddDiet => 'Ajouter un régime alimentaire';

  @override
  String get nephroEditDiet => 'Modifier le régime alimentaire';

  @override
  String get nephroIndividualInstructions => 'Consignes individuelles';

  @override
  String get nephroDeleteInstruction => 'Supprimer la consigne';

  @override
  String get nephroSaveInstructions => 'Enregistrer les consignes';

  @override
  String get schedDialysisCenter => 'Centre de dialyse';

  @override
  String get schedState => 'État';

  @override
  String schedApprovalInProcess(String type) {
    return 'L\'approbation de $type est en cours';
  }

  @override
  String get schedFrequencyScheduleMismatch =>
      'Veuillez planifier selon la fréquence sélectionnée';

  @override
  String get schedSelectDateAndSlot =>
      'Veuillez sélectionner la date et le créneau';

  @override
  String get schedAlreadyBooked => 'Déjà réservé';

  @override
  String schedAppointmentAlreadyGiven(String date) {
    return 'Rendez-vous déjà attribué le $date';
  }

  @override
  String get schedSlotNotAvailable => 'Créneau non disponible';

  @override
  String schedOnThisDate(String date) {
    return 'À cette date $date';
  }

  @override
  String get schedScheduleConfirmed => 'Planification confirmée';

  @override
  String get schedScheduleConfirmedMsg =>
      'Votre planification a été confirmée avec succès.';

  @override
  String get schedAddSchedularFailed => 'Échec de l\'ajout de la planification';

  @override
  String get schedViewLabInvest => 'Voir l\'examen de laboratoire';

  @override
  String get schedAppointmentCancelled => 'Rendez-vous annulé';

  @override
  String get schedAppointmentCancelledMsg => 'Rendez-vous annulé avec succès';

  @override
  String get schedCancelAppointmentConfirm =>
      'Êtes-vous sûr ? Voulez-vous annuler le rendez-vous ?';

  @override
  String get clinFinalUfv => 'UFV final';

  @override
  String get clinVenousPressure => 'Pression veineuse';

  @override
  String get clinBloodFlowQb => 'Débit sanguin (QB)';

  @override
  String get clinDialysateFlowQd => 'Débit du dialysat (QD)';

  @override
  String get clinRrfUrineVolume => 'Volume urinaire RRF (ml/jour)';

  @override
  String get clinPercentOfFbv => '% du VFB';

  @override
  String get commonNoConsultationDetails =>
      'Aucun détail de consultation disponible.';

  @override
  String get commonChooseFile => 'Choisir un fichier';

  @override
  String get schedOxygenSupplyAvailable =>
      'Alimentation en oxygène suffisante disponible au lit';

  @override
  String get schedFuelAvailableGenset =>
      'Carburant suffisant disponible pour le groupe électrogène de l\'hôpital';

  @override
  String get schedIronSucrose => 'Fer saccharose';

  @override
  String get schedCurrentSessionUnderScheme =>
      'Séance de dialyse actuelle dans le cadre du régime';

  @override
  String get schedLastSessionUnderScheme =>
      'Dernière séance de dialyse dans le cadre du régime';

  @override
  String get schedReasonNotRegisteredMjpjay =>
      'Motif de non-inscription à MJPJAY';

  @override
  String schedPendingSession(String count) {
    return 'Séance en attente $count';
  }

  @override
  String schedEffectiveDatePendingSession(String date, String count) {
    return 'Date d\'effet $date et séance en attente $count';
  }

  @override
  String get bookConfirmBookAppointment =>
      'Êtes-vous sûr ?\nVoulez-vous prendre le rendez-vous ?';

  @override
  String get bookSelectBed => 'Veuillez sélectionner un lit';

  @override
  String get schedDieticianConsultationDone =>
      'Consultation diététique effectuée';

  @override
  String get schedNephrologistComment => 'Commentaire du néphrologue';

  @override
  String get schedPatientAbsent => 'Patient Absent';

  @override
  String get dqLastDialysisSession => 'Dernière séance de dialyse';

  @override
  String get clinAccessType => 'Type d\'accès';

  @override
  String get clinExpectedFiberBundleVolume =>
      'Volume attendu du faisceau de fibres';

  @override
  String get clinDialyzerBarcodeNo => 'N° de code-barres du dialyseur';

  @override
  String get clinTubeBarcodeNo => 'N° de code-barres du tube';

  @override
  String get clinTubeReuseNo => 'N° de réutilisation du tube';

  @override
  String get clinBloodTubeRemark => 'Remarque sur la tubulure sanguine';

  @override
  String get clinNewBloodTubing => 'Nouvelle tubulure sanguine';

  @override
  String get clinPulseBeatsMin => 'Pouls\n(battements/min)';

  @override
  String get clinOxygenLevelPercent => 'Niveau d\'oxygène (%)';

  @override
  String get clinRespiratoryRateBreathsMin =>
      'Fréquence respiratoire (resp./min)';

  @override
  String get commonBottom => 'Bas';

  @override
  String get commonTop => 'Haut';

  @override
  String get dqViewHistory => 'Voir l\'historique';

  @override
  String get dqDiscardedRemarksWarning =>
      'Veuillez saisir les remarques sur le matériel écarté avant d\'utiliser un nouveau dialyseur et une nouvelle tubulure sanguine';

  @override
  String get dqDialysisHistory => 'Historique de dialyse';

  @override
  String get dqTubeHistory => 'Historique de la tubulure';

  @override
  String get clinCurrentWgtDiff => 'Diff. poids actuel';

  @override
  String get clinTotalHeparinUsed => 'Total d\'héparine utilisée';

  @override
  String get clinFinalKtv => 'KT/V final';

  @override
  String get clinActualFiberBundleVolume => 'Volume réel du faisceau de fibres';

  @override
  String get clinPercentageFiberBundle => 'Pourcentage du faisceau de fibres';

  @override
  String get clinLastHgb => 'Dernière Hgb (hémoglobine) :';

  @override
  String get clinIronPreparation => 'Préparation de fer';

  @override
  String get clinIronDose => 'Dose de fer';

  @override
  String get clinIronFrequency => 'Fréquence du fer';

  @override
  String get clinIronRoute => 'Voie d\'administration du fer';

  @override
  String get clinIronStartDate => 'Date de début du fer';

  @override
  String get clinIronProtocolUsed => 'Protocole de fer utilisé';

  @override
  String get clinFerritinLevel => 'Taux de ferritine';

  @override
  String get clinBloodTransfusionPost => 'Transfusion sanguine (post-dialyse)';

  @override
  String get clinVolumeMl => 'Volume (mL)';

  @override
  String get clinDialysisDurationRemark => 'Remarque sur la durée de dialyse';

  @override
  String get clinDialysisDurationDescription =>
      'Description de la durée de dialyse';

  @override
  String get clinEpoBrandName => 'Nom de marque de l\'EPO';

  @override
  String get clinEpoFrequency => 'Fréquence de l\'EPO';

  @override
  String get clinEpoRoute => 'Voie d\'administration de l\'EPO';

  @override
  String get clinEpoStartDate => 'Date de début de l\'EPO';

  @override
  String get clinEpoIndication => 'Indication de l\'EPO';

  @override
  String get dqHdTreatmentCount => 'Nombre de traitements HD';

  @override
  String get clinPreDialysisWeightKgs => 'Poids pré-dialyse (kg)';

  @override
  String get clinPostDialysisWeightKgs => 'Poids post-dialyse (kg)';

  @override
  String get clinIntradialyticWeightKgs => 'Poids intradialytique (kg)';

  @override
  String get clinDryWeightKgs => 'Poids sec (kg)';

  @override
  String get clinWeightLoss => 'Perte de poids';

  @override
  String get clinUfTarget => 'Objectif UF (L)';

  @override
  String get clinUfTargetAchieved => 'Objectif UF atteint (L)';

  @override
  String get clinAirDetectorLineClamp => 'Détecteur d\'air / clamp de ligne';

  @override
  String get clinAlarmLimitSet => 'Limite d\'alarme réglée';

  @override
  String get clinHeparinPumpOn => 'Pompe à héparine activée';

  @override
  String get clinDialysateFlowMlMin => 'Débit du dialysat (ml/min)';

  @override
  String get clinPulseBpm => 'Pouls (bpm)';

  @override
  String get clinInjectionEpoIron => 'Injection EPO / fer';

  @override
  String get clinDialysateTempC => 'Temp. du dialysat (°C)';

  @override
  String get clinRespiratoryRateRpm => 'Fréquence respiratoire (rpm)';

  @override
  String get clinConcentrateNa => 'Concentré Na+ (mmol/L)';

  @override
  String get clinTemperatureF => 'Température (°F)';

  @override
  String get clinPtTemperatureF => 'Temp. patient (°F)';

  @override
  String get clinConductivityMho => 'Conductivité (mho)';

  @override
  String get clinHdStartedBy => 'HD commencée par';

  @override
  String get clinHdCompletedBy => 'HD terminée par';

  @override
  String get dischDietician => 'Diététicien';

  @override
  String get dischTermsVerified =>
      'J\'ai vérifié tous les stades de dialyse et les détails du patient';

  @override
  String get roMachineName => 'Nom de la machine RO';

  @override
  String get commonUploadImage => 'Téléverser une image';

  @override
  String get roAddDisinfectionDetails =>
      'Ajouter les détails de désinfection RO';

  @override
  String get roEditDisinfectionDetails =>
      'Modifier les détails de désinfection RO';

  @override
  String get roNextInspectionBeforeError =>
      'La date de la prochaine inspection ne doit pas être antérieure à la date d\'inspection';

  @override
  String get roAddMachineIssueLog =>
      'Ajouter un journal des incidents de machine RO';

  @override
  String get roEditMachineIssueLog =>
      'Modifier le journal des incidents de machine RO';

  @override
  String get roSandFilterPressure => 'Pression du filtre à sable';

  @override
  String get commonInactive => 'Inactif';

  @override
  String get roSandFilterPressurePsi => 'Pression du filtre à sable (PSI)';

  @override
  String get roSoftenerAvailable => 'Adoucisseur disponible';

  @override
  String get roHardnessPostSoftenerPpm =>
      'Dureté de l\'eau après adoucisseur (PPM)';

  @override
  String get roBeforeRegenerationHardnessPpm =>
      'Dureté avant régénération (PPM)';

  @override
  String get roAfterRegenerationHardnessPpm =>
      'Dureté après régénération (PPM)';

  @override
  String get roPreMembranePressure => 'Pression pré-membrane';

  @override
  String get roRejectPressure => 'Pression de rejet';

  @override
  String get roPermeateFlowLph => 'Débit du perméat (LPH)';

  @override
  String get roCarbonChlorideWaterConductivity =>
      'Chlore du carbone et conductivité de l\'eau';

  @override
  String get roPostCarbonChloridePpm => 'Chlore après carbone (PPM)';

  @override
  String get roRoWaterConductivity => 'Conductivité eau RO';

  @override
  String get roHighPressurePump => 'Pompe haute pression';

  @override
  String get roUfMicronFilter => 'Filtre UF/micron';

  @override
  String get roDosingSystem => 'Système de dosage';

  @override
  String roValueLessThan(String value) {
    return 'La valeur doit être inférieure à $value';
  }

  @override
  String roValueGreaterThan(String value) {
    return 'La valeur doit être supérieure à $value';
  }

  @override
  String roValueBetween(String min, String max) {
    return 'La valeur doit être comprise entre $min et $max';
  }

  @override
  String get roEnterValidNumber => 'Veuillez saisir un nombre valide';

  @override
  String get roMachine => 'Machine RO';

  @override
  String get roAddDailyLogSheet =>
      'Ajouter une feuille de relevé RO quotidienne';

  @override
  String get roEditDailyLogSheet =>
      'Modifier la feuille de relevé RO quotidienne';

  @override
  String get commonParameter => 'Paramètre';

  @override
  String get commonUnits => 'Unités';

  @override
  String get commonValues => 'Valeurs';

  @override
  String get roRawWaterTdsLabel => 'TDS eau brute';

  @override
  String get roPostSoftenerTdsLabel => 'TDS post-adoucisseur';

  @override
  String get roPostMembraneTdsLabel => 'TDS post-membrane';

  @override
  String get roPostMixbedTdsLabel => 'TDS post-lit mixte';

  @override
  String get roLooplineTdsLabel => 'TDS boucle';

  @override
  String get roPostSoftenerHardnessLabel => 'Dureté post-adoucisseur';

  @override
  String get roPostCarbonFilterChlorineLabel => 'Chlore post-filtre à charbon';

  @override
  String get roRejectFlowLabel => 'Débit de rejet';

  @override
  String get roProductPermeateFlowLabel => 'Débit produit / perméat';

  @override
  String get machMachineSerialNo => 'N° de série de la machine';

  @override
  String get uploadFeedbackForm => 'Formulaire de retour';

  @override
  String get machTodaysReadingHours => 'Relevé du jour (heures)';

  @override
  String get machLastReadingHours => 'Dernier relevé (heures)';
}
