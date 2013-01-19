//
//  MyViewWeb.m
//  TestUIWebview
//
//  Created by Shane MacPhillamy on 18/12/12.
//  Copyright (c) 2012 Shane MacPhillamy. All rights reserved.
//

#import "MyViewWeb.h"

@implementation MyViewWeb

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithURLbar:(NSString *)URLbar
{
    self = [super init];
    if (self) {
        [self loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:URLbar]]];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
#pragma mark - State Preservation
- (void) encodeRestorableStateWithCoder:(NSCoder *)coder
{
    NSString *urlBar = [self stringByEvaluatingJavaScriptFromString:@"window.location + ''"];
    [coder encodeObject:urlBar forKey:@"kMyURLBar"];
    [super encodeRestorableStateWithCoder:coder];
}

- (void) decodeRestorableStateWithCoder:(NSCoder *)coder
{
    NSString *urlBar = [coder decodeObjectForKey:@"kMyURLBar"];
    NSDictionary *bfDictionary = [coder decodeObjectForKey:@"kBackForwardDictionaryKey"];
    NSArray *entries = [bfDictionary objectForKey:@"entries"];
    NSDictionary *scrollViewDictionary = [entries lastObject];
    float scrollPointX = [[scrollViewDictionary objectForKey:@"scrollPointX"] intValue];
    float scrollPointY = [[scrollViewDictionary objectForKey:@"scrollPointY"] intValue];
    _scrollPoint = CGPointMake(scrollPointX, scrollPointY);

    _myURLBar = urlBar;

    [super decodeRestorableStateWithCoder:coder];

    [self reload];
}

@end
