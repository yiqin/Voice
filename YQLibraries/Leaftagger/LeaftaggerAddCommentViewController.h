//
//  LeaftaggerAddCommentViewController.h
//  Leaftagger-Demo
//
//  Created by yiqin on 9/6/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeaftaggerPoint.h"
#import "LeaftaggerComment.h"

@interface LeaftaggerAddCommentViewController : UIViewController<UITextViewDelegate>

- (instancetype)initWithFolitagPoint:(LeaftaggerPoint*)selectedPoint;
@property (nonatomic, strong) LeaftaggerPoint *currentPoint;


@end
