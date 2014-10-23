//
//  NewsToCoreDataManager.h
//  Voice
//
//  Created by yiqin on 10/22/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleToCoreDataManager : NSObject

@property (nonatomic, strong) NSMutableArray *newsArray;        // Not sure which one to use now.
@property (nonatomic, strong) NSMutableDictionary *newsDictionary;

+ (ArticleToCoreDataManager *)manager;


@end
