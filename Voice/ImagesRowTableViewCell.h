//
//  ImagesRowTableViewCell.h
//  Voice
//
//  Created by yiqin on 10/24/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImagesRowTableViewCell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath;

@property (nonatomic) int rowNumber;

- (void) loadCell;
+ (float) cellHeight;

@end
