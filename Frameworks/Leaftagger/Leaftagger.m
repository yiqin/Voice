//
//  YQManager.m
//  Leaftagger-Demo
//
//  Created by yiqin on 9/6/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "Leaftagger.h"

#import "YO.h"

@interface Leaftagger ()

@property(nonatomic, strong) NSString *applicationId;
@property(nonatomic, strong) NSString *apiKey;

@property(nonatomic, strong) NSMutableDictionary *allFolitagViewsDictionary;

@property(nonatomic, strong) LeaftaggerView *availableFolitagView;

@end

@implementation Leaftagger

+ (instancetype)sharedManager
{
    static Leaftagger *sharedYQManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedYQManager = [[self alloc] init];
    });
    return sharedYQManager;
}

- (instancetype)init
{
    if (self = [super init]) {
        _applicationId = @"";
        _apiKey = @"";
        
        _allFolitagViewsDictionary = [[NSMutableDictionary alloc] init];
        // Init view
        // _availableFolitagView = [LeaftaggerView viewWithObjectId:@"tMejUValWj"];
        [LeaftaggerScreenManager setScreenSize];
    }
    return self;
}

+ (void)setApplicationId:(NSString*)applicationId apiKey:(NSString*)apiKey
{
    // YO
    NSString *APIKey = @"63e019db-a4d4-4789-47de-e110cb192239";
    [YO startWithAPIKey:APIKey];
    
    // Parse Authorization
    [YQParse setApplicationId:@"puJq7igbK6ZeekBulDQP1aJfVwxcd1vvAWAshHPI"
                   restApiKey:@"pkMzP4R37PZz4yd4vI7rswJHUxSm1oQesO4Fvhs7"];
    
    Leaftagger *shared = [Leaftagger sharedManager];
    shared.applicationId = applicationId;
    shared.apiKey = apiKey;
    
    [Leaftagger loadFolitagViewsFromCloud];
}

//////////////////////////////
// This method is not perfect. Actually, I forget why this class method is created.
//////////////////////////////
+ (void)setFolitagView:(LeaftaggerView*)availableFolitagView
{
    Leaftagger *shared = [Leaftagger sharedManager];
    shared.availableFolitagView = availableFolitagView;
}

+ (NSString*)getApplicationId
{
    Leaftagger *shared = [Leaftagger sharedManager];
    return shared.applicationId;
}

+ (NSString*)getApiKey
{
    Leaftagger *shared = [Leaftagger sharedManager];
    return shared.apiKey;
}

+ (LeaftaggerView*)getFolitagView
{
    Leaftagger *shared = [Leaftagger sharedManager];
    return shared.availableFolitagView;
}

+ (NSMutableDictionary*)getAllFolitagViewsDictionary
{
    Leaftagger *shared = [Leaftagger sharedManager];
    return shared.allFolitagViewsDictionary;
}

+ (void)loadFolitagViewsFromCloud
{
    Leaftagger *shared = [Leaftagger sharedManager];
    
    ///////////////////////
    // QUICK WAY to init LeaftaggerApp
    ///////////////////////
    LeaftaggerApp *folitagApp = [LeaftaggerApp objectWithClassName:@"YQApp"];
    folitagApp.objectId = shared.apiKey;
    
    YQParseQuery *query = [YQParseQuery queryWithClassName:@"YQPage"];
    [query whereKey:@"belongTo" equalTo:folitagApp];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (YQParseObject *object in objects) {
                LeaftaggerPage *folitagPage = [[LeaftaggerPage alloc] initWithYQParseObject:object];
                
                NSString *viewControllerName = [object.responseJSON objectForKey:@"viewControllerName"];
                if (viewControllerName) {
                    [shared.allFolitagViewsDictionary setObject:folitagPage forKey:viewControllerName];
                }
            }
            
            //////////////////////////////////////
            // Repeat to load images for realtime.
            //////////////////////////////////////
            // Failed.
            //////////////////////////////////////
            // [NSTimer scheduledTimerWithTimeInterval:15.0 target:self selector:@selector(loadFolitagViewsFromCloud) userInfo:nil repeats:NO];
        }
    }];
}

