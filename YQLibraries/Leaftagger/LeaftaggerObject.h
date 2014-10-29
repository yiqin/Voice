//
//  LeaftaggerObject.h
//  Leaftagger-Demo
//
//  Created by yiqin on 9/6/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "YQParseObject.h"

@interface LeaftaggerObject : YQParseObject

- (instancetype)initWithYQParseObject:(YQParseObject *)parseObject;
@property(nonatomic, strong) NSString *text;

@end
