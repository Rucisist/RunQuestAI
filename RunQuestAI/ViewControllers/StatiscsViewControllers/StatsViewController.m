//
//  StatsViewController.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 16.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "StatsViewController.h"
#import "StatsTableViewCell.h"
#import "AppDelegate.h"
#import "RunStaticsViewController.h"
#import "AISUserDefaultsService.h"
#import "AISDataService.h"
#import "AISTranslationUnitsModel.h"

@interface StatsViewController ()

@property (nonatomic) double allDistance;
@property (nonatomic, strong) StatsTableViewCell *statsTableViewCell;
@property (nonatomic, strong) AISDataService *dataService;
@property (nonatomic, strong) UILabel *allDistanceLabel;

@end

@implementation StatsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.dataService = [AISDataService new];
    
    
    [self fetchRequest];
    [self configureUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configureUI
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self configurateHeaderView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[StatsTableViewCell class] forCellReuseIdentifier:@"cell"];
}

-(void)configurateHeaderView
{
    CGFloat aISheaderViewHeight = 100;
    UIView *aISheaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, aISheaderViewHeight)];
    [self.tableView setTableHeaderView:aISheaderView];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    aISheaderView.backgroundColor = [UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0];
    
    self.allDistanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 100)];
    
    [self.allDistanceLabel setFont:[UIFont boldSystemFontOfSize:25]];
    [aISheaderView addSubview:self.allDistanceLabel];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self fetchRequest];
    [self.tableView reloadData];
    [self calculateTheKilometersEverRun];
}

-(void)fetchRequest
{
    self.runArray = [NSMutableArray new];
    self.runArray = [self.dataService loadAllRuns];
    [self calculateTheKilometersEverRun];
}

-(void)calculateTheKilometersEverRun
{
    double allDistanceHelper = 0;
    for (Run *object in self.runArray)
    {
        allDistanceHelper = allDistanceHelper + object.distance;
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setDouble:allDistanceHelper forKey:@"allDistance"];
    
    self.allDistanceLabel.text = [NSString stringWithFormat:@"Вы пробежали %@", [AISTranslationUnitsModel stringifyDistance:allDistanceHelper]];
    self.allDistance = allDistanceHelper;
}
    

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    StatsTableViewCell *tableViewCell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Run *runObject;
    
    runObject = [self.runArray objectAtIndex:indexPath.row];
    tableViewCell.runInfoLabel.text = [NSString stringWithFormat:@"%@", [runObject.timestamp description]];
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"DD.MM EEEE"];
    tableViewCell.runInfoLabel.text = [NSString stringWithFormat:@"Пробежка в %@", [dateFormatter stringFromDate:runObject.timestamp]];
    
    tableViewCell.distanceInfoLabel.text = [NSString stringWithFormat:@"Вы пробежали %@", [AISTranslationUnitsModel stringifyDistance:runObject.distance]];
    
    return tableViewCell;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.runArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        self.allDistance = self.allDistance - self.runArray[indexPath.row].distance;
        [self.dataService deleteRun:self.runArray[indexPath.row]];
        [self.runArray removeObjectAtIndex:indexPath.row];
        
        self.allDistanceLabel.text = [NSString stringWithFormat:@"Вы пробежали %@", [AISTranslationUnitsModel stringifyDistance:self.allDistance]];
        
        [tableView reloadData];
    }
}

-(void)actionsButtonDeletePressed
{
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Run *runInfo;
    runInfo = [self.runArray objectAtIndex:indexPath.row];
    RunStaticsViewController *runStatViewController;
    runStatViewController = [[RunStaticsViewController alloc] initWithRunInfo:runInfo.timestamp];

    runStatViewController.runDetails = runInfo;
    
    [self.navigationController pushViewController:runStatViewController animated:YES];
}


@end
