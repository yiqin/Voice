//
//  ImagesRowScrollView.m
//  Voice
//
//  Created by yiqin on 10/24/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "ImagesRowScrollView.h"
#import "ImageCollectionViewCell.h"
#import <Parse/Parse.h>
#import <Voice-Swift.h>

@implementation ImagesRowScrollView


- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = CGSizeMake(125, 125);
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [DeviceManager sharedInstance].screenWidth, 130) collectionViewLayout:flowLayout];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        
        self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.backgroundColor = [UIColor blackColor];
                
        // int r = rand() % 8;
        // self.collectionView.contentOffset = CGPointMake(60*(5%(r+1)),0);    // set contentOffset here
        
        UINib *nib = [UINib nibWithNibName:@"ImageCollectionViewCell" bundle:nil];
        [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"ImageCell"];
        
        [self addSubview:self.collectionView];
    }
    return self;
}

- (void) loadCollectionImages:(NSIndexPath *)indexPath
{
    self.rowNumber = indexPath.row;
    
    self.imagesCollectionData = [[StreetImagesManager sharedInstance] fetchStreetImagesWithRowIndex:indexPath.row];
    
    // NSLog(@"%f", [[StreetImagesManager sharedInstance] getCollectionContentOffset:indexPath.row]);
    
    
    [self.collectionView setContentOffset:CGPointMake([[StreetImagesManager sharedInstance] getCollectionContentOffset:self.rowNumber],0) animated:NO];
    
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource methods
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.imagesCollectionData count];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // NSLog(@"%f", scrollView.contentOffset.x);
    
    [[StreetImagesManager sharedInstance] setCollectionContentOffset:self.rowNumber offset:scrollView.contentOffset.x];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ImageCellIdentifier = @"ImageCell";
    StreetImage *streetImage = [self.imagesCollectionData objectAtIndex:indexPath.row];
    
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ImageCellIdentifier forIndexPath:indexPath];
    
    [cell.imageView setImage: streetImage.image.image];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d x %ld", self.rowNumber, (long)indexPath.row);
    
    // a delegate to MainViewController
    StreetImage *streetImage = [self.imagesCollectionData objectAtIndex:indexPath.row];
    [self.delegate moveToSelectedStreetImage:streetImage];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
