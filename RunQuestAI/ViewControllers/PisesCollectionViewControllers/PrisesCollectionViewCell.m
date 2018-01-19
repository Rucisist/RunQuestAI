//
//  PrisesCollectionViewCell.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 17.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "PrisesCollectionViewCell.h"

@implementation PrisesCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    NSLog(@"CASCollectionViewCell");
    self = [super initWithFrame:frame];
    if (self)
    {
        _textLabel = [UILabel new];
        _textLabel.frame = CGRectMake(0, 0, CGRectGetWidth(frame), 25);
        _textLabel.textColor = [UIColor grayColor];
        
        _priseImage = [UIImageView new];
        _priseImage.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
        _priseImage.alpha = 0.3;
        
        [self.contentView addSubview:_textLabel];
        [self.contentView addSubview:_priseImage];
    }
    return self;
}

@end
