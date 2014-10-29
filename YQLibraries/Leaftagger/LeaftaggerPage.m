//
//  LeaftaggerPage.m
//  Leaftagger-Demo
//
//  Created by yiqin on 9/6/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "LeaftaggerPage.h"

@implementation LeaftaggerPage

- (instancetype)initWithYQParseObject:(YQParseObject *)parseObject
{
    self = [super initWithYQParseObject:parseObject];
    if (self) {
        NSLog(@"Leaftagger Page: %@", self.objectId);
        
        NSDictionary *screenshot1 = [self.responseJSON objectForKey:@"screenshot1"];
        
        // More defensive
        if (screenshot1 && ![screenshot1 isKindOfClass:[NSNull class]]) {
            self.imageURL = [[NSURL alloc] initWithString:[screenshot1 objectForKey:@"url"]];
        }
        else {
            // Something wrong here.
            // Check it's the first page or not
            // Get old UserDefault data
            // Check whether the data is saved in the NSUserDefault.
            NSDictionary *firtViewControllerFolitagPageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"LeaftaggerFirstViewControllerFolitagPage"];
            NSString *oldObjectId = [firtViewControllerFolitagPageData objectForKey:@"objectId"];
            
            
            
            // It will stop here. I don't know why.
            if ([self.objectId  isEqual: oldObjectId]) {
                NSDictionary *folitagPageData = [[NSDictionary alloc] init];
                folitagPageData = @{@"objectId": self.objectId};
                [[NSUserDefaults standardUserDefaults] setObject:folitagPageData forKey:@"LeaftaggerFirstViewControllerFolitagPage"];
            }
            else {
                
            }
        }
    }
    return self;
}

- (void)setImageURL:(NSURL *)imageURL
{
    if (imageURL) {
        _imageURL =imageURL;
        [self updateFirstPageData];
        
        NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:imageURL];
        
        YQHTTPRequestOperation *requestOperation = [[YQHTTPRequestOperation alloc] initWithRequest:urlRequest];
        requestOperation.responseSerializer = [YQImageResponseSerializer serializer];
        [requestOperation setCompletionBlockWithSuccess:^(YQHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"Response: %@", responseObject);
            
            self.screenshotImageView = [[UIImageView alloc] initWithImage:responseObject];
            
            
            
        } failure:^(YQHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Image error: %@", error);
            
            
        }];
        [requestOperation start];
    }
}

- (void)updateFirstPageData
{
    // Get old UserDefault data
    // Check whether the data is saved in the NSUserDefault.
    NSDictionary *firtViewControllerFolitagPageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"LeaftaggerFirstViewControllerFolitagPage"];
    NSString *oldObjectId = [firtViewControllerFolitagPageData objectForKey:@"objectId"];
    
    // if nil, go to here
    if (oldObjectId) {
        
        // check whether it's the first page.
        if ([self.objectId  isEqual: oldObjectId]) {
            
            NSDictionary *folitagPageData = [[NSDictionary alloc] init];
            NSString *imageURLString = [_imageURL absoluteString];
            folitagPageData = @{@"objectId": self.objectId,
                                @"imageURL": imageURLString};
            
            [[NSUserDefaults standardUserDefaults] setObject:folitagPageData forKey:@"LeaftaggerFirstViewControllerFolitagPage"];
        }
        
    }
}


@end
