part of '../shapes.dart';

List<List<double>> _torus({
  required double R,
  required double r,
  required int radialDivisions,
  required int tubeDivisions,
}) {
  List<List<double>> points = [];

  for (int i = 0; i <= radialDivisions; i++) {
    double theta = 2 * pi * i / radialDivisions;
    for (int j = 0; j <= tubeDivisions; j++) {
      double phi = 2 * pi * j / tubeDivisions;
      double x = (R + r * cos(theta)) * cos(phi);
      double y = (R + r * cos(theta)) * sin(phi);
      double z = r * sin(theta);
      points.add([x, y, z]);
    }
  }

  return points;
}
