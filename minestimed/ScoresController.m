//
//  ScoresController.m
//  minestimed
//
//  Created by Eugenijus Margalikas on 08.02.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "ScoresController.h"

@implementation ScoresController

@synthesize scores,enterName,minestimed,name;

-(void)dealloc{
    [dictionary release];
    [scoreTime release];
}

-(id)init{
        return self=[super init];
}

-(void)setDictionary:(NSMutableDictionary*)newDictionary{
    dictionary=[NSMutableDictionary dictionaryWithDictionary:newDictionary];
    [dictionary retain];
}

-(NSMutableDictionary*)dictionary{return dictionary;}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {return [dictionary count];}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    
    NSString *identifier = [tableColumn identifier];
    NSString *rowKey;
    
    rowKey=[NSString stringWithFormat:@"%ld",row+1];
    
    if([identifier  isEqualToString:@"Place"]){
        return rowKey;
    }else if([identifier  isEqualToString:@"Name"]){
        return (NSString*)[[dictionary objectForKey:rowKey] objectForKey:@"Name"];
    }else if([identifier  isEqualToString:@"Time"]){
        return (NSString*)[[dictionary objectForKey:rowKey] objectForKey:@"Time"];
    }
    
    return @"bla";
}

-(void)newScoreWithTime:(NSTimeInterval)time{
    
    [scoreTime release];
    scoreTime=[[NSNumber numberWithDouble:time] retain];
    NSArray *keysArray=[NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil];
    place=-1;
    
    for (NSInteger i=0; i<[dictionary count]; ++i) {
        NSNumber *temp=(NSNumber*)[[dictionary objectForKey:[keysArray objectAtIndex:i]] objectForKey:@"Time"];
        if ([scoreTime compare:temp]==NSOrderedAscending) {
            place = i;
            break;
        }
    }
    
    if (place==-1) return;
    NSLog(@"newScore");
    [NSApp beginSheet:enterName modalForWindow:minestimed modalDelegate:nil didEndSelector:nil contextInfo:NULL];
    
    
    
}

-(IBAction)addRecord:(id)sender{
    
    [NSApp endSheet:enterName];
     NSArray *keysArray=[NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil];
    for (NSInteger i=[dictionary count]-1; i>place; --i) {
        [dictionary setObject:[dictionary objectForKey:[keysArray objectAtIndex:i-1]] forKey:[keysArray objectAtIndex:i]];
    }
    NSDictionary *newRecod=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[name stringValue],scoreTime, nil] forKeys:[NSArray arrayWithObjects:@"Name",@"Time", nil]];
    [dictionary setObject:newRecod forKey:[keysArray objectAtIndex:place]];
    
    
    [enterName close];
    
    [NSApp beginSheet:scores modalForWindow:minestimed modalDelegate:nil didEndSelector:nil contextInfo:NULL];
    
}

@end
