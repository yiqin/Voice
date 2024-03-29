//
//  VoiceLabel.h
//  Voice
//
//  Created by yiqin on 11/9/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VoiceLabel : UILabel

- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text;
- (void)setFrame:(CGRect)frame font:(UIFont *)font text:(NSString *)text;
- (void)updateFrameWithText:(NSString *)text;

@end
