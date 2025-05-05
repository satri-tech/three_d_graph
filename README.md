# three_d_graph

**A Flutter package for creating and manipulating 3D shapes in the XYZ plane.**  

Repository: [three_d_shape](https://github.com/dev-satri/three_d_graph)  

---

## 📌 Features  
- Define and manipulate 3D shapes using mathematical functions  
- Plot custom paths and points in a 3D coordinate system  
- Includes built-in default shapes  
- Optimized for numerical and mathematical applications  

---

## 🚀 Installation  

Add the package to your `pubspec.yaml`:  

```
yaml
dependencies:
  three_d_graph: latest_version
```

Then, run:  
```
flutter pub get
```

---

## 🔥 Usage  

### Import the package  
```
//flutter
import 'package:three_d_graph/shapes.dart';
import 'package:three_d_graph/three_d_graph.dart';
```

### Create a 3D shape  
`using points`
```
//flutter
import 'package:flutter/material.dart';
import 'package:three_d_graph/three_d_graph.dart';

//Sphere
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('3D Sphere'),
      ),
      body: ThreeDGraph(
          markerColor: Colors.purple,
          showAxis: true,
          axisLength: 200,
          divisions: 10,
          points: [
            [1.0, 0.0, 0.0],
            [0.0, 1.0, 0.0],
            [0.0, 0.0, 1.0],
            [-1.0, 0.0, 0.0],
            [0.0, -1.0, 0.0],
            [0.0, 0.0, -1.0],
            [0.707, 0.707, 0.0],
            [0.707, -0.707, 0.0],
            [-0.707, 0.707, 0.0],
            [-0.707, -0.707, 0.0],
            [0.707, 0.0, 0.707],
            [0.707, 0.0, -0.707],
            [-0.707, 0.0, 0.707],
            [-0.707, 0.0, -0.707],
            [0.0, 0.707, 0.707],
            [0.0, 0.707, -0.707],
            [0.0, -0.707, 0.707],
            [0.0, -0.707, -0.707],
            [0.5, 0.5, 0.707],
            [0.5, -0.5, 0.707],
            [-0.5, 0.5, 0.707],
            [-0.5, -0.5, 0.707],
            [0.5, 0.5, -0.707],
            [0.5, -0.5, -0.707],
            [-0.5, 0.5, -0.707],
            [-0.5, -0.5, -0.707]
          ]),
    );
  }
}

```
`using lines`
```
import 'package:flutter/material.dart';
import 'package:three_d_graph/three_d_graph.dart';

//Random 3D Shape
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('3D Shape'),
      ),
      body: ThreeDGraph(
          markerColor: Colors.purple,
          showAxis: true,
          axisLength: 200,
          divisions: 10,
          shape: [
            [10.0, 20.0, 30.0],
            [10.0, 20.0, -30.0],
            [10.0, -20.0, 30.0],
            [10.0, -20.0, -30.0],
            [-10.0, 20.0, 30.0],
            [-10.0, 20.0, -30.0],
            [-10.0, -20.0, 30.0],
            [-10.0, -20.0, -30.0],
            [15.0, 25.0, 35.0],
            [15.0, 25.0, -35.0],
            [15.0, -25.0, 35.0],
            [15.0, -25.0, -35.0],
            [-15.0, 25.0, 35.0],
            [-15.0, 25.0, -35.0],
            [-15.0, -25.0, 35.0],
            [-15.0, -25.0, -35.0]
          ]),
    );
  }
}


```

### Generate Shapes  
There are different ways to create Sphere. 
1. Using shape attribute or point attribute and passing the values manually
2. Using the given Shapes class and using it
3.
`Sphere`
```
import 'package:flutter/material.dart';
import 'package:three_d_graph/shapes.dart';
import 'package:three_d_graph/three_d_graph.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sphere'),
      ),
      body: ThreeDGraph(
        markerColor: Colors.purple,
        showAxis: true,
        axisLength: 200,
        divisions: 10,
        points: Shapes.sphere(radius: 4),
      ),
    );
  }
}

```
`Barrel`
```
import 'package:flutter/material.dart';
import 'package:three_d_graph/shapes.dart';
import 'package:three_d_graph/three_d_graph.dart';

//3D Barrel
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('3D Barrel'),
      ),
      body: ThreeDGraph(
          markerColor: Colors.purple,
          showAxis: true,
          axisLength: 100,
          divisions: 10,
          shape: Shapes.barrel()),
    );
  }
}

```
All shapes: `Barrel`,`Cone`,`Cylinder`,`Torus`,`Sphere`,`Cuboid`

---

## 🛠 Attributes  

| Attributes            | Description                              |
|------------------|----------------------------------|
| `points`| Helps to created plotted shapes   |
| `shape`| Uses lines instead of points to draw shapes   |
| `showAxis`    | Shows or hides the 3D axis  |
| `showGrid`    | Shows or hides the Cuboid Grid  |
| `axisLength`    | Determines the length of axis  |
| `markerColor`  | Sets the color of the marker used to plot or create the shape in 3d plain     |
| `divisions`| Defines density of points/ lines used to create the shape     |

---

## 📷 Screenshots  

| 3D Object | Visualization |
|-----------|--------------|
| ![Cube](https://via.placeholder.com/100) | ![Graph](https://via.placeholder.com/100) |

---

## 📜 License  
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.  

---

## 💡 Contributing  
Contributions are welcome! Follow these steps:  
1. Fork the repository  
2. Create a new branch (`feature/new-feature`)  
3. Commit your changes (`git commit -m "Add new feature"`)  
4. Push to the branch (`git push origin feature/new-feature`)  
5. Create a Pull Request  

---

## 📞 Contact  
For questions or suggestions, feel free to reach out:  
📧 Email: [info@satritech.com](mailto:info@satritech.com)  
🌐 Website: [satritech.com](https://satritech.com)  
