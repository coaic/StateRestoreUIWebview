//
//  ViewController.m
//  TestUIWebview
//
//  Created by Shane MacPhillamy on 17/12/12.
//  Copyright (c) 2012 Shane MacPhillamy. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "MyViewWeb.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.restorationIdentifier = @"viewController";
        self.view.restorationIdentifier = @"mainView";
        self.restorationClass = [self class];
        // Custom initialization
    }
    return self;
}

- (id)initFromSnapshot:(BOOL)flag
{
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self = [super initWithNibName:@"ViewController_iPhone" bundle:nil];
    } else {
        self = [super initWithNibName:@"ViewController_iPad" bundle:nil];
    }
    if (self) {
        self.restorationIdentifier = @"viewController";
        self.snapshotExists = flag;
        self.view.restorationIdentifier = @"mainView";
        self.restorationClass = [self class];
        // Custom initialization
    }
    return self;  
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - State Preservation

+ (UIViewController *) viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder
{
    ViewController *vc = nil;
    MyViewWeb *wv = nil;
    
    wv = [[MyViewWeb alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    vc = [[ViewController alloc] initFromSnapshot:YES];
    vc.urlBar = [coder decodeObjectForKey:@"kURLBar"];
    vc.snapshotExists = YES;

    vc.viewWeb = wv;
    vc.viewWeb.restorationIdentifier = @"Webview";
    [vc.view addSubview:wv];

    [(AppDelegate *)[[UIApplication sharedApplication] delegate] setViewController:vc];
    return vc;
}

- (void) encodeRestorableStateWithCoder:(NSCoder *)coder
{
    NSString *urlBar = [_viewWeb stringByEvaluatingJavaScriptFromString:@"window.location + ''"];
    [coder encodeObject:_viewWeb forKey:@"kViewWeb"];
    [coder encodeObject:urlBar forKey:@"kURLBar"];
    [super encodeRestorableStateWithCoder:coder];
}

- (void) decodeRestorableStateWithCoder:(NSCoder *)coder
{
    [[[[UIApplication sharedApplication] delegate] window] setRootViewController:self];
    [super decodeRestorableStateWithCoder:coder];
}

@end
