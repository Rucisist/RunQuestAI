//
//  RunStaticsViewController.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 16.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "AISRunStaticsViewController.h"
#import "AISTranslationUnitsModel.h"
#import <GoogleMaps/GoogleMaps.h>
#import "AISPathHelperModel.h"
#import "AISgMapViewTableViewCell.h"
#import "AISlabelPaceTableViewCell.h"
#import "AISStatiscsPlotViewController.h"


@interface AISRunStaticsViewController ()

@property (nonatomic, strong) GMSMapView *mapView;
@property (nonatomic, strong) GMSMutablePath *path;
@property (nonatomic, strong) GMSPolyline *runTrack;
@property (nonatomic, strong) AISgMapViewTableViewCell *googleMapCell;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation AISRunStaticsViewController

-(instancetype)initWithRunInfo:(NSDate *)date
{
    self = [super init];
    if (self)
    {
        _someDate = [NSDate new];
        _someDate = date;
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"title" style:UIBarButtonItemStylePlain target:self action:@selector(goToGrpahViewController)];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self loadMap];
    [self configureTableView];
    [self.navigationController setNavigationBarHidden:NO];
}

-(void)configureTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[AISgMapViewTableViewCell class] forCellReuseIdentifier:@"mapCell"];
    [self.tableView registerClass:[AISlabelPaceTableViewCell class] forCellReuseIdentifier:@"paceLabelCell"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

-(void)loadMap
{
    CGRect AISGMSMapViewFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude: self.runDetails.locations.lastObject.latitude longitude:self.runDetails.locations.lastObject.longitude zoom:16];
    
    self.mapView = [GMSMapView mapWithFrame:AISGMSMapViewFrame camera:camera];
    self.mapView.myLocationEnabled = YES;
    
    //[self.view addSubview:self.mapView];
    
    self.mapView.mapType = kGMSTypeNormal;
    
    GMSMutablePath *path = [GMSMutablePath path];
    
    GMSMarker *startPointMarker = [[GMSMarker alloc] init];
    GMSMarker *endPointMarker = [[GMSMarker alloc] init];
    
    CLLocationCoordinate2D startRunPosition = CLLocationCoordinate2DMake(self.runDetails.locations.firstObject.latitude, self.runDetails.locations.firstObject.longitude);
    
    CLLocationCoordinate2D endRunPosition = CLLocationCoordinate2DMake(self.runDetails.locations.lastObject.latitude, self.runDetails.locations.lastObject.longitude);
    
    startPointMarker.position = startRunPosition;
    startPointMarker.title = @"Start";
    startPointMarker.snippet = @"Point";
    startPointMarker.map = self.mapView;
    
    endPointMarker.position = endRunPosition;
    endPointMarker.title = @"end";
    startPointMarker.snippet = @"Point";
    endPointMarker.map = self.mapView;

    AISPathHelperModel *model = [AISPathHelperModel new];
    
    GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
    
    
    for (polyline in [model calculatePaceArrayWith:self.runDetails])
    {
        polyline.strokeWidth = 5.0;
        polyline.map = self.mapView;
    }
}

-(void)goToGrpahViewController
{
    AISStatiscsPlotViewController *graphViewController = [AISStatiscsPlotViewController new];
    graphViewController.runDetails = self.runDetails;
    
    [self.navigationController pushViewController:graphViewController animated:YES];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if (indexPath.row < 1)
    {
        AISgMapViewTableViewCell *mapCell = [tableView dequeueReusableCellWithIdentifier:@"mapCell"         forIndexPath:indexPath];
        mapCell.frame = self.view.frame;
        mapCell.theText.text = @"Ниже темп";
        [self loadMap];
        self.mapView.frame = CGRectMake(0, 40, self.view.frame.size.width, 420);
        [mapCell.contentView addSubview:self.mapView];
        return mapCell;
    }
    else
    {
        NSMutableArray *ar = [AISPathHelperModel calculatePaceArrayForKmWith:self.runDetails];
        
        double delta = 0;
        
        AISlabelPaceTableViewCell *paceLabelCell = [tableView dequeueReusableCellWithIdentifier:@"paceLabelCell" forIndexPath:indexPath];
        paceLabelCell.theTextLabel.text = [AISTranslationUnitsModel stringifyPaceFrom:[ar[indexPath.row - 1] doubleValue]];
        
        paceLabelCell.paceInsectLabel.textColor = UIColor.blackColor;
        paceLabelCell.paceInsectLabel.text = [NSString stringWithFormat:@"+%@", [AISTranslationUnitsModel stringifyPaceFrom:delta]];
        
        if (indexPath.row > 1)
        {
            delta = [ar[indexPath.row-1] doubleValue] - [ar[indexPath.row-2] doubleValue];
        }
        if (delta > 0)
        {
            paceLabelCell.paceInsectLabel.textColor = UIColor.redColor;
            paceLabelCell.paceInsectLabel.text = [NSString stringWithFormat:@"+%@", [AISTranslationUnitsModel stringifyPaceFrom:delta]];
        }
        else if (delta < 0)
        {
            paceLabelCell.paceInsectLabel.textColor = UIColor.greenColor;
            paceLabelCell.paceInsectLabel.text = [NSString stringWithFormat:@"-%@", [AISTranslationUnitsModel stringifyPaceFrom:fabs(delta)]];
        }
        
        return [UITableViewCell new];
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [AISPathHelperModel calculatePaceArrayForKmWith:self.runDetails].count + 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < 1)
    {
        return self.view.frame.size.height;
    }
    else
    {
        return 100;
    }
}

-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

@end
