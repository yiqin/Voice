//
//  CommentTableViewCell.h
//  Leaftagger-Demo
//
//  Created by yiqin on 9/6/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQLabel.h"
#import "LeaftaggerComment.h"
#import "YQButton.h"

@interface LeaftaggerCommentTableViewCell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier tableWidth:(float)tableWidth;
- (void)loadComment:(LeaftaggerComment*) comment;

@property (strong, nonatomic) UIView *cellBackground;

@property (nonatomic, strong) YQLabelWithFixedWidth *betaUserNameLabel;
@property (nonatomic, strong) YQLabelWithFixedWidth *timeLabel;
@property (nonatomic, strong) YQLabelWithFixedWidth *commentLabel;

@property (nonatomic, strong) YQOneButton *likeButton;

+ (float)cellHeight:(LeaftaggerComment*) comment;

@end
