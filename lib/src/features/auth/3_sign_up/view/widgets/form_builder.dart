part of 'sign_up_form.dart';

class _FormBuilder extends StatelessWidget {
  final PageController controller;
  final List<Widget> widgets;
  const _FormBuilder({
    super.key,
    required this.controller,
    required this.widgets,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: widgets.length,
      controller: controller,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) =>
          SingleChildScrollView(child: widgets[index]),
    ).resize(height: AppMetrics.scaffold.horizontalBodyPadding * 13);
  }
}
