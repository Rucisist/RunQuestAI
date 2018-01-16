//
//  RunMissionCharacteristicsViewController.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 15.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "RunMissionCharacteristicsViewController.h"

static CGFloat paceTimeDTAlabelWidth = 100;
static CGFloat paceTimeDTAlabelHeight = 50;
static CGFloat pauseButtonDiameter = 100;
static CGFloat pauseButtonSpaceFromCenter = 100;

@interface RunMissionCharacteristicsViewController ()

@property (nonatomic, strong) UILabel *paceLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *distanceToAimLabel;
@property (nonatomic, strong) UIVisualEffectView *blurEffectView;
@property (nonatomic, strong) UIButton *pauseButton;
@property (nonatomic, strong) UIButton *stopButton;
@property (nonatomic, strong) UIButton *resumeButton;
@property (nonatomic) CGRect viewFrame;

@end

@implementation RunMissionCharacteristicsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewFrame = self.view.frame;
    [self configureUI];
    
    self.paceLabel.text = @"sometext";
    self.timeLabel.text = @"sometext";
    self.distanceToAimLabel.text = @"sometext";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configurePaceLabel
{
    CGFloat screenHeight = CGRectGetHeight(self.viewFrame);
    CGFloat paceLabelWidth = paceTimeDTAlabelWidth;
    CGFloat paceLabelHeight = paceTimeDTAlabelHeight;
    
    CGRect paceLabelRect = CGRectMake(20, screenHeight / 2, paceLabelWidth, paceLabelHeight);
    self.paceLabel = [[UILabel alloc] initWithFrame:paceLabelRect];
    
    self.paceLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:self.paceLabel];
}

-(void)configureTimeLabel
{
    CGFloat screenHeight = CGRectGetHeight(self.viewFrame);
    CGFloat screenWidth = CGRectGetWidth(self.viewFrame);
    CGFloat timeLabelWidth = paceTimeDTAlabelWidth;
    CGFloat timeLabelHeight = paceTimeDTAlabelHeight;
    
    CGRect timeLabelRect = CGRectMake(screenWidth - timeLabelWidth - 20, screenHeight / 2, timeLabelWidth, timeLabelHeight);
    self.timeLabel = [[UILabel alloc] initWithFrame:timeLabelRect];
    
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:self.timeLabel];
}

-(void)configureDistanceToAimLabel
{
    CGFloat screenHeight = CGRectGetHeight(self.viewFrame);
    CGFloat screenWidth = CGRectGetWidth(self.viewFrame);
    CGFloat DTALabelWidth = paceTimeDTAlabelWidth;
    CGFloat DTALabelHeigth = paceTimeDTAlabelHeight;
    
    CGRect DTARect = CGRectMake((screenWidth - DTALabelWidth) / 2, screenHeight / 2, DTALabelWidth, DTALabelHeigth);
    self.distanceToAimLabel = [[UILabel alloc] initWithFrame:DTARect];
    
    self.distanceToAimLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:self.distanceToAimLabel];
}

-(void)configurePauseButton
{
    CGFloat screenHeight = CGRectGetHeight(self.viewFrame);
    CGFloat screenWidth = CGRectGetWidth(self.viewFrame);
    
    CGRect pauseButtonRect = CGRectMake(screenWidth / 2 - pauseButtonDiameter / 2, screenHeight / 2 + pauseButtonSpaceFromCenter, pauseButtonDiameter, pauseButtonDiameter);
    
    self.pauseButton = [[UIButton alloc] initWithFrame:pauseButtonRect];
    
    [self.pauseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.pauseButton setTitle:@"||" forState:UIControlStateNormal];
    
//    UIImage *pauseButtonImage = [UIImage imageNamed:@"runbuttonImage"];
//
//    [self.pauseButton setBackgroundImage:pauseButtonImage forState:UIControlStateNormal];
    
    self.pauseButton.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0 alpha:0.7];
    self.pauseButton.layer.cornerRadius = 23;
    
    [self.pauseButton addTarget:self action:@selector(animationForPauseButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.pauseButton];
}

