//
//  LeaftaggerAddCommentNavigationViewController.m
//  Leaftagger-Demo
//
//  Created by yiqin on 9/6/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "LeaftaggerAddCommentNavigationViewController.h"
#import "LeaftaggerCommentOptionsViewController.h"
#import "LeaftaggerConstants.h"

@interface LeaftaggerAddCommentNavigationViewController ()

@end

@implementation LeaftaggerAddCommentNavigationViewController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFolitagPage:(LeaftaggerPoint*)selectedPoint
{
    LeaftaggerCommentOptionsViewController *folitagCommentOptionsViewController = [[LeaftaggerCommentOptionsViewController alloc] initWithFolitagPoint:selectedPoint];
    
    self = [self initWithRootViewController:folitagCommentOptionsViewController];
    if (self) {
        self.currentPoint = selectedPoint;
        
        // Something wrong here. The naviagtionBar background color.
        // I have to add a subview to indicate the difference.
        self.navigationBar.tintColor = kLTTintColor;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
