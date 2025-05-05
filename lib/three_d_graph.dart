import 'package:flutter/material.dart';
import 'dart:math';

class ThreeDGraph extends StatefulWidget {
  final List<List<double>> points;
  final List<List<double>> shape;
  final Color markerColor;
  final bool showGrid;
  final bool showAxis;
  final double? height;
  final double? width;
  final double axisLength;
  final int divisions;

  const ThreeDGraph({
    super.key,
    this.points = const [],
    this.shape = const [],
    this.markerColor = Colors.orange,
    this.showGrid = false,
    this.showAxis = false,
    this.height,
    this.width,
    this.axisLength = 150.0,
    this.divisions = 10,
  });

  @override
  ThreeDGraphState createState() => ThreeDGraphState();
}

class ThreeDGraphState extends State<ThreeDGraph> {
  double rotationX = 0;
  double rotationY = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            rotationX += details.delta.dy * 0.01;
            rotationY += details.delta.dx * 0.01;
          });
        },
        child: CustomPaint(
          painter: ThreeDGraphPainter(
            rotationX: rotationX,
            rotationY: rotationY,
            points: widget.points,
            shape: widget.shape,
            markerColor: widget.markerColor,
            showGrid: widget.showGrid,
            showAxis: widget.showAxis,
            axsLength: widget.axisLength,
            divns: widget.divisions,
          ),
          size: const Size(double.infinity, double.infinity),
        ),
      ),
    );
  }
}

class ThreeDGraphPainter extends CustomPainter {
  final double rotationX;
  final double rotationY;
  final List<List<double>> points;
  final List<List<double>> shape;
  final Color markerColor;
  final bool showGrid;
  final bool showAxis;
  final int divns;
  final double axsLength;

  ThreeDGraphPainter(
      {required this.rotationX,
      required this.rotationY,
      required this.points,
      required this.shape,
      required this.markerColor,
      required this.showGrid,
      required this.showAxis,
      required this.axsLength,
      required this.divns});

  // Project 3D point to 2D
  Offset projectPoint(double x, double y, double z, Size size) {
    double distance = 300;
    double factor = distance / (distance - z);
    double px = x * factor + size.width / 2;
    double py = -y * factor + size.height / 2;
    return Offset(px, py);
  }

