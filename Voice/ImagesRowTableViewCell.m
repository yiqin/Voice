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
        self.rowIndex = indexPath.row;
        
        
        
    }
    return self;
}

- (void) setSubViews
{
    
    
}

- (void) loadCell
{
    NSLog(@"ImagesRowTableViewCell: %d", self.rowIndex);
    
    // Load images row scroll view here.
    
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
