#ifndef _HAS_CSERVO_H
#define _HAS_CSERVO_H

void cservo_init (int pin1, int pin2);
void cservo_off ();
void cservo_forward (int units);
void cservo_backward (int units);
void cservo_left (int units);
void cservo_right (int units);
#endif
