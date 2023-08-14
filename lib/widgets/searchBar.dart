import 'package:flutter/material.dart';
import 'package:maps_app/delegates/delegates.dart';

class SearBar extends StatelessWidget {
  const SearBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
        child: GestureDetector(
          onTap: () async {
            final result = showSearch(
                context: context, delegate: SearchDestinationDelegate());
            if (result == null) return null;
            print(result);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
            child: Text('¿Donde quieres ir?',
                style: TextStyle(color: Colors.black87)),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(0, 5))
                ]),
          ),
        ),
      ),
    );
  }
}
