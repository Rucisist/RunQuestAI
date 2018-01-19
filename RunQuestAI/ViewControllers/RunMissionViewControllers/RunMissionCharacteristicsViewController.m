//
//  RunMissionCharacteristicsViewController.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 15.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "RunMissionCharacteristicsViewController.h"
#import "AISTranslationUnitsModel.h"
#import "Location+CoreDataProperties.h"
#import "Run+CoreDataProperties.h"
#import "MainViewTabbarController.h"
#import "AppDelegate.h"
#import "AISDataService.h"
#import "AISTargetAllocatorHelper.h"
#import "RunMissionMapViewController.h"
#import "AISSystemSpeaker.h"
#import "AISRealVoicesPlayer.h"
#import "AISCustomRunView.h"

static CGFloat paceTimeDTAlabelWidth = 100;
static CGFloat paceTimeDTAlabelHeight = 50;
static CGFloat pauseButtonDiameter = 100;
static CGFloat pauseButtonSpaceFromCenter = 100;

@interface RunMissionCharacteristicsViewController ()

@property int seconds;
@property float distance;
@property float distanceToAim;
@property (nonatomic, strong) NSMutableArray *locations;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) Run *run;
@property (nonatomic, strong) UILabel *paceLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *distanceToAimLabel;
@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UIVisualEffectView *blurEffectView;
@property (nonatomic, strong) UIButton *pauseButton;
@property (nonatomic, strong) UIButton *stopButton;
@property (nonatomic, strong) UIButton *resumeButton;
@property (nonatomic) CGRect viewFrame;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) AISDataService *dataService;
@property (nonatomic, strong) AISTargetAllocatorHelper *targetAllocator;
@property (nonatomic, strong) CLLocation *targetLocation;
@property (nonatomic, strong) UIButton *mapViewOpenButton;
@property (nonatomic, strong) AISSystemSpeaker *speaker;
@property (nonatomic, strong) AISRealVoicesPlayer *voicePlayer;

@end

@implementation RunMissionCharacteristicsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addBackgroundView];
    
    
    self.distanceToAim = 0;
    self.targetAllocator = [AISTargetAllocatorHelper new];
    
    self.speaker = [AISSystemSpeaker new];
    self.voicePlayer = [AISRealVoicesPlayer new];
    
    self.mapViewOpenButton = [UIButton new];
    self.mapViewOpenButton.frame = CGRectMake(20, 20, 40, 40);
    [self.mapViewOpenButton setTitle:@"🗺" forState:UIControlStateNormal];
    //self.mapViewOpenButton.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.mapViewOpenButton];
    
    [self.mapViewOpenButton addTarget:self action:@selector(openMapViewAndPaintaRouteWith) forControlEvents:UIControlEventTouchUpInside];
    
    self.targetLocation = [self.targetAllocator randomLocationInMoscowCenter];
    
    self.dataService = [AISDataService new];
    self.viewFrame = self.view.frame;
    [self configureUI];
    [self startRun];
    
    self.paceLabel.text = @"0.00";
    self.timeLabel.text = @"0";
    self.distanceToAimLabel.text = @"0";
    
    [self changeColorOfLabelsTo:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
}

-(void)configureLocationManager
{
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    
}

-(void)openMapViewAndPaintaRouteWith
{
    RunMissionMapViewController *mapViewController = [[RunMissionMapViewController alloc] initWithRoute:self.locations];
    [self.navigationController pushViewController:mapViewController animated:YES];
}

- (void)startLocationUpdates
{
    if (self.locationManager == nil) {
        self.locationManager = [[CLLocationManager alloc] init];
    }
    
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.activityType = CLActivityTypeFitness;
    
    self.locationManager.allowsBackgroundLocationUpdates = YES;
    self.locationManager.showsBackgroundLocationIndicator = YES;
    
    // Movement threshold for new events.
    self.locationManager.distanceFilter = 10; // meters
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
}

