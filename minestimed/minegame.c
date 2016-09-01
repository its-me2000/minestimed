//
//  minegame.c
//  minesweeper1
//
//  Created by Eugenijus Margalikas on 25.10.12.
//  Copyright (c) 2012 NASA. All rights reserved.
//

#include <stdio.h>
//#include <time.h>
#include "minegame.h"
//#include "field.h"

int click(unsigned int height, unsigned int width, mouse_button mb){
    
    //extern unsigned int field_height;
    //extern unsigned int field_width;
    
    int return_value=0;
    
    if (height>=game_state.field_height || width>=game_state.field_width) return 0;
    if(mb){
        switch (get_tile_status(height, width)) {
            case CLOSED:
            case UNMARKED:
                switch (mark_tile(height, width, OPEN).value) {
                    case EMPTY:
                        --game_state.tiles_opened_countdown;
                        return_value=1+
                        click(height-1, width-1, mb)+
                        click(height-1, width, mb)+
                        click(height-1, width+1, mb)+
                        click(height, width-1, mb)+
                        click(height, width+1, mb)+
                        click(height+1, width-1, mb)+
                        click(height+1, width, mb)+
                        click(height+1, width+1, mb);//tut obrabotka
                        break;
                    case MINE:
                        //finnish_game(LOST);   // tut obrabotka
                        game_state.result=LOST;
                        game_state.status=STOP;
                        return_value=-1;
                        break;
                    case ONE:
                    case TWO:
                    case THREE:
                    case FOUR:
                    case FIVE:
                    case SIX:
                    case SEVEN:
                    case EIGHT:
                    default: // 1 2 3 4 5 6 7 8
                        --game_state.tiles_opened_countdown;
                        return_value=1;
                        break;
                }
                if(!game_state.tiles_opened_countdown) //finnish_game(WIN);
                return_value=-1;
                break;
                
            default:    // OPEN, MARKED
                break;
        }
    }else{
        
        switch (get_tile_status(height, width)) {
            case CLOSED:
                mark_tile(height, width, MARKED);
                return_value=1;
                break;
            case MARKED:
                mark_tile(height, width, UNMARKED);
                return_value=1;
                break;
            case UNMARKED:
                mark_tile(height, width, CLOSED);
                return_value=1;
                break;
            default:    // OPEN
                break;
        }
        
    }
    
    return return_value; // -1 game finished, 0 unchanged, >0 opened
}

int new_game(unsigned int height, unsigned int width , unsigned int mines){
    

    
    if(create_field(height,width,mines)==1) return 1;
    

    
    fill_field();
    
    close_field();
    
    game_state.field_height=height;
    game_state.field_width=width;
    game_state.mines_count=mines;
    //game_state.mines_countdown=mines;
    
    game_state.tiles_opened_countdown=game_state.field_height*game_state.field_width-game_state.mines_count; //tiles to go
    
    game_state.status=PAUSE;
    
    return 0;
    

}

int start_game(void){
    game_state.status=RUNNING;
    game_state.start_time=time(NULL);
    return 0;
}

/*
int finnish_game(game_status result){
    status=result;
    return 0;
}

int pause_game(void){
    status=PAUSE;
    return 0;
}
*/

tile simple_click(unsigned int height, unsigned int width, mouse_button mb){
    
    switch (get_tile_status(height, width)) {
        case CLOSED:
            mark_tile(height, width, mb==LCLICK?OPEN:MARKED);
            break;
        case UNMARKED:
            mark_tile(height, width, mb==LCLICK?OPEN:CLOSED);
            break;
        case OPEN:
            //ne meniaetsia
            break;
        case MARKED:
            mark_tile(height, width, mb==LCLICK?MARKED:UNMARKED);
            break;
            
        default:
            break;
    }
    return get_tile(height, width);
    
}


