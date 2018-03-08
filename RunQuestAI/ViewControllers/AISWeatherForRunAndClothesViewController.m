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
static const CGFloat AISImageViewOffsety = 40;
static const CGFloat AISCurrentWeatherLabelWidth = 100;
static const CGFloat AISCurrentWeatherLabelHeight = 40;
static const CGFloat AISactivityIndicatorViewScale = 40;

@interface AISWeatherForRunAndClothesViewController ()

@property (nonatomic, strong) AISDownloadService *downloadService;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) UILabel *currentWeatherLabel;
@property (nonatomic, strong) UIActivityIndicatorView *activityLoadIndicator;
@property (nonatomic, strong) UIImageView *tShirtImageView;
@property (nonatomic, strong) UIImageView *shortImageView;
@property (nonatomic, strong) UIImageView *capImageView;
@property (nonatomic, strong) UIScrollView *weatherClothesView;
@property (nonatomic, strong) UIButton *closeButton;

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
    
    self.weatherClothesView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    self.weatherClothesView.backgroundColor = UIColor.whiteColor;
    
    self.view = self.weatherClothesView;
    self.weatherClothesView.delegate = self;
    
    self.currentWeatherLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - AISCurrentWeatherLabelWidth / 2, self.view.frame.size.height / 2 - AISCurrentWeatherLabelHeight / 2, AISCurrentWeatherLabelWidth, AISCurrentWeatherLabelHeight)];
    self.currentWeatherLabel.textAlignment = NSTextAlignmentCenter;
    self.currentWeatherLabel.font = [UIFont systemFontOfSize:30];
    self.currentWeatherLabel.transform = CGAffineTransformScale(self.currentWeatherLabel.transform, 1, 1);
    
    self.activityLoadIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - AISactivityIndicatorViewScale / 2, self.view.frame.size.height / 2 - AISactivityIndicatorViewScale / 2, AISactivityIndicatorViewScale, AISactivityIndicatorViewScale)];
    self.activityLoadIndicator.layer.cornerRadius = 12;
    self.activityLoadIndicator.backgroundColor = UIColor.grayColor;
    self.activityLoadIndicator.alpha = 0.4;
    
    self.capImageView = [[UIImageView alloc] initWithFrame:CGRectMake(AISTopImageViewOffsetx, AISImageViewOffsety, self.view.frame.size.width - AISTopImageViewOffsetx * 2, AISTopImageViewHeight)];
    self.capImageView.image = [UIImage imageNamed:@"coldCap"];
    
    self.tShirtImageView = [[UIImageView alloc] initWithFrame:CGRectMake(AISTopImageViewOffsetx, self.capImageView.frame.origin.y + self.capImageView.frame.size.height + AISImageViewOffsety, self.view.frame.size.width - AISTopImageViewOffsetx * 2, AISTopImageViewHeight)];
    self.tShirtImageView.image = [UIImage imageNamed:@"shirtSleeveShort"];
    
    self.shortImageView = [[UIImageView alloc] initWithFrame:CGRectMake(AISTopImageViewOffsetx, self.tShirtImageView.frame.origin.y + self.tShirtImageView.frame.size.height + AISImageViewOffsety, self.view.frame.size.width - AISTopImageViewOffsetx * 2, AISTopImageViewHeight)];
    self.shortImageView.image = [UIImage imageNamed:@"shorts"];
    
    self.weatherClothesView.contentSize = CGSizeMake(self.view.frame.size.width, self.shortImageView.frame.origin.y + self.shortImageView.frame.size.height + AISTopImageViewOffsety);
    
    CGRect closeButtonFrame = CGRectMake(self.view.frame.size.width / 2 - 90, self.weatherClothesView.contentSize.height - 70, 180, 40);
    
    [self configureCloseButtonWithFrame:closeButtonFrame];
    
    [self.view addSubview:self.tShirtImageView];
    [self.view addSubview:self.shortImageView];
    [self.view addSubview:self.capImageView];
    [self.view addSubview:self.currentWeatherLabel];
    [self.view addSubview:self.activityLoadIndicator];
    [self.activityLoadIndicator startAnimating];
    self.capImageView.alpha = 0.0;
    self.tShirtImageView.alpha = 0.0;
    self.shortImageView.alpha = 0.0;
}

-(void)configureCloseButtonWithFrame:(CGRect)frame
{
    self.closeButton = [[UIButton alloc] initWithFrame:frame];
    [self.closeButton setTitle:@"Закрыть" forState:UIControlStateNormal];
    self.closeButton.backgroundColor = UIColor.blueColor;
    self.closeButton.layer.cornerRadius = 20;
    self.closeButton.alpha = 0;
    [self.closeButton addTarget:self action:@selector(closeController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.closeButton];
}

-(void)updateUI
{
    [self.activityLoadIndicator stopAnimating];
    self.currentWeatherLabel.text = self.weatherForRun.temperatureString;
    [self megaAnimation];
}

-(void)closeController
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)megaAnimation
{
    CGRect newCurrentWeatherLabelRect = CGRectMake(0, 30, 100, 40);
    
    [UIView animateWithDuration:2.0 delay:0.4 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.currentWeatherLabel.frame = newCurrentWeatherLabelRect;
        self.currentWeatherLabel.transform = CGAffineTransformScale(self.currentWeatherLabel.transform, 0.5, 0.5);
        self.capImageView.alpha = 1.0;
        self.tShirtImageView.alpha = 1.0;
        self.shortImageView.alpha = 1.0;
    } completion:^(BOOL finished) {
        self.currentWeatherLabel = [[UILabel alloc] initWithFrame:newCurrentWeatherLabelRect];
        self.currentWeatherLabel.font = [UIFont systemFontOfSize:15];
    }];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y > 120)
    {
        [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, 252)];
    }
}

-(float)makeAlphaWith:(NSUInteger)position
{
    float coefficient = 252 - 180;
    return (position - 180) > 0 ? (position - 180) / coefficient : 0.0;
}

@end