  // Rotate a point in 3D space
  List<double> rotatePoint(
      double x, double y, double z, double rotX, double rotY) {
    double cosX = cos(rotX);
    double sinX = sin(rotX);
    double y1 = y * cosX - z * sinX;
    double z1 = y * sinX + z * cosX;

    double cosY = cos(rotY);
    double sinY = sin(rotY);
    double x1 = x * cosY + z1 * sinY;
    double z2 = -x * sinY + z1 * cosY;

    return [x1, y1, z2];
  }

// Generate cone points for arrowheads
  List<List<double>> generateCone({
    required double radius,
    required double height,
    required int divisions,
    required List<double> tip,
    required List<double> direction,
  }) {
    List<List<double>> points = [];

    // Normalize direction vector
    final norm = sqrt(direction[0] * direction[0] +
        direction[1] * direction[1] +
        direction[2] * direction[2]);
    final dx = direction[0] / norm;
    final dy = direction[1] / norm;
    final dz = direction[2] / norm;

    // Base center of the cone
    final baseCenter = [
      tip[0] - height * dx,
      tip[1] - height * dy,
      tip[2] - height * dz
    ];

    // Generate the base circle points
    for (int i = 0; i < divisions; i++) {
      double theta = 2 * pi * i / divisions;
      double x = baseCenter[0] + radius * (cos(theta) * dy - sin(theta) * dz);
      double y = baseCenter[1] + radius * (cos(theta) * dz - sin(theta) * dx);
      double z = baseCenter[2] + radius * (cos(theta) * dx - sin(theta) * dy);
      points.add([x, y, z]);
    }

    // Add the tip point and connect the base
    points.add(tip);

    return points;
  }

// Draw a cone for arrowheads
  void drawCone(
      Canvas canvas, Size size, Paint paint, List<List<double>> cone) {
    for (int i = 0; i < cone.length - 1; i++) {
      drawLine3D(
          canvas, size, paint, cone[i], cone[(i + 1) % (cone.length - 1)]);
      drawLine3D(canvas, size, paint, cone[i], cone.last);
    }
  }

// Draw axes with arrowheads
  void drawAxis(Canvas canvas, Size size, Paint paint, double axisLength) {
    // Define the cone size
    const double coneRadius = 5;
    const double coneHeight = 10;
    const int coneDivisions = 20;

    // X-axis
    paint.color = Colors.red;
    drawLine3D(canvas, size, paint, [-axisLength, 0, 0], [axisLength, 0, 0],
        label: null);
    final xPositiveCone = generateCone(
      radius: coneRadius,
      height: coneHeight,
      divisions: coneDivisions,
      tip: [axisLength, 0, 0],
      direction: [1, 0, 0],
    );
    final xNegativeCone = generateCone(
      radius: coneRadius,
      height: coneHeight,
      divisions: coneDivisions,
      tip: [-axisLength, 0, 0],
      direction: [-1, 0, 0],
    );
    drawCone(canvas, size, paint, xPositiveCone);
    drawCone(canvas, size, paint, xNegativeCone);

    // Place X-axis labels
    drawAxisLabel(canvas, size, paint, [axisLength + 10, 0, 0], 'X');
    drawAxisLabel(canvas, size, paint, [-(axisLength + 10), 0, 0], '-X');

    // Y-axis
    if (showAxis) {}
    paint.color = Colors.green;
    drawLine3D(canvas, size, paint, [0, -axisLength, 0], [0, axisLength, 0],
        label: null);
    final yPositiveCone = generateCone(
      radius: coneRadius,
      height: coneHeight,
      divisions: coneDivisions,
      tip: [0, axisLength, 0],
      direction: [0, 1, 0],
    );
    final yNegativeCone = generateCone(
      radius: coneRadius,
      height: coneHeight,
      divisions: coneDivisions,
      tip: [0, -axisLength, 0],
      direction: [0, -1, 0],
    );
    drawCone(canvas, size, paint, yPositiveCone);
    drawCone(canvas, size, paint, yNegativeCone);

    // Place Y-axis labels
    drawAxisLabel(canvas, size, paint, [0, axisLength + 10, 0], 'Y');
    drawAxisLabel(canvas, size, paint, [0, -(axisLength + 10), 0], '-Y');

    // Z-axis
    paint.color = Colors.blue;
    drawLine3D(canvas, size, paint, [0, 0, -axisLength], [0, 0, axisLength],
        label: null);
    final zPositiveCone = generateCone(
      radius: coneRadius,
      height: coneHeight,
      divisions: coneDivisions,
      tip: [0, 0, axisLength],
      direction: [0, 0, 1],
    );
    final zNegativeCone = generateCone(
      radius: coneRadius,
      height: coneHeight,
      divisions: coneDivisions,
      tip: [0, 0, -axisLength],
      direction: [0, 0, -1],
    );
    drawCone(canvas, size, paint, zPositiveCone);
    drawCone(canvas, size, paint, zNegativeCone);

    // Place Z-axis labels
    drawAxisLabel(canvas, size, paint, [0, 0, axisLength + 10], 'Z');
    drawAxisLabel(canvas, size, paint, [0, 0, -(axisLength + 10)], '-Z');
  }

//!

