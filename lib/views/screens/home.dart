import 'package:flutter/material.dart';
import 'package:hidable/hidable.dart';
import 'package:raya_violation/views/screens/home_fragments/list_drivers.dart';
import 'package:raya_violation/views/screens/home_fragments/list_trucks.dart';
import 'package:raya_violation/views/screens/home_fragments/list_violation.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController scrollController = ScrollController();

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Hidable(
        preferredWidgetSize: const Size.fromHeight(100),
        controller: scrollController,
        enableOpacityAnimation: true, // optional, defaults to `true`.
        child: SalomonBottomBar(
          margin: const EdgeInsets.all(10),
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            SalomonBottomBarItem(
              icon: const Icon(Icons.attach_money),
              title: const Text("Violations"),
              selectedColor: Colors.green,
            ),

            SalomonBottomBarItem(
              icon: const Icon(Icons.fire_truck_rounded),
              title: const Text("Trucks"),
              selectedColor: Colors.cyan,
            ),

            SalomonBottomBarItem(
              icon: const Icon(Icons.person),
              title: const Text("Drivers"),
              selectedColor: Colors.blueAccent,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: _currentIndex == 0? ViolationsListFragment():
            _currentIndex == 1? TrucksListFragment():
                DriversListFragment(),
      ),
    );
  }
}
