import 'package:flutter/material.dart';

/// A single multiple-choice option in the Quiz Screen.
/// Highlights with a border + background tint when selected.
class OptionTile extends StatelessWidget {
  final String label;
  final String optionText;
  final bool isSelected;
  final VoidCallback onTap;

  const OptionTile({
    super.key,
    required this.label,
    required this.optionText,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? primary.withOpacity(0.12) : theme.cardTheme.color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 14,
              backgroundColor: isSelected ? primary : primary.withOpacity(0.1),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : primary,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                optionText,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