  void drawCuboid(
      Canvas canvas, Size size, Paint paint, double length, int divisions) {
    final cuboidVertices = [
      // Bottom face
      [-length, -length, -length],
      [length, -length, -length],
      [length, length, -length],
      [-length, length, -length],

      // Top face
      [-length, -length, length],
      [length, -length, length],
      [length, length, length],
      [-length, length, length],
    ];

    final cuboidEdges = [
      // Bottom edges
      [0, 1], [1, 2], [2, 3], [3, 0],
      // Top edges
      [4, 5], [5, 6], [6, 7], [7, 4],
      // Vertical edges
      [0, 4], [1, 5], [2, 6], [3, 7],
    ];

    paint.color = Colors.grey.withOpacity(0.5); // Light cuboid edges

    for (var edge in cuboidEdges) {
      drawLine3D(
        canvas,
        size,
        paint,
        cuboidVertices[edge[0]],
        cuboidVertices[edge[1]],
      );
    }

    // Draw gridlines inside the cuboid faces
    drawCuboidGrid(canvas, size, paint, length, divisions);
  }

// Method to draw gridlines on the faces of the cuboid
  void drawCuboidGrid(
      Canvas canvas, Size size, Paint paint, double axisLength, int divisions) {
    paint.color = Colors.grey.withOpacity(0.3); // Light gridlines

    double spacing = axisLength * 2 / divisions; // Grid spacing for divisions

    // Front and back faces (XY plane)
    for (int i = 0; i <= divisions; i++) {
      double offset = -axisLength + spacing * i;

      // Front face (Z = -axisLength)
      drawLine3D(canvas, size, paint, [-axisLength, offset, -axisLength],
          [axisLength, offset, -axisLength]);
      drawLine3D(canvas, size, paint, [offset, -axisLength, -axisLength],
          [offset, axisLength, -axisLength]);

      // Back face (Z = axisLength)
      drawLine3D(canvas, size, paint, [-axisLength, offset, axisLength],
          [axisLength, offset, axisLength]);
      drawLine3D(canvas, size, paint, [offset, -axisLength, axisLength],
          [offset, axisLength, axisLength]);
    }

    // Left and right faces (XZ plane)
    for (int i = 0; i <= divisions; i++) {
      double offset = -axisLength + spacing * i;

      // Left face (X = -axisLength)
      drawLine3D(canvas, size, paint, [-axisLength, -axisLength, offset],
          [-axisLength, axisLength, offset]);
      drawLine3D(canvas, size, paint, [-axisLength, offset, -axisLength],
          [-axisLength, offset, axisLength]);

      // Right face (X = axisLength)
      drawLine3D(canvas, size, paint, [axisLength, -axisLength, offset],
          [axisLength, axisLength, offset]);
      drawLine3D(canvas, size, paint, [axisLength, offset, -axisLength],
          [axisLength, offset, axisLength]);
    }

    // Top and bottom faces (YZ plane)
    for (int i = 0; i <= divisions; i++) {
      double offset = -axisLength + spacing * i;

      // Top face (Y = axisLength)
      drawLine3D(canvas, size, paint, [-axisLength, axisLength, offset],
          [axisLength, axisLength, offset]);
      drawLine3D(canvas, size, paint, [offset, axisLength, -axisLength],
          [offset, axisLength, axisLength]);

      // Bottom face (Y = -axisLength)
      drawLine3D(canvas, size, paint, [-axisLength, -axisLength, offset],
          [axisLength, -axisLength, offset]);
      drawLine3D(canvas, size, paint, [offset, -axisLength, -axisLength],
          [offset, -axisLength, axisLength]);
    }
  }

// Method to draw ticks along the axes without placing them at the ends
  void drawTicksWithoutEnds(Canvas canvas, Size size, Paint paint,
      double axisLength, int divisions, double tickSize) {
    double spacing =
        axisLength * 2 / divisions; // Tick spacing based on divisions

    for (double t = -axisLength + spacing; t < axisLength; t += spacing) {
      // Tick on X-axis
      drawLine3D(canvas, size, paint, [t, -tickSize, 0], [t, tickSize, 0]);
      // Tick on Y-axis
      drawLine3D(canvas, size, paint, [-tickSize, t, 0], [tickSize, t, 0]);
      // Tick on Z-axis
      drawLine3D(canvas, size, paint, [0, -tickSize, t], [0, tickSize, t]);
    }
  }

