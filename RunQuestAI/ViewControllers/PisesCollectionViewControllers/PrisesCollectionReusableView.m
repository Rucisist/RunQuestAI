//
//  PrisesCollectionReusableView.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 17.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "PrisesCollectionReusableView.h"

@implementation PrisesCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    NSLog(@"CASCollectionReusableView");
    self = [super initWithFrame:frame];
    if (self)
    {
        _lolLabel = [UILabel new];
        _lolLabel.textAlignment = NSTextAlignmentRight;
        _lolLabel.textColor = UIColor.whiteColor;
        _lolLabel.frame = CGRectMake(CGRectGetWidth(frame) - 200, 0, 200, 25);
        [self addSubview:_lolLabel];
    }
    return self;
}

@end
