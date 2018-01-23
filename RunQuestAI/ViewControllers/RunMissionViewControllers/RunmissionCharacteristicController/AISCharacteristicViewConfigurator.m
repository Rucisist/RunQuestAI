//
//  AISCharacteristicViewConfigurator.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 23.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "AISCharacteristicViewConfigurator.h"

static const CGFloat paceTimeDTAlabelHeight = 50;
static const CGFloat pauseButtonDiameter = 100;
static const CGFloat pauseButtonSpaceFromCenter = 100;

@interface AISCharacteristicViewConfigurator()

@end

@implementation AISCharacteristicViewConfigurator

-(instancetype) init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)configurePaceLabel
{
    CGFloat screenHeight = CGRectGetHeight(self.delegate.view.frame);
    CGFloat paceLabelHeight = paceTimeDTAlabelHeight;
    CGFloat screenWidth = CGRectGetWidth(self.delegate.view.frame);
    
    CGRect paceLabelRect = CGRectMake(0, screenHeight / 2, screenWidth / 2, paceLabelHeight);
    self.delegate.paceLabel = [[UILabel alloc] initWithFrame:paceLabelRect];
    
    self.delegate.paceLabel.numberOfLines = 2;
    
    self.delegate.paceLabel.textAlignment = NSTextAlignmentCenter;
    
    self.delegate.paceLabel.textColor = [UIColor whiteColor];
    
    [self.delegate.paceLabel setFont:[UIFont fontWithName:@"Helvetica" size:20]];
    
    [self.delegate.view addSubview:self.delegate.paceLabel];
}

-(void)configureTimeLabel
{
    CGFloat screenHeight = CGRectGetHeight(self.delegate.view.frame);
    CGFloat screenWidth = CGRectGetWidth(self.delegate.view.frame);
    CGFloat timeLabelHeight = paceTimeDTAlabelHeight;
    
    CGRect timeLabelRect = CGRectMake(screenWidth/2, screenHeight / 2, screenWidth / 2, timeLabelHeight);
    self.delegate.timeLabel = [[UILabel alloc] initWithFrame:timeLabelRect];
    
    self.delegate.timeLabel.numberOfLines = 2;
    
    self.delegate.timeLabel.textAlignment = NSTextAlignmentCenter;
    
    self.delegate.timeLabel.text = @"0";
    
    self.delegate.timeLabel.textColor = [UIColor whiteColor];
    
    [self.delegate.timeLabel setFont:[UIFont fontWithName:@"Helvetica" size:20]];
    
    [self.delegate.view addSubview:self.delegate.timeLabel];
}

-(void)configureDistanceToAimLabel
{
    CGFloat screenHeight = CGRectGetHeight(self.delegate.view.frame);
    CGFloat screenWidth = CGRectGetWidth(self.delegate.view.frame);
    CGFloat DTALabelHeigth = paceTimeDTAlabelHeight;
    
    CGRect DTARect = CGRectMake(0, screenHeight / 2 - 140, screenWidth, DTALabelHeigth *3);
    
    self.delegate.distanceToAimLabel = [[UILabel alloc] initWithFrame:DTARect];
    
    self.delegate.distanceToAimLabel.textAlignment = NSTextAlignmentCenter;
    
    self.delegate.distanceToAimLabel.numberOfLines = 2;
    
    self.delegate.distanceToAimLabel.textColor = [UIColor whiteColor];
    
    [self.delegate.distanceToAimLabel setFont:[UIFont fontWithName:@"Helvetica" size:38]];
    
    [self.delegate.view addSubview:self.delegate.distanceToAimLabel];
}

-(void)configurePauseButton
{
    CGFloat screenHeight = CGRectGetHeight(self.delegate.view.frame);
    CGFloat screenWidth = CGRectGetWidth(self.delegate.view.frame);
    
    CGRect pauseButtonRect = CGRectMake(screenWidth / 2 - pauseButtonDiameter / 2, screenHeight / 2 + pauseButtonSpaceFromCenter, pauseButtonDiameter, pauseButtonDiameter);
    
    self.delegate.pauseButton = [[UIButton alloc] initWithFrame:pauseButtonRect];
    
    [self.delegate.pauseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.delegate.pauseButton setTitle:@"||" forState:UIControlStateNormal];
    
    self.delegate.pauseButton.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0 alpha:0.7];
    self.delegate.pauseButton.layer.cornerRadius = 23;
    
    [self.delegate.pauseButton addTarget:self action:@selector(animationForPauseButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.delegate.view addSubview:self.delegate.pauseButton];
}


