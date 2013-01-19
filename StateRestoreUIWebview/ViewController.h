//
//  ViewController.h
//  TestUIWebview
//
//  Created by Shane MacPhillamy on 17/12/12.
//  Copyright (c) 2012 Shane MacPhillamy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyViewWeb.h"

@interface ViewController : UIViewController <UIViewControllerRestoration>

@property (strong, nonatomic) MyViewWeb *viewWeb;

@property (nonatomic, readwrite, assign) BOOL snapshotExists;

@property (nonatomic, readwrite, strong) NSString *urlBar;

- (id)initFromSnapshot:(BOOL)flag;

@end
