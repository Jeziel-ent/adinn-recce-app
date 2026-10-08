# Measurement Principles

1. **Accuracy is the highest priority.** Speed, polish and convenience come second.
2. **The background does not need to be planar.** It may be sky, trees, road, buildings or open
   space. Plane detection can help but must never be a requirement.
3. **A board may or may not exist.** The target area may be an existing board or just a space
   where one will go.
4. **The primary target is a rectangle or square.** The goal is four 3D corner points, from
   which width, height and area are derived.
5. **Physical dimensions come from spatial geometry, not AI guesses.** AI/CV may help find the
   target and corners; sizes come from 3D points (ARCore pose/raycast/depth) and coordinate
   geometry.
6. **Measurements must be validated.** Check opposite sides, right angles, diagonals,
   rectangle/square fit, tracking state, depth availability/confidence and repeatability.
7. **Poor-quality measurements are rejected and retried**, not displayed as if reliable.
8. **Compare against trusted references.** Results are only credible once checked against
   independently measured real-world dimensions (tape/laser/total station) under varied
   conditions. Until then, no accuracy claim is made. See `tests/accuracy/`.
9. **Devices differ.** ARCore and Depth support vary per phone; detect capabilities and degrade
   or refuse explicitly.
