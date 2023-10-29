import '../../../potentiallibrary/widgets/myselectablelist.dart';
import '../../../potentiallibrary/testframework/testmodule.dart';
import '../../../potentiallibrary/testframework/testunit.dart';

class MySelectableListTests extends TestModule {
  late MySelectableList<String> _list;
  late List<String> _itemsInList;
  late List<String> _onSelectItems;

  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(allItelmsCanBeSelected),
      createTest(selectAllTriggersOnSelectForUnselectedItems),
    ];
  }

  void allItelmsCanBeSelected() {
    _list.selectAll();

    assertEqual(_itemsInList, _list.selectedItems);
  }

  void selectAllTriggersOnSelectForUnselectedItems() {
    _list.selectAll();

    assertEqual(_onSelectItems, _list.selectedItems);
  }

  //#region Supporting Code

  @override
  void setUpData() {
    _itemsInList = ['a', 'b', 'c'];
    _onSelectItems = List.empty(growable: true);
  }

  @override
  void setUpObjectUnderTest() {
    _list = MySelectableList<String>(onSelect: onSelect);

    _list.refresh(_itemsInList, (item) => item, (item) => item);
  }

  void onSelect(String item) {
    _onSelectItems.add(item);
  }
}

//#endregion
