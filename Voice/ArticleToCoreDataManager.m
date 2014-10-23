//
//  NewsToCoreDataManager.m
//  Voice
//
//  Created by yiqin on 10/22/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "ArticleToCoreDataManager.h"
#import <Parse/Parse.h>
#import "Voice-Swift.h"

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
        self.articlesArray = [[NSMutableArray alloc] init];
        PFQuery *newsQuery = [PFQuery queryWithClassName:@"Article"];
        [newsQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                NSLog(@"load data: success");
                for(PFObject *object in objects) {
                    Article *newArticle = [[Article alloc] initWithArticlePFObject:object];
                    [self.articlesArray addObject:newArticle];
                }
                // Save data
                ArticlesManager *test = [[ArticlesManager alloc] init];
            }
        }];
        
    }
    return self;
}

@end