-(void)animationForPauseButton
{

    [UIView animateWithDuration:0.4 animations:^{
        self.stopButton.alpha = 1.0;
        self.resumeButton.alpha = 1.0;
        
        self.stopButton.center = CGPointMake(self.stopButton.center.x-50, self.stopButton.center.y+30);
        self.resumeButton.center = CGPointMake(self.resumeButton.center.x+50, self.resumeButton.center.y+30);
        
        self.stopButton.layer.affineTransform = CGAffineTransformMakeRotation(2*M_PI);
        self.resumeButton.layer.affineTransform = CGAffineTransformMakeRotation(-2*M_PI);
        
        self.pauseButton.hidden = YES;
        self.stopButton.hidden = NO;
        self.resumeButton.hidden = NO;
    }];
    
    [UIView animateWithDuration:0.6 animations:^{
        [self blurEffect];
        
        CGRect stopButtonFrame = self.stopButton.frame;
        CGRect resumeButtonFrame = self.resumeButton.frame;
        

        CGFloat quefficient = 1.5;
        CGFloat newSize = pauseButtonDiameter / quefficient;
        CGFloat oldSize = pauseButtonDiameter / 2;
        CGFloat delta = (newSize - oldSize) / 2;
        
        self.stopButton.frame = CGRectMake(CGRectGetMinX(stopButtonFrame) - delta, CGRectGetMinY(stopButtonFrame), CGRectGetHeight(stopButtonFrame)/quefficient, CGRectGetHeight(stopButtonFrame)/quefficient);


        self.resumeButton.frame = CGRectMake(CGRectGetMinX(resumeButtonFrame) - delta, CGRectGetMinY(resumeButtonFrame), CGRectGetHeight(resumeButtonFrame)/quefficient, CGRectGetHeight(resumeButtonFrame)/quefficient);

        self.resumeButton.layer.cornerRadius = newSize / 2;
        self.stopButton.layer.cornerRadius = newSize / 2;
        

    }];
}

-(void)animationForResumeButton
{
    [UIView animateWithDuration:0.3 animations:^{
        [self returnStopResumeButtonInitialState];
        [self.blurEffectView removeFromSuperview];
        [self configureMainView];
        [self.pauseButton bringSubviewToFront:self.view];
    }
    completion:^(BOOL Finished)
    {
        [self returnStopButtonInitialState];
        [self returnResumeButtonInitialState];
        self.pauseButton.hidden = NO;
        self.stopButton.hidden = YES;
        self.resumeButton.hidden = YES;
        self.stopButton.alpha = 0;
        self.stopButton.alpha = 0;
    }];

}


-(void)configureStopButton
{
    CGFloat screenHeight = CGRectGetHeight(self.viewFrame);
    CGFloat screenWidth = CGRectGetWidth(self.viewFrame);
    
    CGRect stopButtonRect = CGRectMake(screenWidth / 2 - pauseButtonDiameter / 2, screenHeight / 2 + pauseButtonSpaceFromCenter, pauseButtonDiameter / 2, pauseButtonDiameter);
    
    self.stopButton = [[UIButton alloc] initWithFrame:stopButtonRect];
    
    [self.stopButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.stopButton setTitle:@"Stop" forState:UIControlStateNormal];
    
    self.stopButton.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0 alpha:0.7];
    self.stopButton.layer.cornerRadius = 23;
    
    self.stopButton.hidden = YES;
    
    self.stopButton.layer.affineTransform = CGAffineTransformMakeRotation(M_PI);
    
    [self.view addSubview:self.stopButton];
    
}

-(void)returnStopButtonInitialState
{
 
    CGFloat screenHeight = CGRectGetHeight(self.viewFrame);
    CGFloat screenWidth = CGRectGetWidth(self.viewFrame);
    
    CGRect stopButtonRect = CGRectMake(screenWidth / 2 - pauseButtonDiameter / 2, screenHeight / 2 + pauseButtonSpaceFromCenter, pauseButtonDiameter / 2, pauseButtonDiameter);
    
    [self.stopButton setTitle:@"stop" forState:UIControlStateNormal];
    
    self.stopButton.frame = stopButtonRect;
    
    self.stopButton.layer.affineTransform = CGAffineTransformMakeRotation(M_PI);
}


