import 'dart:math';
import 'dart:ui';

Color randColor(Random r) {
  Color c;
  do {
    c = Color.fromARGB(255, r.nextInt(256), r.nextInt(256), r.nextInt(256));
  } while (c.computeLuminance() < 0.5);

  return c;
}