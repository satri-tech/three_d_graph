import 'package:flutter/material.dart';
import 'package:three_d_graph/shapes.dart';
import 'package:three_d_graph/three_d_graph.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShapeExplorer(),
    );
  }
}

enum ShapeType { sphere, cylinder, cone, cuboid, torus, barrel }

extension ShapeLabel on ShapeType {
  String get label => name[0].toUpperCase() + name.substring(1);
}

class ShapeExplorer extends StatefulWidget {
  const ShapeExplorer({super.key});

  @override
  State<ShapeExplorer> createState() => _ShapeExplorerState();
}

class _ShapeExplorerState extends State<ShapeExplorer> {
  ShapeType _shape = ShapeType.sphere;
  bool _showAxes = true;
  bool _showGrid = false;
  bool _showRuler = true;
  Color _markerColor = Colors.cyan;
  Color _shapeColor = const Color(0xFF00E5FF);
  String _renderMode = 'points';

  final Map<String, double> _params = {
    'sphere_radius': 5,
    'sphere_divisions': 15,
    'cylinder_radius': 4,
    'cylinder_height': 8,
    'cylinder_radialDivs': 15,
    'cylinder_heightDivs': 8,
    'cone_radius': 4,
    'cone_height': 8,
    'cone_radialDivs': 15,
    'cone_heightDivs': 8,
    'cuboid_width': 6,
    'cuboid_height': 4,
    'cuboid_depth': 8,
    'cuboid_widthDivs': 8,
    'cuboid_heightDivs': 6,
    'cuboid_depthDivs': 8,
    'torus_R': 5,
    'torus_r': 2,
    'torus_radialDivs': 15,
    'torus_tubeDivs': 8,
    'barrel_radius': 4,
    'barrel_height': 8,
    'barrel_radialDivs': 15,
    'barrel_heightDivs': 8,
  };

