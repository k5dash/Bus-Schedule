//
//  CellDivision.m
//  Cyride
//
//  Created by Anderson, Michael L on 12/8/12.
//  Copyright (c) 2012 A1 Steaksause. All rights reserved.
//

#import "CellDivision.h"

@implementation CellDivision

- (id)initWithDictionary:(NSDictionary *)Data andKey:(NSString *)key {
    titles = [[Data objectForKey:key] objectForKey:@"Stops"];
    _columns = [[[Data objectForKey:key] objectForKey:@"Stops"] count];
    leftColumn = [[Data objectForKey:key] objectForKey:@"Left Column"]!=nil;
    rightColumn = [[Data objectForKey:key] objectForKey:@"Right Column"]!=nil;
    miniColumn = leftColumn || rightColumn;
    _area = 319-miniColumn*(miniWidth+1);
    
    _x = malloc(sizeof(int)*_columns);
    _width = malloc(sizeof(int)*_columns);
    
    cellDivision(_area, _columns, _width, _x);
    return self;
}

- (void)dealloc
{
    free(_x);
    free(_width);
}

- (void)generateRowOfLabelsForHeader:(UIView *)view {
    for (int i = 0; i<_columns; i++) {
        UILabel *label = [self makeLabelWithFrame:CGRectMake(_x[i]+leftColumn*(miniWidth+1),33,_width[i],43)];
        label.tag = i+1;
        label.text = titles[i];
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.numberOfLines = 4;
        label.backgroundColor = [UIColor whiteColor];
        [view addSubview:label];
    }
    if (miniColumn) {
        UILabel *label = [self makeLabelWithFrame:CGRectMake(rightColumn*_area+1,33,miniWidth,43)];
        label.tag = -1;
        label.text = @"";
        label.backgroundColor = [UIColor whiteColor];
        [view addSubview:label];
    }
}

- (void)generateRowOfLabelsForCell:(UITableViewCell *)cell {
    for (int i = 0; i<_columns; i++) {
        UILabel *label = [self makeLabelWithFrame:CGRectMake(_x[i]+leftColumn*(miniWidth+1),0,_width[i],20)];
        label.tag = i+1;
        [cell.contentView addSubview:label];
    }
    if (miniColumn) {
        UILabel *label = [self makeLabelWithFrame:CGRectMake(rightColumn*_area+1,0,miniWidth,20)];
        label.tag = -1;
        [cell.contentView addSubview:label];
    }
}

- (id)makeLabelWithFrame:(CGRect)rect {
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.font = [UIFont systemFontOfSize:9];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

void cellDivision(int area, int columns, int *width, int *x) {
    int sum=1;
    for (int c=0; c<columns; c++) {
        width[c]=0;
    }
    for (int c=0; c<area-columns; c++) {
        width[c%columns]++;
    }
    for (int c=0; c<columns; c++) {
        x[c]=sum;
        sum+=width[c]+1;
    }
}

@end
