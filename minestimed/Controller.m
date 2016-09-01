//
//  Controller.m
//  minestimed
//
//  Created by Eugenijus Margalikas on 20.01.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "Controller.h"

#define ALL_OPENED openedTiles==((fieldWidth*fieldHeight)-mines)

extern struct _game_state game_state;

@implementation Controller

@synthesize fieldWidth,fieldHeight,openedTiles,mines;
@synthesize minesMarked;
@synthesize startTime,endTime;
@synthesize gameStatus;


@synthesize view;
@synthesize window;
@synthesize custom,scores;

@synthesize scoresController;

@synthesize customTable;
@synthesize button;
@synthesize textFieldTime,textFieldMines;
@synthesize customWidth, customHeight, customMines;
@synthesize customWidthSlider, customHeightSlider, customMinesSlider;

-(id)init{
    return self=[super init];
}

-(void)awakeFromNib{
    
    //tut schitat' dannye iz faila
    //ili sgenerirovat' po umolcianiju
    [self loadGamePropertiesFromFile];

    // [self startGame];
    
}



-(IBAction)openScores:(id)sender{
    [NSApp beginSheet:scores modalForWindow:window modalDelegate:nil didEndSelector:nil contextInfo:NULL];

}

-(IBAction)closeScores:(id)sender{
    [NSApp endSheet:scores];
    [scores close];
}

-(IBAction)clickCustomize:(id)sender{
    [NSApp beginSheet:custom modalForWindow:window modalDelegate:nil didEndSelector:nil contextInfo:NULL];
    //[customWidth setIntValue:fieldWidth];
    //[customHeight setIntValue:fieldHeight];
    //[customMines setIntValue:mines];
    
    [customWidthSlider setIntValue:fieldWidth];
    [customHeightSlider setIntValue:fieldHeight];
    [customMinesSlider setIntValue:mines];
    [customWidth setIntegerValue:[customWidthSlider integerValue]];
    [customHeight setIntegerValue:[customHeightSlider integerValue]];
    [customMines setIntegerValue:[customMinesSlider integerValue]];
    
   

}

-(IBAction)customButtonClick:(id)sender{
#ifdef TEST
    NSLog(@"customButtonClick\n");
#endif    
    [NSApp endSheet:custom];

#ifdef TEST
     NSLog(@"%d, %d, %d \n",[customWidth intValue], [customHeight intValue], [customMines intValue]);
#endif
    
    fieldWidth=[customWidth intValue];
    fieldHeight=[customHeight intValue];
    mines=[customMines intValue];
    minesMarked     =   0;
    openedTiles     =   0;
    [startTime release];
    startTime=nil;
    [endTime release];
    endTime=nil;
    gameStatus=UNDEFINED;
    [self startGame];
    
    
    [custom close];
}

-(IBAction)customEdited:(id)sender{
#ifdef TEST
    NSLog(@"customEdited\n");
#endif

    [customWidth takeIntegerValueFrom:customWidthSlider];
    [customHeight takeIntegerValueFrom:customHeightSlider];
    [customMinesSlider setMaxValue:([customWidthSlider intValue]*[customHeightSlider intValue])-1];
    if ([customMinesSlider intValue]>[customMinesSlider maxValue]) {
        [customMinesSlider setDoubleValue:[customMinesSlider maxValue]];
    }
    [customMines takeIntegerValueFrom:customMinesSlider];
    
    
}

-(IBAction)easyMenu:(id)sender{
    if(gameStatus==RUNNING) [self stopTimer];
    fieldWidth      =   10;
    fieldHeight     =   10;
    mines           =   10;
    minesMarked     =   0;
    openedTiles     =   0;
    [startTime release];
    startTime=nil;
    [endTime release];
    endTime=nil;
    gameStatus=UNDEFINED;
    [self startGame];

}

-(IBAction)mediumMenu:(id)sender{
    if(gameStatus==RUNNING) [self stopTimer];
    fieldWidth      =   16;
    fieldHeight     =   16;
    mines           =   40;
    minesMarked     =   0;
    openedTiles     =   0;
    [startTime release];
    startTime=nil;
    [endTime release];
    endTime=nil;
    gameStatus=UNDEFINED;
    [self startGame];
}

-(IBAction)hardMenu:(id)sender{
    if(gameStatus==RUNNING) [self stopTimer];
    fieldWidth      =   30;
    fieldHeight     =   16;
    mines           =   100;
    minesMarked     =   0;
    openedTiles     =   0;
    [startTime release];
    startTime=nil;
    [endTime release];
    endTime=nil;
    gameStatus=UNDEFINED;
    [self startGame];
}

