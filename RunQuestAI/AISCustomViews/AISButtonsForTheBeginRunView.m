//
//  ButtonsForTheBeginRunView.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 18.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "AISButtonsForTheBeginRunView.h"


@interface AISButtonsForTheBeginRunView()

@property (nonatomic, strong) UIButton *freeRunButton;
@property (nonatomic, strong) UIButton *kilometersLimitedRunButton;
@property (nonatomic, strong) UIButton *questRunButton;
@property (nonatomic, strong) UIButton *timeLimitedRunButton;
@property (nonatomic) NSUInteger index;


@end

@implementation AISButtonsForTheBeginRunView


-(instancetype)init
{
    self = [super init];
    if (self)
    {
        _freeRunButton = [UIButton new];
        _kilometersLimitedRunButton = [UIButton new];
        _timeLimitedRunButton = [UIButton new];
        _questRunButton = [UIButton new];
        
        self.index = 4;
        
    }
    return self;
}

-(void)configureButtonsOnTheView: (CGRect)theFrame
{
    self.frame = theFrame;
    
    CGFloat height = CGRectGetHeight(theFrame);
    CGFloat width = round(CGRectGetWidth(theFrame) / 4);
    
    self.freeRunButton.frame = CGRectMake(0, 0, width, height);
    self.kilometersLimitedRunButton.frame = CGRectMake(width*1, 0, width, height);
    self.timeLimitedRunButton.frame = CGRectMake(width*2, 0, width, height);
    self.questRunButton.frame = CGRectMake(width*3, 0, width, height);
    
    [self.freeRunButton setTitle:@"freeRun" forState:UIControlStateNormal];
    [self.kilometersLimitedRunButton setTitle:@"km" forState:UIControlStateNormal];
    [self.timeLimitedRunButton setTitle:@"time" forState:UIControlStateNormal];
    [self.questRunButton setTitle:@"quest" forState:UIControlStateNormal];
    
    [self.freeRunButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.kilometersLimitedRunButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.timeLimitedRunButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.questRunButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [self addSubview:self.freeRunButton];
    [self addSubview:self.kilometersLimitedRunButton];
    [self addSubview:self.timeLimitedRunButton];
    [self addSubview:self.questRunButton];
}


@end
