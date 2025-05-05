part of '../shapes.dart';

List<List<double>> _barrel({
  required double radius,
  required double height,
  required int radialDivisions,
  required int heightDivisions,
}) {
  List<List<double>> points = [];

  // Generate points for the side surface
  for (int i = 0; i <= radialDivisions; i++) {
    double theta = 2 * pi * i / radialDivisions;
    for (int j = 0; j <= heightDivisions; j++) {
      double z = height * j / heightDivisions -
          height / 2; // Position along the height
      double x = radius * cos(theta);
      double y = radius * sin(theta);
      points.add([x, y, z]);
    }
  }

  // Generate points for the top face (fully filled circle)
  for (int i = 0; i <= radialDivisions; i++) {
    double theta = 2 * pi * i / radialDivisions;
    for (int j = 0; j <= radialDivisions; j++) {
      double phi =
          2 * pi * j / radialDivisions; // Angle for points within the circle
      double x = radius * cos(theta) * cos(phi);
      double y = radius * cos(theta) * sin(phi);
      points.add([x, y, height / 2]); // Points for top face
    }
  }

  // Generate points for the bottom face (fully filled circle)
  for (int i = 0; i <= radialDivisions; i++) {
    double theta = 2 * pi * i / radialDivisions;
    for (int j = 0; j <= radialDivisions; j++) {
      double phi =
          2 * pi * j / radialDivisions; // Angle for points within the circle
      double x = radius * cos(theta) * cos(phi);
      double y = radius * cos(theta) * sin(phi);
      points.add([x, y, -height / 2]); // Points for bottom face
    }
  }

  return points;
}
