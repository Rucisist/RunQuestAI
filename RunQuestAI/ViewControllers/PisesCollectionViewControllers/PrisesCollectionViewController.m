//
//  PrisesCollectionViewController.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 17.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "PrisesCollectionViewController.h"
#import "PrisesCollectionReusableView.h"
#import "PrisesCollectionViewCell.h"

@interface PrisesCollectionViewController ()

@property (nonatomic, strong) NSNumber *allDistance;

@end

@implementation PrisesCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.album = @[@"alliance",@"GELogo",@"runbuttonImage",@"SWLogo"];
    self.albumDescription = @[@"пробежать 1 км", @"пробежать 10 км", @"пробежат 50 км", @"пробежать 100 км"];
    self.albumHelper = @[@1, @10, @50, @100];
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(150, 150);
    layout.minimumLineSpacing = 20;
    
    [layout setFooterReferenceSize:CGSizeMake(100, 50)];
    [layout setHeaderReferenceSize:CGSizeMake(150, 25)];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame    collectionViewLayout:layout];
    
    self.collectionView.backgroundColor = UIColor.whiteColor;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.collectionView registerClass:[PrisesCollectionViewCell class] forCellWithReuseIdentifier:@"identifier"];
    [self.collectionView registerClass:[PrisesCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    [self.collectionView registerClass:[PrisesCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.collectionView];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.allDistance = [NSNumber numberWithDouble:[userDefaults doubleForKey:@"allDistance"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PrisesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier" forIndexPath:indexPath];
    cell.textLabel.text = self.albumDescription[indexPath.row];
    if (self.allDistance.doubleValue / 1000 >= [self.albumHelper[indexPath.row] doubleValue])
    {
        cell.priseImage.alpha = 1.0;
    }
    cell.priseImage.image = [UIImage imageNamed:[self.album objectAtIndex:indexPath.row]];

    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.album.count;
}


@end
