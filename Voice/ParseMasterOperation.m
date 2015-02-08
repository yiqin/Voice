//
//  ParseMasterOperation.m
//  Voice
//
//  Created by Yi Qin on 2/7/15.
//  Copyright (c) 2015 yiqin. All rights reserved.
//

#import "ParseMasterOperation.h"
#import "YQParseRequestOperationManager.h"
#import <Voice-Swift.h>

@implementation ParseMasterOperation

+ (void)incrementArticlePageView:(Article *)article currentUserObjectId:(NSString *)currentUserObjectId {
    
    NSArray *pageViewers = article.parseObject[@"pageViewers"];
    
    BOOL isViewBeforeOnParse = NO;
    for (NSString *pageViewer in pageViewers) {
        if ([pageViewer isEqualToString:currentUserObjectId]) {
            isViewBeforeOnParse = YES;
            break;
        }
    }
    
    if (!isViewBeforeOnParse && ![[PageViewsDataManager sharedInstance] checkPageView:currentUserObjectId]) {
        YQParseRequestOperationManager *manage = [YQParseRequestOperationManager manager];
        [manage.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        NSString *path = [NSString stringWithFormat:@"https://api.parse.com/1/classes/Article/%@",article.objectId];
        /*
        NSDictionary *addUnique = @{@"__op":@"AddUnique",
                                    @"objects":@[currentUserObjectId]};
        */
        NSDictionary *increment = @{@"__op":@"Increment",
                                    @"amount":@1};
        
        // NSDictionary *parameters = @{@"pageViewers":addUnique, @"pageViewCount":increment};
        NSDictionary *parameters = @{@"pageViewCount":increment};
        
        [manage PUT:path parameters:parameters success:^(YQHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"successful %@", responseObject);
            [[PageViewsDataManager sharedInstance] addPageView:currentUserObjectId];
            
        } failure:^(YQHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"wrong %@", error);
            
        }];
    }
}

@end
