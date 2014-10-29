//
//  LeaftaggerCommentOptionsViewController.m
//  Leaftagger-Demo
//
//  Created by yiqin on 9/6/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "LeaftaggerCommentOptionsViewController.h"
#import "LeaftaggerAddCommentViewController.h"
#import "YQButton.h"
#import "LeaftaggerConstants.h"
#import "YQActivityIndicatorView.h"
#import "LeaftaggerReordVideoViewController.h"

#import "YO.h"

@interface LeaftaggerCommentOptionsViewController ()

@property (nonatomic, strong) UIView *backgroundView;
// @property (nonatomic, strong) YQRedButton *recordAVideoButton;

@end

@implementation LeaftaggerCommentOptionsViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

        
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
            /* Device is iPad */
            // Do nothing now.
            
        }
        else {
            [self addNavigationItems];
            [self createBackgroundView];
        }
    }
    return self;
}

- (instancetype)initWithFolitagPoint:(LeaftaggerPoint*)selectedPoint
{
    self = [self initWithNibName:nil bundle:nil];
    if (self) {
        self.currentPoint = selectedPoint;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)viewDidLayoutSubviews
{
    //////////////////////////////////
    // I don't why there is 0.5 offset
    //////////////////////////////////
    self.backgroundView.frame = CGRectMake(0.5, 0, CGRectGetWidth(self.view.frame)-1, CGRectGetHeight(self.view.frame));
    
    float width = 0;
    
    // float height = CGRectGetHeight(self.view.frame);
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
        /* Device is iPad */
        // Do nothing now.
        width = CGRectGetWidth(self.view.frame);
    }
    else {
        width = CGRectGetWidth(self.backgroundView.frame);
    }

    
    
    float widthButton = 284;
    
    UILabel *standardLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.5-widthButton*0.5, 10, widthButton, 45)];
    standardLabel.text = @"STANDARD COMMENT";
    standardLabel.textColor = kLTTintColor;
    standardLabel.textAlignment = NSTextAlignmentCenter;
    
    
    
    // 1
    YQOneButton *button3 = [[YQOneButton alloc] initWithFrame:CGRectMake(width*0.5-widthButton*0.5, 55, widthButton, 45)];
    [button3 setTitle:@"A Bug here" forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
    [button3 addTarget:self action:@selector(sendBugReport) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    YQTwoButton *button4 = [[YQTwoButton alloc] initWithFrame:CGRectMake(width*0.5-widthButton*0.5, 110, widthButton, 45)];
    [button4 setTitle:@"Change UI here" forState:UIControlStateNormal];
    [button4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
    [button4 addTarget:self action:@selector(sendChangeUIRequest) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    YQThreeButton *button5 = [[YQThreeButton alloc] initWithFrame:CGRectMake(width*0.5-widthButton*0.5, 165, widthButton, 45)];
    [button5 setTitle:@"This feature is confusing" forState:UIControlStateNormal];
    [button5 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
    [button5 addTarget:self action:@selector(askAboutFeature) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UILabel *customizedLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.5-widthButton*0.5, 220, widthButton, 45)];
    customizedLabel.text = @"CUSTOMIZED COMMENT";
    customizedLabel.textColor = kLTTintColor;
    
    customizedLabel.textAlignment = NSTextAlignmentCenter;
    
    
    YQFourButton *button2 = [[YQFourButton alloc] initWithFrame:CGRectMake(width*0.5-widthButton*0.5, 265, widthButton, 45)];
    [button2 setTitle:@"Write a Comment" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
    [button2 addTarget:self action:@selector(addCustomizedComment) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    YQFiveButton *button1 = [[YQFiveButton alloc] initWithFrame:CGRectMake(width*0.5-widthButton*0.5, 320, widthButton, 45)];
    [button1 setTitle:@"Record a Video" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
    [button1 addTarget:self action:@selector(moveToRecordVideoWebPage) forControlEvents:UIControlEventTouchUpInside];
    
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
        /* Device is iPad */
        // Do nothing now.
        [self.view addSubview:standardLabel];
        [self.view addSubview:button3];
        [self.view addSubview:button4];
        [self.view addSubview:button5];
        [self.view addSubview:customizedLabel];
        [self.view addSubview:button2];
        [self.view addSubview:button1];
    }
    else {
        [self.backgroundView addSubview:standardLabel];
        [self.backgroundView addSubview:button3];
        [self.backgroundView addSubview:button4];
        [self.backgroundView addSubview:button5];
        [self.backgroundView addSubview:customizedLabel];
        [self.backgroundView addSubview:button2];
        [self.backgroundView addSubview:button1];
    }
    

}

- (void)moveToRecordVideoWebPage
{
    /*
    // WebView
    LeaftaggerReordVideoViewController *recordVideoWebPage = [[LeaftaggerReordVideoViewController alloc] initWithNibName:nil bundle:nil];
    
    [self.navigationController pushViewController:recordVideoWebPage animated:YES];
    */
    
    NSURL *url = [NSURL URLWithString:@"https://leaftaggervideo.parseapp.com/"];
    
    if (![[UIApplication sharedApplication] openURL:url]) {
        NSLog(@"%@%@",@"Failed to open url:",[url description]);
    }
}

- (void)addCustomizedComment
{
    LeaftaggerAddCommentViewController *folitagAddCommentViewController = [[LeaftaggerAddCommentViewController alloc] initWithFolitagPoint:self.currentPoint];
    [self.navigationController pushViewController:folitagAddCommentViewController animated:YES];
}

- (void)addNavigationItems
{
    // Cancel Button
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                target:self
                                                                                action:@selector(cancelButtonTapped:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
}

- (void)cancelButtonTapped:(UIBarButtonItem *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LeaftaggerCloseFolitagCommentOptionsViewNotification" object:self userInfo:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createBackgroundView
{
    self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
    self.backgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.backgroundView];
}

- (void)sendBugReport
{
    [self saveCommentToCloudWithStandartComment:@"A bug here."];
}

- (void)sendChangeUIRequest
{
    [self saveCommentToCloudWithStandartComment:@"Change UI here"];
}

- (void)askAboutFeature
{
    [self saveCommentToCloudWithStandartComment:@"This feature is confusing."];
}

- (void)saveCommentToCloudWithStandartComment:(NSString *)commentString
{
    YQActivityIndicatorCenterSpinnerWithBackground *spinner = [[YQActivityIndicatorCenterSpinnerWithBackground alloc] initWithxCenterPostion:CGRectGetWidth(self.view.frame)/2.0 yCenterPosition:CGRectGetHeight(self.view.frame)/2.0];
    
    [self.view addSubview:spinner];
    [spinner startAnimating];
    
    LeaftaggerComment *testComment = [LeaftaggerComment objectWithClassName:@"YQComment"];
    [testComment setValue:self.currentPoint forKey:@"belongTo"];
    [testComment setValue:commentString forKey:@"text"];
    
    LeaftaggerBetaUser *tempBetaUser = [LeaftaggerBetaUser objectWithClassName:@"YQBetaUser"];
    
    NSArray *tempArray = @[@"ls10LfTPOC",
                           @"Y0cqNXnxnf"];
    int r = rand()%2;
    tempBetaUser.objectId = [tempArray objectAtIndex:r];
    
    [testComment setValue:tempBetaUser forKey:@"createdBy"];
    
    [testComment saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        [spinner stopAnimating];
        
        [YO sendYOToIndividualUser:@"YQ123456"];
        
        // Move back.
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LeaftaggerCloseFolitagAddCommentViewNotification" object:self userInfo:nil];
    }];
}


@end
