//
//  minegame.h
//  minesweeper1
//
//  Created by Eugenijus Margalikas on 25.10.12.
//  Copyright (c) 2012 NASA. All rights reserved.
//

#ifndef minesweeper1_minegame_h
#define minesweeper1_minegame_h

#include <time.h>
#include "field.h"
typedef enum{
    LCLICK = 1,
    RCLICK = 0  } mouse_button;


/*
typedef enum {
    STOP    = 0,
    RUNNING = 1,
    PAUSE   = 2,
    WIN     = 3,
    LOST    = 4} game_status;
*/
struct _game_state {
    enum {
                STOP=0,
                RUNNING=1,
                PAUSE=2}    status;
    enum {
                LOST=0,
                WIN=1,
                UNDEFINED = 2}      result;
    //int mines_countdown;
    unsigned int tiles_opened_countdown;
    unsigned int field_height;
    unsigned int field_width;
    int mines_count;
    time_t start_time;
} game_state;



int new_game(unsigned int height, unsigned int width , unsigned int mines);
int start_game(void);
//int finnish_game(struct _game_status result);
//int pause_game(void);
int click(unsigned int height, unsigned int width, mouse_button mb);
tile simple_click(unsigned int height, unsigned int width, mouse_button mb);


#endif
