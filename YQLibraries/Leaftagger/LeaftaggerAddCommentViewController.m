//
//  LeaftaggerAddCommentViewController.m
//  Leaftagger-Demo
//
//  Created by yiqin on 9/6/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "LeaftaggerAddCommentViewController.h"
#import "YQActivityIndicatorView.h"
#import "LeaftaggerConstants.h"
#import "LeaftaggerBetaUser.h"

@interface LeaftaggerAddCommentViewController ()

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UITextView *customizedComment;
@property (nonatomic, strong) UITextView *betaUsernameComment;

@end

@implementation LeaftaggerAddCommentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self addNavigationItems];
        
        [self createBackgroundView];
        [self createCustomizedCommentTextField];
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
    
    // User Default
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    self.backgroundView.frame = CGRectMake(0.5, 0, CGRectGetWidth(self.view.frame)-1, CGRectGetHeight(self.view.frame));
    self.customizedComment.frame = CGRectMake(5, 45, CGRectGetWidth(self.view.frame)-10, 170);
    self.betaUsernameComment.frame = CGRectMake(5, 5, CGRectGetWidth(self.view.frame)-10, 35);
}

- (void)addNavigationItems
{
    // Save Button
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                target:self
                                                                                action:@selector(saveButtonTapped:)];
    self.navigationItem.rightBarButtonItem = saveButton;
    self.navigationItem.rightBarButtonItem.enabled = YES;
}

- (void)saveButtonTapped:(UIBarButtonItem *)sender
{
    if ([self.customizedComment.text length]>0) {
        if (![self.customizedComment.text isEqualToString:@"Tell us what you think of the app."]) {
            self.navigationItem.rightBarButtonItem.enabled = NO;
            [self saveCommentToCloud];
        }
    }
}

- (void)saveCommentToCloud
{
    YQActivityIndicatorCenterSpinnerWithBackground *spinner = [[YQActivityIndicatorCenterSpinnerWithBackground alloc] initWithxCenterPostion:CGRectGetWidth(self.view.frame)/2.0 yCenterPosition:CGRectGetHeight(self.view.frame)/2.0];
    
    [self.view addSubview:spinner];
    [spinner startAnimating];
    
    LeaftaggerComment *testComment = [LeaftaggerComment objectWithClassName:@"YQComment"];
    [testComment setValue:self.currentPoint forKey:@"belongTo"];
    [testComment setValue:self.customizedComment.text forKey:@"text"];
    
    
    if ([self.betaUsernameComment.text length]>0) {
        if (![self.betaUsernameComment.text isEqualToString:@"Your name"]) {
            
            
            LeaftaggerBetaUser *tempBetaUser = [LeaftaggerBetaUser objectWithClassName:@"YQBetaUser"];
            tempBetaUser.username = self.betaUsernameComment.text;
            [tempBetaUser setValue:self.betaUsernameComment.text forKey:@"username"];
            
            [tempBetaUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    
                    [testComment setValue:tempBetaUser forKey:@"createdBy"];
                    
                    [testComment saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                        
                        [spinner stopAnimating];
                        
                        // Move back.
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"LeaftaggerCloseFolitagAddCommentViewNotification" object:self userInfo:nil];
                    }];
                    
                }
            }];
            
            
            
        }
    }
    else {
        LeaftaggerBetaUser *tempBetaUser = [LeaftaggerBetaUser objectWithClassName:@"YQBetaUser"];
        
        NSArray *tempArray = @[@"GZXuP33aC4",
                               @"du4xi0tcM3",
                               @"3qR4MLSz89",
                               @"ipR1jjltxR",
                               @"Jp577Sch2A",
                               @"FMFN94prPw",
                               @"PRTL1R4t4a",
                               @"ls10LfTPOC",
                               @"Y0cqNXnxnf"];
        int r = rand()%9;
        
        tempBetaUser.objectId = [tempArray objectAtIndex:r];
        
        [testComment setValue:tempBetaUser forKey:@"createdBy"];
        
        [testComment saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            
            [spinner stopAnimating];
            
            // Move back.
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LeaftaggerCloseFolitagAddCommentViewNotification" object:self userInfo:nil];
        }];
    }
    
    
}

- (void)createBackgroundView
{
    self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
    self.backgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.backgroundView];
}

- (void)createCustomizedCommentTextField
{
    self.customizedComment = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 45, 45)]; // fake frame value
    self.customizedComment.font = [UIFont fontWithName:@"ArialMT" size:20];
    self.customizedComment.backgroundColor = [UIColor whiteColor];
    self.customizedComment.layer.borderWidth = .5f;
    self.customizedComment.layer.borderColor = kLTGreyColor.CGColor;
    self.customizedComment.layer.cornerRadius = 6.0f;
    
    self.customizedComment.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
    
    self.customizedComment.text = @"Tell us what you think of the app.";
    self.customizedComment.textColor = [UIColor lightGrayColor];
    
    self.customizedComment.delegate = self;
    self.customizedComment.tag = 0;
    
    [self.backgroundView addSubview: self.customizedComment];
    
    
    
    
    
    self.betaUsernameComment = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 45, 45)]; // fake frame value
    self.betaUsernameComment.font = [UIFont fontWithName:@"ArialMT" size:20];
    self.betaUsernameComment.backgroundColor = [UIColor whiteColor];
    self.betaUsernameComment.layer.borderWidth = .5f;
    self.betaUsernameComment.layer.borderColor = kLTGreyColor.CGColor;
    self.betaUsernameComment.layer.cornerRadius = 6.0f;
    
    self.betaUsernameComment.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
    
    self.betaUsernameComment.text = @"Your name";
    self.betaUsernameComment.textColor = [UIColor lightGrayColor];
    
    self.betaUsernameComment.delegate = self;
    self.betaUsernameComment.tag = 1;
    
    [self.backgroundView addSubview: self.betaUsernameComment];
    
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView.tag == 0) {
        if ([textView.text isEqualToString:@"Tell us what you think of the app."]) {
            textView.text = @"";
            textView.textColor = [UIColor blackColor]; //optional
        }
        [textView becomeFirstResponder];
    }
    else if (textView.tag == 1) {
        if ([textView.text isEqualToString:@"Your name"]) {
            textView.text = @"";
            textView.textColor = [UIColor blackColor]; //optional
        }
        [textView becomeFirstResponder];
    }
    
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.tag == 0) {
        if ([textView.text isEqualToString:@""]) {
            textView.text = @"Tell us what you think of the app.";
            textView.textColor = [UIColor lightGrayColor]; //optional
        }
        [textView resignFirstResponder];
    }
    else if (textView.tag == 1) {
        if ([textView.text isEqualToString:@""]) {
            textView.text = @"Your name";
            textView.textColor = [UIColor lightGrayColor]; //optional
        }
        [textView resignFirstResponder];
    }

}

@end
