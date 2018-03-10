//
//  AISgMapViewTableViewCell.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 10.03.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "AISgMapViewTableViewCell.h"

@implementation AISgMapViewTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _theText = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        _theText.textColor = UIColor.blackColor;
        
        [self.contentView addSubview:_mapView];
        [self.contentView addSubview:_theText];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
