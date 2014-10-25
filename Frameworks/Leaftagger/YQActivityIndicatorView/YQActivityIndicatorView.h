//
//  YQActivityIndicatorView.h
//  Leaftagger-Demo
//
//  Created by yiqin on 9/6/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YQActivityIndicatorView : UIView

@property(nonatomic, strong) UIActivityIndicatorView *spinner;

@end


@interface YQActivityIndicatorCenterSpinnerWithBackground : YQActivityIndicatorView

- (instancetype)initWithxCenterPostion:(CGFloat)xCenterPosition yCenterPosition:(CGFloat)yCenterPosition;

- (void)startAnimating;
- (void)stopAnimating;

@end