//
//  PrisesCollectionViewController.h
//  RunQuestAI
//
//  Created by Андрей Илалов on 17.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrisesCollectionViewController : UIViewController <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy) NSArray *album;
@property (nonatomic, copy) NSArray *albumDescription;
@property (nonatomic, copy) NSArray *albumHelper;

@end