  List<List<double>> _buildShape() {
    switch (_shape) {
      case ShapeType.sphere:
        return Shapes.sphere(
          radius: _params['sphere_radius']!,
          divisions: _params['sphere_divisions']!.toInt(),
        );
      case ShapeType.cylinder:
        return Shapes.cylinder(
          radius: _params['cylinder_radius']!,
          height: _params['cylinder_height']!,
          radialDivisions: _params['cylinder_radialDivs']!.toInt(),
          heightDivisions: _params['cylinder_heightDivs']!.toInt(),
        );
      case ShapeType.cone:
        return Shapes.cone(
          radius: _params['cone_radius']!,
          height: _params['cone_height']!,
          radialDivisions: _params['cone_radialDivs']!.toInt(),
          heightDivisions: _params['cone_heightDivs']!.toInt(),
        );
      case ShapeType.cuboid:
        return Shapes.cuboid(
          width: _params['cuboid_width']!,
          height: _params['cuboid_height']!,
          depth: _params['cuboid_depth']!,
          widthDivisions: _params['cuboid_widthDivs']!.toInt(),
          heightDivisions: _params['cuboid_heightDivs']!.toInt(),
          depthDivisions: _params['cuboid_depthDivs']!.toInt(),
        );
      case ShapeType.torus:
        return Shapes.torus(
          R: _params['torus_R']!,
          r: _params['torus_r']!,
          radialDivisions: _params['torus_radialDivs']!.toInt(),
          tubeDivisions: _params['torus_tubeDivs']!.toInt(),
        );
      case ShapeType.barrel:
        return Shapes.barrel(
          radius: _params['barrel_radius']!,
          height: _params['barrel_height']!,
          radialDivisions: _params['barrel_radialDivs']!.toInt(),
          heightDivisions: _params['barrel_heightDivs']!.toInt(),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final shapeVertices = _buildShape();
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(
        title: const Text('THREE_D GRAPH'),
        backgroundColor: const Color(0xFF0A0E1A),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 700;
          if (isWide) {
            return Row(
              children: [
                Expanded(flex: 3, child: _buildViewer(shapeVertices)),
                SizedBox(width: 300, child: _buildControls()),
              ],
            );
          }
          return Column(
            children: [
              Expanded(flex: 3, child: _buildViewer(shapeVertices)),
              _buildControls(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildViewer(List<List<double>> vertices) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFF0A0E1A),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Row(
              children: [
                Text(
                  '${_shape.label} \u2022 ${_renderMode.toUpperCase()}',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF00E5FF),
                  ),
                ),
                const Spacer(),
                Text(
                  'DRAG TO ROTATE',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: ThreeDGraph(
                points: _renderMode == 'shape' ? [] : vertices,
                shape: _renderMode == 'points' ? [] : vertices,
                showAxis: _showAxes,
                showGrid: _showGrid,
                showRuler: _showRuler,
                axisLength: 150,
                divisions: 10,
                markerColor: _markerColor,
                shapeColor: _shapeColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      color: const Color(0xFF0D1117),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _label('SHAPE'),
            const SizedBox(height: 4),
            _dropdown(),
            const SizedBox(height: 14),
            _label('PARAMETERS'),
            const SizedBox(height: 4),
            ..._buildParamControls(),
            const SizedBox(height: 14),
            _label('COLOR'),
            const SizedBox(height: 6),
            ColorPicker(
              selectedColor: _markerColor,
              onChanged: (c) => setState(() => _markerColor = c),
            ),
            const SizedBox(height: 14),
            _label('RENDER MODE'),
            const SizedBox(height: 6),
            Row(
              children: [
                _modeChip('POINTS', 'points'),
                const SizedBox(width: 6),
                _modeChip('SHAPE', 'shape'),
                const SizedBox(width: 6),
                _modeChip('BOTH', 'both'),
              ],
            ),
            const SizedBox(height: 14),
            _label('SHAPE COLOR'),
            const SizedBox(height: 6),
            _miniColorPicker(_shapeColor, (c) => setState(() => _shapeColor = c)),
            const SizedBox(height: 12),
            _label('OVERLAYS'),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(child: _toggle('AXES', _showAxes, (v) => setState(() => _showAxes = v))),
                const SizedBox(width: 8),
                Expanded(child: _toggle('GRID', _showGrid, (v) => setState(() => _showGrid = v))),
                const SizedBox(width: 8),
                Expanded(child: _toggle('RULER', _showRuler, (v) => setState(() => _showRuler = v))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 10,
        letterSpacing: 1.5,
        color: Colors.grey[500],
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _dropdown() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0D1117),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF1A2744)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: DropdownButton<ShapeType>(
        value: _shape,
        isExpanded: true,
        underline: const SizedBox(),
        dropdownColor: const Color(0xFF0D1117),
        style: const TextStyle(color: Colors.white, fontSize: 14),
        items: ShapeType.values
            .map((s) => DropdownMenuItem(
                  value: s,
                  child: Text(s.label),
                ))
            .toList(),
        onChanged: (v) => setState(() => _shape = v!),
      ),
    );
  }

  Widget _toggle(String label, bool value, ValueChanged<bool> onChanged) {
    final color = value ? Colors.cyan : Colors.grey[600]!;
    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: value ? Colors.cyan.withValues(alpha: 0.1) : const Color(0xFF0D1117),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color, width: value ? 1.2 : 0.6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              value ? Icons.check_circle : Icons.radio_button_unchecked,
              size: 14,
              color: color,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(fontSize: 11, color: color, fontWeight: value ? FontWeight.w600 : FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }

  Widget _modeChip(String label, String mode) {
    final active = _renderMode == mode;
    final color = Colors.cyan;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _renderMode = mode),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: active ? color.withValues(alpha: 0.1) : const Color(0xFF0D1117),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: active ? color : const Color(0xFF1A2744),
              width: active ? 1.2 : 0.6,
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              letterSpacing: 1,
              fontWeight: active ? FontWeight.w700 : FontWeight.normal,
              color: active ? color : Colors.grey[600],
            ),
          ),
        ),
      ),
    );
  }

