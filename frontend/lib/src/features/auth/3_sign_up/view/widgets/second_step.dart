part of 'sign_up_form.dart';

class _Step2 extends StatelessWidget {
  final Key formKey;
  final InputControl firstName;
  final InputControl lastName;
  final Observable<DateTime> birthDate;
  final Observable<Country> country;
  final Observable<String> selectedGenderObs;

  const _Step2({
    super.key,
    required this.formKey,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.country,
    required this.selectedGenderObs,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Form(
      key: formKey,
      child: Column(
        children: [
          VerticalSpacing(AppMetrics.spacing.md),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FormInput(
                label: l10n.authFirstName,
                controller: firstName.controller,
                prefixIcon: Icon(Icons.person_2_outlined),
                focusNode: firstName.node,
                nextFocusNode: lastName.node,
                validator: InputValidators.validateName,
              ).expanded(),
              const HorizontalSpacing(10),
              FormInput(
                label: l10n.authLastName,
                controller: lastName.controller,
                prefixIcon: Icon(Icons.person_2_outlined),
                focusNode: lastName.node,
                validator: InputValidators.validateName,
              ).expanded(),
            ],
          ),
          VerticalSpacing(AppMetrics.spacing.md),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Observer(
                observes: country,
                builder: (BuildContext context, value) => CountryFieldPicker(
                  onCountrySelected: (p1) {
                    country.value = p1;
                    Debugger.red(country.value);
                  },
                  country: value,
                ).expanded(),
              ),
              const HorizontalSpacing(10),
              Observer(
                observes: birthDate,
                builder: (BuildContext context, value) => BirthFieldPicker(
                  onDateSelected: (d) {
                    birthDate.value = d;
                  },
                  date: value,
                ).expanded(),
              ),
            ],
          ),
          VerticalSpacing(AppMetrics.spacing.md),

          /// Gender selector bound to the observable
          Observer(
            observes: selectedGenderObs,
            builder: (context, _) => OptionSelector<Gender>(
              title: l10n.authSelectGender,
              options: Gender.values,
              selectedValue: selectedGenderObs.value == "M"
                  ? Gender.male
                  : selectedGenderObs.value == "F"
                  ? Gender.female
                  : null,
              labelBuilder: (g) => switch (g) {
                Gender.male => l10n.authGenderMale,
                Gender.female => l10n.authGenderFemale,
              },
              onChanged: (value) {
                selectedGenderObs.value = value.code;
              },
            ),
          ),
        ],
      ),
    );
  }
}

enum Gender {
  male("M"),
  female("F");

  final String code; // Backend value

  const Gender(this.code);
}

class OptionSelector<T> extends StatelessWidget {
  final String title;
  final List<T> options;
  final T? selectedValue;
  final ValueChanged<T> onChanged;
  final Axis direction;
  final String Function(T)? labelBuilder;

  const OptionSelector({
    super.key,
    required this.title,
    required this.options,
    required this.onChanged,
    this.selectedValue,
    this.direction = Axis.horizontal,
    this.labelBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final children = options.map((option) {
      final label = labelBuilder != null
          ? labelBuilder!(option)
          : option.toString();
      return Padding(
        padding: const EdgeInsets.only(right: 7, bottom: 4),
        child: _RadioButton(
          label: label,
          isSelected: selectedValue == option,
          onSelected: () => onChanged(option),
        ),
      );
    }).toList();

    final titleStyle = AppStyles.indication.semiBold().copyWith(color: onSurface);
    return direction == Axis.horizontal
        ? Row(
            children: [
              Text(title, style: titleStyle),
              const HorizontalSpacing(AppMetrics.defaultElevation),
              ...children,
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: titleStyle),
              const SizedBox(height: 8),
              Wrap(children: children),
            ],
          );
  }
}

class _RadioButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onSelected;

  const _RadioButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) => ChoiceChip(
    padding: const EdgeInsets.all(9),
    showCheckmark: true,
    checkmarkColor: AppColors.primaryDark,
    label: Text(label, style: AppStyles.subtitle.copyWith(color: Theme.of(context).colorScheme.onSurface)),
    selected: isSelected,
    onSelected: (selected) {
      if (selected) onSelected();
    },
  );
}
