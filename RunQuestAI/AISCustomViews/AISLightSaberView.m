//
//  AISLightSaberView.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 18.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "AISLightSaberView.h"
#import "AISUserDefaultsService.h"
#import "AISTranslationUnitsModel.h"

static double distanceToCompleteHelper = 100000.0;

@interface AISLightSaberView()

@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIImageView *frontImageView;
@property (nonatomic, strong) UIImage *backImage;
@property (nonatomic, strong) UIImage *frontImage;
@property (nonatomic, strong) UILabel *allDistanceLabel;
@property (nonatomic, strong) NSNumber *allDistanceValue;

@end

@implementation AISLightSaberView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _frontImage = [UIImage imageNamed:@"LightsaberBlueIndicator"];
        _backImage = [UIImage imageNamed:@"LightsaberBlueIndicator"];
        _backImageView = [[UIImageView alloc] initWithFrame:self.frame];
        _frontImageView = [[UIImageView alloc] initWithFrame:self.frame];
        _allDistanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame)-80, CGRectGetWidth(self.frame), 40)];
        _allDistanceLabel.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.1 alpha:1.0];
        _allDistanceValue = [NSNumber numberWithDouble:0.0];
        [self addSubview:_allDistanceLabel];
    }
    return self;
}

-(void)indicatorFill: (double)portion
{
    self.backImageView.image = self.backImage;
    self.frontImageView.image = self.frontImage;
    [self addSubview:self.backImageView];
    [self addSubview:self.frontImageView];
    CGRect portionFrame = CGRectMake(0, 0, self.frame.size.width * portion, self.frame.size.height);
    CGRect addFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.frontImageView.frame = portionFrame;
    self.backImageView.frame = addFrame;
    self.backImageView.alpha = 0.2;

}

-(void)configureTheLightSaberView
{
    [self configureAllDistanceLabel];
    double coefficientForLightSaber = [self.allDistanceValue doubleValue] / distanceToCompleteHelper;
    [self indicatorFill:coefficientForLightSaber];
}

-(void)configureAllDistanceLabel
{
    [self bringSubviewToFront:self.allDistanceLabel];
    self.allDistanceLabel.textAlignment = NSTextAlignmentCenter;

    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"%f",[userDefaults doubleForKey:@"allDistance"]);
    double allDistanceCopyHelper = [userDefaults doubleForKey:@"allDistance"];
    self.allDistanceValue = [NSNumber numberWithDouble:allDistanceCopyHelper];

    NSString *allDistanceString = [NSString stringWithFormat:@"%@", [AISTranslationUnitsModel stringifyDistance:[self.allDistanceValue doubleValue]]];
    NSString *distanceToCompleteString = [NSString stringWithFormat:@"%@", [AISTranslationUnitsModel stringifyDistance:distanceToCompleteHelper]];
    self.allDistanceLabel.text = [NSString stringWithFormat:@"%@ / %@", allDistanceString, distanceToCompleteString];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
