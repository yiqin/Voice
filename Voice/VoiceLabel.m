//
//  VoiceLabel.m
//  Voice
//
//  Created by yiqin on 11/9/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "VoiceLabel.h"

@implementation VoiceLabel

- (instancetype)initWithFrame:(CGRect)frame font:(UIFont *)font text:(NSString *)text
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setFrame:frame font:font text:text];
    }
    return self;
}

- (void)setFrame:(CGRect)frame font:(UIFont *)font text:(NSString *)text
{
    // or "[text length] <1"
    if (text == nil) {
        text = @"NULL";
    }
    self.font = font;
    self.text = text;
    self.numberOfLines = 0;
    CGFloat maxheight = 1024.0;
    [self setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, maxheight)];
    [self sizeToFit];
    CGFloat labelHeight = self.frame.size.height;
    self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, labelHeight);
}

@end
