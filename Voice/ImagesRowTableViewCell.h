//
//  ImagesRowTableViewCell.h
//  Voice
//
//  Created by yiqin on 10/24/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImagesRowScrollView.h"

@class DeviceManager;

@interface ImagesRowTableViewCell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath;

@property (nonatomic) int rowIndex;
@property (nonatomic, strong) ImagesRowScrollView *imagesRowScrollView;

- (void) loadCell;
+ (float) cellHeight;

@end
