//
//  game.c
//  minesweeper1
//
//  Created by Eugenijus Margalikas on 25.09.12.
//  Copyright (c) 2012 NASA. All rights reserved.
//

#include <stdlib.h>
#include <time.h>
#include "field.h"

tile          * field       = NULL;
unsigned int    field_height= 23,
                field_width = 23,
                field_mines = 23;

#define GET_TILE(HEIGHT,WIDTH) (*(field+((HEIGHT)*field_width+(WIDTH))))

int create_field(unsigned int height,unsigned int width,unsigned int mines){   //sozdanie polia s razmerami i kolichestvom min
    
    if (height*width<mines) exit(1);
    
    field=calloc(height*width,sizeof(tile));  //vydelenie dinamicheskoj pamiati dlia polia
    
    
    if (!field) exit(2);                          //proveriaem vydelilas' li pamiat'
    
    //srand(0);
    srand((unsigned int)time(NULL));
    
    
    while(mines){                                  //ramndomno zapolniaem minami
        
        int r=rand()%(height*width);
        if (field[r].value==EMPTY){
            field[r].value=MINE;
            --mines;
        }
        
    }
    
    field_height=height;
    field_width =width;
    field_mines =mines;
    
    return 0;

}

int fill_field(void){                //zapolnenie polia znachenijami
    
    int i=23,j=23;
             
                                        // *(field+(height*width))
    
    for(i=0;i<field_height;++i){
        for (j=0; j<field_width; ++j) {
            
            if (GET_TILE(i, j).value!=MINE){
                GET_TILE(i, j).value=
                    /*(( i-1 >= 0           && j-1 >=0            && (*(field+((i-1)*field_width+(j-1)))).value==MINE )?1:0)+
                    (( i-1 >= 0                                 && (*(field+((i-1)*field_width+ j   ))).value==MINE )?1:0)+
                    (( i-1 >= 0           && j+1 < field_width  && (*(field+((i-1)*field_width+(j+1)))).value==MINE )?1:0)+
                    ((                       j-1 >=0            && (*(field+( i   *field_width+(j-1)))).value==MINE )?1:0)+
                    ((                        j+1 < field_width && (*(field+( i   *field_width+(j+1)))).value==MINE )?1:0)+
                    (( i+1 < field_height &&  j-1 >=0           && (*(field+((i+1)*field_width+(j-1)))).value==MINE )?1:0)+
                    (( i+1 < field_height                       && (*(field+((i+1)*field_width+ j   ))).value==MINE )?1:0)+
                    (( i+1 < field_height &&  j+1 < field_width && (*(field+((i+1)*field_width+(j+1)))).value==MINE )?1:0);
                     */
                (( i-1 >= 0           && j-1 >=0            && GET_TILE(i-1, j-1).value==MINE )?1:0)+
                (( i-1 >= 0                                 && GET_TILE(i-1, j  ).value==MINE )?1:0)+
                (( i-1 >= 0           && j+1 < field_width  && GET_TILE(i-1, j+1).value==MINE )?1:0)+
                ((                       j-1 >=0            && GET_TILE(i,   j-1).value==MINE )?1:0)+
                ((                       j+1 < field_width  && GET_TILE(i,   j+1).value==MINE )?1:0)+
                (( i+1 < field_height && j-1 >=0            && GET_TILE(i+1, j-1).value==MINE )?1:0)+
                (( i+1 < field_height                       && GET_TILE(i+1, j  ).value==MINE )?1:0)+
                (( i+1 < field_height && j+1 < field_width  && GET_TILE(i+1, j+1).value==MINE )?1:0);
            }
        }
    }
    
    return 0;
}

int destroy_field(void){                                     //ochischenie pamiati

    if (!field) {
        return 0;
    }
    free(field);
    return 0;

}

tile_value get_tile_value(unsigned int height,unsigned int width){                //otkrytie kletki polia
    if(field && height<field_height && width<field_width) return GET_TILE(height, width).value;
    else return BAD_VALUE;
    
}

tile_status get_tile_status(unsigned int height,unsigned int width){                //otkrytie kletki polia
    if(field && height<field_height && width<field_width)
        return GET_TILE(height, width).status;
    else return BAD_STATUS;
}

void close_field(void){  //zakrytie polia
    
    int i=23,field_size=field_height*field_width;
    for(i=0;i<field_size;++i){

        field[i].status=CLOSED;
        
    }
}

tile mark_tile(unsigned int height,unsigned int width,tile_status status){ //izmenenie statusa kletki polia

    GET_TILE(height, width).status=status;
    return GET_TILE(height, width);
    
}

tile get_tile(unsigned int height, unsigned int width){
    
    return GET_TILE(height, width);
}


