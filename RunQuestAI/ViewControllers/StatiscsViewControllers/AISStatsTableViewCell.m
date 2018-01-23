//
//  StatsTableViewCell.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 16.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "AISStatsTableViewCell.h"

static const CGFloat offsetX = 20;
static const CGFloat offsetY = 0;
static const CGFloat labelHeight = 40;

@implementation AISStatsTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        CGFloat labelWidth = self.contentView.frame.size.width;
        
        _runInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(offsetX, offsetY, labelWidth, labelHeight)];
        
        _distanceInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(offsetX, offsetY+labelHeight, labelWidth, labelHeight)];
        _distanceInfoLabel.textColor = [UIColor grayColor];
        
        [_runInfoLabel setFont:[UIFont fontWithName:@"Helvetica" size:18]];
        [_distanceInfoLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
        
        [self.contentView addSubview:_runInfoLabel];
        [self.contentView addSubview:_distanceInfoLabel];
    }
    return self;
}

@end
