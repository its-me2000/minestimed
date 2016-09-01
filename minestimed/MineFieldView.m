//
//  MineFieldView.m
//  minestimed
//
//  Created by Eugenijus Margalikas on 21.01.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

// 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18
// 0 1 2
//     2 3 4
//         4 5 6



#define FLAG_RECT NSMakeRect(0, 0, 18, 18)
#define MINE_RECT NSMakeRect(18, 0, 18, 18)

#define DRAW_POINT(RECT) NSMakePoint((RECT).origin.x+4,(RECT).origin.y)



#import "MineFieldView.h"




@implementation MineFieldView


- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        flagAndMine=[NSImage imageNamed:@"grid2.png"];
        
        attributesForValue[0]=[NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects:[NSFont fontWithName:@"Courier Bold" size:16.0],[NSColor darkGrayColor] , nil] forKeys:[NSArray arrayWithObjects:NSFontAttributeName,NSForegroundColorAttributeName, nil] ];
        [attributesForValue[0] retain];
        attributesForValue[1]=[NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects:[NSFont fontWithName:@"Courier Bold" size:16.0],[NSColor blueColor] , nil] forKeys:[NSArray arrayWithObjects:NSFontAttributeName,NSForegroundColorAttributeName, nil] ];
        [attributesForValue[1] retain];
        attributesForValue[2]=[NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects:[NSFont fontWithName:@"Courier Bold" size:16.0],[NSColor greenColor] , nil] forKeys:[NSArray arrayWithObjects:NSFontAttributeName,NSForegroundColorAttributeName, nil] ];
        [attributesForValue[2] retain];
        attributesForValue[3]=[NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects:[NSFont fontWithName:@"Courier Bold" size:16.0],[NSColor redColor] , nil] forKeys:[NSArray arrayWithObjects:NSFontAttributeName,NSForegroundColorAttributeName, nil] ];
        [attributesForValue[3] retain];
        attributesForValue[4]=[NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects:[NSFont fontWithName:@"Courier Bold" size:16.0],[NSColor purpleColor] , nil] forKeys:[NSArray arrayWithObjects:NSFontAttributeName,NSForegroundColorAttributeName, nil] ];
        [attributesForValue[4] retain];
        attributesForValue[5]=[NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects:[NSFont fontWithName:@"Courier Bold" size:16.0],[NSColor magentaColor] , nil] forKeys:[NSArray arrayWithObjects:NSFontAttributeName,NSForegroundColorAttributeName, nil] ];
        [attributesForValue[5] retain];
        attributesForValue[6]=[NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects:[NSFont fontWithName:@"Courier Bold" size:16.0],[NSColor cyanColor] , nil] forKeys:[NSArray arrayWithObjects:NSFontAttributeName,NSForegroundColorAttributeName, nil] ];
        [attributesForValue[6] retain];
        attributesForValue[7]=[NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects:[NSFont fontWithName:@"Courier Bold" size:16.0],[NSColor brownColor] , nil] forKeys:[NSArray arrayWithObjects:NSFontAttributeName,NSForegroundColorAttributeName, nil] ];
        [attributesForValue[7] retain];
        attributesForValue[8]=[NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects:[NSFont fontWithName:@"Courier Bold" size:16.0],[NSColor orangeColor] , nil] forKeys:[NSArray arrayWithObjects:NSFontAttributeName,NSForegroundColorAttributeName, nil] ];
        [attributesForValue[8] retain];
    }
    return self;
}

-(SEL)action{return action;};
-(id)target{return target;};
-(void)setAction:(SEL)newAction{
    action=newAction;
}
-(void)setTarget:(id)newTarget{
    target=newTarget;
}
-(void)setPoint:(NSPoint)newPoint withButton:(NSEventType)newButton{
    button=newButton;
    point=newPoint;
}
-(NSPoint)point{return point;}
-(NSEventType)button{return button;}


