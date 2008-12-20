/*
Copyright 2008 Diogo Ferreira <diogo@underdev.org>

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
