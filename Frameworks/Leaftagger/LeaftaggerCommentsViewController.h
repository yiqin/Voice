//
//  LeaftaggerCommentsViewController.h
//  Leaftagger-Demo
//
//  Created by yiqin on 9/6/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQButton.h"
#import "LeaftaggerPoint.h"
#import "LeaftaggerComment.h"

@protocol LeaftaggerCommentsViewControllerDelegate;

@interface LeaftaggerCommentsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

- (instancetype)initWithFolitagPoint:(LeaftaggerPoint*)folitagPoint;

@property (nonatomic, strong) LeaftaggerPoint *currentPoint;

@property (nonatomic, strong) UITableViewController *commentsTableViewController;
@property (nonatomic, strong) UITableView *commentsTableView;

@property (nonatomic, strong) YQButtonWithImage *addCommentButton;
@property (nonatomic, strong) YQButtonWithImage *folitagWebButton;

@property (nonatomic, strong) NSMutableArray *commentsArray;

@property (nonatomic, strong) id<LeaftaggerCommentsViewControllerDelegate> delegate;

@end


@protocol LeaftaggerCommentsViewControllerDelegate

- (void)tappedAddCommentButton;
- (void)tappedFolitagWebButton;

@end