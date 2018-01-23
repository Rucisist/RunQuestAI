//
//  AISCharacteristicViewConfigurator.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 23.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "AISCharacteristicViewConfigurator.h"
@class AISRunMissionCharacteristicsViewController;

static CGFloat paceTimeDTAlabelHeight = 50;
static CGFloat pauseButtonDiameter = 100;
static CGFloat pauseButtonSpaceFromCenter = 100;

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
    CGFloat screenHeight = CGRectGetHeight(self.viewController.view.frame);
    CGFloat paceLabelHeight = paceTimeDTAlabelHeight;
    CGFloat screenWidth = CGRectGetWidth(self.viewController.view.frame);
    
    CGRect paceLabelRect = CGRectMake(0, screenHeight / 2, screenWidth / 2, paceLabelHeight);
    self.viewController.paceLabel = [[UILabel alloc] initWithFrame:paceLabelRect];
    
    self.viewController.paceLabel.numberOfLines = 2;
    
    
    self.viewController.paceLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.viewController.paceLabel setFont:[UIFont fontWithName:@"Helvetica" size:20]];
    
    [self.viewController.view addSubview:self.viewController.paceLabel];
    
}

-(void)configureTimeLabel
{
    CGFloat screenHeight = CGRectGetHeight(self.viewController.view.frame);
    CGFloat screenWidth = CGRectGetWidth(self.viewController.view.frame);
    CGFloat timeLabelHeight = paceTimeDTAlabelHeight;
    
    CGRect timeLabelRect = CGRectMake(screenWidth/2, screenHeight / 2, screenWidth / 2, timeLabelHeight);
    self.viewController.timeLabel = [[UILabel alloc] initWithFrame:timeLabelRect];
    
    self.viewController.timeLabel.numberOfLines = 2;
    
    self.viewController.timeLabel.textAlignment = NSTextAlignmentCenter;
    
    self.viewController.timeLabel.text = @"0";
    
    [self.viewController.timeLabel setFont:[UIFont fontWithName:@"Helvetica" size:20]];
    
    [self.viewController.view addSubview:self.viewController.timeLabel];
}

-(void)configureDistanceToAimLabel
{
    CGFloat screenHeight = CGRectGetHeight(self.viewController.view.frame);
    CGFloat screenWidth = CGRectGetWidth(self.viewController.view.frame);
    CGFloat DTALabelHeigth = paceTimeDTAlabelHeight;
    
    CGRect DTARect = CGRectMake(0, screenHeight / 2 - 140, screenWidth, DTALabelHeigth *3);
    
    self.viewController.distanceToAimLabel = [[UILabel alloc] initWithFrame:DTARect];
    
    self.viewController.distanceToAimLabel.textAlignment = NSTextAlignmentCenter;
    
    self.viewController.distanceToAimLabel.numberOfLines = 2;
    
    [self.viewController.distanceToAimLabel setFont:[UIFont fontWithName:@"Helvetica" size:38]];
    
    [self.viewController.view addSubview:self.viewController.distanceToAimLabel];
}

-(void)configurePauseButton
{
    CGFloat screenHeight = CGRectGetHeight(self.viewController.view.frame);
    CGFloat screenWidth = CGRectGetWidth(self.viewController.view.frame);
    
    CGRect pauseButtonRect = CGRectMake(screenWidth / 2 - pauseButtonDiameter / 2, screenHeight / 2 + pauseButtonSpaceFromCenter, pauseButtonDiameter, pauseButtonDiameter);
    
    self.viewController.pauseButton = [[UIButton alloc] initWithFrame:pauseButtonRect];
    
    [self.viewController.pauseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.viewController.pauseButton setTitle:@"||" forState:UIControlStateNormal];
    
    self.viewController.pauseButton.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0 alpha:0.7];
    self.viewController.pauseButton.layer.cornerRadius = 23;
    
    [self.viewController.pauseButton addTarget:self.viewController action:@selector(pauseButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.viewController.view addSubview:self.viewController.pauseButton];
}


-(void)configureStopButton
{
    CGFloat screenHeight = CGRectGetHeight(self.viewController.view.frame);
    CGFloat screenWidth = CGRectGetWidth(self.viewController.view.frame);
    
    CGRect stopButtonRect = CGRectMake(screenWidth / 2 - pauseButtonDiameter / 2, screenHeight / 2 + pauseButtonSpaceFromCenter, pauseButtonDiameter / 2, pauseButtonDiameter);
    
    self.viewController.stopButton = [[UIButton alloc] initWithFrame:stopButtonRect];
    
    [self.viewController.stopButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.viewController.stopButton setTitle:@"Stop" forState:UIControlStateNormal];
    
    self.viewController.stopButton.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0 alpha:0.7];
    self.viewController.stopButton.layer.cornerRadius = 23;
    
    self.viewController.stopButton.hidden = YES;
    
    self.viewController.stopButton.layer.affineTransform = CGAffineTransformMakeRotation(M_PI);
    
    [self.viewController.stopButton addTarget:self.viewController action:@selector(stopButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.viewController.view addSubview:self.viewController.stopButton];
    
}

-(void)configureResumeButton
{
    CGFloat screenHeight = CGRectGetHeight(self.viewController.view.frame);
    CGFloat screenWidth = CGRectGetWidth(self.viewController.view.frame);
    
    CGRect resumeButtonRect = CGRectMake(screenWidth / 2, screenHeight / 2 + pauseButtonSpaceFromCenter, pauseButtonDiameter / 2, pauseButtonDiameter);
    
    self.viewController.resumeButton = [[UIButton alloc] initWithFrame:resumeButtonRect];
    
    [self.viewController.resumeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.viewController.resumeButton setTitle:@">" forState:UIControlStateNormal];
    
    self.viewController.resumeButton.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0 alpha:0.7];
    self.viewController.resumeButton.layer.cornerRadius = 23;
    
    self.viewController.resumeButton.hidden = YES;
    
    self.viewController.resumeButton.layer.affineTransform = CGAffineTransformMakeRotation(M_PI);
    
    [self.viewController.resumeButton addTarget:self.viewController action:@selector(resumeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.viewController.view addSubview:self.viewController.resumeButton];
}

-(void)cofigureDistanceLabel
{
    self.viewController.distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 50)];
    self.viewController.distanceLabel.text = @"distance";
    [self.viewController.view addSubview:self.viewController.distanceLabel];
}

-(void)configureDistanceLabel
{
    CGFloat screenWidth = CGRectGetWidth(self.viewController.view.frame);
    self.viewController.distanceLabel.frame = CGRectMake(0, 40, screenWidth, 60);
    [self.viewController.timeLabel setFont:[UIFont fontWithName:@"Helvetica" size:20]];
}

-(void)configureMainView
{
    self.viewController.view.backgroundColor = [UIColor colorWithRed:0.4 green:0.2 blue:0.8 alpha:1.0];
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
    
    self.viewController.distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 50)];
    self.viewController.distanceLabel.text = @"distance";
    [self.viewController.view addSubview:self.viewController.distanceLabel];
    [self configureDistanceLabel];
}

@end
