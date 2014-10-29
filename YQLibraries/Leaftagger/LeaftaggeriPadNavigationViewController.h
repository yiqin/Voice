//
//  LeaftaggeriPadNavigationViewController.h
//  Leaftagger-Demo
//
//  Created by yiqin on 9/6/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeaftaggerPoint.h"

@interface LeaftaggeriPadNavigationViewController : UINavigationController

- (instancetype)initWithFolitagPage:(LeaftaggerPoint*)selectedPoint;
@property (nonatomic, strong) LeaftaggerPoint *currentPoint;

@end
