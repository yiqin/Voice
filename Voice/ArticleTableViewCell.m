//
//  ArticleTableViewCell.m
//  Voice
//
//  Created by yiqin on 10/24/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "ArticleTableViewCell.h"
#import <Voice-Swift.h>

@implementation ArticleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier tableWidth:(CGFloat)tableWidth
{
    self = [self initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.tableWidth = tableWidth;
        [self setSubViews];
    }
    return self;
}

- (void) setSubViews
{
    self.cellScrollView.backgroundColor = [UIColor colorWithRed:150.0/255.0 green:29.0/255.0 blue:56.0/255.0 alpha:1.0];
    self.title = [[UILabel alloc] initWithFrame:CGRectMake(130, 10, self.tableWidth-140, 15)];
    self.title.textColor = [UIColor whiteColor];
    self.briefDescription = [[UILabel alloc] initWithFrame:CGRectMake(130, 30, self.tableWidth-140, 80)];
    self.briefDescription.textColor = [UIColor whiteColor];
    self.briefDescription.numberOfLines = 0;
    
    
    self.briefImage = [[PFImageView alloc] initWithFrame:CGRectMake(5, 5, 120, 120)];
    self.briefImage.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.cellScrollView addSubview:self.title];
    [self.cellScrollView addSubview:self.briefDescription];
    [self.cellScrollView addSubview:self.briefImage];
    
    UIView *seperateLine = [[UIView alloc] initWithFrame:CGRectMake(0, 129, 500, 0.5)];
    seperateLine.backgroundColor = [UIColor whiteColor];
    [self addSubview:seperateLine];
}

- (void) loadCellFromArticle:(Article *)article
{
    self.title.text = article.title;
    self.briefDescription.text = article.briefDescription;
    
    if (!article.isFirstLoad) {
        self.briefImage.image = article.briefImage.image;
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat) cellHeight
{
    return 130;
}

@end
