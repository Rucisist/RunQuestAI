//
//  RunMissionViewController.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 15.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "CountdownRunMissionViewController.h"
#import "RunMissionInProgressTabBarController.h"

static const int countdownTime = 2;

@interface CountdownRunMissionViewController ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic) NSUInteger counter;
@property (nonatomic, strong) UILabel *countdownLabel;
@property (nonatomic, strong) UILabel *countdownLabelHelper;
@property (nonatomic, strong) UIView *GMapView;

@end

@implementation CountdownRunMissionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureCountdownScreen];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countdown) userInfo:nil repeats:YES];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)countdown
{
    NSLog(@"%lu", (unsigned long)self.counter);
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

    
    self.counter = countdownTime;
    
    self.countdownLabel = [[UILabel alloc] initWithFrame:CGRectMake(frameWidth / 2 - 100, frameHeight / 2 - 50, 200, 100)];
    self.countdownLabelHelper = [[UILabel alloc] initWithFrame:CGRectMake(frameWidth / 2 - 100, frameHeight / 2 - 50, 200, 100)];
    
    [self.countdownLabel setFont:[UIFont boldSystemFontOfSize:50]];
    [self.countdownLabelHelper setFont:[UIFont boldSystemFontOfSize:50]];
    self.countdownLabel.textColor = [UIColor whiteColor];
    self.countdownLabelHelper.textColor = [UIColor whiteColor];
    self.countdownLabel.text = @"ready?";
    self.countdownLabelHelper.text = @"ready?";
    
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
        CGPoint center = CGPointMake(self.countdownLabel.center.x, self.countdownLabel.center.y + 50);
        CGPoint centerHelper = CGPointMake(self.countdownLabelHelper.center.x, self.countdownLabelHelper.center.y + 50);
        
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
    
    self.countdownLabel.frame = CGRectMake(frameWidth / 2 - 100, frameHeight / 2 - 50, 200, 100);
    self.countdownLabel.textColor = [UIColor whiteColor];
    
    self.countdownLabel.alpha = 1.0;
}

-(void)returnCountdownLabelHelperToTheInitialState
{
    CGRect screenFrame = self.view.frame;
    CGFloat frameWidth = CGRectGetWidth(screenFrame);
    CGFloat frameHeight = CGRectGetHeight(screenFrame);
    
    self.countdownLabelHelper.frame = CGRectMake(frameWidth / 2 - 100, frameHeight / 2 - 50 - 50, 200, 100);
    self.countdownLabelHelper.textColor = [UIColor whiteColor];
    
    self.countdownLabelHelper.alpha = 0;
}

-(void)goToRunMissionInProgressTabBarViewController
{
    RunMissionInProgressTabBarController *runTabBarController;
    runTabBarController = [RunMissionInProgressTabBarController new];
    [self presentViewController:runTabBarController animated:YES completion:nil];
}



#pragma mark - Navigation


@end