-(void)loadGamePropertiesFromFile{
    
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSString *plistPath;
    NSData *plistData;
    NSDictionary *plist;
    NSDictionary *gameProperties;
    
   // plistPath   = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
    plistPath= [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                     NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"Data.plist"];
#ifdef TEST
    NSLog(@"%@",[plistPath description]);
#endif
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]){
    
        fieldWidth      =   10;
        fieldHeight     =   10;
        mines           =   10;
       /*
        [scoresController setDictionary:[NSMutableDictionary dictionaryWithContentsOfFile:
            [[NSSearchPathForDirectoriesInDomains
              (NSDocumentDirectory,
               NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"scores.plist"]]];
        */
    
    }else{
        plistData   = [[NSFileManager defaultManager] contentsAtPath:plistPath];
        plist       = (NSDictionary *)[NSPropertyListSerialization
                       propertyListFromData:plistData
                       mutabilityOption:NSPropertyListMutableContainersAndLeaves
                       format:&format
                       errorDescription:&errorDesc];
        gameProperties=(NSDictionary*)[plist objectForKey:@"gameProperties"];
        fieldWidth  = [(NSNumber*)[gameProperties objectForKey:@"fieldWidth"] unsignedIntValue];
        fieldHeight = [(NSNumber*)[gameProperties objectForKey:@"fieldHeight"] unsignedIntValue];
        mines       = [(NSNumber*)[gameProperties objectForKey:@"mines"] unsignedIntValue];
        
        /*[scoresController setDictionary:[NSMutableDictionary dictionaryWithContentsOfFile:
                                         [[NSSearchPathForDirectoriesInDomains
                                           (NSDocumentDirectory,
                                            NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"scores.plist"]]];
         */
        /*
        plistPath=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                        NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"scores.plist"];
        plistData=[[NSFileManager defaultManager] contentsAtPath:plistPath];
        */
        [scoresController setDictionary:(NSMutableDictionary *) [plist objectForKey:@"gameScores"]];
        
        //[scoresController setDictionary:(NSMutableDictionary*)[plist objectForKey:@"gameScores"]];
    }
    minesMarked     =   0;
    openedTiles     =   0;
    [startTime release];
    startTime=nil;
    [endTime release];
    endTime=nil;
    gameStatus=UNDEFINED;
    
    
}

-(void)storeGamePropertiesToFile{
#ifdef TEST
    NSLog(@"load \n");
#endif
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSString *plistPath;
    NSData *plistData;
    NSMutableDictionary *plist;
    NSDictionary *gameProperties;
    plistPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                     NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"Data.plist"];
    // = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:plistPath]){
        plistData   = [[NSFileManager defaultManager] contentsAtPath:plistPath];
        plist       = (NSMutableDictionary *)[NSPropertyListSerialization
                                       propertyListFromData:plistData
                                       mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                       format:&format
                                       errorDescription:&errorDesc];
        
    }else{
        plist=[NSMutableDictionary dictionary];
    }
    gameProperties = [NSDictionary dictionaryWithObjects:
                      [NSArray arrayWithObjects:
                       [NSNumber numberWithUnsignedInt:fieldWidth],
                       [NSNumber numberWithUnsignedInt:fieldHeight],
                       [NSNumber numberWithUnsignedInt:mines], nil] 
                                                 forKeys:
                      [NSArray arrayWithObjects:
                       @"fieldWidth",
                       @"fieldHeight",
                       @"mines", nil]];
    [plist setObject:gameProperties forKey:@"gameProperties"];
    [plist setObject:[scoresController dictionary] forKey:@"gameScores"];
    [plist writeToFile:plistPath atomically:YES];
#ifdef TEST
    NSLog(@"%@",plistPath);
#endif
}

-(void)startGame{
#ifdef TEST
    NSLog(@"startGame\n");
#endif
    destroy_field();
    create_field(fieldHeight, fieldWidth, mines);
    fill_field();
    close_field();
    openedTiles=0;
    minesMarked=0;
    [self setWindowAndViewSize];
    [textFieldMines setIntValue:(mines-minesMarked)];
    [textFieldTime setDoubleValue:0];
    gameStatus=READY;
    
}

-(void)startTimer{
#ifdef TEST
    NSLog(@"startTimer\n");
#endif
    if (startTime!=nil) {
        [startTime release];
    }
    startTime=[NSDate date];
    [startTime retain];
    timer=[NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(updateTextFieldTime) userInfo:nil repeats:YES];
}
-(void)stopTimer{
#ifdef TEST
    NSLog(@"stopTimer\n");
#endif
    NSTimeInterval timerResult;
    if(endTime!=nil) timerResult=0-[startTime timeIntervalSinceDate:endTime];
    else timerResult=0-[startTime timeIntervalSinceNow];
    if(timerResult<1) [textFieldTime setStringValue:@"<1"];
    else [textFieldTime setDoubleValue:timerResult];
    //[textFieldTime setDoubleValue:timerResult];
    [timer invalidate];
    //[timer release];
}

-(void)updateTextFieldTime{
    
    [textFieldTime setDoubleValue:0-[startTime timeIntervalSinceNow]];
}

-(IBAction)buttonClick:(id)sender{
#ifdef TEST
    NSLog(@"buttonClick\n");
#endif
    if(gameStatus==RUNNING) [self stopTimer];
    [self startGame];
    [view setNeedsDisplay:YES];
}

