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
        self.view.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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






@end
