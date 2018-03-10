//
//  AISlabelPaceTableViewCell.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 10.03.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "AISlabelPaceTableViewCell.h"

@implementation AISlabelPaceTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _theTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 100, 30)];
        _theTextLabel.textColor = UIColor.blackColor;
        
        _paceInsectLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 30, 100, 30)];
        _paceInsectLabel.textColor = UIColor.blackColor;
        
        [self.contentView addSubview:_theTextLabel];
        [self.contentView addSubview:_paceInsectLabel];
    }
    return self;
}

@end
