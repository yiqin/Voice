//
//  LeaftaggerTapGestureRecognizer.h
//  Leaftagger-Demo
//
//  Created by yiqin on 9/6/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeaftaggerPage.h"

@interface LeaftaggerTapGestureRecognizer : UITapGestureRecognizer

@property(nonatomic, strong) LeaftaggerPage *selectedFolitagPage;
@property(nonatomic, strong) NSString *pageObjectId;

@end
