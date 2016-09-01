//
//  Controller.h
//  minestimed
//
//  Created by Eugenijus Margalikas on 20.01.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//
/*
#ifndef TEST
#define TEST
#endif
*/
#import <Foundation/Foundation.h>
#import "MineFieldView.h"
#include "field.h"
#import "ScoresController.h"

#define PROPERTY_FILE @"property"

#define MAX_WIDTH 100
#define MAX_HEIGHT 100
#define MIN_WIDTH 10
#define MIN_HEIGHT 10
#define MIN_MINES 1

#define WINDOW_WIDTH(X_TILES)   VIEW_WIDTH(X_TILES)+40
#define WINDOW_HEIGHT(Y_TILES)   VIEW_HEIGHT(Y_TILES)+100
#define WINDOW_SIZE(X_TILES,Y_TILES) NSMakeSize(WINDOW_WIDTH(X_TILES),WINDOW_HEIGHT(Y_TILES))





@interface Controller : NSObject {

    /*
    unsigned int    fieldWidth;
    unsigned int    fieldHeight;
    int             minesCountDown;
    unsigned int    openedTiles;
    time_t          startTime;
    time_t          endTime;
    enum {UNDEFINED,RUNNING,READY,WIN,LOST}gameStatus;
     */
    NSTimer *timer;  
   // NSMutableDictionary *scoresDictionary;
    //NSTimeInterval timerResult;

}
@property unsigned int fieldWidth,fieldHeight,openedTiles,mines;
@property int minesMarked;
@property (retain) NSDate *startTime,*endTime;
@property enum {UNDEFINED=0,RUNNING=1,READY=2,WIN=3,LOST=4}gameStatus;

@property (strong) IBOutlet NSWindow *window;
@property (strong) IBOutlet NSWindow *custom;
@property (strong) IBOutlet NSWindow *scores;

@property (strong) IBOutlet ScoresController *scoresController;

@property (strong) IBOutlet NSTableView *customTable;

@property (strong) IBOutlet NSTextField *customWidth, *customHeight, *customMines;
@property (strong) IBOutlet NSSlider *customWidthSlider, *customHeightSlider, *customMinesSlider;

@property (strong) IBOutlet MineFieldView *view;
@property (strong) IBOutlet NSButton *button;
@property (strong) IBOutlet NSTextField *textFieldTime, *textFieldMines;



-(void)setViewFeedback;

-(id)init;
-(void)awakeFromNib;

-(IBAction)openScores:(id)sender;
-(IBAction)closeScores:(id)sender;

-(IBAction)clickCustomize:(id)sender;
-(IBAction)customButtonClick:(id)sender;
-(IBAction)customEdited:(id)sender;

-(IBAction)easyMenu:(id)sender;
-(IBAction)mediumMenu:(id)sender;
-(IBAction)hardMenu:(id)sender;

-(void)loadGamePropertiesFromFile;
-(void)storeGamePropertiesToFile;

-(void)setWindowAndViewSize;

-(void)startGame;
-(void)click:(id)sender;
-(BOOL)clickOnTileX:(unsigned int)x Y:(unsigned int)y;
-(BOOL)clickRightOnTileX:(unsigned int)x Y:(unsigned int)y;

-(IBAction)buttonClick:(id)sender;
-(void)updateTextFieldTime;

-(void)winGame;
//-(void)finish;

//-(void)score;

-(void)startTimer;
-(void)stopTimer;


@end
