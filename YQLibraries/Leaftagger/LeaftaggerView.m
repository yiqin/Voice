//
//  LeaftaggerView.m
//  Leaftagger-Demo
//
//  Created by yiqin on 9/6/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "LeaftaggerView.h"
#import "YQButton.h"

#import "YQPopoverController.h"
#import "LeaftaggerCommentsViewController.h"
#import "LeaftaggerAddCommentNavigationViewController.h"
#import "LeaftaggeriPadNavigationViewController.h"

#import "LeaftaggerScreenManager.h"

#import "YQModalWebViewController.h"

#import "YQActivityIndicatorView.h"

@interface LeaftaggerView ()

@property (nonatomic) int pointsNumber;             // Be Cared
@property (nonatomic, strong) NSNumber *xPosition;  // Be Cared
@property (nonatomic, strong) NSNumber *yPosition;  // Be Cared

@property (nonatomic, strong) YQPopoverController *commentsPopoverController;
@property (nonatomic, strong) YQPopoverController *addCommentPopoverController;
@property (nonatomic, strong) YQPopoverController *folitagWebPopoverController;


@property (nonatomic, strong) UIPopoverController *iPadCommentsPopoverController;
@property (nonatomic, strong) UIPopoverController *iPadAddCommentPopoverController;
@property (nonatomic, strong) UIPopoverController *iPadFolitagWebPopoverController;


@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, strong) NSMutableArray *pointsAlreadyExitXPosition;
@property (nonatomic, strong) NSMutableArray *pointsAlreadyExitYPosition;

@end

@implementation LeaftaggerView


+ (instancetype)viewWithFolitagPage:(LeaftaggerPage*)selectedPage
{
    return [[self alloc] initWithFrame:CGRectMake(0, 0, [LeaftaggerScreenManager getScreenWidth], [LeaftaggerScreenManager getScreenHeight]) folitagPage:selectedPage];
}

+ (instancetype)view
{
    return [[self alloc] initWithFrame:CGRectMake(0, 0, [LeaftaggerScreenManager getScreenWidth], [LeaftaggerScreenManager getScreenHeight])];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveNSNotification:)
                                                     name:@"LeaftaggerHideOrShowViewNotification"
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveNSNotification:)
                                                     name:@"LeaftaggerCloseFolitagWebViewNotification"
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveNSNotification:)
                                                     name:@"LeaftaggerCloseFolitagCommentOptionsViewNotification"
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveNSNotification:) name:@"LeaftaggerCloseFolitagAddCommentViewNotification"
                                                   object:nil];
        
        self.pointsAlreadyExitXPosition = [[NSMutableArray alloc] init];
        self.pointsAlreadyExitYPosition = [[NSMutableArray alloc] init];
        
        self.backgroundView = [[UIView alloc] initWithFrame:frame];
        self.backgroundView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.7];
        [self addSubview:self.backgroundView];
        
        [self createTwoFingersTapGestureRecognizer];
        [self createdLongPressGestureRecognizer];
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame folitagPage:(LeaftaggerPage*)selectedPage
{
    self = [self initWithFrame:frame];
    if (self) {
        
        self.selectedPage = selectedPage;
        
        self.hidden = YES;
        [self hideOrShow];
        
        
    }
    return self;
}

- (void)createTwoFingersTapGestureRecognizer
{
    LeaftaggerTapGestureRecognizer *tapGestureRecognizer = [[LeaftaggerTapGestureRecognizer alloc] initWithTarget:self action:@selector(twoFingersOneTap:)];
    [self addGestureRecognizer:tapGestureRecognizer];
}

- (void)twoFingersOneTap:(UITapGestureRecognizer*)sender
{
    [self hideOrShow];
}

- (void)createdLongPressGestureRecognizer
{
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    // longPressGestureRecognizer.minimumPressDuration = 1.0f;
    longPressGestureRecognizer.allowableMovement = 50.0f;
    [self addGestureRecognizer:longPressGestureRecognizer];
}

