import 'package:flutter/material.dart';

/// Represents a single selectable option inside a [SettingsExpandableTile].
///
/// Provide either [icon] (a Material icon) or [leadingWidget] (e.g. a flag
/// image) as the visual indicator — [leadingWidget] takes priority if both
/// are provided.
class SettingsSelectableOption {
  final String value;
  final String label;
  final IconData? icon;
  final Color iconColor;
  final Widget? leadingWidget;

  const SettingsSelectableOption({
    required this.value,
    required this.label,
    this.icon,
    this.iconColor = Colors.grey,
    this.leadingWidget,
  });
}

/// An accordion-style settings row: tapping the header expands a list
/// of selectable options directly below it, instead of opening a
/// bottom sheet or dialog.
class SettingsExpandableTile extends StatefulWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final List<SettingsSelectableOption> options;
  final String selectedValue;
  final ValueChanged<String> onSelected;

  const SettingsExpandableTile({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.options,
    required this.selectedValue,
    required this.onSelected,
  });

  @override
  State<SettingsExpandableTile> createState() =>
      _SettingsExpandableTileState();
}

class _SettingsExpandableTileState extends State<SettingsExpandableTile> {
  bool _isExpanded = false;

  SettingsSelectableOption get _selectedOption =>
      widget.options.firstWhere((o) => o.value == widget.selectedValue);

  @override
  Widget build(BuildContext context) {
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
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Text(
                  _selectedOption.label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade500,
                  ),
                ),
                const SizedBox(width: 4),
                AnimatedRotation(
                  turns: _isExpanded ? 0.5 : 0.0,
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    size: 22,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          child: _isExpanded ? _buildOptionsList() : const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildOptionsList() {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(color: Colors.grey.shade50),
      child: Column(
        children: widget.options.map((option) {
          final isSelected = option.value == widget.selectedValue;
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
                      Icon(option.icon, color: option.iconColor, size: 18),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      option.label,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: isSelected
                            ? Colors.black87
                            : Colors.grey.shade600,
                      ),
                    ),
                  ),
                  if (isSelected)
                    Icon(Icons.check_circle, color: widget.iconColor, size: 18),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}