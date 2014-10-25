//
//  CellDivision.h
//  Cyride
//
//  Created by Anderson, Michael L on 12/8/12.
//  Copyright (c) 2012 A1 Steaksause. All rights reserved.
//

#import <Foundation/Foundation.h>

#define miniWidth 15

@interface CellDivision : NSObject{
    NSArray *titles;
    BOOL leftColumn,rightColumn,miniColumn;
}

@property (readonly) int *x;
@property (readonly) int *width;
@property (readonly) int area;
@property (readonly) int columns;

- (id)initWithDictionary:(NSDictionary *)Data andKey:(NSString *)key;
- (void)generateRowOfLabelsForHeader:(UIView *)view;
- (void)generateRowOfLabelsForCell:(UITableViewCell *)cell;
void cellDivision(int cellArea, int columns, int *cellWidth, int *cellX);

@end
