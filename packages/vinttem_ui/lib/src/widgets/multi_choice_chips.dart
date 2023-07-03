import 'package:flutter/material.dart';

class ChoiceChipItem<T> {
  ChoiceChipItem({required this.id, required this.label});

  String id;
  String label;

  @override
  String toString() => label;
}

class MultiChoiceChips<T> extends StatelessWidget {
  const MultiChoiceChips({
    required this.options,
    super.key,
    ChoiceChipItem<T>? selectedItem,
    ValueChanged<ChoiceChipItem<T>>? onSelected,
  })  : _selectedOption = selectedItem,
        _onSelected = onSelected;

  final List<ChoiceChipItem<T>> options;
  final ChoiceChipItem<T>? _selectedOption;
  final ValueChanged<ChoiceChipItem<T>>? _onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Wrap(
        key: key,
        spacing: 8,
        children: options.map((element) {
          return ChoiceChip(
            label: Text(element.label),
            labelStyle: theme.textTheme.bodyMedium,
            selected: _selectedOption!.id == element.id,
            onSelected: (e) {
              _onSelected!.call(element);
            },
          );
        }).toList(),
      ),
    );
  }
}
