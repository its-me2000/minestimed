//
//  AQTAppDelegate.m
//  minestimed
//
//  Created by Eugenijus Margalikas on 20.01.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "AQTAppDelegate.h"


@implementation AQTAppDelegate

@synthesize window = _window;
@synthesize controller;




- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [controller setViewFeedback];
    [controller startGame];
    // Insert code here to initialize your application
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender{
    
    
    NSLog(@"terminate \n");
    [controller storeGamePropertiesToFile];
    
    return NSTerminateNow;
}

@end
