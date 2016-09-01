//
//  MineFieldView.h
//  minestimed
//
//  Created by Eugenijus Margalikas on 21.01.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#ifndef TEST
#define TEST
#endif

#import <Cocoa/Cocoa.h>
#include "field.h"


#define TILE_HEIGHT 18
#define TILE_WIDTH  18
#define TILE_V_SPACE  1
#define TILE_H_SPACE  1
#define TILE_X_IN_RECT(RECT) (((RECT).origin.x-1)/(TILE_WIDTH+TILE_H_SPACE))
#define TILE_Y_IN_RECT(RECT) (((RECT).origin.y-1)/(TILE_HEIGHT+TILE_V_SPACE))
#define TILE_X_AT_POINT(POINT) ((int)((POINT).x-1)/(int)(TILE_WIDTH+TILE_H_SPACE))
#define TILE_Y_AT_POINT(POINT) ((int)((POINT).y-1)/(int)(TILE_HEIGHT+TILE_V_SPACE))
#define RECT_FOR_TILE(X,Y)   NSMakeRect(\
((X)*(TILE_WIDTH+1)+1),\
((Y)*(TILE_HEIGHT+1)+1),\
TILE_WIDTH,\
TILE_HEIGHT)

#define VIEW_WIDTH(X_TILES)  (((TILE_WIDTH +TILE_H_SPACE)*(X_TILES))+TILE_H_SPACE)
#define VIEW_HEIGHT(Y_TILES) (((TILE_HEIGHT+TILE_V_SPACE)*(Y_TILES))+TILE_V_SPACE)

#define TILES_IN_RECT_V(RECT)   (((RECT).size.height-TILE_V_SPACE)/(TILE_HEIGHT+TILE_V_SPACE))
#define TILES_IN_RECT_H(RECT)   (((RECT).size.width -TILE_H_SPACE)/(TILE_WIDTH +TILE_H_SPACE))

#define VIEW_SIZE(X_TILES,Y_TILES) NSMakeSize(VIEW_WIDTH(X_TILES),VIEW_HEIGHT(Y_TILES))



@interface MineFieldView : NSView{
    
    NSImage *flagAndMine;
    //NSMutableParagraphStyle *paragraphStyle;
    NSDictionary *attributesForValue[9];
    NSPoint point;
    NSEventType button;
    id target;
    SEL action;
    
}

-(SEL)action;
-(id)target;
-(void)setAction:(SEL)newAction;
-(void)setTarget:(id)newTarget;
-(void)setPoint:(NSPoint)newPoint withButton:(NSEventType)newButton;
-(NSPoint)point;
-(NSEventType)button;

@end
