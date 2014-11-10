//
//  AdTableViewCell.h
//  Voice
//
//  Created by yiqin on 10/27/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Ad;
@class AdsManager;

@interface AdTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView *adImageView;

+ (CGFloat) cellHeight;

@end
