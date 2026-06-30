# three_d_graph

A Flutter package for rendering 3D graphs, point clouds, and geometric shapes with interactive drag-to-rotate.

[![pub package](https://img.shields.io/pub/v/three_d_graph)](https://pub.dev/packages/three_d_graph)

## Features

- Render 3D point clouds and polygon wireframes
- Built-in shape generators: Sphere, Cylinder, Cone, Cuboid, Torus, Barrel
- Interactive rotation via drag gesture
- Configurable axes, grid overlays, and marker colors
- Support for both `points` (dot) and `shape` (line) rendering

## Installation

```yaml
dependencies:
  three_d_graph: ^0.1.0
```

Run `flutter pub get`.

## Quick Start

```dart
import 'package:flutter/material.dart';
import 'package:three_d_graph/shapes.dart';
import 'package:three_d_graph/three_d_graph.dart';

void main() => runApp(MaterialApp(home: Scaffold(
  body: ThreeDGraph(
    points: Shapes.sphere(radius: 4, divisions: 15),
    showAxis: true,
    showGrid: true,
  ),
)));
```

## Example

Check the [example](example/) directory for a full interactive demo showcasing all shapes, parameter controls, color picker, and render modes.

Run it locally:

```bash
cd example
flutter run
```

## API

| Attribute | Type | Description |
|-----------|------|-------------|
| `points` | `List<List<double>>` | Renders each vertex as a dot |
| `shape` | `List<List<double>>` | Renders vertices as a connected polygon |
| `showAxis` | `bool` | Show/hide XYZ axes with arrowheads |
| `showGrid` | `bool` | Show/hide the cuboid grid overlay |
| `axisLength` | `double` | Length of the axes and grid bounds |
| `divisions` | `int` | Number of grid divisions |
| `markerColor` | `Color` | Color of point markers |

## Shapes

```dart
Shapes.sphere(radius: 5, divisions: 15)
Shapes.cylinder(radius: 4, height: 8, radialDivisions: 15, heightDivisions: 8)
Shapes.cone(radius: 4, height: 8, radialDivisions: 15, heightDivisions: 8)
Shapes.cuboid(width: 6, height: 4, depth: 8, ...)
Shapes.torus(R: 5, r: 2, radialDivisions: 15, tubeDivisions: 8)
Shapes.barrel(radius: 4, height: 8, radialDivisions: 15, heightDivisions: 8)
```

## License

MIT