-(void)configureStopButton
{
    CGFloat screenHeight = CGRectGetHeight(self.delegate.view.frame);
    CGFloat screenWidth = CGRectGetWidth(self.delegate.view.frame);
    
    CGRect stopButtonRect = CGRectMake(screenWidth / 2 - pauseButtonDiameter / 2, screenHeight / 2 + pauseButtonSpaceFromCenter, pauseButtonDiameter / 2, pauseButtonDiameter);
    
    self.delegate.stopButton = [[UIButton alloc] initWithFrame:stopButtonRect];
    
    [self.delegate.stopButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.delegate.stopButton setTitle:@"Stop" forState:UIControlStateNormal];
    
    self.delegate.stopButton.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0 alpha:0.7];
    self.delegate.stopButton.layer.cornerRadius = 23;
    
    self.delegate.stopButton.hidden = YES;
    
    self.delegate.stopButton.layer.affineTransform = CGAffineTransformMakeRotation(M_PI);
    
    [self.delegate.view addSubview:self.delegate.stopButton];
    
}

-(void)configureResumeButton
{
    CGFloat screenHeight = CGRectGetHeight(self.delegate.view.frame);
    CGFloat screenWidth = CGRectGetWidth(self.delegate.view.frame);
    
    CGRect resumeButtonRect = CGRectMake(screenWidth / 2, screenHeight / 2 + pauseButtonSpaceFromCenter, pauseButtonDiameter / 2, pauseButtonDiameter);
    
    self.delegate.resumeButton = [[UIButton alloc] initWithFrame:resumeButtonRect];
    
    [self.delegate.resumeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.delegate.resumeButton setTitle:@">" forState:UIControlStateNormal];
    
    self.delegate.resumeButton.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0 alpha:0.7];
    self.delegate.resumeButton.layer.cornerRadius = 23;
    
    self.delegate.resumeButton.hidden = YES;
    
    self.delegate.resumeButton.layer.affineTransform = CGAffineTransformMakeRotation(M_PI);
    
    [self.delegate.resumeButton addTarget:self action:@selector(animationForResumeButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.delegate.view addSubview:self.delegate.resumeButton];
}


-(void)animationForResumeButton
{
    [UIView animateWithDuration:0.3 animations:^{
        [self returnStopResumeButtonInitialState];
        [self.delegate.blurEffectView removeFromSuperview];
        [self configureMainView];
        [self.delegate.pauseButton bringSubviewToFront:self.delegate.view];
    }
        completion:^(BOOL Finished){
        [self returnStopButtonInitialState];
        [self returnResumeButtonInitialState];
        self.delegate.pauseButton.hidden = NO;
        self.delegate.stopButton.hidden = YES;
        self.delegate.resumeButton.hidden = YES;
        self.delegate.stopButton.alpha = 0;
        self.delegate.resumeButton.alpha = 0;
        }];
    
}

-(void)animationForPauseButton
{
    [UIView animateWithDuration:0.4 animations:^{
        self.delegate.stopButton.alpha = 1.0;
        self.delegate.resumeButton.alpha = 1.0;
        
        self.delegate.stopButton.center = CGPointMake(self.delegate.stopButton.center.x-50, self.delegate.stopButton.center.y+30);
        self.delegate.resumeButton.center = CGPointMake(self.delegate.resumeButton.center.x+50, self.delegate.resumeButton.center.y+30);
        
        self.delegate.stopButton.layer.affineTransform = CGAffineTransformMakeRotation(2*M_PI);
        self.delegate.resumeButton.layer.affineTransform = CGAffineTransformMakeRotation(-2*M_PI);
        
        self.delegate.pauseButton.hidden = YES;
        self.delegate.stopButton.hidden = NO;
        self.delegate.resumeButton.hidden = NO;
    }];
    
    
    [UIView animateWithDuration:0.6 animations:^{
        [self blurEffect];
        
        CGRect stopButtonFrame = self.delegate.stopButton.frame;
        CGRect resumeButtonFrame = self.delegate.resumeButton.frame;
        
        CGFloat quefficient = 1.5;
        CGFloat newSize = pauseButtonDiameter / quefficient;
        CGFloat oldSize = pauseButtonDiameter / 2;
        CGFloat delta = (newSize - oldSize) / 2;
        
        self.delegate.stopButton.frame = CGRectMake(CGRectGetMinX(stopButtonFrame) - delta, CGRectGetMinY(stopButtonFrame), CGRectGetHeight(stopButtonFrame)/quefficient, CGRectGetHeight(stopButtonFrame)/quefficient);
        
        self.delegate.resumeButton.frame = CGRectMake(CGRectGetMinX(resumeButtonFrame) - delta, CGRectGetMinY(resumeButtonFrame), CGRectGetHeight(resumeButtonFrame)/quefficient, CGRectGetHeight(resumeButtonFrame)/quefficient);
        
        self.delegate.resumeButton.layer.cornerRadius = newSize / 2;
        self.delegate.stopButton.layer.cornerRadius = newSize / 2;
    }];
}

