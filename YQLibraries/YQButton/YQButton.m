//
//  YQButton.m
//  RT
//
//  Created by yiqin on 8/25/14.
//  Copyright (c) 2014 yiqin.info All rights reserved.
//

#import "YQButton.h"

@implementation YQButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		// self.layer.cornerRadius = 5.0;
        self.layer.masksToBounds = YES;
		self.titleLabel.textAlignment = NSTextAlignmentCenter;
		
		// ensure color properties are never nil
		self.highlightedColor = self.backgroundColor;
		self.regularColor = self.backgroundColor;
    }
    return self;
}

// swap highlight/regular color for touch down/up
- (void)setHighlighted:(BOOL)highlighted
{
	[super setHighlighted:highlighted];
	
	if (highlighted) {
		self.backgroundColor = self.highlightedColor;
	}
	else{
		self.backgroundColor = self.regularColor;
	}
}

@end

@implementation YQButtonWithImage

- (instancetype)initWithFrame:(CGRect)frame image:(NSString *)image selectedImage:(NSString *)selectedImage_
{
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [UIColor clearColor];
        
        if (self.isBackgroundTransparent) {
            [self setBackgroundToTransparent];
        };
        
        self.hasAnimation = NO;
        
		self.highlightedColor = [UIColor clearColor];
		self.regularColor = [UIColor clearColor];
		
		self.regularImage = image;
		self.selectedImage = selectedImage_;
		
		[self addTarget:self action:@selector(didTap) forControlEvents:UIControlEventTouchUpInside];
	}
	return self;
}

- (instancetype)initWithCenterPoin:(CGPoint)centerPoint imageSize:(CGSize)imageSize image:(NSString*)image selectedImage:(NSString*)selectedImage
{
    CGRect frame = CGRectMake(centerPoint.x-imageSize.width*0.5, centerPoint.y-imageSize.height*0.5, imageSize.width, imageSize.height);
    self = [self initWithFrame:frame image:image selectedImage:selectedImage];
    if (self) {
        
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{
	[super setHighlighted:highlighted];
    
    if (self.isBackgroundTransparent) {
        [self setBackgroundToTransparent];
    };
    
	if (highlighted) {
		[self setImage:[UIImage imageNamed:self.selectedImage] forState:UIControlStateNormal];
	}
	else{
		[self setImage:[UIImage imageNamed:self.regularImage] forState:UIControlStateNormal];
	}
}

- (void) didTap
{
	self.selected = !self.selected;
}

- (void)setRegularImage:(NSString *)regularImage_
{
	_regularImage = regularImage_;
    
    if (self.isBackgroundTransparent) {
        [self setBackgroundToTransparent];
    };
    
	[self setImage:[UIImage imageNamed:self.regularImage] forState:UIControlStateNormal];
}

- (void)setSelectedImage:(NSString *)selectedImage_
{
	_selectedImage = selectedImage_;
    
    if (self.isBackgroundTransparent) {
        [self setBackgroundToTransparent];
    };
    
	[self setImage:[UIImage imageNamed:self.selectedImage] forState:UIControlStateSelected];
}

- (void)setIsTransparent:(BOOL)isBackgroundTransparent
{
    _isBackgroundTransparent = isBackgroundTransparent;
}

- (void)setHasAnimation:(BOOL)hasAnimation
{
    _hasAnimation = hasAnimation;
    if (hasAnimation) {
        CATransition *transition = [CATransition animation];
        transition.duration = 0.6;
        transition.type = kCATransitionReveal;
        [self.layer addAnimation:transition forKey:nil];
    }
}

- (void)setBackgroundToTransparent
{
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
}

@end

@implementation YQButtonWithParse

- (void)setObjectId:(NSString *)objectId
{
    _objectId = objectId;
}

@end
