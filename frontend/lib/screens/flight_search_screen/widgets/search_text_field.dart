import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final String hint;
  final Function(String) onChanged;
  final Set<String> suggestions;

  const SearchTextField({
    super.key,
    required this.label,
    required this.icon,
    required this.hint,
    required this.onChanged,
    required this.suggestions,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text.isEmpty) {
            return const Iterable<String>.empty();
          }
          return suggestions.where((String option) {
            return option.toLowerCase().contains(
              textEditingValue.text.toLowerCase(),
            );
          });
        },
        onSelected: onChanged,
        fieldViewBuilder: (
          BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted,
        ) {
          return TextField(
            controller: textEditingController,
            focusNode: focusNode,
            decoration: InputDecoration(
              labelText: label,
              hintText: hint,
              prefixIcon: Icon(icon),
              border: const OutlineInputBorder(),
            ),
            onChanged: onChanged,
          );
        },
        optionsViewBuilder: (
          BuildContext context,
          AutocompleteOnSelected<String> onSelected,
          Iterable<String> options,
        ) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              elevation: 4.0,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 200),
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children:
                      options.map((String option) {
                        return ListTile(
                          title: Text(option),
                          onTap: () => onSelected(option),
                        );
                      }).toList(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
