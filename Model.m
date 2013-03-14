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
                          [NSNumber numberWithInt:1],
                          [NSNumber numberWithInt:1],
                          [NSNumber numberWithInt:1],
                           [NSNumber numberWithInt:1],
                           [NSNumber numberWithInt:1],
                           [NSNumber numberWithInt:1],
                           [NSNumber numberWithInt:1],
                           [NSNumber numberWithInt:1],
                           [NSNumber numberWithInt:1],
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
    self.currentPointsTotal = -1;
    self.diceValue = 0;
}

-(int)randomDice
{
    int index = (arc4random() % 6);
    return index;
}



@end