-(void)setWindowAndViewSize{
#ifdef TEST
    NSLog(@"setWindow and view Size\n");
#endif
    
    if ([[view trackingAreas] count]!=0) {
        [view removeTrackingArea:[[view trackingAreas] objectAtIndex:0]];
    }
    
    NSRect windowRect=[window frame];
    windowRect.size=WINDOW_SIZE(fieldWidth, fieldHeight);
    [window setFrame:windowRect display:YES];
    [view setFrameSize:VIEW_SIZE(fieldWidth, fieldHeight)];
    
    [view addTrackingArea:[[NSTrackingArea alloc] initWithRect:[view bounds] options: NSTrackingMouseEnteredAndExited|NSTrackingActiveAlways owner:view userInfo:nil]];
    
}

-(void)setViewFeedback{

    [view setAction:@selector(click:)];
    [view setTarget:self];

}
-(void)click:(id)sender{
#ifdef TEST
    NSLog(@"click \n");
#endif
    if (gameStatus!=RUNNING && gameStatus!=READY) {
        return;
    }
    
    if (gameStatus==READY) {
        gameStatus=RUNNING;
        //startTime=[NSDate date];
        //[startTime retain];
        [self startTimer];
    }
    
    NSPoint local_point = [view convertPoint:[view point] fromView: nil];
    if ([view button]==NSLeftMouseUp) {
        [self clickOnTileX:TILE_X_AT_POINT(local_point) Y:TILE_Y_AT_POINT(local_point)];
        //[view setNeedsDisplay:[self clickOnTileX:TILE_X_AT_POINT(local_point) Y:TILE_Y_AT_POINT(local_point)]];
    }else{
        [self clickRightOnTileX:TILE_X_AT_POINT(local_point) Y:TILE_Y_AT_POINT(local_point)];
        [textFieldMines setIntValue:(mines-minesMarked)];
    }
    switch (gameStatus) {
        case WIN:
            [self winGame];
        case LOST:
            [self stopTimer];
        default:
            break;
    }
   /* if (gameStatus==WIN || gameStatus==LOST) {
        [self stopTimer];
        [self winGame];
    }*/
    
}
-(BOOL)clickOnTileX:(unsigned int)x Y:(unsigned int)y{
#ifdef TEST
    NSLog(@"clickXY\n");
#endif
    
    if (gameStatus!=RUNNING || x>fieldWidth || y>fieldHeight) return NO;
    switch (get_tile_status(y,x)) {
        case CLOSED:
        case UNMARKED:
            switch (mark_tile(y,x, OPEN).value) {
                case MINE:
                    endTime=[NSDate date];
                    endTime=[endTime retain];
                    gameStatus=LOST;
                    [view setNeedsDisplayInRect:RECT_FOR_TILE(x, y)];

                    return YES;
                case EMPTY:
                    ++openedTiles;
                    if (ALL_OPENED) {
                        gameStatus=WIN;
                    }
                    [self clickOnTileX:x-1 Y:y-1];
                    [self clickOnTileX:x-1 Y:y  ];
                    [self clickOnTileX:x-1 Y:y+1];
                    [self clickOnTileX:x   Y:y-1];
                    [self clickOnTileX:x   Y:y+1];
                    [self clickOnTileX:x+1 Y:y-1];
                    [self clickOnTileX:x+1 Y:y  ];
                    [self clickOnTileX:x+1 Y:y+1];
                    [view setNeedsDisplayInRect:RECT_FOR_TILE(x, y)];
                    return YES;
                default: // 1 2 3 4 5 6 7 8
                    ++openedTiles;
                    if (ALL_OPENED) {
                        endTime=[NSDate date];
                        endTime=[endTime retain];
                        gameStatus=WIN;
                    }
                    [view setNeedsDisplayInRect:RECT_FOR_TILE(x, y)];

                    return YES;
            }
            
            break;
            
        default:    // OPEN, MARKED
            break;
    }
    return NO;    
}
-(BOOL)clickRightOnTileX:(unsigned int)x Y:(unsigned int)y{
    
    switch (get_tile_status(y, x)) {
        case CLOSED:
            mark_tile(y, x, MARKED);
            ++minesMarked;
            [view setNeedsDisplayInRect:RECT_FOR_TILE(x, y)];
            return YES;
        case MARKED:
            mark_tile(y, x, UNMARKED);
            --minesMarked;
            [view setNeedsDisplayInRect:RECT_FOR_TILE(x, y)];
            return YES;
        case UNMARKED:
            mark_tile(y, x, CLOSED);
            [view setNeedsDisplayInRect:RECT_FOR_TILE(x, y)];
            return YES;
        default:    // OPEN
            break;
    }
    return NO;
}

-(void)winGame{
    [scoresController newScoreWithTime:0-[startTime timeIntervalSinceDate:endTime]];
}

@end