- (void)updateLabels
{
    self.timeLabel.text = [NSString stringWithFormat:@"⏱\n %@",  [AISTranslationUnitsModel stringifySecondCount:self.seconds usingLongFormat:NO]];
    self.distanceToAimLabel.numberOfLines = 2;
    self.distanceToAimLabel.text = [NSString stringWithFormat:@"%@", [AISTranslationUnitsModel stringifyDistance:self.distance]];
    self.paceLabel.text = [NSString stringWithFormat:@"Темп\n%@",  [AISTranslationUnitsModel stringifyAvgPaceFromDist:self.distance overTime:self.seconds]];
    self.distanceLabel.text = [NSString stringWithFormat:@" %@", [AISTranslationUnitsModel stringifyDistance:self.distanceToAim]];
}

-(void)addBackgroundView
{
    AISCustomRunView *customView = [[AISCustomRunView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:customView];
    customView.backgroundColor = [UIColor blackColor];
    [self.view sendSubviewToBack:customView];
}

-(void)speakCharacteristics
{
    NSString *timeString = [NSString stringWithFormat:@"Time is %@ minutes.",  [AISTranslationUnitsModel stringifySecondCount:self.seconds usingLongFormat:NO]];
    NSString *distanceString = [NSString stringWithFormat:@"Distance: %@.", [AISTranslationUnitsModel stringifyDistance:self.distance]];
    NSString *paceString = [NSString stringWithFormat:@"Pace: %@.",  [AISTranslationUnitsModel stringifyAvgPaceFromDist:self.distance overTime:self.seconds]];
    [self.speaker speakCharacteristicsTime:timeString pace:paceString distance:distanceString];
}

- (void)eachSecond
{
    self.seconds++;
    
    if (self.seconds % 60 == 0)
    {
        [self speakCharacteristics];
    }
    
    [self updateLabels];
}


-(void)stopButtonPressed
{
    [self pauseUpdatingLocations];
    [self saveRun];
    self.resumeButton.hidden = YES;
    [self goToBeginRunViewController];
    
}

-(void)goToBeginRunViewController
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)resumeButtonPressed
{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:(1.0) target:self selector:@selector(eachSecond) userInfo:nil repeats:YES];
    [self.locationManager startUpdatingLocation];
    [self animationForResumeButton];
}

-(void)pauseButtonPressed
{
    [self pauseUpdatingLocations];
    [self animationForPauseButton];
}

-(void)pauseUpdatingLocations
{
    [self.locationManager pausesLocationUpdatesAutomatically];
    [self.locationManager stopUpdatingLocation];
    [self.timer invalidate];
}



- (void)saveRun
{
    [self.dataService saveDataWith:self.locations duration:self.seconds distance:self.distance date:[NSDate date]];
}


-(void)pauseRun
{
    [self.locationManager stopUpdatingLocation];
}

-(void)startRun
{
    // hide the start UI
    
    self.seconds = 0;
    
    // initialize the timer
    self.timer = [NSTimer scheduledTimerWithTimeInterval:(1.0) target:self selector:@selector(eachSecond) userInfo:nil repeats:YES];
    
    [self.voicePlayer play];
    
    self.distance = 0;
    self.locations = [NSMutableArray array];
    
    [self startLocationUpdates];
}

-(void)configurePaceLabel
{
    CGFloat screenHeight = CGRectGetHeight(self.viewFrame);
    //CGFloat paceLabelWidth = paceTimeDTAlabelWidth;
    CGFloat paceLabelHeight = paceTimeDTAlabelHeight;
    CGFloat screenWidth = CGRectGetWidth(self.viewFrame);
    
    CGRect paceLabelRect = CGRectMake(0, screenHeight / 2, screenWidth / 2, paceLabelHeight);
    self.paceLabel = [[UILabel alloc] initWithFrame:paceLabelRect];
    
    self.paceLabel.numberOfLines = 2;
    
    self.paceLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.paceLabel setFont:[UIFont fontWithName:@"Helvetica" size:20]];
    
    [self.view addSubview:self.paceLabel];
}

