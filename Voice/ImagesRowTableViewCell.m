//
//  ImagesRowTableViewCell.m
//  Voice
//
//  Created by yiqin on 10/24/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "ImagesRowTableViewCell.h"
#import <Voice-Swift.h>

@implementation ImagesRowTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor brownColor];
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

+ (float) cellHeight
{
    return 130;
}

@end
