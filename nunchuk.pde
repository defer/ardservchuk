// inspired in http://www.windmeadow.com/node/42
#include "nunchuk.h"
#include <Wire.h>

extern unsigned char nunchuk_data[6];
extern unsigned char nunchuk_cnt;

//data
extern unsigned char nunchuk_joy_x;
extern unsigned char nunchuk_joy_y;
extern int nunchuk_accel_x;
extern int nunchuk_accel_y;
extern int nunchuk_accel_z;
extern char nunchuk_button_c;
extern char nunchuk_button_z;

char nunchuk_decode (char x) {
	return (x^0x17) + 0x17;
}

void nunchuk_send_zero () {
	Wire.beginTransmission (0x52);
	Wire.send(0x00);
	Wire.endTransmission ();
}

void nunchuk_init () {
	Wire.begin();
	Wire.beginTransmission (0x52);
	Wire.send (0x40);
	Wire.send (0x00);
	Wire.endTransmission ();
}

void nunchuk_normalize () {
	nunchuk_joy_x = nunchuk_data[0];
	nunchuk_joy_y = nunchuk_data[1];
	nunchuk_accel_x = nunchuk_data[2] << 2;
	nunchuk_accel_y = nunchuk_data[3] << 2;
	nunchuk_accel_z = nunchuk_data[4] << 2;
	nunchuk_button_z = (nunchuk_data[5] >> 0)&1;
	nunchuk_button_c = (nunchuk_data[5] >> 1)&1;

	if ((nunchuk_data[5]>>2)&1) {
		nunchuk_accel_x += 2;
	}
	if ((nunchuk_data[5]>>3)&1) {
		nunchuk_accel_x += 1;
	}
	if ((nunchuk_data[5]>>4)&1) {
		nunchuk_accel_y += 2;
	}
	if ((nunchuk_data[5]>>5)&1) {
		nunchuk_accel_y += 1;
	}
	if ((nunchuk_data[5]>>6)&1) {
		nunchuk_accel_z += 2;
	}
	if ((nunchuk_data[5]>>7)&1) {
		nunchuk_accel_z += 1;
	}
}

bool nunchuk_get_data () {
	bool result = false;
	Wire.requestFrom (0x52, 6);
	while (Wire.available()) {
		nunchuk_data[nunchuk_cnt++] = nunchuk_decode (Wire.receive());
	}
	if (nunchuk_cnt >= 5) {
		result = true;
		nunchuk_cnt = 0;
		nunchuk_normalize ();
	}
	nunchuk_send_zero();
	return result;
}

