//
//  HelloWorldLayer.m
//  dragDrop2
//
//  Created by vaibhav patel on 3/12/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "AppleSprite.h"
// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer
#include <math.h>
#import "Model.h"
#import "CCShake.h"

// HelloWorldLayer implementation
@implementation HelloWorldLayer
@synthesize model = _model;
// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init {
    if((self = [super init])) {
        self.model = [[Model alloc]init];
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_Default];
        background = [CCSprite spriteWithFile:@"Untitled-2Artboard-1Background.png"];
        background.anchorPoint = ccp(0,0);
        [self addChild:background];
        
        CCSprite *terran = [CCSprite spriteWithFile:@"terran.png"];
        terran.anchorPoint = ccp(0,0);
        [terran setScale:0.60];
        [self addChild:terran];
        
        CCSprite *tree = [CCSprite spriteWithFile:@"tree.png"];
        tree.anchorPoint = ccp(0,0);
        tree.position = ccp(0, 50);
        [tree setScale:0.60];
        [self addChild:tree];
        
        CCSprite *pie = [CCSprite spriteWithFile:@"pie.png"];
        pie.anchorPoint = ccp(0,0);
        pie.position = ccp(5, (winSize.height - (pie.contentSize.height*0.62)));
        [pie setScale:0.60];
        [self addChild:pie];
        
        scoreLabel = [[CCLabelBMFont alloc]initWithString:@"0" fntFile:@"Arial-hd.fnt"];
        scoreLabel.position = ccp(pie.contentSize.width/2, pie.contentSize.height/2);
        [pie addChild:scoreLabel];
        pie.opacity = 50.0;
        
        basket = [CCSprite spriteWithFile:@"bucket.png"];
        basket.anchorPoint = ccp(0,0);
        basket.position = ccp(winSize.width - (basket.contentSize.width*0.60),10);
        [basket setScale:0.60];
        [self addChild:basket];
        
        finishSign = [CCSprite spriteWithFile:@"sign.png"];
        finishSign.anchorPoint = ccp(0,0);
        //finishSign.position = ccp(10,winSize.height - (finishSign.contentSize.height*60));
        [finishSign setScale:0.60];
        [self addChild:finishSign];
        
        movableSprites = [[NSMutableArray alloc] init];
        NSArray *images = [NSArray arrayWithObjects:@"apple1.png",
                                                    @"apple2.png",
                                                    @"apple3.png",
                                                    @"apple4.png",
                                                    @"apple5.png",
                                                    nil];
        NSArray *images2 = [NSArray arrayWithObjects:@"apple6.png",
                                                    @"apple7.png",
                                                    @"apple8.png",
                                                    @"apple9.png",
                                                    @"apple10.png",
                                                    nil];
        
        [self drawApples:images withRadius:50.0 withOffset:1.0];
        [self drawApples:images2 withRadius:90.0 withOffset:1.2];
        
        diceImages = [[NSMutableArray alloc]init];
        CCTexture2D *dice1 = [[CCTextureCache sharedTextureCache] addImage:@"new_Dice1.png"];
        
        CCTexture2D *dice2 = [[CCTextureCache sharedTextureCache] addImage:@"new_dice2.png"];
        
        CCTexture2D *dice3 = [[CCTextureCache sharedTextureCache] addImage:@"new_dice3.png"];
        
        CCTexture2D *dice4 =  [[CCTextureCache sharedTextureCache] addImage:@"new_dice4.png"];
        
        CCTexture2D *dice5 =   [[CCTextureCache sharedTextureCache] addImage:@"new_dice5.png"];
        
        CCTexture2D *dice6 =  [[CCTextureCache sharedTextureCache] addImage:@"new_dice6.png"];
        

        [diceImages addObject:dice1];
        [diceImages addObject:dice2];
        [diceImages addObject:dice3];
        [diceImages addObject:dice4];
        [diceImages addObject:dice5];
        [diceImages addObject:dice6];
        
        diceSprite = [CCSprite spriteWithTexture: [diceImages objectAtIndex:0]];
        
        diceSprite.anchorPoint = ccp(0,0);
        
        diceSprite.position = ccp(winSize.width - (diceSprite.contentSize.width/2),
                                (winSize.height - (diceSprite.contentSize.height/2)));
        [diceSprite setScale:0.50];
        [self addChild:diceSprite];
        
        
        
        
        
        
        
        [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];

    }
    return self;
}