-(void)configureResumeButton
{
    CGFloat screenHeight = CGRectGetHeight(self.viewFrame);
    CGFloat screenWidth = CGRectGetWidth(self.viewFrame);
    
    CGRect resumeButtonRect = CGRectMake(screenWidth / 2, screenHeight / 2 + pauseButtonSpaceFromCenter, pauseButtonDiameter / 2, pauseButtonDiameter);
    
    self.resumeButton = [[UIButton alloc] initWithFrame:resumeButtonRect];
    
    [self.resumeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.resumeButton setTitle:@">" forState:UIControlStateNormal];
    
    self.resumeButton.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0 alpha:0.7];
    self.resumeButton.layer.cornerRadius = 23;
    
    self.resumeButton.hidden = YES;
    
    self.resumeButton.layer.affineTransform = CGAffineTransformMakeRotation(M_PI);
    
    [self.resumeButton addTarget:self action:@selector(animationForResumeButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.resumeButton];
}

-(void)returnPauseButtonInitialState
{
    CGFloat screenHeight = CGRectGetHeight(self.viewFrame);
    CGFloat screenWidth = CGRectGetWidth(self.viewFrame);
    
    CGRect pauseButtonRect = CGRectMake(screenWidth / 2 - pauseButtonDiameter / 2, screenHeight / 2 + pauseButtonSpaceFromCenter, pauseButtonDiameter, pauseButtonDiameter);
    
    self.pauseButton.frame = pauseButtonRect;
}

-(void)returnStopResumeButtonInitialState
{
    CGFloat screenHeight = CGRectGetHeight(self.viewFrame);
    CGFloat screenWidth = CGRectGetWidth(self.viewFrame);
    
    CGRect buttonRect = CGRectMake(screenWidth / 2 - pauseButtonDiameter / 2, screenHeight / 2 + pauseButtonSpaceFromCenter, pauseButtonDiameter, pauseButtonDiameter);
    
    [self.resumeButton setTitle:@"|" forState:UIControlStateNormal];
    [self.stopButton setTitle:@"|" forState:UIControlStateNormal];
    
    self.resumeButton.frame = buttonRect;
    self.stopButton.frame = buttonRect;
    
    self.stopButton.layer.cornerRadius = 23;
    self.resumeButton.layer.cornerRadius = 23;
}

-(void)returnResumeButtonInitialState
{
    CGFloat screenHeight = CGRectGetHeight(self.viewFrame);
    CGFloat screenWidth = CGRectGetWidth(self.viewFrame);
    
    CGRect resumeButtonRect = CGRectMake(screenWidth / 2, screenHeight / 2 + pauseButtonSpaceFromCenter, pauseButtonDiameter / 2, pauseButtonDiameter);
    
    [self.resumeButton setTitle:@">" forState:UIControlStateNormal];
    
    self.resumeButton.frame = resumeButtonRect;
    
    self.resumeButton.layer.affineTransform = CGAffineTransformMakeRotation(M_PI);
}

-(void)configureMainView
{
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)blurEffect
{
    if (!UIAccessibilityIsReduceTransparencyEnabled()) {
        self.view.backgroundColor = [UIColor clearColor];
        
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        self.blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        self.blurEffectView.frame = self.view.bounds;
        self.blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self.view addSubview:self.blurEffectView];
        
        [self.view bringSubviewToFront:self.resumeButton];
        [self.view bringSubviewToFront:self.stopButton];
        [self.view bringSubviewToFront:self.paceLabel];
        [self.view bringSubviewToFront:self.timeLabel];
        [self.view bringSubviewToFront:self.distanceToAimLabel];
        
    } else {
        self.view.backgroundColor = [UIColor whiteColor];
    }
}


- (void)configureView
{
//    self.distanceLabel.text = [MathController stringifyDistance:self.run.distance.floatValue];
//
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
//    self.dateLabel.text = [formatter stringFromDate:self.run.timestamp];
    
  //  self.timeLabel.text = [NSString stringWithFormat:@"Time: %@",  [MathController stringifySecondCount:self.run.duration.intValue usingLongFormat:YES]];
    
 //   self.paceLabel.text = [NSString stringWithFormat:@"Pace: %@",  [MathController stringifyAvgPaceFromDist:self.run.distance.floatValue overTime:self.run.duration.intValue]];
    
   // Badge *badge = [[BadgeController defaultController] bestBadgeForDistance:self.run.distance.floatValue];
//    self.badgeImageView.image = [UIImage imageNamed:badge.imageName];
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
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
