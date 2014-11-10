//
//  ArticleCoverTableViewCell.h
//  Voice
//
//  Created by yiqin on 10/27/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DeviceManager;

@interface ArticleCoverTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView *coverImageView;

+ (CGFloat) cellHeight;

@end
