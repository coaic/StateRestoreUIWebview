//
//  MyViewWeb.h
//  TestUIWebview
//
//  Created by Shane MacPhillamy on 18/12/12.
//  Copyright (c) 2012 Shane MacPhillamy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyViewWeb : UIWebView

@property (nonatomic, readwrite, strong) NSString *myURLBar;
@property (assign) CGPoint scrollPoint;

- (id)initWithURLbar:(NSString *)URLbar;

@end
