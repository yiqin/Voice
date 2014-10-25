//
//  LeaftaggerView.h
//  Leaftagger-Demo
//
//  Created by yiqin on 9/6/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQParse.h"
#import "LeaftaggerPage.h"
#import "LeaftaggerPoint.h"
#import "LeaftaggerTapGestureRecognizer.h"

#import "LeaftaggerCommentsViewController.h"

@interface LeaftaggerView : UIView <LeaftaggerCommentsViewControllerDelegate>

+ (instancetype)viewWithFolitagPage:(LeaftaggerPage*)selectedPage;
+ (instancetype)view;

@property(nonatomic, strong) LeaftaggerPage *selectedPage;
@property(nonatomic, strong) LeaftaggerPoint *selectedPoint;


@end