  //!
  void drawAxisLabel(Canvas canvas, Size size, Paint paint,
      List<double> position, String label) {
    final rotated = rotatePoint(
        position[0], position[1], position[2], rotationX, rotationY);
    final labelOffset = projectPoint(rotated[0], rotated[1], rotated[2], size);

    final textPainter = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(color: paint.color, fontSize: 12),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(
        canvas, labelOffset.translate(6, -6)); // Adjusted for offset
  }

  // Draw a 3D line
  void drawLine3D(Canvas canvas, Size size, Paint paint, List<double> start,
      List<double> end,
      {String? label}) {
    final startRotated =
        rotatePoint(start[0], start[1], start[2], rotationX, rotationY);
    final endRotated =
        rotatePoint(end[0], end[1], end[2], rotationX, rotationY);

    final p1 =
        projectPoint(startRotated[0], startRotated[1], startRotated[2], size);
    final p2 = projectPoint(endRotated[0], endRotated[1], endRotated[2], size);

    canvas.drawLine(p1, p2, paint);

    // Draw the label at the end of the axis
    if (label != null && endRotated[2] > -300) {
      final labelOffset =
          projectPoint(endRotated[0], endRotated[1], endRotated[2], size);
      final textPainter = TextPainter(
        text: TextSpan(
          text: label,
          style: TextStyle(color: paint.color, fontSize: 12),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      textPainter.paint(canvas, labelOffset.translate(4, -12));
    }
  }

// Function to normalize point to grid units
  List<double> normalizeToGrid(
      List<double> point, double axisLength, int divisions) {
    double scale = axisLength * 2 / divisions; // Grid spacing for divisions
    return [
      point[0] * scale, // X coordinate
      point[1] * scale, // Y coordinate
      point[2] * scale // Z coordinate
    ];
  }

  // Draw a 3D point, aligned with grid
  void drawPoint3D(Canvas canvas, Size size, Paint paint, List<double> point,
      double length, int divisions) {
    // Normalize the point to fit the grid
    List<double> normalizedPoint = normalizeToGrid(point, length, divisions);

    final rotated = rotatePoint(normalizedPoint[0], normalizedPoint[1],
        normalizedPoint[2], rotationX, rotationY);
    final p = projectPoint(rotated[0], rotated[1], rotated[2], size);

    // Use a small circle to represent the point
    const pointRadius = 1.0; // Small radius for point
    canvas.drawCircle(p, pointRadius, paint);
  }

  // Draw a polygon (closed shape) in 3D
  void drawPolygon3D(
      Canvas canvas, Size size, Paint paint, List<List<double>> vertices) {
    for (int i = 0; i < vertices.length; i++) {
      final start = vertices[i];
      final end = vertices[(i + 1) % vertices.length];
      drawLine3D(canvas, size, paint, start, end);
    }
  }

  // Function to scale points based on cuboid length and divisions
  List<List<double>> scalePoints(
      List<List<double>> points, double cuboidLength, int divisions) {
    double scale = cuboidLength / divisions;
    List<List<double>> scaledPoints = [];

    for (var point in points) {
      scaledPoints.add([
        point[0] * scale, // Scale X
        point[1] * scale, // Scale Y
        point[2] * scale, // Scale Z
      ]);
    }

    return scaledPoints;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    double axisLength = axsLength; // New adjustable axis length
    int divisions = divns; // Number of divisions on each axis
    // Draw the 3D axes
    if (showAxis) drawAxis(canvas, size, paint, axisLength);

    // Draw the cuboid with gridlines
    if (showGrid) drawCuboid(canvas, size, paint, axisLength, divisions);

    // Draw ticks on the axes, avoid ends where the cones are placed
    double tickSize = 5.0; // Adjust size as needed
    if (showAxis) {
      drawTicksWithoutEnds(
          canvas, size, paint, axisLength, divisions, tickSize);
    }

    // Plot points
    paint.color = markerColor;
    for (var point in points) {
      // drawPoint3D(canvas, size, paint, point);
      drawPoint3D(canvas, size, paint, point, axisLength, divisions);
    }

    // Draw shapes
    paint.color = Colors.purple;
    drawPolygon3D(canvas, size, paint, shape);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
