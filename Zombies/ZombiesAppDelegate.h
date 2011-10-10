//
//  ZombiesAppDelegate.h
//  Zombies
//
//  Created by Ankit Tyagi on 6/20/11.
//  Copyright 2011 Ankit Tyagi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HighScoreSingletonData.h"
#import "GameCenterManager.h"

@class ZombiesViewController;

@interface ZombiesAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ZombiesViewController *viewController;

@end
