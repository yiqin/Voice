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


- (instancetype) initWithFrame:(CGRect)frame rowIndex:(int)rowIndex
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imagesCollectionData = [[VoiceImagesManager sharedInstance] fetchVoiceImagesWithRowIndex:rowIndex];
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = CGSizeMake(130, 130);
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [DeviceManager sharedInstance].screenWidth, 130) collectionViewLayout:flowLayout];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        
        self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.contentOffset = CGPointMake(60*(5%(rowIndex+1)),0);    // set contentOffset here
        
        UINib *nib = [UINib nibWithNibName:@"ImageCollectionViewCell" bundle:nil];
        [self.collectionView registerNib:nib
              forCellWithReuseIdentifier:@"ImageCell"];
        
        [self addSubview:self.collectionView];
    }
    return self;
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

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ImageCellIdentifier = @"ImageCell";
    VoiceImage *voiceImage = [self.imagesCollectionData objectAtIndex:indexPath.row];
    
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ImageCellIdentifier forIndexPath:indexPath];
    
    [cell.image setImage: voiceImage.image.image];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d x %ld", self.rowNumber, (long)indexPath.row);
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end