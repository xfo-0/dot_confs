// Copyright 2022 xfo-0 (@xfo-0)
// SPDX-License-Identifier: GPL-2.0-or-later

#pragma once

#include "config_common.h"

/*
 * Feature disable options
 *  These options are also useful to firmware size reduction.
 */

/* disable debug print */
// #define NO_DEBUG

/* disable print */
// #define NO_PRINT

#define DEBOUNCE 5

#define IGNORE_MOD_TAP_INTERRUPT
#define HOLD_ON_OTHER_KEY_PRESS

#define DYNAMIC_KEYMAP_LAYER_COUNT 4

/* key matrix size */
#define MATRIX_ROWS 8
#define MATRIX_COLS 6

#define DIODE_DIRECTION COL2ROW

#define MATRIX_ROW_PINS \
    { D0, E6, B4, B5 }
#define MATRIX_COL_PINS \
    { B6, B2, B3, B1, F7, F6 }

#define EE_HANDS
#define USE_SERIAL
#define SOFT_SERIAL_PIN D1
#define SELECT_SOFT_SERIAL_SPEED 1
