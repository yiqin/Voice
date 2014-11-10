//
//  ArticleDetailBlockTableViewCell.m
//  Voice
//
//  Created by yiqin on 10/27/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "ArticleTextBlockTableViewCell.h"
#import <Voice-Swift.h>

@implementation ArticleTextBlockTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // self.backgroundColor = [UIColor brownColor];
        self.paragraph = [[VoiceLabel alloc] initWithFrame:CGRectMake(10, 15, [DeviceManager sharedInstance].screenWidth-20, 500)];
        
        [self addSubview:self.paragraph];
    }
    return self;
}

- (void)updateFrame:(NSString *)paragraphText
{
    [self.paragraph updateFrameWithText:paragraphText];
}

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)cellHeight:(NSString *)paragraphText
{
    VoiceLabel *voiceLabel = [[VoiceLabel alloc] initWithFrame:CGRectMake(10, 15, [DeviceManager sharedInstance].screenWidth-20, 44) text:paragraphText];
    return CGRectGetHeight(voiceLabel.frame)+30;
}

+ (CGFloat)cellHeight
{
    return 130;
}

@end
