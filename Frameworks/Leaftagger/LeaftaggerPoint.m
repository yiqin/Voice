//
//  LeaftaggerPoint.m
//  Leaftagger-Demo
//
//  Created by yiqin on 9/6/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "LeaftaggerPoint.h"
#import "LeaftaggerScreenManager.h"

@implementation LeaftaggerPoint

- (instancetype)initWithYQParseObject:(YQParseObject *)parseObject
{
    self = [super initWithYQParseObject:parseObject];
    if (self) {
        self.xPosition = [[self.responseJSON objectForKey:@"xPosition"] floatValue];
        self.yPosition = [[self.responseJSON objectForKey:@"yPosition"] floatValue];
        
        self.imageNumber = [[self.responseJSON objectForKey:@"imageNumber"] intValue];
    }
    return self;
}

- (void)setImageNumber:(int)imageNumber
{
    _imageNumber = imageNumber;
    
    NSString *imageName = [[NSString alloc] init];
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
        /* Device is iPad */
        imageName = [NSString stringWithFormat:@"iPadYQNumbers-%i", self.imageNumber];
    }
    else {
        /* Device is iPhone */
        imageName = [NSString stringWithFormat:@"YQNumbers-%i", self.imageNumber];
        
    }
    
    
    
    // _ or self (I'm not sure at this time.)
    
    // I don't this is a good method.
    self.image = [[YQLeaftaggerPointButton alloc] initWithCenterPoin:CGPointMake(self.xPosition*[LeaftaggerScreenManager getScreenWidth], self.yPosition*[LeaftaggerScreenManager getScreenHeight]) imageSize:CGSizeMake(45, 45) image:imageName selectedImage:imageName];
    // self.image.hasAnimation = YES;
    self.image.objectId = self.objectId;
}


@end
