#include "ergodox.h"
#include "debug.h"
#include "action_layer.h"
#include "version.h"
#include "keymap_french.h"

#define BASE 0 // default layer
#define SYMB 1 // symbols
#define QWER 2 // symbols
#define QWSY 3 // symbols

enum custom_keycodes {
  PLACEHOLDER = SAFE_RANGE, // can always be here
  EPRM,
  VRSN,
  RGB_SLD
};

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
/* Keymap 0: Basic layer
 *
 * ,--------------------------------------------------.           ,--------------------------------------------------.
 * |   ^    |   &  |   é  |   "  |   '  |   (  | LEFT |           | RIGHT|   -  |   è  |   _  |   ç  |   à  |   )    |
 * |--------+------+------+------+------+-------------|           |------+------+------+------+------+------+--------|
 * | Del    |   A  |   Z  |   E  |   R  |   T  |  L1  |           |  L1  |   Y  |   U  |   I  |   O  |   P  |   =    |
 * |--------+------+------+------+------+------|      |           |      |------+------+------+------+------+--------|
 * | ESC    |   Q  |   S  |   D  |   F  |   G  |------|           |------|   H  |   J  |   K  |   L  |   M  |   ù    |
 * |--------+------+------+------+------+------| Hyper|           | Meh  |------+------+------+------+------+--------|
 * | LShift |   Z  |   X  |   C  |   V  |   B  |      |           |      |   N  |   ,  |   ;  |   :  |   !  | RShift |
 * `--------+------+------+------+------+-------------'           `-------------+------+------+------+------+--------'
 *   | ~L1  |   <  |  Alt | Ctrl | LGui |                                       |  RGui| RCtrl|  Alt |   $  | ~L1  |
 *   `----------------------------------'                                       `----------------------------------'
 *                                        ,-------------.       ,-------------.
 *                                        | App  | Home |       | PgUp | PrScrn |
 *                                 ,------|------|------|       |------+--------+------.
 *                                 |      |      | End  |       | PgDn |        |      |
 *                                 | Space|  Tab |------|       |------| BkSpce |Enter |
 *                                 |      |      | AltGr|       | AltGr|        |      |
 *                                 `--------------------'       `----------------------'
 */
// If it accepts an argument (i.e, is a function), it doesn't need KC_.
// Otherwise, it needs KC_*
[BASE] = KEYMAP(  // layer 0 : default
        // left hand
        FR_CIRC,  FR_AMP,  FR_EACU, FR_QUOT, FR_APOS, FR_LPRN, KC_LEFT,
        KC_DELT, FR_A,    FR_Z,    KC_E,     KC_R,    KC_T,    TG(QWER),
        KC_ESC,  FR_Q,    KC_S,    KC_D,     KC_F,    KC_G,
        KC_LSFT, FR_W,    KC_X,    KC_C,     KC_V,    KC_B,    TG(SYMB),
        KC_FN1,  FR_LESS, KC_LALT, KC_LCTRL, KC_LGUI,
                                                      KC_APP,  KC_HOME,
                                                               KC_END,
                                             KC_SPC,  KC_TAB,  KC_RALT,
        // right hand
             KC_RGHT,      FR_MINS, FR_EGRV, FR_UNDS,  FR_CCED, FR_AGRV,   FR_RPRN,
             TG(QWER),     KC_Y,    KC_U,    KC_I,     KC_O,    KC_P,      FR_EQL,
                           KC_H,    KC_J,    KC_K,     KC_L,    FR_M,      FR_UGRV,
             TG(SYMB), KC_N,    FR_COMM, FR_SCLN,  FR_COLN, FR_EXLM,   KC_RSFT,
                                    KC_RGUI, KC_RCTRL, KC_LALT, FR_DLR,    KC_FN1,
             KC_PGUP, KC_PSCREEN,
             KC_PGDN,
             KC_RALT, KC_BSPC, KC_ENT
    ),
