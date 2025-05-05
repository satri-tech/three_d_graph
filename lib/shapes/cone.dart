part of '../shapes.dart';

List<List<double>> _cone({
  required double radius,
  required double height,
  required int radialDivisions,
  required int heightDivisions,
}) {
  List<List<double>> points = [];

  for (int i = 0; i <= radialDivisions; i++) {
    double theta = 2 * pi * i / radialDivisions;
    for (int j = 0; j <= heightDivisions; j++) {
      double z = height * j / heightDivisions;
      double r = radius * (1 - z / height);
      double x = r * cos(theta);
      double y = r * sin(theta);
      points.add([x, y, z]);
    }
  }

  return points;
}
