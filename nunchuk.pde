/*
Copyright 2008 Diogo Ferreira <diogo@underdev.org>
Copyright 2007 Chad Phillips <chad@chadphillips.org>

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:

1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
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

