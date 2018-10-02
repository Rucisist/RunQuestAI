//
//  AISMathModel.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 11.03.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "AISMathModel.h"

@implementation AISMathModel

+(NSMutableArray *)smoothMedianFor:(NSMutableArray *)array withWindo:(NSUInteger)w
{
    NSUInteger sizeOfArray = array.count;
    NSUInteger i = 0;
    NSUInteger j = 0;
    double sum = 0;
    double count = 0;
    
    NSMutableArray *filteredArray = [NSMutableArray new];
    if (w >= sizeOfArray) {
        w = sizeOfArray - 2;
    }
    while (i < sizeOfArray-1) {
        if ((i > w) && (i<sizeOfArray-w-2))
        {
            j = i - w;
            while (j < i + w) {
                sum = sum + [array[j] doubleValue];
                
                j = j + 1;
            }
            [filteredArray addObject:[NSNumber numberWithDouble:(sum / (2*w+1))]]; // filterComment
            sum = 0;
        }
        else if (i <= w)
        {
            j = i;
            count = 0;
            while (j < i + w) {
                sum = sum + [array[j] doubleValue];
                
                j = j + 1;
                count = count + 1;
            }
            [filteredArray addObject:[NSNumber numberWithDouble:(sum / (count))]];
            sum = 0;
            count = 0;
        }
        else if (i >= sizeOfArray-w-2)
        {
            j = i - w;
            count = 0;
            while (j < sizeOfArray - 1) {
                sum = sum + [array[j] doubleValue];
                
                j = j + 1;
                count = count + 1;
            }
            [filteredArray addObject:[NSNumber numberWithDouble:(sum / (count))]];
            sum = 0;
            count = 0;
        }
        i = i + 1;
    }
    return filteredArray;
}

@end
