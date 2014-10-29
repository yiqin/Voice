//
//  YQActivityIndicatorView.m
//  Leaftagger-Demo
//
//  Created by yiqin on 9/6/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "YQActivityIndicatorView.h"

@implementation YQActivityIndicatorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

@end


@implementation YQActivityIndicatorCenterSpinnerWithBackground

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // self.backgroundColor = [UIColor blackColor];
        [self createActivityIndicatorSpinner];
        
    }
    return self;
}

- (instancetype)initWithxCenterPostion:(CGFloat)xCenterPosition yCenterPosition:(CGFloat)yCenterPosition
{
    CGFloat viewWidth = 60;
    CGFloat viewHeight = 60;
    self = [self initWithFrame:CGRectMake(xCenterPosition-viewWidth*0.5, yCenterPosition-viewHeight*0.5, viewWidth, viewHeight)];
    if (self) {
        
    }
    return self;
}

- (void)createActivityIndicatorSpinner
{
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.spinner setCenter:CGPointMake(CGRectGetWidth(self.frame)/2.0, CGRectGetHeight(self.frame)/2.0)];
    [self.spinner setColor:[UIColor colorWithRed:67.0/255.0 green:157.0/255.0 blue:90.0/255.0 alpha:1.0]];
    [self addSubview:self.spinner];
}

- (void)startAnimating
{
    [self.spinner startAnimating];
}

- (void)stopAnimating
{
    [self.spinner stopAnimating];
    [self removeFromSuperview];
}

@end
