//
//  BeginRunViewController.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 14.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "BeginRunViewController.h"
#import "CountdownRunMissionViewController.h"
#import "SettingsViewController.h"
#import "AISUserDefaultsService.h"
#import "AISLightSaberView.h"
#import "AISButtonsForTheBeginRunView.h"

static CGFloat AISstartRunButtonDiameter = 100;
static CGFloat AISSettingsButtonDiameter = 60;
static CGFloat AISoffsetFromBottom = 200;

@interface BeginRunViewController ()

@property (nonatomic, strong) UIButton *startRunButton;
@property (nonatomic, strong) UIImageView *lightSaberImageView;
@property (nonatomic, strong) UIButton *settingsButton;
@property (nonatomic, strong) AISUserDefaultsService *userDefaultsService;
@property (nonatomic, strong) AISLightSaberView *lightSaberView;
@property (nonatomic, strong) AISButtonsForTheBeginRunView *buttonPannel;
@property (nonatomic, strong) UILabel *AllDistanceLabel;
@property (nonatomic, strong) UIButton *freeRunButton;
@property (nonatomic, strong) UIButton *questRunButton;
@property (nonatomic, strong) CLLocationManager *locationManager;


@end

@implementation BeginRunViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureUI];
    [self initializeSaberView];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SW1"]];
    
    imageView.frame = self.view.frame;
    
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.view addSubview:imageView];
    [self.view sendSubviewToBack:imageView];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"SW1"]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)configureUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect screenFrame = self.view.frame;
    CGFloat frameWidth = CGRectGetWidth(screenFrame);
    CGFloat frameHeight = CGRectGetHeight(screenFrame);
    
    CGRect startButtonFrame = CGRectMake(frameWidth / 2 - AISstartRunButtonDiameter / 2, frameHeight - AISoffsetFromBottom, AISstartRunButtonDiameter, AISstartRunButtonDiameter);
    self.startRunButton = [[UIButton alloc] initWithFrame:startButtonFrame];
    
    self.startRunButton.layer.cornerRadius = AISstartRunButtonDiameter / 2;
    
    self.startRunButton.backgroundColor = [UIColor redColor];
    
    [self.startRunButton setTitle:@"run!" forState:UIControlStateNormal];
    [self.startRunButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.view addSubview:self.startRunButton];
    [self.startRunButton addTarget:self action:@selector(startButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self configureSaberView];
    
    //[self configureSettingsButton];
    
    
    self.AllDistanceLabel = [UILabel new];
}


-(void)configureSettingsButton
{
    CGFloat height = CGRectGetHeight(self.view.frame);
    CGFloat width = CGRectGetWidth(self.view.frame);
    self.settingsButton = [[UIButton alloc] initWithFrame:CGRectMake(50, height - AISoffsetFromBottom + 40, AISSettingsButtonDiameter, AISSettingsButtonDiameter)];
    self.settingsButton.backgroundColor = [UIColor redColor];
    self.settingsButton.layer.cornerRadius = AISSettingsButtonDiameter / 2;
    [self.settingsButton setTitle:@"информация" forState:UIControlStateNormal];
    
    [self.view addSubview:self.settingsButton];
    [self.settingsButton addTarget:self action:@selector(goToSettingsScreen) forControlEvents:UIControlEventTouchUpInside];
}

-(void)goToSettingsScreen
{
    SettingsViewController *settingsViewController = [SettingsViewController new];
    [self presentViewController:settingsViewController animated:YES completion:nil];
}

-(void)initializeSaberView
{
    self.lightSaberView = [[AISLightSaberView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 200)];
    [self.view addSubview:self.lightSaberView];
}

-(void)configureSaberView
{
    [self.lightSaberView configureTheLightSaberView];
}


-(void)configureUserSettings
{
    self.userDefaultsService = [AISUserDefaultsService new];
    [self.userDefaultsService setUserDefaultsForTheKey:@"name" objectForTheKey:@"Andrew I."];
    
}

-(void)startButtonPressed
{
    [self goToCountdownViewController];
}

-(void)goToCountdownViewController
{
    CountdownRunMissionViewController *countdownViewController;
    countdownViewController = [CountdownRunMissionViewController new];
    //[self presentViewController:countdownViewController animated:YES completion:nil];
    [self.navigationController pushViewController:countdownViewController animated:YES];
}


-(void)changeBackgroundColor
{
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
