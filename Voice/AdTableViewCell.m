//
//  AdTableViewCell.m
//  Voice
//
//  Created by yiqin on 10/27/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "AdTableViewCell.h"
#import <Parse/Parse.h>
#import <Voice-Swift.h>

@implementation AdTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        NSLog(@"%.2f", self.frame.size.width);
        NSLog(@"%.2f", self.frame.size.height);
        
        int randNum1 = rand() % 3;
        int randNum2 = rand() % 3;
        
        Ad *randomAd = [[AdsManager sharedInstance].ads objectAtIndex:randNum1];
        AdImage *randomAdImage = [randomAd.adImages objectAtIndex:randNum2];
        
        self.image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        [self.image setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.image setContentMode:UIViewContentModeScaleAspectFit];
        
        self.image.image = randomAdImage.image.image;
        [self addSubview:self.image];
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

+ (CGFloat)cellHeight{
    return 180;
}

@end
