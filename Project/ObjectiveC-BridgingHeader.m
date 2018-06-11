//
//  ObjectiveC-BridgingHeader.m
//  Project
//
//  Created by Zooey Bossert on 11-06-18.
//  Copyright © 2018 Zooey Bossert. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Project-Bridging-Header.h"

@interface AppDelegate ()
@end

@implementation AppDelegate
@end

@interface AppDelegate ()
@property (nonatomic, strong) SPTAuth *auth;
@property (nonatomic, strong) SPTAudioStreamingController *player;
@property (nonatomic, strong) UIViewController *authViewController;
@end
