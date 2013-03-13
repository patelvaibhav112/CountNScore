//
//  Model.m
//  dragDrop2
//
//  Created by vaibhav patel on 3/12/13.
//
//

#import "Model.h"

@implementation Model
@synthesize currentPointsTotal = _currentPointsTotal;
@synthesize currentScore = _currentScore;
@synthesize weightTable = _weightTable;
@synthesize diceValue = _diceValue;

- (NSDictionary *)weightTable
{
    if(!_weightTable){
        NSArray *images = [NSArray arrayWithObjects:@"apple1.png",
                           @"apple2.png",
                           @"apple3.png",
                           @"apple4.png",
                           @"apple5.png",
                           @"apple6.png",
                           @"apple7.png",
                           @"apple8.png",
                           @"apple9.png",
                           @"apple10.png",
                           nil];
        NSArray *weight = [NSArray arrayWithObjects:
                          [NSNumber numberWithInt:1],
                          [NSNumber numberWithInt:2],
                          [NSNumber numberWithInt:3],
                          [NSNumber numberWithInt:4],
                           [NSNumber numberWithInt:5],
                           [NSNumber numberWithInt:6],
                           [NSNumber numberWithInt:7],
                           [NSNumber numberWithInt:8],
                           [NSNumber numberWithInt:9],
                           [NSNumber numberWithInt:10],
                           nil];
        _weightTable = [[NSDictionary alloc]initWithObjects:weight forKeys:images];
    }
    return _weightTable;
}
-(void)addPoints:(NSInteger)points
{
    self.currentPointsTotal+=points;
    NSLog(@"Total Points for this session: %d, Dice Value: %d", self.currentPointsTotal, self.diceValue);
}

-(void)resetAll
{
    self.currentPointsTotal = 0;
    self.currentScore = 0;
    self.diceValue = 0;
}

-(int)randomDice
{
    int index = (arc4random() % 6);
    return index;
}



@end
