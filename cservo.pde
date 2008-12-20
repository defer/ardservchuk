/*
Copyright 2008 Diogo Ferreira <diogo@underdev.org>
Copyright 2008 TigPT <http://www.lusorobotica.com> 

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

//
//Based on the code from smalluino by TigPT (http://lusorobotica.com)
//
unsigned char cservo_pin1, cservo_pin2;
void cservo_init (int pin1, int pin2) {
	cservo_pin1 = pin1;
	cservo_pin2 = pin2;
}
void cservo_off () {
	analogWrite (cservo_pin1, 0);
	analogWrite (cservo_pin2, 0);
}

void cservo_backward (int units) {
	for (int i = 0; i < units; i++) {
		analogWrite (cservo_pin1, 127);
		analogWrite (cservo_pin2, 250);
		delay (20);
	}
}

void cservo_forward (int units) {
	for (int i = 0; i < units; i++) {
		analogWrite (cservo_pin1, 250);
		analogWrite (cservo_pin2, 127);
		delay (20);
	}

}

void cservo_left (int units) {
	for (int i = 0; i < units; i++) {
		analogWrite (cservo_pin1, 250);
		analogWrite (cservo_pin2, 250);
		delay (20);
	}
}
void cservo_right (int units) {
	for (int i = 0; i < units; i++) {
		analogWrite (cservo_pin1, 127);
		analogWrite (cservo_pin2, 127);
		delay (20);
	}
}
