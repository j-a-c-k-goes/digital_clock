int counter = 0;
float angle = 0; // for smooth oscillation
float speed = 0;
int columns; // width of images divided by each slice
int slice_factor = 4; // 36, 54, 88, 96, 172 work really well. highers number means looser cuts
PFont font;
void setup() {
  size(1080, 1080);
  columns = width / slice_factor;
  font = createFont("GlyphWorld-Mountain", 48);
  //textAlign(CENTER);
  String[] font_list = PFont.list();
  println(font_list);
}
void draw () {
  int second = second();
  int hour = hour();
  int minute = minute();
  background(255, 255, 255, 144);
  for (int x = 0; x < width; x += slice_factor) {
    float factor = map(x, 0, width, 0.1, 0.2);
    int offset = int(map(tan(angle * factor), -1, 1, 0, factor * second));
    int source_x = (x + offset) % width; // solves using x directly from loop
    float tan_wave = map(tan(radians(source_x)), -1, 1, -1, factor * second); // simpler wave
    //translate(((width / 2) + (172)), offset * factor);
    //
    pushMatrix();
    textFont(font);
    textAlign(CENTER);
    fill(28, 28, second, 188);
    rotate(radians(sin(second * angle)));
    text(second, (width / 2) * tan_wave, (height / 2 + 72) + second * tan_wave);
    popMatrix();
    //
    pushMatrix();
    textFont(font);
    textAlign(CENTER);
    fill(second, 28, 28, 144);
    textSize( (288 - second) );
    rotate(radians(tan(second * angle)));
    if (minute < 10) {
      text(hour + ":" + "0" + minute, (width / 2), height / 2 * tan_wave);
    } else {
      text(hour + ":" +  minute, (width / 2), height / 2 * tan_wave);
    }
    popMatrix();
    copy(source_x, second, slice_factor, slice_factor, x, second, slice_factor, slice_factor);
  }
  if (slice_factor > width + 28) {
    slice_factor = 0;
    println(hour, minute, second);
  }
  if (slice_factor > height + 28) {
    slice_factor = 0;
    println(hour, minute, second);
  }
  slice_factor ++;
  speed ++;
  counter += slice_factor % speed;
  angle ++;
  saveFrame("out_e/frame+####.jpg");
}
