//
//  NewsToCoreDataManager.m
//  Voice
//
//  Created by yiqin on 10/22/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "ArticleToCoreDataManager.h"
#import <Parse/Parse.h>
// #import "Article-Swift.h"

@implementation ArticleToCoreDataManager

static ArticleToCoreDataManager *instance = nil;

+(ArticleToCoreDataManager*)manager{
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        instance = [[ArticleToCoreDataManager alloc] init];
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
                    
                    
                    
                    
                    
                    
                }
                
                
            }
        }];
        
    }
    return self;
}

@end
