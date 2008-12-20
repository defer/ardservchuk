#include "nunchuk.h"
#include "cservo.h"


void setup () {
	Serial.begin (9600);
	nunchuk_init ();
	cservo_init (10,11);
	cservo_off ();
}


void loop () {
	if (nunchuk_get_data()) {
		if (nunchuk_button_z) {
			int joy_x = nunchuk_joy_x;
			int joy_y = nunchuk_joy_y;
			if (joy_y > 215) {
				cservo_forward(1);
			}
			else if (joy_y < 40) {
				cservo_backward(1);
			}
			else if (joy_x > 215) {
				cservo_right (1);
			}
			else if (joy_x < 40) {
				cservo_left (1);
			}
		}
		else {
			if (nunchuk_accel_x < 400)  {
				cservo_left (1);
			}
			if (nunchuk_accel_x > 600)  {
				cservo_right (1);
			}
			if (nunchuk_accel_y > 600) {
				cservo_forward (1);
			}
			if (nunchuk_accel_y < 400) {
				cservo_backward (1);
			}
/*			Serial.print(nunchuk_accel_x);
			Serial.print(" ");
			Serial.print(nunchuk_accel_y);
			Serial.print(" ");
			Serial.print(nunchuk_accel_z);
			Serial.println();*/
		}
	}
	cservo_off ();
	delay (20);
}
