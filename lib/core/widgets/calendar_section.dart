import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/localization/intl_locale.dart';
import 'package:tabib_app/core/widgets/details_section.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarSection extends StatefulWidget {
  const CalendarSection({
    super.key,
    this.calendarFormat,
    this.selectedDay,
    this.onDaySelected,
  });

  final CalendarFormat? calendarFormat;
  final DateTime? selectedDay;
  final ValueChanged<DateTime>? onDaySelected;

  @override
  State<CalendarSection> createState() => _CalendarSectionState();
}

class _CalendarSectionState extends State<CalendarSection> {
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = widget.selectedDay ?? DateTime.now();
  }

  @override
  void didUpdateWidget(covariant CalendarSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDay != null &&
        !isSameDay(widget.selectedDay, _selectedDay)) {
      _selectedDay = widget.selectedDay!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedDay = widget.selectedDay ?? _selectedDay;

    return DetailsSection(
      title: 'home.doctorDetails.selectDay'.tr(),
      child: TableCalendar(
        locale: intlLocale(context.locale.languageCode),
        firstDay: DateTime.now(),
        calendarFormat: widget.calendarFormat ?? CalendarFormat.week,
        lastDay: DateTime.utc(2030, 3, 14),
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
        ),
        selectedDayPredicate: (day) {
          return isSameDay(selectedDay, day);
        },
        onDaySelected: (day, focusedDay) {
          if (widget.onDaySelected != null) {
            widget.onDaySelected!(day);
          } else {
            setState(() {
              _selectedDay = day;
            });
          }
        },
        focusedDay: selectedDay,
      ),
    );
  }
}
