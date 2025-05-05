import 'dart:math';

part 'shapes/barrel.dart';
part 'shapes/sphere.dart';
part 'shapes/cylinder.dart';
part 'shapes/cuboid.dart';
part 'shapes/cone.dart';
part 'shapes/torus.dart';

class Shapes {
  //barrel
  static barrel({
    double radius = 40,
    double height = 100,
    int radialDivisions = 20,
    int heightDivisions = 10,
  }) =>
      _barrel(
        height: height,
        heightDivisions: heightDivisions,
        radialDivisions: radialDivisions,
        radius: radius,
      );

  //cone
  static cone(
          {double radius = 40,
          double height = 100,
          int radialDivisions = 20,
          int heightDivisions = 10}) =>
      _cone(
        radius: radius,
        height: height,
        radialDivisions: radialDivisions,
        heightDivisions: heightDivisions,
      );

//cuboid
  static cuboid({
    double width = 60,
    double height = 40,
    double depth = 80,
    int widthDivisions = 10,
    int heightDivisions = 10,
    int depthDivisions = 10,
  }) =>
      _cuboid(
        width: width,
        height: height,
        depth: depth,
        widthDivisions: widthDivisions, // More subdivisions along width
        heightDivisions: heightDivisions, // More subdivisions along height
        depthDivisions: depthDivisions, // More subdivisions along depth
      );

  //cylinder
  static cylinder({
    double radius = 40,
    double height = 100,
    int radialDivisions = 20,
    int heightDivisions = 10,
  }) =>
      _cylinder(
        radius: radius,
        height: height,
        heightDivisions: heightDivisions,
        radialDivisions: radialDivisions,
      );

  //sphere
  static sphere({double radius = 50, int divisions = 20}) =>
      _sphere(radius: radius, divisions: divisions);

//torus
  static torus({
    double R = 50,
    double r = 20,
    int radialDivisions = 20,
    int tubeDivisions = 10,
  }) =>
      _torus(
          R: R,
          r: r,
          radialDivisions: radialDivisions,
          tubeDivisions: tubeDivisions);
}
