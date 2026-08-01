import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moneytracker/core/services/external_link_launcher_provider.dart';
import 'package:moneytracker/core/theme/app_colors.dart';
import 'package:moneytracker/features/settings/presentation/widgets/settings_section.dart';
import 'package:moneytracker/l10n/app_localizations.dart';
import 'package:moneytracker/shared/presentation/widgets/app_snackbar.dart';

class AboutScreen extends ConsumerWidget {
  const AboutScreen({super.key});

  static const _linkedInUrl = 'https://www.linkedin.com/in/sergio-sm/';
  static const _gitHubUrl = 'https://github.com/sergiosabater';
  static const _contactEmail = 'sergiosabater@gmail.com';

  Future<void> _openUrl(
    BuildContext context,
    WidgetRef ref,
    String url,
  ) async {
    final success =
        await ref.read(externalLinkLauncherProvider).openUrl(url);
    if (!context.mounted || success) return;

    AppSnackbar.show(
      context,
      message: AppLocalizations.of(context)!.linkOpenError,
      type: AppSnackbarType.error,
    );
  }

  Future<void> _openEmail(BuildContext context, WidgetRef ref) async {
    final success = await ref
        .read(externalLinkLauncherProvider)
        .openEmail(_contactEmail);
    if (!context.mounted || success) return;

    AppSnackbar.show(
      context,
      message: AppLocalizations.of(context)!.linkOpenError,
      type: AppSnackbarType.error,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.black87;
    final secondaryColor = theme.textTheme.bodyMedium?.color ?? Colors.grey.shade600;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.headerGradient(theme.brightness),
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: _buildContent(context, ref, textColor, secondaryColor),
              ),
            ],
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
            AppLocalizations.of(context)!.about,
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

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    Color textColor,
    Color secondaryColor,
  ) {
    final theme = Theme.of(context);
    final surfaceColor = theme.colorScheme.surface;
    final borderColor = theme.dividerColor;
    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SettingsSection(
              title: l10n.thisApp,
              children: [
                _ProfileCard(
                  avatar: const CircleAvatar(
                    backgroundImage: AssetImage('assets/icons/app_icon.png'),
                    radius: 50,
                  ),
                  name: l10n.appTitle,
                  title: null,
                  bio: l10n.appDescription,
                  textColor: textColor,
                  secondaryColor: secondaryColor,
                  surfaceColor: surfaceColor,
                ),
              ],
            ),
            const SizedBox(height: 24),
            SettingsSection(
              title: l10n.developer,
              children: [
                _ProfileCard(
                  avatar: const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/profile.png'),
                    radius: 50,
                  ),
                  name: 'Sergio Sabater',
                  title: l10n.developerRole,
                  bio: l10n.developerBio,
                  textColor: textColor,
                  secondaryColor: secondaryColor,
                  surfaceColor: surfaceColor,
                ),
              ],
            ),
            const SizedBox(height: 24),
            SettingsSection(
              title: l10n.skills,
              children: [
                _SkillsList(
                  skills: const [
                    'Flutter',
                    'Dart',
                    'Kotlin',
                    'Android SDK',
                    'Clean Architecture',
                    'Riverpod',
                    'Git',
                  ],
                  accentColor: AppColors.accent,
                  surfaceColor: surfaceColor,
                ),
              ],
            ),
            const SizedBox(height: 24),
            SettingsSection(
              title: l10n.getInTouch,
              children: [
                _SocialRow(
                  onLinkedIn: () => _openUrl(context, ref, _linkedInUrl),
                  onGitHub: () => _openUrl(context, ref, _gitHubUrl),
                  onEmail: () => _openEmail(context, ref),
                  emailLabel: l10n.email,
                  accentColor: AppColors.accent,
                  textColor: textColor,
                  surfaceColor: surfaceColor,
                  borderColor: borderColor,
                ),
              ],
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                l10n.appVersion,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: secondaryColor.withValues(alpha: 0.6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== COMPONENTES INTERNOS ====================

class _ProfileCard extends StatelessWidget {
  final Widget avatar;
  final String name;
  final String? title;
  final String bio;
  final Color textColor;
  final Color secondaryColor;
  final Color surfaceColor;

  const _ProfileCard({
    required this.avatar,
    required this.name,
    required this.title,
    required this.bio,
    required this.textColor,
    required this.secondaryColor,
    required this.surfaceColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          avatar,
          const SizedBox(height: 16),
          Text(
            name,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: textColor,
              letterSpacing: 0.3,
            ),
          ),
          if (title != null) ...[
            const SizedBox(height: 6),
            Text(
              title!,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.accent,
                letterSpacing: 0.3,
              ),
            ),
          ],
          const SizedBox(height: 16),
          Text(
            bio,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              height: 1.6,
              color: secondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillsList extends StatelessWidget {
  final List<String> skills;
  final Color accentColor;
  final Color surfaceColor;

  const _SkillsList({
    required this.skills,
    required this.accentColor,
    required this.surfaceColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: skills.map((skill) {
          return _SkillChip(
            label: skill,
            accentColor: accentColor,
          );
        }).toList(),
      ),
    );
  }
}

class _SkillChip extends StatelessWidget {
  final String label;
  final Color accentColor;

  const _SkillChip({
    required this.label,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.25),
          width: 1.2,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: accentColor,
        ),
      ),
    );
  }
}

class _SocialRow extends StatelessWidget {
  final VoidCallback onLinkedIn;
  final VoidCallback onGitHub;
  final VoidCallback onEmail;
  final String emailLabel;
  final Color accentColor;
  final Color textColor;
  final Color surfaceColor;
  final Color borderColor;

  const _SocialRow({
    required this.onLinkedIn,
    required this.onGitHub,
    required this.onEmail,
    required this.emailLabel,
    required this.accentColor,
    required this.textColor,
    required this.surfaceColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _SocialButton(
            icon: Icons.link,
            label: 'LinkedIn',
            onTap: onLinkedIn,
            accentColor: accentColor,
            textColor: textColor,
            surfaceColor: surfaceColor,
            borderColor: borderColor,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _SocialButton(
            icon: Icons.code,
            label: 'GitHub',
            onTap: onGitHub,
            accentColor: accentColor,
            textColor: textColor,
            surfaceColor: surfaceColor,
            borderColor: borderColor,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _SocialButton(
            icon: Icons.email_outlined,
            label: emailLabel,
            onTap: onEmail,
            accentColor: accentColor,
            textColor: textColor,
            surfaceColor: surfaceColor,
            borderColor: borderColor,
          ),
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color accentColor;
  final Color textColor;
  final Color surfaceColor;
  final Color borderColor;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.accentColor,
    required this.textColor,
    required this.surfaceColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 1),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.04),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: accentColor, size: 24),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}