//
//  LeaftaggerPoint.h
//  Leaftagger-Demo
//
//  Created by yiqin on 9/6/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "LeaftaggerObject.h"
#import "YQLeaftaggerPointButton.h"

@interface LeaftaggerPoint : LeaftaggerObject

@property(nonatomic) int imageNumber;
@property(nonatomic) float xPosition;                         // 0~1 relative position
@property(nonatomic) float yPosition;                         // 0~1 relative position
@property(nonatomic, strong) YQLeaftaggerPointButton *image;

@end

