import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myownmenu/utils/SourceUtils.dart';

Widget filter(listFilters, int index, dynamic backgroundColor, dynamic fontColor) {
  return Card(
      color: backgroundColor,
      clipBehavior: Clip.antiAlias,
      child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Image.asset(SourceUtils.FILTRO_SRC),
              Text(
                listFilters.elementAt(index),
                style: TextStyle(
                    height: 4, fontWeight: FontWeight.bold, color: fontColor),
              ),
            ],
          )));
}
