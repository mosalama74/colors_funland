import 'package:color_funland/features/addProfileInfo/presentation/pages/child_progress_scareen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaintingService {
  static const String _paintedItemsKey = 'painted_items';
  static late SharedPreferences _prefs;

  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    _loadPaintedItems();
  }

  static void _loadPaintedItems() {
    final paintedItemsJson = _prefs.getStringList(_paintedItemsKey) ?? [];
    for (final itemKey in paintedItemsJson) {
      PaintingProgress.paintedItems[itemKey] = true;
    }
  }

  static Future<void> markItemAsPainted(String itemKey) async {
    PaintingProgress.markItemAsPainted(itemKey);
    final paintedItems = PaintingProgress.paintedItems.keys.toList();
    await _prefs.setStringList(_paintedItemsKey, paintedItems);
  }
}
