import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moneytracker/core/theme/app_colors.dart';
import 'package:moneytracker/features/settings/presentation/widgets/settings_expandable_tile.dart';
import 'package:moneytracker/features/settings/presentation/widgets/settings_option_tile.dart';
import 'package:moneytracker/features/settings/presentation/widgets/settings_section.dart';

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

  // Local UI state only — not wired to real functionality yet.
  String _selectedTheme = 'system';
  String _selectedLanguage = 'system';
  String _selectedCurrency = 'usd';

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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primary,
              AppColors.primaryMedium,
              AppColors.primaryLight,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 0.5, 1.0],
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
          const Text(
            'Settings',
            style: TextStyle(
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
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.lightBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SettingsSection(
              title: 'Appearance',
              children: [
                SettingsExpandableTile(
                  icon: Icons.palette_outlined,
                  iconColor: AppColors.warning,
                  title: 'Theme',
                  selectedValue: _selectedTheme,
                  onSelected: (value) {
                    setState(() => _selectedTheme = value);
                  },
                  options: const [
                    SettingsSelectableOption(
                      value: 'light',
                      label: 'Light',
                      icon: Icons.light_mode,
                      iconColor: AppColors.warning,
                    ),
                    SettingsSelectableOption(
                      value: 'dark',
                      label: 'Dark',
                      icon: Icons.dark_mode,
                      iconColor: AppColors.security,
                    ),
                    SettingsSelectableOption(
                      value: 'system',
                      label: 'System',
                      icon: Icons.brightness_auto,
                      iconColor: Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            SettingsSection(
              title: 'Language',
              children: [
                SettingsExpandableTile(
                  icon: Icons.language,
                  iconColor: AppColors.info,
                  title: 'App language',
                  selectedValue: _selectedLanguage,
                  onSelected: (value) {
                    setState(() => _selectedLanguage = value);
                  },
                  options: [
                    const SettingsSelectableOption(
                      value: 'system',
                      label: 'System default',
                      icon: Icons.smartphone,
                      iconColor: Colors.grey,
                    ),
                    SettingsSelectableOption(
                      value: 'es',
                      label: 'Español',
                      leadingWidget: CountryFlag.fromCountryCode(
                        'ES',
                        height: 18,
                        width: 24,
                        shape: const RoundedRectangle(3),
                      ),
                    ),
                    SettingsSelectableOption(
                      value: 'en',
                      label: 'English',
                      leadingWidget: CountryFlag.fromCountryCode(
                        'GB',
                        height: 18,
                        width: 24,
                        shape: const RoundedRectangle(3),
                      ),
                    ),
                    SettingsSelectableOption(
                      value: 'fr',
                      label: 'Français',
                      leadingWidget: CountryFlag.fromCountryCode(
                        'FR',
                        height: 18,
                        width: 24,
                        shape: const RoundedRectangle(3),
                      ),
                    ),
                    SettingsSelectableOption(
                      value: 'de',
                      label: 'Deutsch',
                      leadingWidget: CountryFlag.fromCountryCode(
                        'DE',
                        height: 18,
                        width: 24,
                        shape: const RoundedRectangle(3),
                      ),
                    ),
                    SettingsSelectableOption(
                      value: 'pl',
                      label: 'Polski',
                      leadingWidget: CountryFlag.fromCountryCode(
                        'PL',
                        height: 18,
                        width: 24,
                        shape: const RoundedRectangle(3),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            SettingsSection(
              title: 'Currency',
              children: [
                SettingsExpandableTile(
                  icon: Icons.attach_money,
                  iconColor: AppColors.income,
                  title: 'Base currency',
                  selectedValue: _selectedCurrency,
                  onSelected: (value) {
                    setState(() => _selectedCurrency = value);
                  },
                  options: [
                    SettingsSelectableOption(
                      value: 'usd',
                      label: 'US Dollar (\$)',
                      leadingWidget: CountryFlag.fromCountryCode(
                        'US',
                        height: 18,
                        width: 24,
                        shape: const RoundedRectangle(3),
                      ),
                    ),
                    SettingsSelectableOption(
                      value: 'eur',
                      label: 'Euro (€)',
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
                      value: 'gbp',
                      label: 'British Pound (£)',
                      leadingWidget: CountryFlag.fromCountryCode(
                        'GB',
                        height: 18,
                        width: 24,
                        shape: const RoundedRectangle(3),
                      ),
                    ),
                    SettingsSelectableOption(
                      value: 'pln',
                      label: 'Polish Złoty (zł)',
                      leadingWidget: CountryFlag.fromCountryCode(
                        'PL',
                        height: 18,
                        width: 24,
                        shape: const RoundedRectangle(3),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            SettingsSection(
              title: 'Security',
              children: [
                SettingsOptionTile(
                  icon: Icons.pin_outlined,
                  iconColor: AppColors.security,
                  title: 'PIN code',
                  onTap: () {},
                ),
                SettingsOptionTile(
                  icon: Icons.fingerprint,
                  iconColor: AppColors.security,
                  title: 'Biometric authentication',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            SettingsSection(
              title: 'Information',
              children: [
                SettingsOptionTile(
                  icon: Icons.info_outline,
                  iconColor: AppColors.accent,
                  title: 'About',
                  onTap: () {
                    // TODO (Paso 5.4): navigate to AboutScreen
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
