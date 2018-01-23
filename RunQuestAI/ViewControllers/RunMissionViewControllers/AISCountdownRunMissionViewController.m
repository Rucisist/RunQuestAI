//
//  RunMissionViewController.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 15.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "AISCountdownRunMissionViewController.h"
#import "AISRunMissionCharacteristicsViewController.h"


static const int AIScountdownTime = 6;
static const CGFloat AIScountdownLabelWidth = 200;
static const CGFloat AIScountdownLabelHeight = 100;
static const CGFloat AISYOffset = 50;


@interface AISCountdownRunMissionViewController ()

@property (nonatomic) NSUInteger counter;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, strong) UILabel *countdownLabel;
@property (nonatomic, strong) UILabel *countdownLabelHelper;
@property (nonatomic, strong) UIView *GMapView;

@end


@implementation AISCountdownRunMissionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureCountdownScreen];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countdown) userInfo:nil repeats:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
}

-(void)countdown
{
    if (self.counter > 1)
    {
        self.counter = self.counter - 1;
        [self updateCountdownScreen];
    }
    else
    {
        [self.timer invalidate];
        self.counter = 0;
        [self goToRunMissionInProgressTabBarViewController];
    }
}

-(void)configureCountdownScreen
{
    self.view.backgroundColor = [UIColor blackColor];
    CGRect screenFrame = self.view.frame;
    CGFloat frameWidth = CGRectGetWidth(screenFrame);
    CGFloat frameHeight = CGRectGetHeight(screenFrame);

    self.counter = AIScountdownTime;
    
    self.countdownLabel = [[UILabel alloc] initWithFrame:CGRectMake(frameWidth / 2 - AIScountdownLabelWidth / 2, frameHeight / 2 - AIScountdownLabelHeight / 2, AIScountdownLabelWidth, AIScountdownLabelHeight)];
    
    self.countdownLabelHelper = [[UILabel alloc] initWithFrame:CGRectMake(frameWidth / 2 - AIScountdownLabelWidth / 2, frameHeight / 2 - AIScountdownLabelHeight / 2, AIScountdownLabelWidth, AIScountdownLabelHeight)];
    
    [self.countdownLabel setFont:[UIFont boldSystemFontOfSize:70]];
    [self.countdownLabelHelper setFont:[UIFont boldSystemFontOfSize:70]];
    
    self.countdownLabel.textAlignment = NSTextAlignmentCenter;
    self.countdownLabelHelper.textAlignment = NSTextAlignmentCenter;
    
    self.countdownLabel.textColor = [UIColor whiteColor];
    self.countdownLabelHelper.textColor = [UIColor whiteColor];
    self.countdownLabel.text = [NSString stringWithFormat:@"%d", AIScountdownTime - 1];
    self.countdownLabelHelper.text = @"";
    
    [self.view addSubview:self.countdownLabel];
    [self.view addSubview:self.countdownLabelHelper];
}

-(void)updateCountdownScreen
{
    if (self.counter > 1)
    {
        self.countdownLabelHelper.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.counter-1];
        
        self.countdownLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.counter];
    }
    else
    {
        self.countdownLabel.text = @"1";
        self.countdownLabelHelper.text = @"go!";
    }
    
    [self returnCountdownLabelToTheInitialState];
    [self returnCountdownLabelHelperToTheInitialState];
    
    [UIView animateWithDuration:0.3 animations:^{
        CGPoint center = CGPointMake(self.countdownLabel.center.x, self.countdownLabel.center.y + AISYOffset);
        CGPoint centerHelper = CGPointMake(self.countdownLabelHelper.center.x, self.countdownLabelHelper.center.y + AISYOffset);
        
        self.countdownLabel.center = center;
        self.countdownLabelHelper.center = centerHelper;
        self.countdownLabel.alpha = 0;
        self.countdownLabelHelper.alpha = 1.0;
    }];
}

-(void)returnCountdownLabelToTheInitialState
{
    CGRect screenFrame = self.view.frame;
    CGFloat frameWidth = CGRectGetWidth(screenFrame);
    CGFloat frameHeight = CGRectGetHeight(screenFrame);
    
    self.countdownLabel.frame = CGRectMake(frameWidth / 2 - AIScountdownLabelWidth / 2, frameHeight / 2 - AIScountdownLabelHeight / 2, AIScountdownLabelWidth, AIScountdownLabelHeight);
    self.countdownLabel.textColor = [UIColor whiteColor];
    
    self.countdownLabel.alpha = 1.0;
}

-(void)returnCountdownLabelHelperToTheInitialState
{
    CGRect screenFrame = self.view.frame;
    CGFloat frameWidth = CGRectGetWidth(screenFrame);
    CGFloat frameHeight = CGRectGetHeight(screenFrame);
    
    self.countdownLabelHelper.frame = CGRectMake(frameWidth / 2 - AIScountdownLabelWidth / 2, frameHeight / 2 - AIScountdownLabelHeight / 2 - AISYOffset, AIScountdownLabelWidth, AIScountdownLabelHeight);
    
    self.countdownLabelHelper.textColor = [UIColor whiteColor];
    
    self.countdownLabelHelper.alpha = 0;
}

#pragma mark - Navigation

-(void)goToRunMissionInProgressTabBarViewController
{
    AISRunMissionCharacteristicsViewController *runMissionController;
    runMissionController = [AISRunMissionCharacteristicsViewController new];
    [self.navigationController pushViewController:runMissionController animated:YES];
}

@end
