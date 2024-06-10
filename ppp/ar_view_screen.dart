import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:flutter/material.dart';

class ARViewScreen extends StatefulWidget {
  final String modelUrl;

  ARViewScreen({required this.modelUrl});

  @override
  _ARViewScreenState createState() => _ARViewScreenState();
}

class _ARViewScreenState extends State<ARViewScreen> {
  late ARSessionManager arSessionManager;
  late ARObjectManager arObjectManager;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AR View')),
      body: Stack(
        children: [
          ARView(
            onARViewCreated: onARViewCreated,
            planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: ElevatedButton(
              onPressed: onPlaceObjectButtonPressed,
              child: Text('Place Object'),
            ),
          ),
        ],
      ),
    );
  }

  void onARViewCreated(
      ARSessionManager sessionManager, ARObjectManager objectManager) {
    arSessionManager = sessionManager;
    arObjectManager = objectManager;

    arSessionManager.onInitialize(
      showFeaturePoints: false,
      showPlanes: true,
      customPlaneTexturePath: "images/triangle.png",
      showWorldOrigin: true,
      handleTaps: true,
    );
    arObjectManager.onInitialize();
  }

  void onPlaceObjectButtonPressed() async {
    var newNode = ARNode(
      type: NodeType.webGLB,
      uri: widget.modelUrl,
      scale: Vector3(0.2, 0.2, 0.2),
      position: Vector3(0.0, 0.0, 0.0),
      rotation: Vector4(1.0, 0.0, 0.0, 0.0),
    );
    bool didAddNode = await arObjectManager.addNode(newNode);
    if (didAddNode) {
      print("Successfully added node");
    } else {
      print("Failed to add node");
    }
  }

  @override
  void dispose() {
    arSessionManager.dispose();
    arObjectManager.dispose();
    super.dispose();
  }
}
