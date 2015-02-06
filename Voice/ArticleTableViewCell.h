//
//  ArticleTableViewCell.h
//  Voice
//
//  Created by yiqin on 10/24/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parse.h"
#import <ParseUI/PFImageView.h>
#import "SWTableViewCell.h"
#import "VoiceLabel.h"

@class Article;

@interface ArticleTableViewCell : SWTableViewCell

@property (nonatomic) CGFloat tableWidth;

@property (nonatomic, strong) PFImageView *briefImage;
@property (nonatomic, strong) VoiceLabel *title;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier tableWidth:(CGFloat)tableWidth;

- (void)loadCellFromArticle:(Article *)article;
+ (CGFloat)cellHeight;

@end
