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
#import "AISImageResizer.h"

static const double distanceToCompleteHelper = 50000.0;
static const double distanceToCompleteForRedSaber = 100000.0;
static const CGFloat YOffsetAllDistanceLabel = 80.0;
static const CGFloat allDistanceHeight = 40.0;

@interface AISLightSaberView()

@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIImageView *frontImageView;
@property (nonatomic, strong) UIImage *backImage;
@property (nonatomic, strong) UIImage *frontImage;
@property (nonatomic, strong) UILabel *allDistanceLabel;
@property (nonatomic, strong) NSNumber *allDistanceValue;
@property (nonatomic, strong) AISImageResizer *resizer;

@end

@implementation AISLightSaberView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        _allDistanceValue = [NSNumber numberWithDouble:[userDefaults doubleForKey:@"allDistance"]];
        
        if ([_allDistanceValue doubleValue] >= distanceToCompleteHelper)
        {
            _frontImage = [UIImage imageNamed:@"LightsaberRedIndicator"];
            _backImage = [UIImage imageNamed:@"LightsaberRedIndicator"];
        }
        else
        {
            _frontImage = [UIImage imageNamed:@"LightsaberBlueIndicator"];
            _backImage = [UIImage imageNamed:@"LightsaberBlueIndicator"];
        }
        
        _backImageView = [UIImageView new];
        _frontImageView = [UIImageView new];
        
        _backImageView.contentMode = UIViewContentModeLeft;
        _frontImageView.contentMode = UIViewContentModeLeft;
        
        _frontImageView.clipsToBounds = YES;
        _backImageView.clipsToBounds = YES;
    
        _allDistanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame)-YOffsetAllDistanceLabel, CGRectGetWidth(self.frame), allDistanceHeight)];
        
        _allDistanceLabel.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.1 alpha:1.0];
    
        _resizer = [AISImageResizer new];
        
        [self addSubview:_backImageView];
        [self addSubview:_frontImageView];
        
        [self addSubview:_allDistanceLabel];
    }
    return self;
}

-(void)indicatorFill: (double)portion
{
    UIImage *newBackImage = [self.resizer scaleImage:self.backImage proportionallyToSize:CGSizeMake(self.frame.size.width, self.frame.size.height)];
    UIImage *newFrontImage = [self.resizer scaleImage:self.frontImage proportionallyToSize:CGSizeMake(self.frame.size.width, self.frame.size.height)];

    self.backImageView.image = newBackImage;
    self.frontImageView.image = newFrontImage;
    
    CGRect portionFrame = CGRectMake(0, 0, self.frame.size.width * portion, self.frame.size.height);
    CGRect addFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.frontImageView.frame = portionFrame;
    self.backImageView.frame = addFrame;
    self.backImageView.alpha = 0.2;
    self.frontImageView.alpha = 0.9;
}

-(void)configureTheLightSaberView
{
    [self configureAllDistanceLabel];
    double coefficientForLightSaber = [self.allDistanceValue doubleValue] / distanceToCompleteHelper;
    
    if (coefficientForLightSaber > 1)
    {
        coefficientForLightSaber = [self.allDistanceValue doubleValue] / distanceToCompleteForRedSaber;
    }
    
    if (coefficientForLightSaber > 1)
    {
        coefficientForLightSaber = 1;
    }
    
    [self indicatorFill:coefficientForLightSaber];
}

-(void)configureAllDistanceLabel
{
    [self bringSubviewToFront:self.allDistanceLabel];
    self.allDistanceLabel.textAlignment = NSTextAlignmentCenter;

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    double allDistanceCopyHelper = [userDefaults doubleForKey:@"allDistance"];
    self.allDistanceValue = [NSNumber numberWithDouble:allDistanceCopyHelper];

    
    double actualDistanceToComplete;

    if ([self.allDistanceValue doubleValue] < distanceToCompleteHelper)
    {
        actualDistanceToComplete = distanceToCompleteHelper;
    }
    else
    {
        actualDistanceToComplete = distanceToCompleteForRedSaber;
    }
    
    NSString *allDistanceString = [NSString stringWithFormat:@"%@", [AISTranslationUnitsModel stringifyDistance:[self.allDistanceValue doubleValue]]];
    
    NSString *distanceToCompleteString = [NSString stringWithFormat:@"%@", [AISTranslationUnitsModel stringifyDistance:actualDistanceToComplete]];
    
    self.allDistanceLabel.text = [NSString stringWithFormat:@"%@ / %@", allDistanceString, distanceToCompleteString];
}

@end
