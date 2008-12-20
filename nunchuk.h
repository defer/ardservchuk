#ifndef _HAS_NUNCHUK_H
#define _HAS_NUNCHUK_H

unsigned char nunchuk_data[6];
unsigned char nunchuk_cnt;

unsigned char nunchuk_joy_x;
unsigned char nunchuk_joy_y;
int nunchuk_accel_x;
int nunchuk_accel_y;
int nunchuk_accel_z;
char nunchuk_button_c;
char nunchuk_button_z;


char nunchuk_decode (char x);
void nunchuk_send_zero ();
void nunchuk_init ();
bool nunchuk_get_data ();
void nunchuk_normalize ();


#endif
