import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:raya_violation/models/driver.dart';
import 'package:raya_violation/models/truck.dart';
import 'package:raya_violation/models/violation.dart';
import 'package:intl/intl.dart';
import 'package:raya_violation/views/elements/dropdown_search.dart';

class ViolationsListFragment extends StatefulWidget {
  const ViolationsListFragment({super.key, required this.scrollController});
  final ScrollController scrollController;

  @override
  State<ViolationsListFragment> createState() => _ViolationsListFragmentState();
}

class _ViolationsListFragmentState extends State<ViolationsListFragment> {
  List<Violation> vList = [];
  List<Truck> tList = [];
  List<Driver> dList = [];
  Driver? _selectedDriver;
  Truck? _selectedTruck;
  @override
  Widget build(BuildContext context) {
    _initData();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          _searchbar(),
          _filters(),
          _violationsList(),
        ],
      ),
    );
  }

  Widget _violationsList() {
    if (searchText != "") {
      vList = vList
          .where((element) =>
              element.driver.name.contains(searchText) ||
              element.truck.plateNumber.contains(searchText) ||
              element.dateTime.year.toString() == searchText ||
              element.dateTime.month.toString() == searchText)
          .toList();
    }
    if (_selectedDriver != null) {
      vList = vList
          .where((element) => element.driver.id == _selectedDriver!.id)
          .toList();
    }
    if (_selectedTruck != null) {
      vList = vList
          .where((element) => element.truck.id == _selectedTruck!.id)
          .toList();
    }
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.green.withOpacity(.5),
            ),
            child: ViolationItemWidget(
              item: vList[index],
            ),
          );
        },
        controller: widget.scrollController,
        itemCount: vList.length,
      ),
    );
  }

  String searchText = "";
  Widget _searchbar() => AnimatedSearchBar(
        onChanged: (value) {
          debugPrint("value on Change");
          setState(() {
            searchText = value;
          });
        },
      );

  Widget _filters() => Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _filterItem('Filter by truck:', _trucksDropdown()),
            _filterItem('Filter by driver:', _driversDropdown()),
          ],
        ),
      );

  Widget _filterItem(String label, Widget dropdown) => Expanded(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              Text(label),
              const SizedBox(
                height: 4,
              ),
              dropdown
            ],
          ),
        ),
      );

  Widget _trucksDropdown() => SearchDropdownMenuModel(
      dataList: tList,
      onItemSelected: (item) {
        setState(() {
          _selectedTruck = item;
        });
      },
      selectedItem: _selectedTruck);

  Widget _driversDropdown() => SearchDropdownMenuModel(
      dataList: dList,
      onItemSelected: (item) {
        setState(() {
          _selectedDriver = item;
        });
      },
      selectedItem: _selectedDriver);

  void _initData() {
    for (int i = 0; i <= 20; i++) {
      vList.add(
        Violation.init(i + 1,
            violationDesc: 'سبب المخالفة',
            truck: Truck.init(i + 1, plateNumber: "نمرة العربية"),
            driver: Driver.init(i + 1, name: "اسم السائق"),
            dateTime: DateTime.now().add(Duration(days: i))),
      );

      tList.add(
        Truck.init(
          i + 1,
          plateNumber: 'ق ب د ١ ٢ ٣',
        ),
      );

      dList.add(
        Driver.init(
          i + 1,
          name: 'محمد ه$i',
        ),
      );
    }
  }
}

class ViolationItemWidget extends StatelessWidget {
  const ViolationItemWidget({super.key, required this.item});
  final Violation item;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _data(item),
        Text(DateFormat('yyyy-MM-dd – kk:mm').format(item.dateTime))
      ],
    );
  }

  Widget splitter() => const SizedBox(
        height: 4,
      );

  Widget _data(Violation item) => Column(
        children: [
          Text(item.violationDesc),
          splitter(),
          Text(item.driver.name),
          splitter(),
          Text(item.truck.plateNumber),
        ],
      );
}
