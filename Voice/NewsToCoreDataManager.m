//
//  NewsToCoreDataManager.m
//  Voice
//
//  Created by yiqin on 10/22/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "NewsToCoreDataManager.h"
#import <Parse/Parse.h>
#import <News-Swift.h>

@implementation NewsToCoreDataManager

static NewsToCoreDataManager *instance = nil;

+(NewsToCoreDataManager*)manager{
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        instance = [[NewsToCoreDataManager alloc] init];
    });
    return instance;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        PFQuery *newsQuery = [PFQuery queryWithClassName:@"News"];
        [newsQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                NSLog(@"success");
                for(PFObject *object in objects) {
                    
                    News *new = [[New alloc] init];
                }
                
                
            }
        }];
        
    }
    return self;
}

@end
