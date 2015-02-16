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
        
        NSDictionary *addUnique = @{@"__op":@"AddUnique",
                                    @"objects":@[currentUserObjectId]};
        NSDictionary *increment = @{@"__op":@"Increment",
                                    @"amount":@1};
        
        NSDictionary *parameters = @{@"pageViewers":addUnique, @"pageViewCount":increment};
        
        [manage PUT:path parameters:parameters success:^(YQHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"successful %@", responseObject);
            [[PageViewsDataManager sharedInstance] addPageView:currentUserObjectId];
            
        } failure:^(YQHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"wrong %@", error);
            
        }];
    }
}


+ (void)createLikeArticle:(Article *)article currentUserObjectId:(NSString *)objectId {
    
    YQParseRequestOperationManager *manage = [YQParseRequestOperationManager manager];
    [manage.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSString *path = [NSString stringWithFormat:@"https://api.parse.com/1/classes/LikeArticle/"];
    
    NSDictionary *articleParameters = @{@"__type":@"Pointer",
                                     @"className":@"Article",
                                      @"objectId":article.objectId};
    NSDictionary *userParameters = @{@"__type":@"Pointer",
                                  @"className":@"_User",
                                   @"objectId":objectId};
    NSDictionary *parameters = @{@"article":articleParameters, @"user":userParameters};
    
    [manage POST:path parameters:parameters success:^(YQHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"successful %@", responseObject);
        
        
    } failure:^(YQHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"wrong %@", error);
        
    }];
}


+ (void)deleteLikeArticle:(Article *)article currentUserObjectId:(NSString *)objectId {
    
    PFQuery *query = [PFQuery queryWithClassName:@"LikeArticle"];
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    [query whereKey:@"article" equalTo:article.parseObject];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error && objects.count>0) {
            
            for (PFObject *object in objects) {
                YQParseRequestOperationManager *manage = [YQParseRequestOperationManager manager];
                [manage.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
                
                NSString *path = [NSString stringWithFormat:@"https://api.parse.com/1/classes/LikeArticle/%@", object.objectId];
                NSDictionary *parameters = @{};
                
                [manage DELETE:path parameters:parameters success:^(YQHTTPRequestOperation *operation, id responseObject) {
                    NSLog(@"successful %@", responseObject);
                    
                } failure:^(YQHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"wrong %@", error);
                    
                }];
            }
        }
        else {
        }
    }];
    
}


@end
