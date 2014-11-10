//
//  ArticleCoverTableViewCell.m
//  Voice
//
//  Created by yiqin on 10/27/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "ArticleCoverTableViewCell.h"
#import "Voice-Swift.h"

@implementation ArticleCoverTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        
        self.coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        [self.coverImageView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.coverImageView setContentMode:UIViewContentModeScaleAspectFit];
        
        [self addSubview:self.coverImageView];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)cellHeight {
    return [DeviceManager sharedInstance].screenHeight;
}

@end
