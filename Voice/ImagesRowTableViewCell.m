//
//  ImagesRowTableViewCell.m
//  Voice
//
//  Created by yiqin on 10/24/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "ImagesRowTableViewCell.h"
#import <Voice-Swift.h>

@implementation ImagesRowTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor brownColor];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath
{
    self = [self initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSubViews];
        self.rowIndex = (int)indexPath.row;
        
    }
    return self;
}

- (void) setSubViews
{
    
}

/*!
 Load images into row scroll view.
 @param:  the coloumn index in the.
 */
- (void) loadCell:(NSIndexPath *)indexPath
{
    NSLog(@"ImagesRowTableViewCell: %d", self.rowIndex);
    
    // Load images row scroll view here.
    self.imagesRowScrollView = [[ImagesRowScrollView alloc] initWithFrame:CGRectMake(0, 0, [DeviceManager sharedInstance].screenWidth, 130) rowIndex:(int)indexPath.row];
    [self addSubview:self.imagesRowScrollView];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (float) cellHeight
{
    return 130;
}

@end
