import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ListFromAPI<T extends BaseResponse> extends StatelessWidget {
  const ListFromAPI(
      {super.key, required this.request, required this.widgetOnSuccessful});
  final Future<T>? request;
  final Widget Function(T) widgetOnSuccessful;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: request,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          if (!snapshot.hasError && snapshot.hasData) {
            return widgetOnSuccessful(snapshot.data!);
          } else {
            //widget of no data
            return Container();
          }
        }
      },
    );
  }
}
