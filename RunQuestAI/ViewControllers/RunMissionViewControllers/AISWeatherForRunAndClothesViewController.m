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
    
    self.currentWeatherLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 50, self.view.frame.size.height / 2 - 20, 100, 40)];
    self.currentWeatherLabel.textAlignment = NSTextAlignmentCenter;
    self.currentWeatherLabel.font = [UIFont systemFontOfSize:30];
    self.currentWeatherLabel.transform = CGAffineTransformScale(self.currentWeatherLabel.transform, 1, 1);
    
    self.activityLoadIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 20, self.view.frame.size.height / 2 - 20, 40, 40)];
    self.activityLoadIndicator.layer.cornerRadius = 12;
    self.activityLoadIndicator.backgroundColor = UIColor.grayColor;
    self.activityLoadIndicator.alpha = 0.4;
    
    self.tShirtImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 100, self.view.frame.size.width - 80, 200)];
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
    [UIView animateWithDuration:1.0 animations:^{

    }];
    
    [UIView animateWithDuration:2.0 animations:^{
        self.currentWeatherLabel.frame = CGRectMake(0, 70, 100, 40);
        self.currentWeatherLabel.transform = CGAffineTransformScale(self.currentWeatherLabel.transform, 0.5, 0.5);
        //        [self.currentWeatherLabel setFont:[UIFont systemFontOfSize:15]];
        self.tShirtImageView.alpha = 1.0;
    } completion:^(BOOL finished) {
        self.currentWeatherLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, 100, 40)];
        
        self.currentWeatherLabel.font = [UIFont systemFontOfSize:15];
    }];
}

@end
