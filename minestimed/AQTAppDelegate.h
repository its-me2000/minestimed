//
//  AQTAppDelegate.h
//  minestimed
//
//  Created by Eugenijus Margalikas on 20.01.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Controller.h"
/*
#ifndef TEST
#define TEST
#endif
*/
@interface AQTAppDelegate : NSObject <NSApplicationDelegate>

@property (strong) IBOutlet NSWindow *window;
@property (strong) IBOutlet Controller *controller;


@end