+ (void)tagLeafOnViewController:(id)viewController;
{
    UIViewController *tempViewController = (UIViewController *)viewController;
    
    LeaftaggerTapGestureRecognizer *tapGestureRecognizer = [[LeaftaggerTapGestureRecognizer alloc] initWithTarget:self action:@selector(twoFingersOneTap:)];
    
    
    [[tempViewController view] addGestureRecognizer:tapGestureRecognizer];
    
    
    NSString *currentViewControllerName = [[NSString alloc] initWithFormat:@"%@", [viewController class]];
    
    NSMutableDictionary *temp = [Leaftagger getAllFolitagViewsDictionary];
    NSLog(@"%@",temp);
    
    
    LeaftaggerPage *folitagPage = [[Leaftagger getAllFolitagViewsDictionary] objectForKey:currentViewControllerName];
    
    tapGestureRecognizer.pageObjectId = folitagPage.objectId;
    tapGestureRecognizer.selectedFolitagPage = folitagPage;
    
    
    // First View has some bugs. The data is not ready yet.
    // [Leaftagger getAllFolitagViewsDictionary] is nil. NSUserdefault is used to handle it.
    if (!tapGestureRecognizer.pageObjectId) {
        
        // Get Current LeaftaggerApp
        LeaftaggerApp *folitagApp = [LeaftaggerApp objectWithClassName:@"YQApp"];
        folitagApp.objectId = [Leaftagger getApiKey];
        
        // If the data is loading, or it's the first time to setup
        if ([[Leaftagger getAllFolitagViewsDictionary] count] == 0) {
            
            // Check whether the data is saved in the NSUserDefault.
            NSDictionary *firtViewControllerFolitagPageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"LeaftaggerFirstViewControllerFolitagPage"];
            
            if (![firtViewControllerFolitagPageData objectForKey:@"objectId"]) {
                
                YQParseQuery *query = [YQParseQuery queryWithClassName:@"YQPage"];
                [query whereKey:@"belongTo" equalTo:folitagApp];
                [query whereKey:@"viewControllerName" equalTo:currentViewControllerName];
                
                [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                    if (!error) {
                        if ([objects count] == 1) {
                            for (YQParseObject *object in objects) {
                                
                                NSLog(@"%@", object.objectId);
                                tapGestureRecognizer.pageObjectId = object.objectId;
                                tapGestureRecognizer.selectedFolitagPage = [[LeaftaggerPage alloc] initWithYQParseObject:object];
                                
                                // Save it to NSDictionary
                                NSString *imageURLString = [tapGestureRecognizer.selectedFolitagPage.imageURL absoluteString];
                                
                                
                                NSDictionary *folitagPageData = [[NSDictionary alloc] init];
                                
                                
                                
                                // imageURLString
                                if (!imageURLString) {
                                    folitagPageData = @{@"objectId": tapGestureRecognizer.pageObjectId};
                                }
                                else {
                                    folitagPageData = @{@"objectId": tapGestureRecognizer.pageObjectId,
                                                        @"imageURL": imageURLString};
                                }
                                
                                
                                [[NSUserDefaults standardUserDefaults] setObject:folitagPageData forKey:@"LeaftaggerFirstViewControllerFolitagPage"];
                                
                            }
                        }
                        else {
                            /////////////////
                            // If no object is returned,
                            // Create one.
                            /////////////////
                            YQParseObject *object = [YQParseObject objectWithClassName:@"YQPage"];
                            [object setValue:currentViewControllerName forKey:@"viewControllerName"];
                            [object setValue:folitagApp forKey:@"belongTo"];
                            [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                                if (!error) {
                                    tapGestureRecognizer.pageObjectId = object.objectId;
                                    tapGestureRecognizer.selectedFolitagPage = [[LeaftaggerPage alloc] initWithYQParseObject:object];
                                    // [Leaftagger loadFolitagViewsFromCloud];
                                    // No need to reload.
                                }
                            }];
                        }
                    }
                }];
            }
            else {
                tapGestureRecognizer.pageObjectId = [firtViewControllerFolitagPageData objectForKey:@"objectId"];
                tapGestureRecognizer.selectedFolitagPage = [LeaftaggerPage objectWithClassName:@"YQPage"];
                tapGestureRecognizer.selectedFolitagPage.objectId = [firtViewControllerFolitagPageData objectForKey:@"objectId"];
                
                // From UserDefault
                NSString *imageURLSavedDataAsUserDefault = [firtViewControllerFolitagPageData objectForKey:@"imageURL"];
                
                
                if (imageURLSavedDataAsUserDefault) {
                    tapGestureRecognizer.selectedFolitagPage.imageURL = [[NSURL alloc] initWithString:imageURLSavedDataAsUserDefault]
                    ;
                }
            }
        }
        else {
            ///////////////////////
            // This page is not in the data based.
            // Create on Parse.com, but without imagebackground.
            ///////////////////////
            // Not Class method now.
            ///////////////////////
            YQParseObject *object = [YQParseObject objectWithClassName:@"YQPage"];
            [object setValue:currentViewControllerName forKey:@"viewControllerName"];
            [object setValue:folitagApp forKey:@"belongTo"];
            [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    tapGestureRecognizer.pageObjectId = object.objectId;
                    tapGestureRecognizer.selectedFolitagPage = [[LeaftaggerPage alloc] initWithYQParseObject:object];
                    [Leaftagger loadFolitagViewsFromCloud];
                }
            }];
        }
    }
}

+ (void)twoFingersOneTap:(LeaftaggerTapGestureRecognizer*)sender
{
    NSLog(@"Two Fingers One Tap");
    
    if (sender.pageObjectId) {
        if (![Leaftagger getFolitagView]) {
            NSLog(@"No View");
            
            // It's just to create a view to use.
            LeaftaggerView *view = [LeaftaggerView viewWithFolitagPage:sender.selectedFolitagPage];
            [Leaftagger setFolitagView:view];
            // [[UIApplication sharedApplication].keyWindow addSubview:view];
        }
        else {
            NSLog(@"has View");
            
            NSDictionary *pageData = @{@"selectedPage": sender.selectedFolitagPage};
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LeaftaggerHideOrShowViewNotification" object:self userInfo:pageData];
        }
    }

}


@end