/* Keymap 1: Symbol Layer
 *
 * ,---------------------------------------------------.           ,--------------------------------------------------.
 * |Version  |  F1  |  F2  |  F3  |  F4  |  F5  |      |           |      |  F6  |  F7  |  F8  |  F9  |  F10 |   F11  |
 * |---------+------+------+------+------+------+------|           |------+------+------+------+------+------+--------|
 * |         |   !  |   @  |   {  |   }  |   |  |      |           |      |   =  |   7  |   8  |   9  |   *  |   F12  |
 * |---------+------+------+------+------+------|      |           |      |------+------+------+------+------+--------|
 * |         |   #  |   $  |   (  |   )  |   `  |------|           |------|   0  |   4  |   5  |   6  |   +  |        |
 * |---------+------+------+------+------+------|      |           |      |------+------+------+------+------+--------|
 * |         |   %  |   ^  |   [  |   ]  |   ~  |      |           |      |   .  |   1  |   2  |   3  |   \  |        |
 * `---------+------+------+------+------+-------------'           `-------------+------+------+------+------+--------'
 *   |       |      |      |      |      |                                       |      |      |      |      |      |
 *   `-----------------------------------'                                       `----------------------------------'
 *                                        ,-------------.       ,-------------.
 *                                        |      |      |       |      |      |
 *                                 ,------|------|------|       |------+------+------.
 *                                 |      |      |      |       |      |      |      |
 *                                 |      |      |------|       |------|      |      |
 *                                 |      |      |      |       |      |      |      |
 *                                 `--------------------'       `--------------------'
 */
// SYMBOLS
[SYMB] = KEYMAP(
       // left hand
       VRSN,    KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,   KC_TRNS,
       KC_TRNS, FR_EXLM, FR_AT,   FR_LCBR, FR_RCBR, FR_PIPE, KC_TRNS,
       KC_TRNS, FR_HASH, FR_DLR,  FR_LPRN, FR_RPRN, FR_GRV,
       KC_TRNS, FR_PERC, FR_CIRC, FR_LBRC, FR_RBRC, FR_TILD, KC_TRNS,
       KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,
                                                    KC_TRNS, KC_TRNS,
                                                             KC_TRNS,
                                           KC_TRNS, KC_TRNS, KC_TRNS,
       // right hand
       KC_TRNS, KC_F6,   KC_F7,  KC_F8,   KC_F9,   KC_F10,  KC_F11,
       KC_TRNS, FR_EQL,  FR_7,   FR_8,    FR_9,    FR_ASTR, KC_F12,
                FR_0,    FR_4,   FR_5,    FR_6,    FR_PLUS, KC_TRNS,
       KC_TRNS, FR_DOT,  FR_1,   FR_2,    FR_3,    FR_BSLS, KC_TRNS,
                         KC_TRNS,KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,
       KC_TRNS, KC_TRNS,
       KC_TRNS,
       KC_TRNS, KC_TRNS, KC_TRNS
),
[QWER] = KEYMAP(  // layer 1 : default
        // left hand
        KC_EQL,  KC_1,   KC_HASH,  KC_QUOT,  LSFT(KC_QUOT), KC_LPRN, KC_LEFT,
        KC_DELT, KC_A,    KC_Z,    KC_E,     KC_R,    KC_T,    TG(QWER),
        KC_ESC,  KC_Q,    KC_S,    KC_D,     KC_F,    KC_G,
        KC_LSFT, KC_W,    KC_X,    KC_C,     KC_V,    KC_B,    TG(QWSY),
        KC_FN3,  KC_NUBS, KC_LALT, KC_LCTRL, KC_LGUI,
                                                      KC_APP,  KC_HOME,
                                                               KC_END,
                                             KC_SPC,  KC_TAB,  KC_RALT,
        // right hand
             KC_RGHT,      KC_MINS, KC_GRV, KC_UNDS,  KC_CIRC, KC_AT,   KC_RPRN,
             TG(QWER),     KC_Y,    KC_U,    KC_I,     KC_O,    KC_P,      KC_EQL,
                           KC_H,    KC_J,    KC_K,     KC_L,    KC_M,      KC_PERC,
             TG(QWSY), KC_N,    KC_COMM, KC_SCLN,  KC_COLN, KC_EXLM,   KC_RSFT,
                                    KC_RGUI, KC_RCTRL, KC_LALT, KC_DLR,    KC_FN3,
             KC_PGUP, KC_PSCREEN,
             KC_PGDN,
             KC_RALT, KC_BSPC, KC_ENT
),
[QWSY] = KEYMAP(
       // left hand
       VRSN,    KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,   KC_TRNS,
       KC_TRNS, KC_EXLM, KC_AT,   KC_LCBR, KC_RCBR, KC_PIPE, KC_TRNS,
       KC_TRNS, KC_HASH, KC_DLR,  KC_LPRN, KC_RPRN, KC_GRV,
       KC_TRNS, KC_PERC, KC_CIRC, KC_LBRC, KC_RBRC, KC_TILD, KC_TRNS,
       KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,
                                                    RGB_MOD, KC_TRNS,
                                                             KC_TRNS,
                                           RGB_VAD, RGB_VAI, KC_TRNS,
       // right hand
       KC_TRNS, KC_F6,   KC_F7,  KC_F8,   KC_F9,   KC_F10,  KC_F11,
       KC_TRNS, KC_EQL,  KC_7,   KC_8,    KC_9,    KC_ASTR, KC_F12,
                KC_0,    KC_4,   KC_5,    KC_6,    KC_PLUS, KC_TRNS,
       KC_TRNS, KC_DOT,  KC_1,   KC_2,    KC_3,    KC_BSLS, KC_TRNS,
                         KC_TRNS,KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,
       RGB_TOG, RGB_SLD,
       KC_TRNS,
       KC_TRNS, RGB_HUD, RGB_HUI
),
};