  Widget _miniColorPicker(Color current, ValueChanged<Color> onChanged) {
    const colors = [
      Color(0xFF00E5FF), Color(0xFF00FF88), Color(0xFFFF00E5),
      Color(0xFFFF1744), Color(0xFFFFB300), Color(0xFF76FF03),
      Color(0xFF2979FF), Color(0xFFD500F9), Color(0xFF00BFA5),
      Color(0xFFFF6D00), Color(0xFF18FFFF), Color(0xFFE040FB),
      Color(0xFF536DFE), Color(0xFF69F0AE), Color(0xFFFFAB40),
    ];
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      children: colors.map((c) => GestureDetector(
        onTap: () => onChanged(c),
        child: Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: c,
            shape: BoxShape.circle,
            border: Border.all(
              color: c == current ? Colors.white : const Color(0xFF1A2744),
              width: c == current ? 2 : 1,
            ),
          ),
        ),
      )).toList(),
    );
  }

  List<Widget> _buildParamControls() {
    switch (_shape) {
      case ShapeType.sphere:
        return [_slider('Radius', 'sphere_radius', 0.5, 10), _sliderInt('Divisions', 'sphere_divisions', 3, 30)];
      case ShapeType.cylinder:
        return [_slider('Radius', 'cylinder_radius', 0.5, 8), _slider('Height', 'cylinder_height', 1, 10), _sliderInt('Radial', 'cylinder_radialDivs', 3, 20), _sliderInt('Height', 'cylinder_heightDivs', 3, 20)];
      case ShapeType.cone:
        return [_slider('Radius', 'cone_radius', 0.5, 8), _slider('Height', 'cone_height', 1, 10), _sliderInt('Radial', 'cone_radialDivs', 3, 20), _sliderInt('Height', 'cone_heightDivs', 3, 20)];
      case ShapeType.cuboid:
        return [_slider('Width', 'cuboid_width', 1, 10), _slider('Height', 'cuboid_height', 1, 10), _slider('Depth', 'cuboid_depth', 1, 10), _sliderInt('W', 'cuboid_widthDivs', 3, 15), _sliderInt('H', 'cuboid_heightDivs', 3, 15), _sliderInt('D', 'cuboid_depthDivs', 3, 15)];
      case ShapeType.torus:
        return [_slider('Major R', 'torus_R', 1, 8), _slider('Minor r', 'torus_r', 0.5, 4), _sliderInt('Radial', 'torus_radialDivs', 3, 20), _sliderInt('Tube', 'torus_tubeDivs', 3, 20)];
      case ShapeType.barrel:
        return [_slider('Radius', 'barrel_radius', 0.5, 8), _slider('Height', 'barrel_height', 1, 10), _sliderInt('Radial', 'barrel_radialDivs', 3, 20), _sliderInt('Height', 'barrel_heightDivs', 3, 20)];
    }
  }

  Widget _slider(String label, String key, double min, double max) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(width: 60, child: Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[400]))),
          Expanded(
            child: SliderTheme(
              data: SliderThemeData(
                trackHeight: 3,
                activeTrackColor: Colors.cyan,
                inactiveTrackColor: Colors.cyan.withValues(alpha: 0.15),
                thumbColor: Colors.cyan,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                overlayColor: Colors.cyan.withValues(alpha: 0.12),
              ),
              child: Slider(
                value: _params[key]!,
                min: min,
                max: max,
                divisions: ((max - min) * 10).round(),
                onChanged: (v) => setState(() => _params[key] = v),
              ),
            ),
          ),
          SizedBox(width: 34, child: Text(_params[key]!.toStringAsFixed(1), style: TextStyle(fontSize: 11, color: Colors.cyan[300]))),
        ],
      ),
    );
  }

  Widget _sliderInt(String label, String key, int min, int max) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(width: 60, child: Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[400]))),
          Expanded(
            child: SliderTheme(
              data: SliderThemeData(
                trackHeight: 3,
                activeTrackColor: Colors.amber,
                inactiveTrackColor: Colors.amber.withValues(alpha: 0.15),
                thumbColor: Colors.amber,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                overlayColor: Colors.amber.withValues(alpha: 0.12),
              ),
              child: Slider(
                value: _params[key]!,
                min: min.toDouble(),
                max: max.toDouble(),
                divisions: max - min,
                onChanged: (v) => setState(() => _params[key] = v),
              ),
            ),
          ),
          SizedBox(width: 34, child: Text('${_params[key]!.toInt()}', style: TextStyle(fontSize: 11, color: Colors.amber[300]))),
        ],
      ),
    );
  }
}

class ColorPicker extends StatefulWidget {
  final Color selectedColor;
  final ValueChanged<Color> onChanged;

  const ColorPicker({super.key, required this.selectedColor, required this.onChanged});

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  late double _hue;
  late double _saturation;
  late double _brightness;
  bool _showPicker = false;

  static const _presets = [
    Color(0xFF00F0FF), Color(0xFF00FF88), Color(0xFFFF00E5),
    Color(0xFFFF1744), Color(0xFFFFB300), Color(0xFF76FF03),
    Color(0xFF2979FF), Color(0xFFD500F9), Color(0xFFFFFFFF),
    Color(0xFFFF6D00), Color(0xFF00E5FF), Color(0xFF00B0FF),
    Color(0xFFE040FB), Color(0xFF536DFE), Color(0xFF69F0AE),
    Color(0xFFFFAB40), Color(0xFF40C4FF), Color(0xFF18FFFF),
    Color(0xFFFF4081), Color(0xFF7C4DFF), Color(0xFFB2FF59),
    Color(0xFFFF5252), Color(0xFF448AFF), Color(0xFFFFD740),
  ];

