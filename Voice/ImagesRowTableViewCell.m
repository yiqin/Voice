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
        [self setSubViews];
        
    }
    return self;
}

- (void) setSubViews
{
    // NSLog(@"Set SubViews: %d", self.rowIndex);
    self.imagesRowScrollView = [[ImagesRowScrollView alloc] initWithFrame:CGRectMake(0, 0, [DeviceManager sharedInstance].screenWidth, 130)];
    
    // spend two hours to fix this bug....
    self.imagesRowScrollView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.imagesRowScrollView];
}

/*!
 Load images into row scroll view.
 @param:  the coloumn index in the.
 */
- (void) loadCell:(NSIndexPath *)indexPath
{
    NSLog(@"ImagesRowTableViewCell: %ld", (long)indexPath.row);
    
    // Load images row scroll view here.
    [self.imagesRowScrollView loadCollectionImages:indexPath];
    
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat) cellHeight
{
    return 130.0;
}

@end
