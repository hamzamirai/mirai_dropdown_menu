## 0.0.9+1 - 2024-10-02

- Update to Flutter 3.24.3 & Dart 3.5.3.

## 0.0.9 - 2024-07-29

- Update to Flutter 3.22.3 & Dart 3.4.3.

## 0.0.8+2 - 2024-01-31

- Made showDropDownMenu public.
- 1- You create a GlobalKey for the MiraiDropDownMenuState<String?>:
```dart
GlobalKey<MiraiDropDownMenuState<String?>> firstDropdownGlobalKey = GlobalKey<MiraiDropDownMenuState<String?>>();
```
- 2- You can then assign this GlobalKey to your MiraiDropDownMenu widget. This allows you to access the widget's state from anywhere in your widget tree.
- 3- To open the dropdown menu from another button, you call the showDropDownMenu method on the current state of the MiraiDropDownMenu widget:
```dart
firstDropdownGlobalKey.currentState?.showDropDownMenu();
```
- 4- Assigning the GlobalKey: By using firstDropdownGlobalKey in the dropdownKey property, you're ensuring that this specific instance of your dropdown widget is associated with the GlobalKey. Your code snippet would look like this:
```dart
// ... inside your widget build method
MiraiDropdownWidget<String>(
dropdownKey: firstDropdownGlobalKey,
// ... other properties
)
```

- ## 0.0.8 - 2023-11-25

- Changed MiraiPopupMenu to MiraiDropDownMenu.
- Added Animation Duration.
- Added AnimatedSwitcher when Choosing an item.
- Added Switch showMode to Top when keyboard is Open while searching.
- Added Switch showMode to Top if the there is no available space to show drop-down at the bottom.
- Added searchNoDataWidget.
- Added Selected Item Background Color
    -     itemWidgetBuilder: (
                int index,
                String? item, {
                bool isItemSelected = false,
              }) {
                return MiraiDropDownItemWidget(
                  item: item,
                  isItemSelected: isItemSelected,
                );
              }, 
    - You can control select item color as you want, for example:
        - color: isSelectedItem ? Colors.white : Colors.black,
    - New Fields:
        - showItemSelectedBackgroundColor
        - itemBackgroundColor
        - selectedItemBackgroundColor

- ## 0.0.7+3 - 2023-11-08

- Added Search TextFormField Style

## 0.0.7+2 - 2023-11-06

- Some Changes...

- ## 0.0.7+1 - 2023-11-06

- Fix onTapChild(newIndex)...

- ## 0.0.7 - 2023-11-05

- Fixed bugs and Added new Features.
- New Fields added on other widget.

## 0.0.6+4 - 2023-10-09

- Added DropDown Item Padding.
- Added DropDown Item OverlayColor.
- Added DropDown Item Height.

## 0.0.6+3 - 2023-09-24

- Upgrade to Flutter 3.13.

- ## 0.0.6+2 - 2023-01-25

- Change DropDown Radius.

## 0.0.6+1 - 2022-06-29

- General search ✅

## 0.0.6 - 2022-06-24

- Added new features such as:
    - Make Dropdown not opening when Children list isEmpty
    - Added search TextFormField:
        - make showSearchTextField: true,
        - Also, you can use a custom input decoration:
            - searchDecoration: InputDecoration(),

## 0.0.5+1 - 2022-05-26

- Support Dart version 2.17.0

## 0.0.5 - 2022-05-25

- Added more detail to the description.

## 0.0.4 - 2022-05-24

- Update to Flutter 3

## 0.0.3

- Upgrade to Flutter 2.10.4 and Dart 2.16.2

## 0.0.2

- Fix Mirai ShowMode Top.

## 0.0.1

- Initial version, created by Mirai Devs.