const uint16_t PROGMEM fn_actions[] = {
    [1] = ACTION_LAYER_TAP_TOGGLE(SYMB),                // FN1 - Momentary Layer 1 (Symbols)
    [3] = ACTION_LAYER_TAP_TOGGLE(QWSY)                // FN1 - Momentary Layer 1 (Symbols)
};

const macro_t *action_get_macro(keyrecord_t *record, uint8_t id, uint8_t opt)
{
  // MACRODOWN only works in this function
      switch(id) {
        case 0:
        if (record->event.pressed) {
          SEND_STRING (QMK_KEYBOARD "/" QMK_KEYMAP " @ " QMK_VERSION);
        }
        break;
        case 1:
        if (record->event.pressed) { // For resetting EEPROM
          eeconfig_init();
        }
        break;
      }
    return MACRO_NONE;
};

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  switch (keycode) {
    // dynamically generate these.
    case EPRM:
      if (record->event.pressed) {
        eeconfig_init();
      }
      return false;
      break;
    case VRSN:
      if (record->event.pressed) {
        SEND_STRING (QMK_KEYBOARD "/" QMK_KEYMAP " @ " QMK_VERSION);
      }
      return false;
      break;
    case RGB_SLD:
      if (record->event.pressed) {
        #ifdef RGBLIGHT_ENABLE
          rgblight_mode(1);
        #endif
      }
      return false;
      break;
  }
  return true;
}

// Runs just one time when the keyboard initializes.
void matrix_init_user(void) {

};


// Runs constantly in the background, in a loop.
void matrix_scan_user(void) {

    uint8_t layer = biton32(layer_state);

    ergodox_board_led_off();
    ergodox_right_led_1_off();
    ergodox_right_led_2_off();
    ergodox_right_led_3_off();
    switch (layer) {
      // TODO: Make this relevant to the ErgoDox EZ.
        case 1:
            ergodox_right_led_1_on();
            break;
        case 2:
            ergodox_right_led_2_on();
            break;
        case 3:
            ergodox_right_led_3_on();
            break;
        default:
            // none
            break;
    }

};
