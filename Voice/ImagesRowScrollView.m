//
//  ImagesRowScrollView.m
//  Voice
//
//  Created by yiqin on 10/24/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "ImagesRowScrollView.h"
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
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 320, 320) collectionViewLayout:flowLayout];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        
        self.collectionView.showsHorizontalScrollIndicator = NO;
        
        
    }
    return self;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
