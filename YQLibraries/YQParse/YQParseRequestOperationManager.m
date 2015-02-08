//
//  YQParseRequestOperationManager.m
//  Leaftagger-Demo
//
//  Created by yiqin on 9/6/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "YQParseRequestOperationManager.h"
#import "YQParse.h"

@implementation YQParseRequestOperationManager

+ (instancetype)manager
{
    return [[self alloc] initWithBaseURL:nil];
}

- (instancetype)init
{
    return [self initWithBaseURL:nil];
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        self.requestSerializer = [YQJSONRequestSerializer serializer];
        self.responseSerializer = [YQJSONResponseSerializer serializer];
        
        [self.requestSerializer setValue:@"67k8jnSI757kUzLNletpqjxMHdBWTbELiyJoMy52" forHTTPHeaderField:@"X-Parse-Application-Id"];
        [self.requestSerializer setValue:@"BZi6qS4QKjblJvrlvOq8veoSgO3F5cJj7zLciYrs" forHTTPHeaderField:@"X-Parse-REST-API-Key"];
        [self.requestSerializer setValue:@"MoGyejL0btpLM7vrEKuen6a1x" forHTTPHeaderField:@"X-Parse-Session-Token"];
    }
    return self;
}

@end