-(void)changeColorOfLabelsTo: (UIColor*) color
{
    self.timeLabel.textColor = color;
    self.paceLabel.textColor = color;
    self.distanceLabel.textColor = color;
    self.distanceToAimLabel.textColor = color;
}

-(void)configureTimeLabel
{
    CGFloat screenHeight = CGRectGetHeight(self.viewFrame);
    CGFloat screenWidth = CGRectGetWidth(self.viewFrame);
    //CGFloat timeLabelWidth = paceTimeDTAlabelWidth;
    CGFloat timeLabelHeight = paceTimeDTAlabelHeight;
    
    CGRect timeLabelRect = CGRectMake(screenWidth/2, screenHeight / 2, screenWidth / 2, timeLabelHeight);
    self.timeLabel = [[UILabel alloc] initWithFrame:timeLabelRect];
    
    self.timeLabel.numberOfLines = 2;
    
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    
    self.timeLabel.text = @"something\n";
    
    [self.timeLabel setFont:[UIFont fontWithName:@"Helvetica" size:20]];
    
    [self.view addSubview:self.timeLabel];
}

-(void)configureDistanceToAimLabel
{
    CGFloat screenHeight = CGRectGetHeight(self.viewFrame);
    CGFloat screenWidth = CGRectGetWidth(self.viewFrame);
    CGFloat DTALabelHeigth = paceTimeDTAlabelHeight;
    
    CGRect DTARect = CGRectMake(0, screenHeight / 2 - 140, screenWidth, DTALabelHeigth *3);
    
    self.distanceToAimLabel = [[UILabel alloc] initWithFrame:DTARect];
    
    self.distanceToAimLabel.textAlignment = NSTextAlignmentCenter;
    
    self.distanceToAimLabel.numberOfLines = 2;
    
    [self.distanceToAimLabel setFont:[UIFont fontWithName:@"Helvetica" size:38]];
    
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
    
    self.pauseButton.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0 alpha:0.7];
    self.pauseButton.layer.cornerRadius = 23;
    
    [self.pauseButton addTarget:self action:@selector(pauseButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
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
        self.resumeButton.alpha = 0;
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
    
    [self.stopButton addTarget:self action:@selector(stopButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
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
    
    [self.resumeButton addTarget:self action:@selector(resumeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
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
    self.view.backgroundColor = [UIColor colorWithRed:0.4 green:0.2 blue:0.8 alpha:1.0];
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


-(void)cofigureDistanceLabel
{
    self.distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 50)];
    self.distanceLabel.text = @"distance";
    [self.view addSubview:self.distanceLabel];
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
    
    self.distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 50)];
    self.distanceLabel.text = @"distance";
    [self.view addSubview:self.distanceLabel];
    [self configureDistanceLabel];
}

-(void)configureDistanceLabel
{
    CGFloat screenHeight = CGRectGetHeight(self.viewFrame);
    CGFloat screenWidth = CGRectGetWidth(self.viewFrame);
    self.distanceLabel.frame = CGRectMake(0, 40, screenWidth, 60);
    [self.timeLabel setFont:[UIFont fontWithName:@"Helvetica" size:20]];
}


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    for (CLLocation *newLocation in locations) {
        
        NSDate *eventDate = newLocation.timestamp;
        
        NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
        
        if (fabs(howRecent) < 10.0 && newLocation.horizontalAccuracy < 20) {
            
            // update distance
            if (self.locations.count > 0) {
                self.distance += [newLocation distanceFromLocation:self.locations.lastObject];
                
                self.distanceToAim = [newLocation distanceFromLocation:self.targetLocation];
                
                
                
                CLLocationCoordinate2D coords[2];
                coords[0] = ((CLLocation *)self.locations.lastObject).coordinate;
                coords[1] = newLocation.coordinate;
                
            }
            
            [self.locations addObject:newLocation];
        }
    }
}


@end