- (void)handleLongPress:(UILongPressGestureRecognizer*)sender
{
    if (sender.state == UIGestureRecognizerStateEnded) {
        //Do Whatever You want on End of Gesture
        [self createCommentPoint:[sender locationInView:self]];
    }
    else if (sender.state == UIGestureRecognizerStateBegan){
        //Do Whatever You want on Began of Gesture
    }
}

- (void)createCommentPoint:(CGPoint)locationInView
{
    NSLog(@"Create ---- x: %.2f  y: %.2f", locationInView.x, locationInView.y);
    
    
    BOOL exit = NO;
    // check this point
    /*
    for (NSNumber *xPositionAlreadyExit in self.pointsAlreadyExitXPosition) {
        float tempXPositionAlreadyExit = [xPositionAlreadyExit floatValue];
        if (fabsf(tempXPositionAlreadyExit-locationInView.x)<100) {
            exit = YES;
        }
    }
    for (NSNumber *yPositionAlreadyExit in self.pointsAlreadyExitYPosition) {
        float tempYPositionAlreadyExit = [yPositionAlreadyExit floatValue];
        if (fabsf(tempYPositionAlreadyExit-locationInView.y)<100) {
            exit = YES;
        }
    }
    */
    //
    
    for (int i = 0; i < [self.pointsAlreadyExitXPosition count]; i++) {
        NSLog(@"X----%.2f", [[self.pointsAlreadyExitXPosition objectAtIndex:i] floatValue]);
        NSLog(@"Y----%.2f", [[self.pointsAlreadyExitYPosition objectAtIndex:i] floatValue]);
        
        
        float delta_x = [[self.pointsAlreadyExitXPosition objectAtIndex:i] floatValue] - locationInView.x;
        float delta_y = [[self.pointsAlreadyExitYPosition objectAtIndex:i] floatValue] - locationInView.y;
        
        NSLog(@"%.2f", delta_x);
        
        NSLog(@"%.2f", delta_x*delta_x+delta_y*delta_y);
        
        if (delta_x*delta_x+delta_y*delta_y<40.0*40.0) {
            exit = YES;
            
        }
        
    }
    
    if (!exit) {
        self.xPosition = [NSNumber numberWithFloat:locationInView.x/[LeaftaggerScreenManager getScreenWidth]];
        self.yPosition = [NSNumber numberWithFloat:locationInView.y/[LeaftaggerScreenManager getScreenHeight]];
        
       //  NSString *tempImageName = @"YQNumbers-00";
        
        NSString *tempImageName = [[NSString alloc] init];
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
            /* Device is iPad */
            tempImageName = @"iPadYQNumbers-00";
        }
        else {
            /* Device is iPhone */
            tempImageName = @"YQNumbers-00";
        }
        
        YQButtonWithParse *tempButton = [[YQButtonWithParse alloc] initWithCenterPoin:locationInView imageSize:CGSizeMake(45, 45) image:tempImageName selectedImage:tempImageName];
        tempButton.hasAnimation = YES;
        
        
        // replot many tempButtons
        [self.backgroundView addSubview:tempButton];
        
        [self saveNewPointToCloud];
    }

}

- (void)saveNewPointToCloud
{
    LeaftaggerPoint *newPoint = [LeaftaggerPoint objectWithClassName:@"YQPoint"];
    [newPoint setValue:[NSNumber numberWithInt:self.pointsNumber+1] forKey:@"imageNumber"];
    
    // CLoud xPosition and yPosition is 0 ~ 1.
    
    [newPoint setValue:self.xPosition forKey:@"xPosition"];
    [newPoint setValue:self.yPosition forKey:@"yPosition"];
    
    [newPoint setValue:self.selectedPage forKey:@"belongTo"];
    
    [newPoint saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        self.pointsNumber++;
        NSLog(@"objectId - %@", newPoint.objectId);
        
        // It maybe no need to reload again.
        [self loadPointsFromCloud];
        
    }];
}

