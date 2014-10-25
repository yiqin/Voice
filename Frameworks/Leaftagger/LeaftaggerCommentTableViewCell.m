//
//  CommentTableViewCell.m
//  Leaftagger-Demo
//
//  Created by yiqin on 9/6/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "LeaftaggerCommentTableViewCell.h"
#import "YQParse.h"
#import "LeaftaggerConstants.h"
#import "YQButton.h"

@interface LeaftaggerCommentTableViewCell ()

@property (nonatomic) float tableWidth;

@end

@implementation LeaftaggerCommentTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier tableWidth:(float)tableWidth
{
    self = [self initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.tableWidth = tableWidth;
        [self setSubViews];
    }
    return self;
}

- (void)setSubViews
{
    // Fake value of cellBackgroud (from super class)
    float width = self.frame.size.width;
    float height = self.frame.size.height;
    
    // Turning variables -> width
    UIViewAutoresizing backgroundAutoresizing =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.cellBackground = [[UIView alloc] initWithFrame:CGRectMake(15, 15, width-40, height)];
    self.cellBackground.autoresizingMask = backgroundAutoresizing;
    // self.cellBackground.layer.cornerRadius = 5.0;
    self.cellBackground.backgroundColor = [UIColor whiteColor];
    
    // Actual value of cellBackgroundWidth
    float cellBackgroundWidth = self.tableWidth;
    float labelMaxWidth = cellBackgroundWidth-30;
    
    // main address
    CGRect mainAddressLabelFrame = CGRectMake(0, 0, labelMaxWidth, 1000);
    
    self.betaUserNameLabel = [[YQLabelWithFixedWidth alloc] initWithFrame:mainAddressLabelFrame
                                                                    font:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15]
                                                                    text:@"main address"
                                                           textAlignment:NSTextAlignmentLeft];
    
    self.betaUserNameLabel.textColor = kLTRedColor;
    
    self.timeLabel = [[YQLabelWithFixedWidth alloc] initWithText:nil
                                                            textAlignment:NSTextAlignmentLeft
                                                                 fontSize:12
                                                      labelEstimatedWidth:labelMaxWidth
                                                             afterUILabel:self.betaUserNameLabel];
    self.timeLabel.textColor = kLTGreyColor;
    
    self.commentLabel = [[YQLabelWithFixedWidth alloc] initWithText:nil
                                                         textAlignment:NSTextAlignmentLeft
                                                              fontSize:15
                                                   labelEstimatedWidth:labelMaxWidth
                                                          afterUILabel:self.timeLabel];
    self.commentLabel.textColor = kLTTintColor;
    
    
    [self.cellBackground addSubview:self.betaUserNameLabel];
    [self.cellBackground addSubview:self.timeLabel];
    [self.cellBackground addSubview:self.commentLabel];
    [self addSubview:self.cellBackground];
    
    float widthButton = 50;
    self.likeButton = [[YQOneButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.commentLabel.frame)+20, widthButton, 20)];
    
    [ self.likeButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    
    [ self.likeButton setTitle:@"Like" forState:UIControlStateNormal];
    [ self.likeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
    [ self.likeButton addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview: self.likeButton];
    

}

- (void)loadComment:(LeaftaggerComment*) comment
{
    // init value
    [self.betaUserNameLabel setTextAndUpdateFrame: @""];
    
    NSString *strTemp = [NSString stringWithFormat:@"%@",comment.createdAt];
    NSString* zhong = [strTemp substringToIndex:19];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    NSDate *date1 = [dateFormat dateFromString:zhong];
    
    NSDateFormatter *outputDateFormatter = [[NSDateFormatter alloc] init];
    [outputDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [outputDateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"US/Eastern"]];
    NSString *data  = [NSString stringWithFormat:@"%@",[outputDateFormatter stringFromDate:date1]];
    
    
    // NSString *testDataString = [NSString stringWithFormat:@"%@", comment.createdAt];
    
    [self.timeLabel setTextAndUpdateFrame:data];
    
    self.timeLabel.frame = CGRectMake(CGRectGetMinX(self.timeLabel.frame), 19, CGRectGetWidth(self.timeLabel.frame), CGRectGetHeight(self.timeLabel.frame));
    ///////////////////////
    
    
    [self.commentLabel setTextAndUpdateFrame:comment.text];
    float widthButton = 50;
    self.likeButton.frame = CGRectMake(15, CGRectGetMaxY(self.commentLabel.frame)+20, widthButton, 20);
    
    YQParseQuery *query = [YQParseQuery queryWithClassName:@"YQBetaUser"];
    [query getObjectInBackgroundWithId:comment.betaUserObjectId block:^(YQParseObject *object, NSError *error) {
        if (!error) {
            LeaftaggerBetaUser *betaUser = [[LeaftaggerBetaUser alloc] initWithYQParseObject:object];
            
            [self.betaUserNameLabel setTextAndUpdateFrame: betaUser.username];
            // NSLog(@"%.2f", CGRectGetMaxY(self.betaUserNameLabel.frame));
            
            // Too dynamic
            

            
        }
    }];
    
    
}


- (void)createLikeButton
{
}


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (float)cellHeight:(LeaftaggerComment*) comment
{
    CGRect mainAddressLabelFrame = CGRectMake(0, 0, 289, 1000);
    YQLabelWithFixedWidth *commentLabel = [[YQLabelWithFixedWidth alloc] initWithFrame:mainAddressLabelFrame
                                                                                  font:[UIFont fontWithName:@"Helvetica Neue" size:15]
                                                                                  text:comment.text
                                                                         textAlignment:NSTextAlignmentLeft];
    [commentLabel setTextAndUpdateFrame:comment.text];
    
    return CGRectGetHeight(commentLabel.frame)+75+20;
}

@end
