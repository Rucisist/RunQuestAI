//
//  BeginRunViewController.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 14.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "AISBeginRunViewController.h"
#import "AISCountdownRunMissionViewController.h"
#import "AISUserDefaultsService.h"
#import "AISLightSaberView.h"
#import "AISWeatherForRunAndClothesViewController.h"

static const CGFloat AISstartRunButtonDiameter = 100;
static const CGFloat AISoffsetFromBottom = 200;
static const CGFloat AISSaberViewHeight = 200;

@interface AISBeginRunViewController ()

@property (nonatomic, strong) UIButton *freeRunButton;
@property (nonatomic, strong) UIButton *questRunButton;
@property (nonatomic, strong) UIButton *clothesWeatherButton;
@property (nonatomic, strong) UIButton *startRunButton;
@property (nonatomic, strong) UIButton *settingsButton;
@property (nonatomic, strong) UIImageView *lightSaberImageView;
@property (nonatomic, strong) UILabel *AllDistanceLabel;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) AISUserDefaultsService *userDefaultsService;
@property (nonatomic, strong) AISLightSaberView *lightSaberView;

@end

@implementation AISBeginRunViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configureUI];
    [self initializeSaberView];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SW1"]];
    
    imageView.frame = self.view.frame;
    
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.view addSubview:imageView];
    [self.view sendSubviewToBack:imageView];
    
    self.view.backgroundColor = [UIColor blackColor];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
    [self configureSaberView];
}

#pragma mark - configureView

-(void)configureUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configurateStartButton];
    [self configureSaberView];
    [self configurateGoToClothesWeatherButton];
    self.AllDistanceLabel = [UILabel new];
}

-(void)configurateGoToClothesWeatherButton
{
    CGRect screenFrame = self.view.frame;
    CGFloat frameWidth = CGRectGetWidth(screenFrame);
    CGFloat frameHeight = CGRectGetHeight(screenFrame);
    
    self.clothesWeatherButton = [[UIButton alloc] initWithFrame:CGRectMake(frameWidth / 2 + 100, frameHeight / 2 + 70, 40, 40)];
    [self.clothesWeatherButton setTitle:@"t" forState:UIControlStateNormal];
    [self.clothesWeatherButton setTitleColor:UIColor.orangeColor forState:UIControlStateNormal];
    self.clothesWeatherButton.layer.cornerRadius = 10;
    self.clothesWeatherButton.backgroundColor = UIColor.yellowColor;
    [self.view addSubview:self.clothesWeatherButton];
    [self.clothesWeatherButton addTarget:self action:@selector(goToAISWeatherForRunAndClothesViewController) forControlEvents:UIControlEventTouchUpInside];
}

-(void)configurateStartButton
{
    CGRect screenFrame = self.view.frame;
    CGFloat frameWidth = CGRectGetWidth(screenFrame);
    CGFloat frameHeight = CGRectGetHeight(screenFrame);
    
    CGRect startButtonFrame = CGRectMake(frameWidth / 2 - AISstartRunButtonDiameter / 2, frameHeight - AISoffsetFromBottom, AISstartRunButtonDiameter, AISstartRunButtonDiameter);
    
    self.startRunButton = [[UIButton alloc] initWithFrame:startButtonFrame];
    self.startRunButton.layer.cornerRadius = AISstartRunButtonDiameter / 2;
    self.startRunButton.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0 alpha:0.7];
    
    [self.startRunButton setTitle:@"run!" forState:UIControlStateNormal];
    [self.startRunButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.view addSubview:self.startRunButton];
    [self.startRunButton addTarget:self action:@selector(startButtonPressed) forControlEvents:UIControlEventTouchUpInside];
}

-(void)initializeSaberView
{
    self.lightSaberView = [[AISLightSaberView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), AISSaberViewHeight)];
    
    [self.view addSubview:self.lightSaberView];
}

-(void)configureSaberView
{
    [self.lightSaberView configureTheLightSaberView];
}

-(void)startButtonPressed
{
    [self goToCountdownViewController];
}

-(void)changeBackgroundColor
{
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - Navigation

-(void)goToCountdownViewController
{
    AISCountdownRunMissionViewController *countdownViewController;
    countdownViewController = [AISCountdownRunMissionViewController new];
    
    [self.navigationController pushViewController:countdownViewController animated:YES];
}

-(void)goToAISWeatherForRunAndClothesViewController
{
    AISWeatherForRunAndClothesViewController *runClothesViewController;
    runClothesViewController = [AISWeatherForRunAndClothesViewController new];
    
    [self.navigationController pushViewController:runClothesViewController animated:YES];
}

@end
