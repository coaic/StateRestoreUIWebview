//
//  AppDelegate.h
//  TestUIWebview
//
//  Created by Shane MacPhillamy on 17/12/12.
//  Copyright (c) 2012 Shane MacPhillamy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@property (nonatomic, readwrite, assign) BOOL snapshotExists;

@end
