//
//  AISWeatherForRunAndClothesViewController.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 22.02.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "AISWeatherForRunAndClothesViewController.h"
#import "AISDownloadService.h"

static const CGFloat AISTopImageViewOffsetx = 40;
static const CGFloat AISTopImageViewOffsety = 100;
static const CGFloat AISTopImageViewHeight = 200;
static const CGFloat AISCurrentWeatherLabelWidth = 100;
static const CGFloat AISCurrentWeatherLabelHeight = 40;
static const CGFloat AISactivityIndicatorViewScale = 40;

@interface AISWeatherForRunAndClothesViewController ()

@property (nonatomic, strong) AISDownloadService *downloadService;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) UILabel *currentWeatherLabel;
@property (nonatomic, strong) UIActivityIndicatorView *activityLoadIndicator;
@property (nonatomic, strong) UIImageView *tShirtImageView;

@end

@implementation AISWeatherForRunAndClothesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.weatherForRun = [[AISSpecialWeatherForRun alloc] init];
    self.locationManager = [CLLocationManager new];
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    self.downloadService = [AISDownloadService new];
    self.downloadService.delegate = self;
    [self.downloadService loadWeatherData:self.locationManager.location];
    [self configureUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
}

-(void)configureUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.currentWeatherLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - AISCurrentWeatherLabelWidth / 2, self.view.frame.size.height / 2 - AISCurrentWeatherLabelHeight / 2, AISCurrentWeatherLabelWidth, AISCurrentWeatherLabelHeight)];
    self.currentWeatherLabel.textAlignment = NSTextAlignmentCenter;
    self.currentWeatherLabel.font = [UIFont systemFontOfSize:30];
    self.currentWeatherLabel.transform = CGAffineTransformScale(self.currentWeatherLabel.transform, 1, 1);
    
    self.activityLoadIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - AISactivityIndicatorViewScale / 2, self.view.frame.size.height / 2 - AISactivityIndicatorViewScale / 2, AISactivityIndicatorViewScale, AISactivityIndicatorViewScale)];
    self.activityLoadIndicator.layer.cornerRadius = 12;
    self.activityLoadIndicator.backgroundColor = UIColor.grayColor;
    self.activityLoadIndicator.alpha = 0.4;
    
    self.tShirtImageView = [[UIImageView alloc] initWithFrame:CGRectMake(AISTopImageViewOffsetx, AISTopImageViewOffsety, self.view.frame.size.width - AISTopImageViewOffsetx * 2, AISTopImageViewHeight)];
    self.tShirtImageView.image = [UIImage imageNamed:@"shirtSleeveShort"];
    
    [self.view addSubview:self.tShirtImageView];
    [self.view addSubview:self.currentWeatherLabel];
    [self.view addSubview:self.activityLoadIndicator];
    [self.activityLoadIndicator startAnimating];
    self.tShirtImageView.alpha = 0.0;
}

-(void)updateUI
{
    [self.activityLoadIndicator stopAnimating];
    self.currentWeatherLabel.text = self.weatherForRun.temperatureString;
    [self megaAnimation];
}

-(void)megaAnimation
{
    CGRect newCurrentWeatherLabelRect = CGRectMake(0, 70, 100, 40);
    
    [UIView animateWithDuration:2.0 delay:0.4 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.currentWeatherLabel.frame = newCurrentWeatherLabelRect;
        self.currentWeatherLabel.transform = CGAffineTransformScale(self.currentWeatherLabel.transform, 0.5, 0.5);
        self.tShirtImageView.alpha = 1.0;
    } completion:^(BOOL finished) {
        self.currentWeatherLabel = [[UILabel alloc] initWithFrame:newCurrentWeatherLabelRect];
        self.currentWeatherLabel.font = [UIFont systemFontOfSize:15];
    }];
}

@end
