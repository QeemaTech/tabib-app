import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class CustomDropdownField extends StatelessWidget {
  const CustomDropdownField({super.key, required this.hintText, required this.items, this.onChanged});
  final String hintText;
  final List<String> items;
  final void Function(String?)? onChanged;
  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.12),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        
        initialValue: items.first,
        hint: Text(
          hintText,
          style: theme.medium16.copyWith(
            fontWeight: FontWeight.w400,
            color: theme.textColor300,
          ),
        ),
        icon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: theme.textColor300,
            size: 26,
          ),
        ),
        alignment: AlignmentDirectional.centerStart,
        isExpanded: true,
        
        style: const TextStyle(fontSize: 16.0, color: Colors.black87),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 18.0,
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        items: items.map((String key) {
          return DropdownMenuItem<String>(

            value: key,
            child: Text(key.tr()),
          );
        }).toList(),
        onChanged: (newValue) {
          onChanged?.call(newValue);
        },
        
      ),
    );
  }
}