-(void)blurEffect
{
    if (!UIAccessibilityIsReduceTransparencyEnabled()) {
        self.delegate.view.backgroundColor = [UIColor clearColor];
        
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        self.delegate.blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        self.delegate.blurEffectView.frame = self.delegate.view.bounds;
        self.delegate.blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self.delegate.view addSubview:self.delegate.blurEffectView];
        
        [self.delegate.view bringSubviewToFront:self.delegate.resumeButton];
        [self.delegate.view bringSubviewToFront:self.delegate.stopButton];
        [self.delegate.view bringSubviewToFront:self.delegate.paceLabel];
        [self.delegate.view bringSubviewToFront:self.delegate.timeLabel];
        [self.delegate.view bringSubviewToFront:self.delegate.distanceToAimLabel];
    }
    else
    {
        self.delegate.view.backgroundColor = [UIColor whiteColor];
    }
}


-(void)returnStopResumeButtonInitialState
{
    CGFloat screenHeight = CGRectGetHeight(self.delegate.view.frame);
    CGFloat screenWidth = CGRectGetWidth(self.delegate.view.frame);
    
    CGRect buttonRect = CGRectMake(screenWidth / 2 - pauseButtonDiameter / 2, screenHeight / 2 + pauseButtonSpaceFromCenter, pauseButtonDiameter, pauseButtonDiameter);
    
    [self.delegate.resumeButton setTitle:@"|" forState:UIControlStateNormal];
    [self.delegate.stopButton setTitle:@"|" forState:UIControlStateNormal];
    
    self.delegate.resumeButton.frame = buttonRect;
    self.delegate.stopButton.frame = buttonRect;
    
    self.delegate.stopButton.layer.cornerRadius = 23;
    self.delegate.resumeButton.layer.cornerRadius = 23;
}

-(void)returnResumeButtonInitialState
{
    CGFloat screenHeight = CGRectGetHeight(self.delegate.view.frame);
    CGFloat screenWidth = CGRectGetWidth(self.delegate.view.frame);
    
    CGRect resumeButtonRect = CGRectMake(screenWidth / 2, screenHeight / 2 + pauseButtonSpaceFromCenter, pauseButtonDiameter / 2, pauseButtonDiameter);
    
    [self.delegate.resumeButton setTitle:@">" forState:UIControlStateNormal];
    
    self.delegate.resumeButton.frame = resumeButtonRect;
    
    self.delegate.resumeButton.layer.affineTransform = CGAffineTransformMakeRotation(M_PI);
}

-(void)returnStopButtonInitialState
{
    CGFloat screenHeight = CGRectGetHeight(self.delegate.view.frame);
    CGFloat screenWidth = CGRectGetWidth(self.delegate.view.frame);
    
    CGRect stopButtonRect = CGRectMake(screenWidth / 2 - pauseButtonDiameter / 2, screenHeight / 2 + pauseButtonSpaceFromCenter, pauseButtonDiameter / 2, pauseButtonDiameter);
    
    [self.delegate.stopButton setTitle:@"stop" forState:UIControlStateNormal];
    
    self.delegate.stopButton.frame = stopButtonRect;
    
    self.delegate.stopButton.layer.affineTransform = CGAffineTransformMakeRotation(M_PI);
}

-(void)configureDistanceLabel
{
    self.delegate.distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 50)];
    self.delegate.distanceLabel.text = @"distance";
    [self.delegate.view addSubview:self.delegate.distanceLabel];
    self.delegate.distanceLabel.textColor = [UIColor whiteColor];
    CGFloat screenWidth = CGRectGetWidth(self.delegate.view.frame);
    self.delegate.distanceLabel.frame = CGRectMake(0, 40, screenWidth, 60);
    [self.delegate.timeLabel setFont:[UIFont fontWithName:@"Helvetica" size:20]];
}

-(void)configureMainView
{
    self.delegate.view.backgroundColor = [UIColor colorWithRed:0.4 green:0.2 blue:0.8 alpha:1.0];
}

-(void)configureUI
{
    [self configureMainView];
    [self configurePaceLabel];
    [self configureTimeLabel];
    [self configureDistanceToAimLabel];
    [self configurePauseButton];
    [self configureResumeButton];
    [self configureStopButton];
    [self configureDistanceLabel];
    
    self.delegate.paceLabel.text = @"0.00";
    self.delegate.timeLabel.text = @"0";
    self.delegate.distanceToAimLabel.text = @"0";
}

@end
