//
//  ParseMasterOperation.h
//  Voice
//
//  Created by Yi Qin on 2/7/15.
//  Copyright (c) 2015 yiqin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Article;

@interface ParseMasterOperation : NSObject


+ (void)incrementArticlePageView:(Article *)article currentUserObjectId:(NSString *)objectId;

+ (void)createLikeArticle:(Article *)article currentUserObjectId:(NSString *)objectId;
+ (void)deleteLikeArticle:(Article *)article currentUserObjectId:(NSString *)objectId;



@end
