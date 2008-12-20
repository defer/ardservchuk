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
