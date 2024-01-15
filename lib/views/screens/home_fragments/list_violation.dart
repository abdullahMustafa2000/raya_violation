import 'package:flutter/material.dart';

class ViolationsListFragment extends StatelessWidget {
  const ViolationsListFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(),
          child: const Center(
            child: Text(
              'Violations',
            ),
          ),
        ),
      ),
    );
  }
}

class ViolationItemWidget extends StatelessWidget {
  const ViolationItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}