- (void)drawRect:(NSRect)dirtyRect
{
    
    // Drawing code here.
    
    
        unsigned int i,j;
        [[NSColor darkGrayColor] set];
        [NSBezierPath fillRect:dirtyRect];

        for(i=TILE_X_AT_POINT(dirtyRect.origin);i<TILE_X_AT_POINT(dirtyRect.origin)+TILES_IN_RECT_H(dirtyRect);++i){
            for(j=TILE_Y_AT_POINT(dirtyRect.origin);j<TILE_Y_AT_POINT(dirtyRect.origin)+TILES_IN_RECT_V(dirtyRect);++j){
                    switch (get_tile_status(j, i)) {
                    case CLOSED:
                        [[NSColor lightGrayColor] set];
                        [NSBezierPath fillRect:RECT_FOR_TILE(i, j)];
                        break;
                    case MARKED:
                        [[NSColor lightGrayColor] set];
                        [NSBezierPath fillRect:RECT_FOR_TILE(i, j)];
                        [flagAndMine drawInRect:RECT_FOR_TILE(i, j) fromRect:FLAG_RECT operation:NSCompositeSourceOver fraction:1];
                        break;
                    case UNMARKED:
                        [[NSColor lightGrayColor] set];
                        [NSBezierPath fillRect:RECT_FOR_TILE(i, j)];
                        [@"?" drawAtPoint:DRAW_POINT(RECT_FOR_TILE(i, j)) withAttributes:attributesForValue[0]];
                        break;
                    case OPEN:
                        switch (get_tile_value(j, i)) {
                            case MINE:
                                [[NSColor redColor] set];
                                [NSBezierPath fillRect:RECT_FOR_TILE(i, j)];
                                [flagAndMine drawInRect:RECT_FOR_TILE(i, j) fromRect:MINE_RECT operation:NSCompositeSourceOver fraction:1];
                                break;
                             case EMPTY:
                                [[NSColor grayColor] set];
                                [NSBezierPath fillRect:RECT_FOR_TILE(i, j)];
                                break;
                            case ONE:
                                [[NSColor grayColor] set];
                                [NSBezierPath fillRect:RECT_FOR_TILE(i, j)];
                               [@"1" drawAtPoint:DRAW_POINT(RECT_FOR_TILE(i, j)) withAttributes:attributesForValue[1]];                                break;
                            case TWO:
                                [[NSColor grayColor] set];
                                [NSBezierPath fillRect:RECT_FOR_TILE(i, j)];
                                [@"2" drawAtPoint:DRAW_POINT(RECT_FOR_TILE(i, j)) withAttributes:attributesForValue[2]];
                                break;
                            case THREE:
                                [[NSColor grayColor] set];
                                [NSBezierPath fillRect:RECT_FOR_TILE(i, j)];
                                [@"3" drawAtPoint:DRAW_POINT(RECT_FOR_TILE(i, j)) withAttributes:attributesForValue[3]];
                                break;
                            case FOUR:
                                [[NSColor grayColor] set];
                                [NSBezierPath fillRect:RECT_FOR_TILE(i, j)];
                                [@"4" drawAtPoint:DRAW_POINT(RECT_FOR_TILE(i, j)) withAttributes:attributesForValue[4]];
                                break;
                            case FIVE:
                                [[NSColor grayColor] set];
                                [NSBezierPath fillRect:RECT_FOR_TILE(i, j)];
                                [@"5" drawAtPoint:DRAW_POINT(RECT_FOR_TILE(i, j)) withAttributes:attributesForValue[5]];
                                break;
                            case SIX:
                                [[NSColor grayColor] set];
                                [NSBezierPath fillRect:RECT_FOR_TILE(i, j)];
                                [@"6" drawAtPoint:DRAW_POINT(RECT_FOR_TILE(i, j)) withAttributes:attributesForValue[6]];
                                break;
                            case SEVEN:
                                [[NSColor grayColor] set];
                                [NSBezierPath fillRect:RECT_FOR_TILE(i, j)];
                                [@"7" drawAtPoint:DRAW_POINT(RECT_FOR_TILE(i, j)) withAttributes:attributesForValue[7]];
                                break;
                            case EIGHT:
                                //DRAW_TILE(RECT_FOR_TILE(i, j), @"8", orangeColor, grayColor);
                                
                                [[NSColor grayColor] set];
                                [NSBezierPath fillRect:RECT_FOR_TILE(i, j)];
                                [@"8" drawAtPoint:DRAW_POINT(RECT_FOR_TILE(i, j)) withAttributes:attributesForValue[8]];
                                break;
                            default:
                                break;
                        }
                        break;
                    default:
                        break;
                }
            }
        }    
}

-(void)mouseEntered:(NSEvent *)theEvent{ 
    [[self window] setMovableByWindowBackground:NO];
}

-(void)mouseExited:(NSEvent *)theEvent{ 
     [[self window] setMovableByWindowBackground:YES];
}


-(void)mouseUp:(NSEvent *)theEvent{
    point=[theEvent locationInWindow];
    button=NSLeftMouseUp;
    [NSApp sendAction:[self action] to:[self target] from:self];
}

-(void)rightMouseUp:(NSEvent *)theEvent{
    point=[theEvent locationInWindow];
    button=NSRightMouseUp;
    [NSApp sendAction:[self action] to:[self target] from:self];
}

@end
