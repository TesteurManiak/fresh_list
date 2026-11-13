import 'package:material_ui/material_ui.dart';
import 'package:motor/motor.dart';

class SpringPagePhysics extends PageScrollPhysics {
  const new({super.parent});

  @override
  SpringPagePhysics applyTo(ScrollPhysics? ancestor) =>
      SpringPagePhysics(parent: buildParent(ancestor));

  @override
  SpringDescription get spring =>
      const MaterialSpringMotion.standardSpatialDefault().description;
}