- (void)hideOrShow
{
    self.hidden = !self.hidden;
    
    /////////////////////////
    // Load points from cloud everytime when the view is show.
    // I know it's not the best way to do it.
    /////////////////////////
    if (!self.hidden) {
        [self loadPointsFromCloud];
        
        [self addSubview:self.backgroundView];
        [self insertSubview:self.selectedPage.screenshotImageView belowSubview:self.backgroundView];
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
    else {
        // Hide LeaftaggerView
        for (YQLeaftaggerPointButton *image in self.backgroundView.subviews) {
            [image removeFromSuperview];
        }
        [self.selectedPage.screenshotImageView removeFromSuperview];
        [self.backgroundView removeFromSuperview];
        [self removeFromSuperview];
    }
}

- (void)loadPointsFromCloud
{
    YQActivityIndicatorCenterSpinnerWithBackground *spinner = [[YQActivityIndicatorCenterSpinnerWithBackground alloc] initWithxCenterPostion:[LeaftaggerScreenManager getScreenWidth]*0.5 yCenterPosition:[LeaftaggerScreenManager getScreenHeight]*0.5];
    [self.backgroundView addSubview:spinner];
    
    [spinner startAnimating];
    
    YQParseQuery *query = [YQParseQuery queryWithClassName:@"YQPoint"];
    [query whereKey:@"belongTo" equalTo:self.selectedPage];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            [spinner stopAnimating];
            
            self.pointsNumber = [objects count];
            
            [self.pointsAlreadyExitXPosition removeAllObjects];
            [self.pointsAlreadyExitYPosition removeAllObjects];
            
            for (YQParseObject *object in objects) {
                LeaftaggerPoint *folitagPoint = [[LeaftaggerPoint alloc] initWithYQParseObject:object];
                [folitagPoint.image addTarget:self action:@selector(tappedFolitagPoint:) forControlEvents:UIControlEventTouchUpInside];
                
                NSLog(@"%i", folitagPoint.imageNumber);
                [self.backgroundView addSubview:folitagPoint.image];
                
                [self.pointsAlreadyExitXPosition addObject:[NSNumber numberWithFloat:folitagPoint.xPosition*[LeaftaggerScreenManager getScreenWidth]]];
                
                [self.pointsAlreadyExitYPosition addObject:[NSNumber numberWithFloat:folitagPoint.yPosition*[LeaftaggerScreenManager getScreenWidth]]];
                
                /////////////////////////////////////////////////////////////
                // Will cover previous buttons that is not removed actually.
                // Plot again and agian.
                // Why it's such slow ????????
                /////////////////////////////////////////////////////////////
            }
        }
    }];
}

- (void)tappedFolitagPoint:(YQButtonWithParse*)sender
{
    //////////////////////////////////
    // SelectedPoint only has objectId, as we have a button on it.
    //////////////////////////////////
    self.selectedPoint = [LeaftaggerPoint objectWithClassName:@"YQPoint"];
    self.selectedPoint.objectId = sender.objectId;
    
    [self plotCommentPopover:sender.frame withPoint:(LeaftaggerPoint*)self.selectedPoint];
}

