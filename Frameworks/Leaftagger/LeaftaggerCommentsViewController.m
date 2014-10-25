//
//  LeaftaggerCommentsViewController.m
//  Leaftagger-Demo
//
//  Created by yiqin on 9/6/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "LeaftaggerCommentsViewController.h"
#import "YQParse.h"
#import "LeaftaggerScreenManager.h"
#import "YQActivityIndicatorView.h"

#import "LeaftaggerConstants.h"

#import "LeaftaggerCommentTableViewCell.h"
#import "LeaftaggerCommentOptionsViewController.h"

@interface LeaftaggerCommentsViewController ()

@end

@implementation LeaftaggerCommentsViewController

- (instancetype)initWithFolitagPoint:(LeaftaggerPoint*)folitagPoint;
{
    self = [self initWithNibName:nil bundle:nil];
    if (self) {
        self.currentPoint = folitagPoint;
        [self loadCommentsFromCloudWithFolitagPoint:folitagPoint];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        // No color here.
        // self.view.backgroundColor = kLTCommentsBackgroundColor;
        
        self.commentsTableView = [[UITableView alloc] init];
        
        self.commentsTableView.separatorColor = [UIColor clearColor];
        
        self.commentsTableView.delegate = self;
        self.commentsTableView.dataSource = self;
        
        
        self.commentsArray = [[NSMutableArray alloc] init];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveNSNotification:)
                                                     name:@"LeaftaggerReloadCommentsTable"
                                                   object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Leaftagger";
    
    self.commentsTableViewController = [[UITableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    [self.commentsTableViewController setTableView:self.commentsTableView];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    self.commentsTableViewController.refreshControl = refreshControl;
    
    [self.view addSubview:self.commentsTableViewController.view];
    
    
    // Need a better image here.
    self.addCommentButton = [[YQButtonWithImage alloc] initWithFrame:CGRectMake(0, 0, 45, 45) image:@"LeaftaggerAddComment" selectedImage:@"LeaftaggerAddComment"];
    [self.addCommentButton addTarget:self action:@selector(tappedAddCommentButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    ///////////////////////
    // Need a beatiful logo    ---- I need a button here.
    ///////////////////////
    self.folitagWebButton = [[YQButtonWithImage alloc] initWithFrame:CGRectMake(0, 0, 45, 45) image:@"LeaftaggerLogo" selectedImage:@"LeaftaggerLogo"];
    [self.folitagWebButton addTarget:self action:@selector(tappedFolitagWebButton:) forControlEvents:UIControlEventTouchUpInside];
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
        /* Device is iPad */
        // Do nothing now.
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(movedToCommentOptionsPage)];
        rightButton.tintColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
        self.navigationItem.rightBarButtonItem = rightButton;
        
    }
    else {
        [self.view addSubview:self.addCommentButton];
        [self.view addSubview:self.folitagWebButton];
    }

}

- (void)viewDidLayoutSubviews
{
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
        /* Device is iPad */
        NSLog(@"width %.2f, height %.2f", self.view.frame.size.width, self.view.frame.size.height);
        self.commentsTableViewController.view.frame = CGRectMake(0.5, 5, self.view.frame.size.width-1, self.view.frame.size.height-40);
        self.addCommentButton.frame = CGRectMake(self.view.frame.size.width-50, self.view.frame.size.height-50, 45, 45);
        // self.folitagWebButton.frame = CGRectMake((self.view.frame.size.width-140)*0.5, 0, 140, 40);
    }
    else {
        NSLog(@"width %.2f, height %.2f", self.view.frame.size.width, self.view.frame.size.height);
        self.commentsTableViewController.view.frame = CGRectMake(0.5, 40, self.view.frame.size.width-1, self.view.frame.size.height-40);
        self.addCommentButton.frame = CGRectMake(self.view.frame.size.width-50, self.view.frame.size.height-50, 45, 45);
        self.folitagWebButton.frame = CGRectMake((self.view.frame.size.width-140)*0.5, 0, 140, 40);
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadCommentsFromCloudWithFolitagPoint:(LeaftaggerPoint*)folitagPoint
{
    // No Spinner Here
    // YQActivityIndicatorCenterSpinnerWithBackground *spinner = [[YQActivityIndicatorCenterSpinnerWithBackground alloc] initWithxCenterPostion:[LeaftaggerScreenManager getScreenWidth]/2.0 yCenterPosition:80/2.0];
    
    // [self.view addSubview:spinner];
    // [spinner startAnimating];
    
    YQParseQuery *query = [YQParseQuery queryWithClassName:@"YQComment"];
    [query whereKey:@"belongTo" equalTo:folitagPoint];
    
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            // [spinner stopAnimating];
            
            // Removed first then reload.
            [self.commentsArray removeAllObjects];
            
            for (YQParseObject *object in objects) {
                NSLog(@"%@", [object objectForKey:@"text"]);
                LeaftaggerComment *comment = [[LeaftaggerComment alloc] initWithYQParseObject:object];
                [self.commentsArray addObject:comment];
                
            }
            [self.commentsTableView reloadData];
        }
    }];
}

- (void)refresh:(id)sender
{
    // Load data from Cloud first
    [self loadCommentsFromCloudWithFolitagPoint:self.currentPoint];
    [(UIRefreshControl *)sender endRefreshing];
}

- (void)tappedAddCommentButton:(YQButtonWithParse*)sender
{
    NSLog(@"Tap Add Comment Button");
    [self.delegate tappedAddCommentButton];
}

- (void)tappedFolitagWebButton:(YQButtonWithImage*)sender
{
    NSLog(@"Tap Leaftagger Web Button");
    [self.delegate tappedFolitagWebButton];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if ([self.commentsArray count] > 0) {
        return [self.commentsArray count];
    }
    else {
        return 1;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.commentsArray count] > 0) {
        LeaftaggerComment *comment = [self.commentsArray objectAtIndex:indexPath.row];
        return [LeaftaggerCommentTableViewCell cellHeight:comment];
    }
    else {
        return 45;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"CommentCell";
    
    LeaftaggerCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[LeaftaggerCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier tableWidth:CGRectGetWidth(tableView.frame)];
    }
    
    if ([self.commentsArray count] > 0) {
        LeaftaggerComment *comment = [self.commentsArray objectAtIndex:indexPath.row];
        [cell loadComment:comment];

    }
    else {
        
        UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NoCallsCell"];
        cell.textLabel.text = @"No Comments";
        cell.textLabel.textColor = [UIColor colorWithRed:13.0/255.0 green:33.0/255.0 blue:5.0/255.0 alpha:1.0];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        return cell;
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - Notification Center
- (void)receiveNSNotification:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:@"LeaftaggerReloadCommentsTable"]) {
        
        
        [self loadCommentsFromCloudWithFolitagPoint:self.currentPoint];
    }
    
}

- (void)movedToCommentOptionsPage
{
    
    LeaftaggerCommentOptionsViewController *folitagCommentOptionsViewController = [[LeaftaggerCommentOptionsViewController alloc] initWithFolitagPoint:self.currentPoint];
    [self.navigationController pushViewController:folitagCommentOptionsViewController animated:YES];
}


@end
