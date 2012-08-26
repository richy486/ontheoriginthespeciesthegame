//
//  Man.m
//  Evolution
//
//  Created by Richard Adem on 26/08/12.
//
//

#import "Man.h"
#import "GameConfig.h"

@interface Man()
@property (nonatomic, retain) CCSprite *fishHead;

@end

@implementation Man

- (id) init
{
    self = [super init];
    if (self)
    {
        // Body
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"man.plist"];
        
        CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"man.png"];
        [self addChild:spriteSheet];
        
        NSArray *names;
        if( [[CCDirector sharedDirector] contentScaleFactor] >= 2)
        {
            names = [NSArray arrayWithObjects:@"man0-hd.png"
                              , @"man1-hd.png"
                              , @"man2-hd.png"
                              , @"man3-hd.png"
                              , @"man2-hd.png"
                              , @"man1-hd.png"
                              , nil];
        }
        else
        {
            names = [NSArray arrayWithObjects:@"man0.png"
                     , @"man1.png"
                     , @"man2.png"
                     , @"man3.png"
                     , @"man2.png"
                     , @"man1.png"
                     , nil];
        }
        
        int index = arc4random()%[names count];
        NSMutableArray *walkAnimFrames = [NSMutableArray arrayWithCapacity:7];
        for (int i = 0; i < [names count]; ++i)
        {
            
            NSString *name = [names objectAtIndex:index];
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: name];
            [walkAnimFrames addObject: frame];
            
            if (++index >= [names count])
            {
                index = 0;
            }
        }
        CCAnimation *walkAnim = [CCAnimation animationWithFrames:walkAnimFrames delay:0.2f];
        
        
        CCSprite *walkSprite = [[CCDirector sharedDirector] contentScaleFactor] >= 2
                                ? [CCSprite spriteWithSpriteFrameName:@"man0-hd.png"]
                                : [CCSprite spriteWithSpriteFrameName:@"man0.png"];
        
        CCAction *walkAction = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:walkAnim restoreOriginalFrame:NO]];
        
        [walkSprite runAction:walkAction];
        [spriteSheet addChild:walkSprite];
        
        // Head
        CCSprite *f = [CCSprite spriteWithFile:@"fish.png"];
        
        [f setScale:0.5];
        f.position = ccp(0, 35);
        [self addChild:f];
        
        self.fishHead = f;
    }
    return self;
}

- (void) setUp
{
    self.lost = YES;
    [self.fishHead setVisible:NO];
    [self setPosition:ccp((arc4random()%(int)WIDTH) - WIDTH
                         , arc4random()%(int)(HEIGHT * 0.4) + (HEIGHT /2) )];
    
    self.speed = 100 + ((float)(arc4random()%100));
}

- (void) addedHead
{
    [self.fishHead setVisible:YES];
    self.lost = NO;
    
    float animationTime = 0.5;
    
    
//    ccBezierConfig bezier;
//    bezier.controlPoint_1 = ccp(self.position.x, self.position.y + 100);
//    bezier.controlPoint_2 = ccp(self.position.x + 100, self.position.y + 100);
//    bezier.endPosition = ccp(self.position.x + 100, self.position.y);
//    CCBezierTo *bezierAction = [CCBezierTo actionWithDuration:animationTime bezier:bezier];
    
    CCMoveBy *moveUp = [CCMoveBy actionWithDuration:animationTime/4 position:ccp(0, 40)];
    CCMoveBy *moveDown = [CCMoveBy actionWithDuration:animationTime/2 position:ccp(0, -40)];
    
    CCMoveTo *runOff = [CCMoveTo actionWithDuration:animationTime position:ccp(self.position.x + WIDTH, self.position.y)];
    
    CCCallFunc *setupFunct = [CCCallFunc actionWithTarget:self selector:@selector(setUp)];
    
    CCDelayTime *delayAction = [CCDelayTime actionWithDuration:2.0];
    
    [self runAction:[CCSequence actions:
                     moveUp
                     , moveDown
                     , moveUp
                     , moveDown
                     , runOff
                     , delayAction
                     , setupFunct
                     , nil]];
}

- (void) dealloc
{
    [_fishHead release];
    [super dealloc];
}
@end
