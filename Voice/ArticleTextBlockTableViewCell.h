//
//  ArticleDetailBlockTableViewCell.h
//  Voice
//
//  Created by yiqin on 10/27/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VoiceLabel.h"

@class DeviceManager;

@interface ArticleTextBlockTableViewCell : UITableViewCell

@property(strong, nonatomic) VoiceLabel *paragraph;

- (void)updateFrame:(NSString *)paragraphText;

+ (CGFloat)cellHeight:(NSString *)paragraphText;
+ (CGFloat)cellHeight;

@end