- (void)drawApples:(NSArray*)images
        withRadius:(float)radius
        withOffset:(float)offset
{
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    float center_y = winSize.height/2;
    float center_x = winSize.width/2;
    float theta = 0.0;
    
    for(int i = 0; i < images.count; ++i) {
        
        NSString *image = [images objectAtIndex:i];
        
        //float offsetFraction = ((float)(i+1))/(images.count+1);
        
        theta = (i+1)*(360/images.count);
        float cosTheta = (cos(theta *(M_PI/(180*offset))));
        float sinTheta = (sin(theta *(M_PI/(180*offset))));
        
        double x = (center_x) + (radius * cosTheta);
        double y = center_y + (radius * sinTheta );
        
        CGPoint position = {x,y};
        
        //AppleSprite *apple = [[AppleSprite alloc]initWith:position File:image arrayIndex:i];
        NSInteger weight = [[self.model.weightTable valueForKey:image] integerValue];
        AppleSprite *apple = [[AppleSprite alloc]initWith:position file:image arrayIndex:i weightValue:weight];
        [self addChild:apple.mySprite];
        [movableSprites addObject:apple];
    }
}
- (void)selectSpriteForTouch:(CGPoint)touchLocation {
    AppleSprite * newSprite = nil;
    for (AppleSprite *sprite in movableSprites) {
        if (CGRectContainsPoint(sprite.mySprite.boundingBox, touchLocation)) {
            newSprite = sprite;
            break;
        }
    }
    if (newSprite.mySprite != selSprite.mySprite) {
        [selSprite.mySprite stopAllActions];
        [selSprite.mySprite runAction:[CCRotateTo actionWithDuration:0.1 angle:0]];
        
        CCRotateTo * rotLeft = [CCRotateBy actionWithDuration:0.1 angle:-4.0];
        CCRotateTo * rotCenter = [CCRotateBy actionWithDuration:0.1 angle:0.0];
        CCRotateTo * rotRight = [CCRotateBy actionWithDuration:0.1 angle:4.0];
        CCSequence * rotSeq = [CCSequence actions:rotLeft, rotCenter, rotRight, rotCenter, nil];
        
        [newSprite.mySprite runAction:[CCRepeat actionWithAction:rotSeq times:10]];
        selSprite =  newSprite;
    }
    if(CGRectContainsPoint(diceSprite.boundingBox, touchLocation))
    {        
        [diceSprite stopAllActions];
        //[diceSprite runAction:[CCRotateTo actionWithDuration:0.1 angle:0]];
        //[diceSprite runAction:[CCShake actionWithDuration:.05f amplitude:ccp(16,16) dampening:false shakes:2]];
        [diceSprite runAction:[CCShake actionWithDuration:0.9f amplitude:ccp(40,40) dampening:true]];
        /*CCRotateTo * rotate = [CCRotateBy actionWithDuration:0.3 angle:360];
        CCSequence * rotSeq = [CCSequence actions:rotate, nil];
        
        [diceSprite runAction:[CCRepeat actionWithAction:rotSeq times:3]];*/
        int index = [self.model randomDice];
        self.model.diceValue = index+1;

        
        CCTexture2D * newDice = [diceImages objectAtIndex:index];
        diceSprite.texture = newDice;
    }
    
    if(CGRectContainsPoint(finishSign.boundingBox, touchLocation))
    {
        //popup a message of success or failure
        
        //update the score
        if(self.model.diceValue == self.model.currentPointsTotal)
        {
            self.model.currentScore++;
            [scoreLabel setString:[NSString stringWithFormat:@"%d",self.model.currentScore]];
        }
        
        [self.model resetAll];
    }
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    [self selectSpriteForTouch:touchLocation];
    return TRUE; 
}


- (CGPoint)boundLayerPos:(CGPoint)newPos {
    CGSize winSize = [CCDirector sharedDirector].winSize;
    CGPoint retval = newPos;
    retval.x = MIN(retval.x, 0);
    retval.x = MAX(retval.x, -background.contentSize.width+winSize.width);
    retval.y = self.position.y;
    return retval;
}

- (void)panForTranslation:(CGPoint)translation {
    if (selSprite.mySprite) {
        CGPoint newPos = ccpAdd(selSprite.mySprite.position, translation);
        selSprite.mySprite.position = newPos;
        //TODO: logic to put current toy in bin and create new toy
        if (CGRectContainsPoint(basket.boundingBox, newPos))
        {
            if(!selSprite.putInBasket){
                NSLog(@"TouchDown");
                AppleSprite *apple = [[AppleSprite alloc]initWith:selSprite.originalPosition
                                                         file:selSprite.originalFilename
                                                        arrayIndex:selSprite.index
                                      weightValue:selSprite.weight];
                [self.model addPoints:selSprite.weight];
                
                [movableSprites replaceObjectAtIndex:selSprite.index withObject:apple];
                selSprite.putInBasket = YES;
                selSprite.mySprite.opacity = 50;
                
                [self addChild:apple.mySprite];
            }
        }
    } else {
        CGPoint newPos = ccpAdd(self.position, translation);
        self.position = [self boundLayerPos:newPos];
    }
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    
    CGPoint oldTouchLocation = [touch previousLocationInView:touch.view];
    oldTouchLocation = [[CCDirector sharedDirector] convertToGL:oldTouchLocation];
    oldTouchLocation = [self convertToNodeSpace:oldTouchLocation];
    
    CGPoint translation = ccpSub(touchLocation, oldTouchLocation);
    [self panForTranslation:translation];
}



// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
    [movableSprites release];
    movableSprites = nil;
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
@end