- (void)plotCommentPopover:(CGRect)frame withPoint:(LeaftaggerPoint*)selectedFolitagPoint
{
    
    
    // To be optimized
    ///////////////////////
    ///// Why PopoverController must be here?
    ///// Very unstable
    ///////////////////////
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
        /* Device is iPad */
        LeaftaggeriPadNavigationViewController *leaftaggeriPadNavigationViewController = [[LeaftaggeriPadNavigationViewController alloc] initWithFolitagPage:selectedFolitagPoint];
        
        self.iPadCommentsPopoverController = [[UIPopoverController alloc] initWithContentViewController:leaftaggeriPadNavigationViewController];
        self.iPadCommentsPopoverController.popoverContentSize = CGSizeMake(320, 500);
        
        [self.iPadCommentsPopoverController presentPopoverFromRect:frame
                                                            inView:self
                                          permittedArrowDirections:UIPopoverArrowDirectionAny
                                                          animated:YES];
        
        
    }
    else {
        /* Device is iPhone */
        LeaftaggerCommentsViewController *commentsViewController = [[LeaftaggerCommentsViewController alloc] initWithFolitagPoint:selectedFolitagPoint];
        
        commentsViewController.delegate = self;
        
        
        self.commentsPopoverController = [[YQPopoverController alloc] initWithContentViewController:commentsViewController];
        // self.commentsPopoverController.delegate = self;
        
        [self.commentsPopoverController presentPopoverFromRect:frame
                                                        inView:self
                                      permittedArrowDirections:YQPopoverArrowDirectionDown|YQPopoverArrowDirectionUp
                                                      animated:YES
                                                       options:YQPopoverAnimationOptionFadeWithScale];
        
    }
    

    
    
    
    
}

#pragma mark - Notification Center
- (void)receiveNSNotification:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:@"LeaftaggerHideOrShowViewNotification"]) {
        NSDictionary *pageData = [notification userInfo];
        self.selectedPage = [pageData objectForKey:@"selectedPage"];
        [self hideOrShow];
    }
    else if ([[notification name] isEqualToString:@"LeaftaggerCloseFolitagWebViewNotification"]) {
        [self closeFolitagWebPopoverController];
    }
    else if ([[notification name] isEqualToString:@"LeaftaggerCloseFolitagCommentOptionsViewNotification"]) {
        [self closeAddCommentPopoverController];
    }
    else if ([[notification name] isEqualToString:@"LeaftaggerCloseFolitagAddCommentViewNotification"]) {
        [self reloadFolitagCommentsTableView];
        [self closeAddCommentPopoverController];
    }
        
}

#pragma mark - Comment View Controller Delegate
- (void)tappedAddCommentButton
{

    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
        /* Device is iPad */
        // Do nothing now.
    }
    else {
        LeaftaggerAddCommentNavigationViewController *folitagAddCommentNavigationViewController = [[LeaftaggerAddCommentNavigationViewController alloc] initWithFolitagPage:self.selectedPoint];
        
        self.addCommentPopoverController = [[YQPopoverController alloc] initWithContentViewController:folitagAddCommentNavigationViewController];
        
        // there is bug here.
        
        [self.addCommentPopoverController presentPopoverAsDialogAnimated:YES
                                                              completion:^{
                                                                  // Code executed after popover presentation animation sequence ends
                                                              }];
    }

}

- (void)tappedFolitagWebButton
{
    YQModalWebViewController *webViewController = [[YQModalWebViewController alloc] initWithAddress:@"http://www.leaftagger.com"];
    
    
    self.folitagWebPopoverController = [[YQPopoverController alloc] initWithContentViewController:webViewController];
    [self.folitagWebPopoverController presentPopoverAsDialogAnimated:YES
                                                          completion:^{
                                                              // Code executed after popover presentation animation sequence ends
                                                          }];
}

- (void)closeAddCommentPopoverController
{
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
        /* Device is iPad */
        // Do nothing now.
        [self.iPadCommentsPopoverController dismissPopoverAnimated:YES];
    }
    else {
        
        [self.addCommentPopoverController dismissPopoverAnimated:YES completion:^{
           // Do something
            
        }];
    }
}

- (void)closeFolitagWebPopoverController
{
    [self.folitagWebPopoverController dismissPopoverAnimated:YES completion:^{
        // Do something
        
    }];
}

- (void)reloadFolitagCommentsTableView
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LeaftaggerReloadCommentsTable" object:self userInfo:nil];
}

@end
