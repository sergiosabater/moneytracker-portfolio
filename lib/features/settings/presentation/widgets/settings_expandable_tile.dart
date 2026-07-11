import 'package:flutter/material.dart';
import 'package:moneytracker/core/theme/app_colors.dart';

class SettingsSelectableOption<T> {
  final T value;
  final String label;
  final IconData? icon;
  final Color? iconColor;
  final Widget? leadingWidget;

  const SettingsSelectableOption({
    required this.value,
    required this.label,
    this.icon,
    this.iconColor,
    this.leadingWidget,
  });
}

class SettingsExpandableTile<T> extends StatefulWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final List<SettingsSelectableOption<T>> options;
  final T selectedValue;
  final ValueChanged<T> onSelected;

  final Color? selectionColor;

  const SettingsExpandableTile({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.options,
    required this.selectedValue,
    required this.onSelected,
    this.selectionColor,
  });

  @override
  State<SettingsExpandableTile<T>> createState() =>
      _SettingsExpandableTileState<T>();
}

class _SettingsExpandableTileState<T> extends State<SettingsExpandableTile<T>> {
  bool _isExpanded = false;

  SettingsSelectableOption<T> get _selectedOption =>
      widget.options.firstWhere((o) => o.value == widget.selectedValue);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleColor = theme.textTheme.bodyLarge?.color ?? Colors.black87;
    final secondaryColor =
        theme.textTheme.bodyMedium?.color ?? Colors.grey.shade600;

    return Column(
      children: [
        InkWell(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: widget.iconColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(widget.icon, color: widget.iconColor, size: 20),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: titleColor,
                    ),
                  ),
                ),
                Text(
                  _selectedOption.label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: secondaryColor,
                  ),
                ),
                const SizedBox(width: 4),
                AnimatedRotation(
                  turns: _isExpanded ? 0.5 : 0.0,
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    size: 22,
                    color: secondaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          child: _isExpanded
              ? _buildOptionsList(titleColor, secondaryColor)
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildOptionsList(Color titleColor, Color secondaryColor) {
    final backgroundColor = Theme.of(context).colorScheme.surface;
    final selectionColor = widget.selectionColor ?? widget.iconColor;

    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(color: backgroundColor),
      child: Column(
        children: widget.options.map((option) {
          final isSelected = option.value == widget.selectedValue;
          final optionColor = option.iconColor ?? AppColors.accent;

          return InkWell(
            onTap: () {
              widget.onSelected(option.value);
              setState(() => _isExpanded = false);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              child: Row(
                children: [
                  const SizedBox(width: 36),
                  const SizedBox(width: 14),
                  option.leadingWidget ??
                      Icon(option.icon, color: optionColor, size: 18),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      option.label,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: isSelected ? titleColor : secondaryColor,
                      ),
                    ),
                  ),
                  if (isSelected)
                    Icon(Icons.check_circle, color: selectionColor, size: 18),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}