// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'MONEY TRACKER';

  @override
  String get balance => 'Solde :';

  @override
  String get incomes => 'Revenus';

  @override
  String get expenses => 'Dépenses';

  @override
  String get newTransaction => 'Nouvelle transaction';

  @override
  String get income => 'Revenu';

  @override
  String get expense => 'Dépense';

  @override
  String get amount => 'MONTANT';

  @override
  String get description => 'DESCRIPTION';

  @override
  String get enterDescription => 'Saisissez une description';

  @override
  String get noDescription => 'Sans description';

  @override
  String get add => 'Ajouter';

  @override
  String get noTransactionsYet => 'Aucune transaction pour le moment';

  @override
  String get transactionOptions => 'Options de la transaction';

  @override
  String get edit => 'Modifier';

  @override
  String get delete => 'Supprimer';

  @override
  String get confirmDelete => 'Supprimer la transaction';

  @override
  String get confirmDeleteMessage =>
      'Êtes-vous sûr de vouloir supprimer cette transaction ?';

  @override
  String get cancel => 'Annuler';

  @override
  String get noDescriptionTitle => 'Aucune description';

  @override
  String get noDescriptionMessage =>
      'Voulez-vous vraiment ajouter une transaction sans description ?';

  @override
  String get transactionDeleted => 'Transaction supprimée';

  @override
  String get transactionAdded => 'Transaction ajoutée';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get appearance => 'Apparence';

  @override
  String get theme => 'Thème';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';

  @override
  String get themeSystem => 'Système';

  @override
  String get language => 'Langue';

  @override
  String get currency => 'Devise';

  @override
  String get currencyDollar => 'Dollar (\$)';

  @override
  String get currencyEuro => 'Euro (€)';

  @override
  String get currencyPound => 'Livre sterling (£)';

  @override
  String get currencyZloty => 'Zloty (zł)';

  @override
  String get security => 'Sécurité';

  @override
  String get pinCode => 'Code PIN';

  @override
  String get biometricAuth => 'Authentification biométrique';

  @override
  String get information => 'Informations';

  @override
  String get about => 'À propos';

  @override
  String get profile => 'Profil';

  @override
  String get developerRole => 'Développeur d\'applications mobiles';

  @override
  String get developerBio =>
      'Plus de 5 ans d\'expérience dans le développement d\'applications natives Android, désormais concentré sur le développement multiplateforme avec Flutter. J\'accorde une grande importance à l\'architecture propre, au code maintenable et à la création d\'applications rapides, soignées et réellement utiles pour leurs utilisateurs.';

  @override
  String get skills => 'Compétences';

  @override
  String get getInTouch => 'Me contacter';

  @override
  String get email => 'E-mail';

  @override
  String get appVersion => 'Money Tracker · v1.0.0';

  @override
  String get noTransactionsHint =>
      'Appuyez sur + pour ajouter votre première transaction';

  @override
  String get editFeatureComingSoon =>
      'Fonction de modification bientôt disponible';

  @override
  String get dismiss => 'Fermer';

  @override
  String get languageNameEs => 'Espagnol';

  @override
  String get languageNameEn => 'Anglais';

  @override
  String get languageNameFr => 'Français';

  @override
  String get languageNameDe => 'Allemand';

  @override
  String get languageNamePl => 'Polonais';

  @override
  String get preferences => 'Préférences';

  @override
  String get clearData => 'Effacer les données';

  @override
  String get confirmClearData => 'Attention';

  @override
  String get confirmClearDataMessage =>
      'Êtes-vous sûr de vouloir supprimer toutes les données ?';

  @override
  String get dataCleared => 'Données effacées';

  @override
  String get pinCreateTitle => 'Créez un code PIN';

  @override
  String get pinCreateSubtitle =>
      'Vous utiliserez ce code PIN pour déverrouiller l\'application et confirmer les actions sensibles';

  @override
  String get pinConfirmTitle => 'Confirmez votre code PIN';

  @override
  String get pinConfirmSubtitle =>
      'Saisissez à nouveau votre code PIN pour le confirmer';

  @override
  String get pinMismatch => 'Les codes PIN ne correspondent pas. Réessayez';

  @override
  String get pinVerifyTitle => 'Saisissez votre code PIN';

  @override
  String get pinIncorrect => 'Code PIN incorrect. Réessayez';

  @override
  String get pinEnabled => 'Code PIN activé';

  @override
  String get pinDisabled => 'Code PIN désactivé';

  @override
  String get appLockTitle => 'Content de vous revoir';

  @override
  String get appLockSubtitle => 'Saisissez votre code PIN pour continuer';

  @override
  String get biometricEnabled => 'Authentification biométrique activée';

  @override
  String get biometricDisabled => 'Authentification biométrique désactivée';

  @override
  String get pinAndBiometricEnabled =>
      'Code PIN et authentification biométrique activés';

  @override
  String get pinAndBiometricDisabled =>
      'Code PIN et authentification biométrique désactivés';

  @override
  String get biometricPromptSubtitle =>
      'Utilisez votre empreinte ou votre visage pour déverrouiller';

  @override
  String get biometricNotRecognized => 'Empreinte non reconnue. Réessayez.';

  @override
  String get tryAnotherWay => 'Essayer autrement';

  @override
  String get tryAgain => 'Réessayer';

  @override
  String get biometricUnlockReason => 'Déverrouiller Money Tracker';

  @override
  String get biometricVerifyReason => 'Confirmez que c\'est bien vous';

  @override
  String get linkOpenError =>
      'Impossible d\'ouvrir le lien. Réessayez plus tard.';

  @override
  String get thisApp => 'Cette application';

  @override
  String get appDescription =>
      'Money Tracker est une application de finances personnelles qui vous aide à suivre vos revenus et dépenses, voir votre solde en un coup d\'œil et garder le contrôle de votre argent — développée avec Flutter pour une expérience rapide et native sur iOS et Android.';

  @override
  String get developer => 'Développeur';

  @override
  String get today => 'Aujourd\'hui';

  @override
  String get yesterday => 'Hier';
}
