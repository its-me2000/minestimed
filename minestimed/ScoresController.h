//
//  ScoresController.h
//  minestimed
//
//  Created by Eugenijus Margalikas on 08.02.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScoresController : NSObject  <NSTableViewDataSource>
{
    NSMutableDictionary *dictionary;
    NSInteger place;
    NSNumber *scoreTime;
}

@property (strong) IBOutlet NSWindow *scores;
@property (strong) IBOutlet NSWindow *enterName;
@property (strong) IBOutlet NSWindow *minestimed;
@property (strong) IBOutlet NSTextField *name;

-(void)setDictionary:(NSMutableDictionary*)newDictionary;
-(NSMutableDictionary*)dictionary;
-(void)newScoreWithTime:(NSTimeInterval)time;
-(IBAction)addRecord:(id)sender;

@end
