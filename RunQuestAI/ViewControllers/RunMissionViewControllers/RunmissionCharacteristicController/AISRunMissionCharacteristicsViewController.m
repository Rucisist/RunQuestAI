//
//  RunMissionCharacteristicsViewController.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 15.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "AISRunMissionCharacteristicsViewController.h"
#import "AISTranslationUnitsModel.h"
#import "Location+CoreDataProperties.h"
#import "Run+CoreDataProperties.h"
#import "AISMainViewTabbarController.h"
#import "AppDelegate.h"
#import "AISDataService.h"
#import "AISTargetAllocatorHelper.h"
#import "AISRunMissionMapViewController.h"
#import "AISSystemSpeaker.h"
#import "AISRealVoicesPlayer.h"
#import "AISCustomRunView.h"
#import "AISCharacteristicViewConfigurator.h"

@interface AISRunMissionCharacteristicsViewController ()

@property int seconds;
@property int lastSecond;
@property float distance;
@property float distanceToAim;
@property (nonatomic) BOOL isPaused;
@property (nonatomic) BOOL beenOnPause;
@property (nonatomic) CGRect viewFrame;

@property (nonatomic, strong) NSMutableArray *locations;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *targetLocation;

@property (nonatomic, strong) AISSystemSpeaker *speaker;
@property (nonatomic, strong) AISRealVoicesPlayer *voicePlayer;
@property (nonatomic, strong) Run *run;
@property (nonatomic, strong) AISDataService *dataService;
@property (nonatomic, strong) AISTargetAllocatorHelper *targetAllocator;

@property (nonatomic, strong) AISCharacteristicViewConfigurator *configurator;

@end

@implementation AISRunMissionCharacteristicsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addBackgroundView];
    
    self.configurator = [AISCharacteristicViewConfigurator new];
    
    self.configurator.delegate = self;
    
    self.distanceToAim = 0;
    self.targetAllocator = [AISTargetAllocatorHelper new];
    
    self.speaker = [AISSystemSpeaker new];
    self.voicePlayer = [AISRealVoicesPlayer new];
    
    [self configureAVSession];
    
    [self addMapButton];
    
    self.targetLocation = [self.targetAllocator randomLocationInMoscowCenter];
    
    self.dataService = [AISDataService new];
    self.viewFrame = self.view.frame;

    [self startRun];
    
    [self.configurator configureUI];
    
    [self.pauseButton addTarget:self action:@selector(pauseButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.stopButton addTarget:self action:@selector(stopButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.resumeButton addTarget:self action:@selector(resumeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
}

-(void)configureAVSession
{
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    NSError *setCategoryError = nil;
    if (![session setCategory:AVAudioSessionCategoryPlayback
                  withOptions:AVAudioSessionCategoryOptionMixWithOthers
                        error:&setCategoryError]) {
        NSLog(@"error");
    }
}

-(void)addMapButton
{
    self.mapViewOpenButton = [UIButton new];
    self.mapViewOpenButton.frame = CGRectMake(20, 20, 40, 40);
    [self.mapViewOpenButton setTitle:@"🗺" forState:UIControlStateNormal];
    
    [self.view addSubview:self.mapViewOpenButton];
    
    [self.mapViewOpenButton addTarget:self action:@selector(openMapViewAndPaintaRouteWith) forControlEvents:UIControlEventTouchUpInside];
    
    [self.mapViewOpenButton addTarget:self action:@selector(openMapViewAndPaintaRouteWith) forControlEvents:UIControlEventTouchUpInside];
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
    AISRunMissionMapViewController *mapViewController = [[AISRunMissionMapViewController alloc] initWithRoute:self.locations];
    [self.navigationController pushViewController:mapViewController animated:YES];
}

- (void)startLocationUpdates
{
    if (self.locationManager == nil)
    {
        self.locationManager = [[CLLocationManager alloc] init];
    }
    
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.activityType = CLActivityTypeFitness;
    
    self.locationManager.allowsBackgroundLocationUpdates = YES;
    self.locationManager.showsBackgroundLocationIndicator = YES;
    
    self.locationManager.distanceFilter = 10;
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
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
    self.isPaused = NO;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:(1.0) target:self selector:@selector(eachSecond) userInfo:nil repeats:YES];
    [self.locationManager startUpdatingLocation];
}

-(void)pauseButtonPressed
{
    self.beenOnPause = YES;
    self.isPaused = YES;
    [self pauseUpdatingLocations];
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
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    double distanceSaved = [userDefaults doubleForKey:@"allDistance"];
    [userDefaults setDouble:distanceSaved + self.distance forKey:@"allDistance"];
}

-(void)pauseRun
{
    [self.locationManager stopUpdatingLocation];
}

-(void)startRun
{
    self.seconds = 0;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:(1.0) target:self selector:@selector(eachSecond) userInfo:nil repeats:YES];
    
    [self.voicePlayer play];
    
    self.distance = 0;
    self.locations = [NSMutableArray array];
    
    self.isPaused = NO;
    self.beenOnPause = NO;
    
    [self startLocationUpdates];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    for (CLLocation *newLocation in locations)
    {
        NSDate *eventDate = newLocation.timestamp;
        NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
        
        if (fabs(howRecent) < 10.0 && newLocation.horizontalAccuracy < 20)
        {

            if (self.locations.count > 0)
            {
                if (!self.beenOnPause)
                {
                    self.distance += [newLocation distanceFromLocation:self.locations.lastObject];
                }
                else
                {
                    self.beenOnPause = NO;
                }
                
                self.distanceToAim = [newLocation distanceFromLocation:self.targetLocation];
                
                CLLocationCoordinate2D coords[2];
                coords[0] = ((CLLocation *)self.locations.lastObject).coordinate;
                coords[1] = newLocation.coordinate;
            }
            
            if (!self.isPaused)
            {
                [self.locations addObject:newLocation];
            }
        }
    }
}

- (void)configureUI {
    
}

@end
