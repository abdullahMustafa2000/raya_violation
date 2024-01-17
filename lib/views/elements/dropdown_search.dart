import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:raya_violation/models/base_entity.dart';
import 'package:raya_violation/models/driver.dart';
import 'package:raya_violation/models/truck.dart';
import 'package:raya_violation/views/themes/colors.dart';

class SearchDropdownMenuModel extends StatefulWidget {
  SearchDropdownMenuModel(
      {Key? key,
      required this.dataList,
      required this.onItemSelected,
      required this.selectedItem})
      : super(key: key);
  final List<BaseEntity>? dataList;
  final Function onItemSelected;
  BaseEntity? selectedItem;
  @override
  State<SearchDropdownMenuModel> createState() =>
      _SearchDropdownMenuModelState();
}

class _SearchDropdownMenuModelState extends State<SearchDropdownMenuModel> {
  @override
  Widget build(BuildContext context) {
    return DecorateDropDown(
      dropDown: DropdownSearch<BaseEntity>(
        selectedItem: widget.selectedItem,
        itemAsString: (BaseEntity? item) => _getTypeTitle(item!),
        compareFn: (BaseEntity? item, BaseEntity? selected) =>
            _getTypeTitle(item!) == _getTypeTitle(selected!),
        items: widget.dataList ?? [],
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            filled: true,
            hintText: 'choose',
            suffixIcon: const Icon(Icons.keyboard_arrow_down_sharp),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: BorderSide(color: primaryColor, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor, width: 1),
            ),
          ),
        ),
        onChanged: (BaseEntity? val) {
          widget.onItemSelected(val);
          setState(() {
            widget.selectedItem = val;
          });
        },
        popupProps: PopupProps.menu(
          searchDelay: const Duration(microseconds: 500),
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            cursorColor: Theme.of(context).primaryColor,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getTypeTitle(BaseEntity item) {
    if (item is Driver) {
      return item.name;
    } else if (item is Truck) {
      return item.plateNumber;
    }
    return "";
  }
}

class DecorateDropDown extends StatelessWidget {
  const DecorateDropDown({Key? key, required this.dropDown}) : super(key: key);
  final Widget dropDown;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7), color: Colors.white),
      child: dropDown,
    );
  }
}
