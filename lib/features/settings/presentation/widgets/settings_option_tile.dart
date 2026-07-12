import 'package:flutter/material.dart';

class SettingsOptionTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? value;
  final VoidCallback onTap;
  final bool enabled;

  const SettingsOptionTile({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    this.value,
    required this.onTap,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleColor = theme.textTheme.bodyLarge?.color ?? Colors.black87;
    final secondaryColor =
        theme.textTheme.bodyMedium?.color ?? Colors.grey.shade600;

    // When disabled, everything falls back to a muted, low-emphasis
    // version of the same palette — no separate "disabled" colors are
    // hardcoded, they're derived from the same tokens used elsewhere.
    final effectiveIconColor =
        enabled ? iconColor : secondaryColor.withValues(alpha: 0.4);
    final effectiveTitleColor =
        enabled ? titleColor : secondaryColor.withValues(alpha: 0.5);
    final effectiveChevronColor =
        enabled ? secondaryColor : secondaryColor.withValues(alpha: 0.3);

    return InkWell(
      onTap: enabled ? onTap : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: effectiveIconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: effectiveIconColor, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: effectiveTitleColor,
                ),
              ),
            ),
            if (value != null) ...[
              Text(
                value!,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: secondaryColor,
                ),
              ),
              const SizedBox(width: 4),
            ],
            Icon(
              Icons.chevron_right,
              size: 20,
              color: effectiveChevronColor,
            ),
          ],
        ),
      ),
    );
  }
}