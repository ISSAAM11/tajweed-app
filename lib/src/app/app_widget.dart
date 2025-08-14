import '../base/screens/exports.dart';
import 'router/app_router.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({
    super.key,
    this.invertOversizedImages = false,
    this.showMaterialGrid = false,
    this.showPerformanceOverlay = false,
  });

  final bool invertOversizedImages;
  final bool showMaterialGrid;
  final bool showPerformanceOverlay;

  @override
  Widget build(BuildContext context) {
    debugInvertOversizedImages = invertOversizedImages;

    return MaterialApp.router(
      debugShowMaterialGrid: showMaterialGrid,
      showPerformanceOverlay: showPerformanceOverlay,
      theme: AppThemes.light,
      routerConfig: router,
    );
  }
}
