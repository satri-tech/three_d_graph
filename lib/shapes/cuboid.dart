part of '../shapes.dart';

List<List<double>> _cuboid({
  required double width,
  required double height,
  required double depth,
  required int widthDivisions,
  required int heightDivisions,
  required int depthDivisions,
}) {
  List<List<double>> points = [];

  // Generate points for front and back faces
  for (int i = 0; i <= widthDivisions; i++) {
    for (int j = 0; j <= heightDivisions; j++) {
      // Front face
      points.add([
        -width / 2 + i * (width / widthDivisions),
        -height / 2 + j * (height / heightDivisions),
        depth / 2
      ]);
      // Back face
      points.add([
        -width / 2 + i * (width / widthDivisions),
        -height / 2 + j * (height / heightDivisions),
        -depth / 2
      ]);
    }
  }

  // Generate points for the sides
  for (int i = 0; i <= widthDivisions; i++) {
    for (int j = 0; j <= depthDivisions; j++) {
      // Left face
      points.add([
        -width / 2,
        height / 2 - j * (height / depthDivisions),
        depth / 2 - i * (depth / depthDivisions)
      ]);
      // Right face
      points.add([
        width / 2,
        height / 2 - j * (height / depthDivisions),
        depth / 2 - i * (depth / depthDivisions)
      ]);
    }
  }

  // Generate points for the top and bottom faces
  for (int i = 0; i <= depthDivisions; i++) {
    for (int j = 0; j <= heightDivisions; j++) {
      // Top face
      points.add([
        -width / 2 + j * (width / heightDivisions),
        height / 2,
        depth / 2 - i * (depth / depthDivisions)
      ]);
      // Bottom face
      points.add([
        -width / 2 + j * (width / heightDivisions),
        -height / 2,
        depth / 2 - i * (depth / depthDivisions)
      ]);
    }
  }

  return points;
}
