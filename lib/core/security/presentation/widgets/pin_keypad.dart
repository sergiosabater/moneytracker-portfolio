import 'package:flutter/material.dart';

/// Numeric keypad (0-9 + backspace) for PIN entry screens, styled as a
/// single grouped card: rounded corners on the outer edge only, with
/// hairline dividers separating each cell. Purely presentational —
/// reports taps via callbacks, no PIN logic here.
class PinKeypad extends StatelessWidget {
  final ValueChanged<String> onDigitPressed;
  final VoidCallback onBackspacePressed;

  const PinKeypad({
    super.key,
    required this.onDigitPressed,
    required this.onBackspacePressed,
  });

  static const double _cellWidth = 84;
  static const double _cellHeight = 64;
  static const double _dividerThickness = 1;
  static const double _radius = 20;
  static const double _totalWidth = _cellWidth * 3 + _dividerThickness * 2;

  static const _rows = [
    ['1', '2', '3'],
    ['4', '5', '6'],
    ['7', '8', '9'],
  ];

  @override
  Widget build(BuildContext context) {
    final dividerColor = Colors.white.withValues(alpha: 0.18);
    final borderRadius = BorderRadius.circular(_radius);

    return Center(
      child: Container(
        width: _totalWidth,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: Colors.white.withValues(alpha: 0.08),
        ),
        // The border lives in foregroundDecoration (painted on top, after
        // layout) rather than in `decoration`, so it never competes with
        // the fixed `width` above for the child's available space — that
        // combination (explicit width + border inside `decoration`) is
        // what caused a 2px RenderFlex overflow here.
        foregroundDecoration: BoxDecoration(
          borderRadius: borderRadius,
          border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final row in _rows) ...[
              _buildRow(
                row
                    .map((digit) => _PinKeypadCell(
                          label: digit,
                          onTap: () => onDigitPressed(digit),
                        ))
                    .toList(),
                dividerColor,
              ),
              Container(height: _dividerThickness, color: dividerColor),
            ],
            _buildRow(
              [
                // Reserved for a future biometric shortcut — kept empty
                // (and untappable) for now to preserve the 3-column grid.
                const _PinKeypadCell(),
                _PinKeypadCell(
                  label: '0',
                  onTap: () => onDigitPressed('0'),
                ),
                _PinKeypadCell(
                  icon: Icons.backspace_outlined,
                  onTap: onBackspacePressed,
                ),
              ],
              dividerColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(List<Widget> cells, Color dividerColor) {
    final children = <Widget>[];
    for (var i = 0; i < cells.length; i++) {
      children.add(cells[i]);
      if (i != cells.length - 1) {
        children.add(Container(
          width: _dividerThickness,
          height: _cellHeight,
          color: dividerColor,
        ));
      }
    }
    return Row(mainAxisSize: MainAxisSize.min, children: children);
  }
}

class _PinKeypadCell extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final VoidCallback? onTap;

  const _PinKeypadCell({this.label, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isEmpty = label == null && icon == null;

    return SizedBox(
      width: PinKeypad._cellWidth,
      height: PinKeypad._cellHeight,
      child: isEmpty
          ? const SizedBox.shrink()
          : InkWell(
              onTap: onTap,
              child: Center(
                child: icon != null
                    ? Icon(icon, color: Colors.white, size: 24)
                    : Text(
                        label!,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
    );
  }
}