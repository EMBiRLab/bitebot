#include <Servo.h>
#include "HX711.h"

// ---------------- PINS ----------------
#define SERVO_PIN 9
#define LOADCELL_DOUT_PIN 3
#define LOADCELL_SCK_PIN  2

// ---------------- OBJECTS ----------------
Servo lever;
HX711 scale;

// ---------------- PARAMETERS ----------------
float calibration_factor = -7050; // <-- your calibration

// Tune these for your latch/release geometry
const int LATCH_ANGLE   = 0;    // holding position
const int RELEASE_ANGLE = 90;   // release position

// Data capture settings
const int  N_SAMPLES = 150;     // how many readings to stream
const int  Ts_ms     = 50;      // 50ms = 20 Hz (HX711-friendly)
const int  SETTLE_ms = 300;     // wait after release before reading

void setup() {
  Serial.begin(115200);

  // Servo
  lever.attach(SERVO_PIN);
  lever.write(LATCH_ANGLE);

  // HX711
  scale.begin(LOADCELL_DOUT_PIN, LOADCELL_SCK_PIN);
  scale.set_scale(calibration_factor);
  scale.tare();

  Serial.println("READY");
}

void runTrial() {
  // 1) release lever
  lever.write(RELEASE_ANGLE);
  delay(SETTLE_ms);

  // 2) stream readings
  Serial.println("DATA_BEGIN");
  for (int i = 0; i < N_SAMPLES; i++) {
    // Ensure HX711 has a sample; if not, wait briefly
    unsigned long t0 = millis();
    while (!scale.is_ready() && (millis() - t0 < 200)) {
      delay(1);
    }

    if (scale.is_ready()) {
      float val = scale.get_units(1);
      Serial.println(val);
    } else {
      Serial.println("NaN");
    }

    delay(Ts_ms);
  }
  Serial.println("DATA_END");
}

void loop() {
  // Start trial when MATLAB sends 'S'
  if (Serial.available()) {
    char cmd = Serial.read();
    if (cmd == 'S') {
      runTrial();
    }
  }
}
