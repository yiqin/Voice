//
//  CardsViewController.m
//  Voice
//
//  Created by Yi Qin on 2/18/15.
//  Copyright (c) 2015 yiqin. All rights reserved.
//
#define TAG 99

#import "CardsViewController.h"
#import "RGCollectionViewCell.h"
#import "Voice-Swift.h"

@interface CardsViewController ()<UICollectionViewDataSource>

@end

@implementation CardsViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.view.backgroundColor = [UIColor blackColor];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    tempImageView.image = [UIImage imageNamed:@"background"];
    tempImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.cardsCollectionView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    self.cardsCollectionView.opaque = NO;
    [self.view insertSubview:tempImageView atIndex:0];
    self.view.backgroundColor = [UIColor yellowColor];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return  [SessionsManager sharedInstance].sessions.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RGCollectionViewCell *cell = (RGCollectionViewCell  *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CardReuse" forIndexPath:indexPath];
    [self configureCell:cell withIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(RGCollectionViewCell *)cell withIndexPath:(NSIndexPath *)indexPath
{
    // UIView  *subview = [cell.contentView viewWithTag:TAG];
    // [subview removeFromSuperview];
    
    NSLog(@"%li", (long)indexPath.section);
    
    if ([SessionsManager sharedInstance].sessions.count > indexPath.section) {
        Session *session = [[SessionsManager sharedInstance].sessions objectAtIndex:indexPath.section];
        NSLog(@"%@", session.title);
        
        cell.sessionImageView.image = session.image;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([SessionsManager sharedInstance].sessions.count > indexPath.section) {
        Session *session = [[SessionsManager sharedInstance].sessions objectAtIndex:indexPath.section];
        NSLog(@"%@", session.title);
        
        NSArray *tempArray = session.articles;
        Article *tempArticle = [tempArray objectAtIndex:0];
        
        NSLog(@"You clicked the collection view:  %li", (long)indexPath.section);
        ArticleDetailViewController *temp = [[ArticleDetailViewController alloc] initWithNibName:nil bundle:nil article:tempArticle];
        
        UINavigationController *tempNavigationController = [[UINavigationController alloc] initWithRootViewController:temp];
        
        
        [self presentViewController:tempNavigationController animated:YES completion:^{
            
        }];
    }
    
}


@end
