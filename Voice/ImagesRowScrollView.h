//
//  ImagesRowScrollView.h
//  Voice
//
//  Created by yiqin on 10/24/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StreetImage;
@class StreetImagesManager;

@protocol ImageViewCellDelegation
- (void) moveToSelectedStreetImage:(StreetImage *)streetImage;
@end

@interface ImagesRowScrollView : UIView <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic) int rowNumber;
@property (nonatomic, strong) NSArray *imagesCollectionData;
@property (nonatomic, strong) UICollectionView *collectionView;

- (void) loadCollectionImages:(NSIndexPath *)indexPath;

@property (nonatomic, strong) id<ImageViewCellDelegation> delegate;

@end
