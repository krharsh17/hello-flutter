// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'unit.dart';

const _padding = EdgeInsets.all(16.0);

/// [ConverterRoute] where users can input amounts to convert in one [Unit]
/// and retrieve the conversion in another [Unit] for a specific [Category].
///
/// While it is named ConverterRoute, a more apt name would be ConverterScreen,
/// because it is responsible for the UI at the route's destination.
class ConverterRoute extends StatefulWidget {
  /// Color for this [Category].
  final Color color;

  /// Units for this [Category].
  final List<Unit> units;

  /// This [ConverterRoute] requires the color and units to not be null.
  const ConverterRoute({
    @required this.color,
    @required this.units,
  })
      : assert(color != null),
        assert(units != null);

  @override
  _ConverterRouteState createState() => _ConverterRouteState();
}

class _ConverterRouteState extends State<ConverterRoute> {
  // TODO: Set some variables, such as for keeping track of the user's input
  // value and units
  String _userInput;
  String _inputUnit = "Unit 1";
  String userOutput;
  String _outputUnit = "Unit 1";
  List<String> units = <String>["Unit 1", "Unit 2", "Unit 3"];

  // TODO: Determine whether you need to override anything, such as initState()

  // TODO: Add other helper functions. We've given you one, _format()

  /// Clean up conversion; trim trailing zeros, e.g. 5.500 -> 5.5, 10.0 -> 10
  String _format(double conversion) {
    var outputNum = conversion.toStringAsPrecision(7);
    if (outputNum.contains('.') && outputNum.endsWith('0')) {
      var i = outputNum.length - 1;
      while (outputNum[i] == '0') {
        i -= 1;
      }
      outputNum = outputNum.substring(0, i + 1);
    }
    if (outputNum.endsWith('.')) {
      return outputNum.substring(0, outputNum.length - 1);
    }
    return outputNum;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Create the 'input' group of widgets. This is a Column that
    // includes the input value, and 'from' unit [Dropdown].
    var inputGroup = Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(children: <Widget>[
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Input',
            ),
            onChanged: (newValue) {
              setState(() {
                _userInput = newValue;
              });
            },
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
              decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1.0, style: BorderStyle.solid),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)))),
              child: DropdownButtonHideUnderline(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: DropdownButton<String>(
                      hint: new Text("Please choose a unit"),
                      value: _inputUnit,
                      items: units.map((String value) {
                        return new DropdownMenuItem(
                            value: value, child: new Text(value));
                      }).toList(),
                      onChanged: (String newValue) {
                        setState(() {
                          _inputUnit = newValue;
                        });
                      },
                    ),
                  )))
        ]));

    // TODO: Create a compare arrows icon.
    var arrow = Transform.rotate(
        angle: 90 * math.pi / 180,
        child: Icon(Icons.compare_arrows, color: Colors.black, size: 40.0));

    // TODO: Create the 'output' group of widgets. This is a Column that
    // includes the output value, and 'to' unit [Dropdown].
    var outputGroup = Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(children: <Widget>[
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Output',
            ),
            onChanged: (newValue) {
              setState(() {
                userOutput = newValue;
              });
            },
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
              decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1.0, style: BorderStyle.solid),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)))),
              child: DropdownButtonHideUnderline(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: DropdownButton<String>(
                      hint: new Text("Please choose a unit"),
                      value: _outputUnit,
                      items: units.map((String value) {
                        return new DropdownMenuItem(
                            value: value, child: new Text(value));
                      }).toList(),
                      onChanged: (String newValue) {
                        setState(() {
                          _outputUnit = newValue;
                        });
                      },
                    ),
                  )))
        ]));

    // TODO: Return the input, arrows, and output widgets, wrapped in a Column.
    var finalGroup = Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            inputGroup,
            SizedBox(height: 40),
            arrow,
            SizedBox(height: 40),
            outputGroup
          ],
        ));

    return finalGroup;
  }
}
