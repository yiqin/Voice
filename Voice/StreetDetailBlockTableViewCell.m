//
//  StreetDetailBlockTableViewCell.m
//  Voice
//
//  Created by yiqin on 11/22/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "StreetDetailBlockTableViewCell.h"

@implementation StreetDetailBlockTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.streetDetailImageView = [[PFImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        [self.streetDetailImageView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.streetDetailImageView setContentMode:UIViewContentModeScaleAspectFit];
        
        [self addSubview:self.streetDetailImageView];
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

@end
