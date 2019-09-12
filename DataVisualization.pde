JSONArray json_data;
HashMap<Float, Integer> data = new HashMap<Float, Integer>();
int max = 0;

void setup() {
  size(800, 600);
  json_data = loadJSONObject("data.json").getJSONObject("data").getJSONArray("findManyTeacher");
  for (int i = 0; i < json_data.size(); i++) {
    Float rating = round(json_data.getJSONObject(i).getFloat("rating") / 0.5) * 0.5;
    if (rating != 0.0) {
      if (data.get(rating) == null) {
        data.put(rating, 1);
      } else {
        data.put(rating, data.get(rating) + 1);
        if (data.get(rating) > max) {
          max = data.get(rating);
        }
      }
    }
  }
  bar_chart(data, max);
  textAlign(CENTER);
  textSize(32);
  text("Lowell High School Teacher Ratings", width / 2, height / 8);
  textSize(16);
  text("data from studentsreview.me", width / 2, height / 8 + 20);
}

void bar_chart(HashMap<Float, Integer> data, int max) {
  float margin = 20;
  for (float i = 1.0; i <= 5.0; i += 0.5) {
    fill((5.0 - i) * 51, i * 51, 0);
    strokeWeight(5);
    float x = width / data.size() * (i - 1.0) * 2.0 + margin;
    float width_ = width / data.size() - margin * 2;
    float max_height = height * 3 / 4;
    float height_ = max_height * (data.get(i) / (float) max) + 25;
    rect(x, height - height_ + 5, width_, height_);
    textAlign(CENTER);
    fill(0);
    text(String.format("%.01f", i), x + width_ / 2, height - height_ / 2 + 7.5);
    text(data.get(i), x + width_ / 2, height - height_ - 7.5);
  }
}