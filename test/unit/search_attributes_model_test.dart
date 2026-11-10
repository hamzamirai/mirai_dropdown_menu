import 'package:flutter_test/flutter_test.dart';
import 'package:mirai_dropdown_menu/src/models/search_attributes_model.dart';

void main() {
  group('SearchAttributes Model Unit Tests', () {
    test('initializes with default values', () {
      final SearchAttributes<String> attributes = SearchAttributes<String>();

      expect(attributes.searchList, isEmpty);
      expect(attributes.showHighLight, isFalse);
      expect(attributes.mQueryClient, '');
    });

    test('initializes with custom values', () {
      final List<String> initialList = <String>['Option A', 'Option B'];
      final SearchAttributes<String> attributes = SearchAttributes<String>(
        searchList: initialList,
        showHighLight: true,
        mQueryClient: 'Option',
      );

      expect(attributes.searchList, <String>['Option A', 'Option B']);
      expect(attributes.showHighLight, isTrue);
      expect(attributes.mQueryClient, 'Option');
    });

    test('updates properties mutably', () {
      final SearchAttributes<int> attributes = SearchAttributes<int>();

      attributes.searchList = <int>[1, 2, 3];
      attributes.showHighLight = true;
      attributes.mQueryClient = '1';

      expect(attributes.searchList, <int>[1, 2, 3]);
      expect(attributes.showHighLight, isTrue);
      expect(attributes.mQueryClient, '1');
    });
  });
}
