import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moneytracker/core/currency/currency_notifier.dart';
import 'package:moneytracker/core/currency/currency_option.dart';
import 'package:moneytracker/core/locale/locale_notifier.dart';
import 'package:moneytracker/core/locale/locale_option.dart';
import 'package:moneytracker/core/theme/app_colors.dart';
import 'package:moneytracker/core/theme/theme_mode_option.dart';
import 'package:moneytracker/core/theme/theme_notifier.dart';
import 'package:moneytracker/features/settings/presentation/widgets/settings_expandable_tile.dart';
import 'package:moneytracker/features/settings/presentation/widgets/settings_option_tile.dart';
import 'package:moneytracker/features/settings/presentation/widgets/settings_section.dart';
import 'package:moneytracker/features/settings/presentation/widgets/settings_toggle_tile.dart';
import 'package:moneytracker/l10n/app_localizations.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.05), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.headerGradient(Theme.of(context).brightness),
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                children: [
                  _buildHeader(context),
                  Expanded(child: _buildContent()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          Text(
            AppLocalizations.of(context)!.settingsTitle,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    final l10n = AppLocalizations.of(context)!;
    final currentThemeMode = ref.watch(themeNotifierProvider);
    final currentLocaleOption = ref.watch(localeNotifierProvider);
    final currentCurrency = ref.watch(currencyNotifierProvider);

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SettingsSection(
              title: l10n.appearance,
              children: [
                SettingsExpandableTile<ThemeModeOption>(
                  icon: Icons.palette_outlined,
                  iconColor: AppColors.warning,
                  selectionColor: AppColors.info,
                  title: l10n.theme,
                  selectedValue: currentThemeMode,
                  onSelected: (option) {
                    ref
                        .read(themeNotifierProvider.notifier)
                        .setThemeMode(option);
                  },
                  options: [
                    SettingsSelectableOption(
                      value: ThemeModeOption.system,
                      label: l10n.themeSystem,
                      icon: Icons.smartphone,
                      iconColor: Colors.grey,
                    ),
                    SettingsSelectableOption(
                      value: ThemeModeOption.light,
                      label: l10n.themeLight,
                      icon: Icons.light_mode,
                      iconColor: AppColors.warning,
                    ),
                    SettingsSelectableOption(
                      value: ThemeModeOption.dark,
                      label: l10n.themeDark,
                      icon: Icons.dark_mode,
                      iconColor: AppColors.security,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            SettingsSection(
              title: l10n.preferences,
              children: [
                SettingsExpandableTile<LocaleOption>(
                  icon: Icons.language,
                  iconColor: AppColors.info,
                  selectionColor: AppColors.info,
                  title: l10n.language,
                  selectedValue: currentLocaleOption,
                  onSelected: (option) {
                    ref.read(localeNotifierProvider.notifier).setLocale(option);
                    ref
                        .read(currencyNotifierProvider.notifier)
                        .setCurrency(CurrencyOption.forLocale(option));
                  },
                  options: [
                    SettingsSelectableOption(
                      value: LocaleOption.es,
                      label: l10n.languageNameEs,
                      leadingWidget: CountryFlag.fromCountryCode(
                        'ES',
                        height: 18,
                        width: 24,
                        shape: const RoundedRectangle(3),
                      ),
                    ),
                    SettingsSelectableOption(
                      value: LocaleOption.en,
                      label: l10n.languageNameEn,
                      leadingWidget: CountryFlag.fromCountryCode(
                        'GB',
                        height: 18,
                        width: 24,
                        shape: const RoundedRectangle(3),
                      ),
                    ),
                    SettingsSelectableOption(
                      value: LocaleOption.fr,
                      label: l10n.languageNameFr,
                      leadingWidget: CountryFlag.fromCountryCode(
                        'FR',
                        height: 18,
                        width: 24,
                        shape: const RoundedRectangle(3),
                      ),
                    ),
                    SettingsSelectableOption(
                      value: LocaleOption.de,
                      label: l10n.languageNameDe,
                      leadingWidget: CountryFlag.fromCountryCode(
                        'DE',
                        height: 18,
                        width: 24,
                        shape: const RoundedRectangle(3),
                      ),
                    ),
                    SettingsSelectableOption(
                      value: LocaleOption.pl,
                      label: l10n.languageNamePl,
                      leadingWidget: CountryFlag.fromCountryCode(
                        'PL',
                        height: 18,
                        width: 24,
                        shape: const RoundedRectangle(3),
                      ),
                    ),
                  ],
                ),
                SettingsExpandableTile<CurrencyOption>(
                  icon: Icons.attach_money,
                  iconColor: AppColors.income,
                  selectionColor: AppColors.info,
                  title: l10n.currency,
                  selectedValue: currentCurrency,
                  onSelected: (value) {
                    ref.read(currencyNotifierProvider.notifier).setCurrency(value);
                  },
                  options: [
                    SettingsSelectableOption(
                      value: CurrencyOption.usd,
                      label: l10n.currencyDollar,
                      leadingWidget: CountryFlag.fromCountryCode(
                        'US',
                        height: 18,
                        width: 24,
                        shape: const RoundedRectangle(3),
                      ),
                    ),
                    SettingsSelectableOption(
                      value: CurrencyOption.eur,
                      label: l10n.currencyEuro,
                      leadingWidget: ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: Image.asset(
                          'assets/flags/eu.webp',
                          height: 18,
                          width: 24,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SettingsSelectableOption(
                      value: CurrencyOption.gbp,
                      label: l10n.currencyPound,
                      leadingWidget: CountryFlag.fromCountryCode(
                        'GB',
                        height: 18,
                        width: 24,
                        shape: const RoundedRectangle(3),
                      ),
                    ),
                    SettingsSelectableOption(
                      value: CurrencyOption.pln,
                      label: l10n.currencyZloty,
                      leadingWidget: CountryFlag.fromCountryCode(
                        'PL',
                        height: 18,
                        width: 24,
                        shape: const RoundedRectangle(3),
                      ),
                    ),
                  ],
                ),
                SettingsOptionTile(
                  icon: Icons.delete_outline,
                  iconColor: AppColors.error,
                  title: l10n.clearData,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            SettingsSection(
              title: l10n.security,
              children: [
                SettingsToggleTile(
                  icon: Icons.pin_outlined,
                  iconColor: AppColors.security,
                  title: l10n.pinCode,
                  value: false,
                  onChanged: null,
                ),
                SettingsToggleTile(
                  icon: Icons.fingerprint,
                  iconColor: AppColors.security,
                  title: l10n.biometricAuth,
                  value: false,
                  onChanged: null,
                ),
              ],
            ),
            const SizedBox(height: 24),
            SettingsSection(
              title: l10n.information,
              children: [
                SettingsOptionTile(
                  icon: Icons.info_outline,
                  iconColor: AppColors.accent,
                  title: l10n.about,
                  onTap: () => context.push('/settings/about'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}