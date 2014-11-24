//
//  ArticleTableViewCell.h
//  Voice
//
//  Created by yiqin on 10/24/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@class Article;

@interface ArticleTableViewCell : UITableViewCell

@property (nonatomic) CGFloat tableWidth;

@property (nonatomic, strong) PFImageView *briefImage;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *briefDescription;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier tableWidth:(CGFloat)tableWidth;

- (void)loadCellFromArticle:(Article *)article;
+ (CGFloat)cellHeight;

@end
