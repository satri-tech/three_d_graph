part of '../shapes.dart';

List<List<double>> _sphere({required double radius, required int divisions}) {
  List<List<double>> points = [];
  for (int i = 0; i <= divisions; i++) {
    double theta = pi * i / divisions; // Angle from Z-axis
    for (int j = 0; j <= divisions; j++) {
      double phi = 2 * pi * j / divisions; // Angle in XY plane
      double x = radius * sin(theta) * cos(phi);
      double y = radius * sin(theta) * sin(phi);
      double z = radius * cos(theta);
      points.add([x, y, z]);
    }
  }
  return points;
}
