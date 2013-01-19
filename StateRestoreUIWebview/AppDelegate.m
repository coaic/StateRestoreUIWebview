//
//  AppDelegate.m
//  TestUIWebview
//
//  Created by Shane MacPhillamy on 17/12/12.
//  Copyright (c) 2012 Shane MacPhillamy. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import "MyViewWeb.h"

@implementation AppDelegate

#pragma mark - State Restoration
- (BOOL) application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder
{
    return YES;
}

- (BOOL) application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder
{
    _snapshotExists = YES;
    return YES;
}

#pragma mark - UIApplicationDelegate implementation

- (void)commonInitialization:(UIApplication *)application withLaunchOptions:(NSDictionary *)launchOptions
{
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    });
}

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self commonInitialization:application withLaunchOptions:launchOptions];

    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self commonInitialization:application withLaunchOptions:launchOptions];
    NSString *fullURL = @"http://d.blinkm.co/samdemo";
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    if (!_snapshotExists) {
        self.viewController = [[ViewController alloc] initFromSnapshot:NO];
        self.window.rootViewController = self.viewController;
        self.viewController.viewWeb = [[MyViewWeb alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.viewController.viewWeb.restorationIdentifier = @"Webview";
        [self.viewController.view addSubview:self.viewController.viewWeb];
        [self.viewController.viewWeb loadRequest:requestObj];
    } else {
        int64_t delayInSeconds = 10.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self.viewController.viewWeb.scrollView setContentOffset:self.viewController.viewWeb.scrollPoint animated:YES];
        });
    }
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
