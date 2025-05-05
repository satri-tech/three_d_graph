part of '../shapes.dart';

List<List<double>> _cylinder({
  required double radius,
  required double height,
  required int radialDivisions,
  required int heightDivisions,
}) {
  List<List<double>> points = [];

  for (int i = 0; i <= radialDivisions; i++) {
    double theta = 2 * pi * i / radialDivisions;
    for (int j = 0; j <= heightDivisions; j++) {
      double z = height * j / heightDivisions - height / 2;
      double x = radius * cos(theta);
      double y = radius * sin(theta);
      points.add([x, y, z]);
    }
  }

  return points;
}
