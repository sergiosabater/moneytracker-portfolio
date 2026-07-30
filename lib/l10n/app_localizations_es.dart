// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'MONEY TRACKER';

  @override
  String get balance => 'Saldo:';

  @override
  String get incomes => 'Ingresos';

  @override
  String get expenses => 'Gastos';

  @override
  String get newTransaction => 'Nueva Transacción';

  @override
  String get income => 'Ingreso';

  @override
  String get expense => 'Gasto';

  @override
  String get amount => 'CANTIDAD';

  @override
  String get description => 'DESCRIPCIÓN';

  @override
  String get enterDescription => 'Ingresa descripción';

  @override
  String get noDescription => 'Sin descripción';

  @override
  String get add => 'Agregar';

  @override
  String get noTransactionsYet => 'Aún no hay transacciones';

  @override
  String get transactionOptions => 'Opciones de Transacción';

  @override
  String get edit => 'Editar';

  @override
  String get delete => 'Eliminar';

  @override
  String get confirmDelete => 'Eliminar Transacción';

  @override
  String get confirmDeleteMessage =>
      '¿Estás seguro de que quieres eliminar esta transacción?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get noDescriptionTitle => 'Sin Descripción';

  @override
  String get noDescriptionMessage =>
      '¿Seguro que quieres agregar una transacción sin descripción?';

  @override
  String get transactionDeleted => 'Transacción eliminada';

  @override
  String get transactionAdded => 'Transacción agregada';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get appearance => 'Apariencia';

  @override
  String get theme => 'Tema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get language => 'Idioma';

  @override
  String get currency => 'Moneda';

  @override
  String get currencyDollar => 'Dólar (\$)';

  @override
  String get currencyEuro => 'Euro (€)';

  @override
  String get currencyPound => 'Libra (£)';

  @override
  String get currencyZloty => 'Zloty (zł)';

  @override
  String get security => 'Seguridad';

  @override
  String get pinCode => 'Código PIN';

  @override
  String get biometricAuth => 'Autenticación biométrica';

  @override
  String get information => 'Información';

  @override
  String get about => 'Acerca de';

  @override
  String get profile => 'Perfil';

  @override
  String get developerRole => 'Desarrollador de aplicaciones móviles';

  @override
  String get developerBio =>
      'Más de 5 años de experiencia construyendo aplicaciones nativas para Android, ahora centrado en el desarrollo multiplataforma con Flutter. Me preocupo profundamente por la arquitectura limpia, el código mantenible y crear aplicaciones que se sientan rápidas, pulidas y realmente útiles para las personas que las usan.';

  @override
  String get skills => 'Habilidades';

  @override
  String get getInTouch => 'Contacto';

  @override
  String get email => 'Correo electrónico';

  @override
  String get appVersion => 'Money Tracker · v1.0.0';

  @override
  String get noTransactionsHint => 'Toca + para añadir tu primera transacción';

  @override
  String get editFeatureComingSoon => 'Función de edición próximamente';

  @override
  String get dismiss => 'Cerrar';

  @override
  String get languageNameEs => 'Español';

  @override
  String get languageNameEn => 'Inglés';

  @override
  String get languageNameFr => 'Francés';

  @override
  String get languageNameDe => 'Alemán';

  @override
  String get languageNamePl => 'Polaco';

  @override
  String get preferences => 'Preferencias';

  @override
  String get clearData => 'Borrar datos';

  @override
  String get confirmClearData => 'Atención';

  @override
  String get confirmClearDataMessage =>
      '¿Estás seguro de que quieres borrar todos los datos?';

  @override
  String get dataCleared => 'Datos borrados';

  @override
  String get pinCreateTitle => 'Crea un PIN';

  @override
  String get pinCreateSubtitle =>
      'Usarás este PIN para desbloquear la app y confirmar acciones sensibles';

  @override
  String get pinConfirmTitle => 'Confirma tu PIN';

  @override
  String get pinConfirmSubtitle => 'Introduce de nuevo tu PIN para confirmarlo';

  @override
  String get pinMismatch => 'Los PIN no coinciden. Inténtalo de nuevo';

  @override
  String get pinVerifyTitle => 'Introduce tu PIN';

  @override
  String get pinIncorrect => 'PIN incorrecto. Inténtalo de nuevo';

  @override
  String get pinEnabled => 'PIN activado';

  @override
  String get pinDisabled => 'PIN desactivado';

  @override
  String get appLockTitle => 'Bienvenido de nuevo';

  @override
  String get appLockSubtitle => 'Introduce tu PIN para continuar';

  @override
  String get biometricEnabled => 'Autenticación biométrica activada';

  @override
  String get biometricDisabled => 'Autenticación biométrica desactivada';

  @override
  String get pinAndBiometricEnabled =>
      'PIN y autenticación biométrica activados';

  @override
  String get pinAndBiometricDisabled =>
      'PIN y autenticación biométrica desactivados';

  @override
  String get biometricPromptSubtitle =>
      'Usa tu huella o tu rostro para desbloquear';

  @override
  String get biometricNotRecognized =>
      'Huella digital no reconocida. Prueba de nuevo.';

  @override
  String get tryAnotherWay => 'Probar de otra manera';

  @override
  String get tryAgain => 'Intentar de nuevo';

  @override
  String get biometricUnlockReason => 'Desbloquear Money Tracker';
}