  @override
  void initState() {
    super.initState();
    _updateHSV(widget.selectedColor);
  }

  @override
  void didUpdateWidget(ColorPicker old) {
    super.didUpdateWidget(old);
    if (old.selectedColor != widget.selectedColor) {
      _updateHSV(widget.selectedColor);
    }
  }

  void _updateHSV(Color c) {
    final hsv = HSVColor.fromColor(c);
    _hue = hsv.hue;
    _saturation = hsv.saturation;
    _brightness = hsv.value;
  }

  Color _hsvColor() => HSVColor.fromAHSV(1, _hue, _saturation, _brightness).toColor();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            for (final preset in _presets)
              GestureDetector(
                onTap: () => widget.onChanged(preset),
                child: Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    color: preset,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: preset == widget.selectedColor ? Colors.white : const Color(0xFF1A2744),
                      width: preset == widget.selectedColor ? 2 : 1,
                    ),
                  ),
                ),
              ),
            GestureDetector(
              onTap: () => setState(() => _showPicker = !_showPicker),
              child: Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: widget.selectedColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.cyan, width: 1.5),
                ),
                child: Icon(Icons.tune, size: 13, color: const Color(0xFF0D1117)),
              ),
            ),
          ],
        ),
        if (_showPicker) ...[
          const SizedBox(height: 10),
          _buildHueBar(),
          const SizedBox(height: 8),
          _buildSVPad(),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: Container(height: 28, decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), border: Border.all(color: const Color(0xFF1A2744)), color: widget.selectedColor))),
              const SizedBox(width: 10),
              Text(_hexColor(widget.selectedColor), style: TextStyle(fontSize: 11, color: Colors.grey[500], letterSpacing: 1)),
            ],
          ),
        ],
      ],
    );
  }

  String _hexColor(Color c) {
    final r = (c.r * 255).round().clamp(0, 255);
    final g = (c.g * 255).round().clamp(0, 255);
    final b = (c.b * 255).round().clamp(0, 255);
    return '#${r.toRadixString(16).padLeft(2, '0')}${g.toRadixString(16).padLeft(2, '0')}${b.toRadixString(16).padLeft(2, '0')}'.toUpperCase();
  }

  Widget _buildHueBar() {
    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        onPanDown: (d) => _setHue(d.localPosition.dx, constraints.maxWidth),
        onPanUpdate: (d) => _setHue(d.localPosition.dx, constraints.maxWidth),
        child: Container(
          height: 18,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            gradient: const LinearGradient(colors: [Color(0xFFFF0000), Color(0xFFFFFF00), Color(0xFF00FF00), Color(0xFF00FFFF), Color(0xFF0000FF), Color(0xFFFF00FF), Color(0xFFFF0000)]),
          ),
          child: Align(
            alignment: Alignment(_hue / 360 * 2 - 1, 0),
            child: Container(width: 4, height: 22, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(2))),
          ),
        ),
      );
    });
  }

  void _setHue(double dx, double width) {
    final hue = (dx / width).clamp(0.0, 1.0) * 360;
    setState(() {
      _hue = hue;
      widget.onChanged(_hsvColor());
    });
  }

  Widget _buildSVPad() {
    return LayoutBuilder(builder: (context, constraints) {
      final w = constraints.maxWidth;
      return GestureDetector(
        onPanDown: (d) => _setSV(d.localPosition.dx, d.localPosition.dy, w, w * 0.55),
        onPanUpdate: (d) => _setSV(d.localPosition.dx, d.localPosition.dy, w, w * 0.55),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: SizedBox(
            height: w * 0.55,
            child: Stack(
              children: [
                Container(decoration: BoxDecoration(gradient: LinearGradient(colors: [HSVColor.fromAHSV(1, _hue, 1, 1).toColor(), Colors.white], begin: Alignment.topLeft, end: Alignment.topRight))),
                Container(decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.transparent, Colors.black], begin: Alignment.topCenter, end: Alignment.bottomCenter))),
                Align(
                  alignment: Alignment(_saturation * 2 - 1, _brightness * 2 - 1),
                  child: Container(width: 12, height: 12, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2))),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  void _setSV(double dx, double dy, double w, double h) {
    setState(() {
      _saturation = (dx / w).clamp(0.0, 1.0);
      _brightness = 1.0 - (dy / h).clamp(0.0, 1.0);
      widget.onChanged(_hsvColor());
    });
  }
}
