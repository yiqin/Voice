//
//  ParseMasterOperation.m
//  Voice
//
//  Created by Yi Qin on 2/7/15.
//  Copyright (c) 2015 yiqin. All rights reserved.
//

#import "ParseMasterOperation.h"
#import "YQParseRequestOperationManager.h"

@implementation ParseMasterOperation

+ (void)incrementArticlePageView:(NSString *)articleParseObjectId currentUserObjectId:(NSString *)objectId {
    YQParseRequestOperationManager *manage = [YQParseRequestOperationManager manager];
    [manage.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSString *path = [NSString stringWithFormat:@"https://api.parse.com/1/classes/Article/%@",articleParseObjectId];
    
    NSDictionary *addUnique = @{@"__op":@"AddUnique",
                                @"objects":@[objectId]};
    NSDictionary *parameters = @{@"pageViewers":addUnique};
    
    [manage PUT:path parameters:parameters success:^(YQHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"successful");
        
    } failure:^(YQHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"wrong %@", error);
        
    }];
}

@end
