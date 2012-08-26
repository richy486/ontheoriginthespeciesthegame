//
//  Fish.m
//  Evolution
//
//  Created by Richard Adem on 26/08/12.
//
//

#import "Fish.h"
#import "GameConfig.h"

@interface Fish()
@property (nonatomic, retain) CCSprite *fishSprite;

@end

@implementation Fish

- (id) init
{
    self = [super init];
    if (self)
    {
        CCSprite *f = [CCSprite spriteWithFile:@"fish.png"];
        
        [f setScale:0.5];
        [self addChild:f];
        self.fishSprite = f;
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"explode.plist"];
    }
    return self;
}

- (void) setUp
{
    [self.fishSprite setVisible:YES];
    [self setPosition:ccp((arc4random()%(int)WIDTH) - WIDTH
                       , arc4random()%(int)(HEIGHT * 0.35))];
    self.speed = 100 + ((float)(arc4random()%100));
    self.fresh = YES;
}



- (void) fireFish:(float) power
{
    self.fresh = NO;
    
    float animationTime = 1.0;
    
    float amount = power * 300;
    
    ccBezierConfig bezier;
    bezier.controlPoint_1 = ccp(self.position.x, self.position.y + amount);
    bezier.controlPoint_2 = ccp(self.position.x + animationTime * self.speed, self.position.y + amount);
    bezier.endPosition = ccp(self.position.x + animationTime * self.speed, self.position.y + amount - 50);
    CCBezierTo *bezierAction = [CCBezierTo actionWithDuration:animationTime bezier:bezier];
    
    CCCallFunc *landFunct = [CCCallFunc actionWithTarget:self selector:@selector(land)];
    
    [self runAction:[CCSequence actionOne:bezierAction
                                      two:landFunct]];
}

- (void) land
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(fishDidLand:)])
    {
        [self.delegate fishDidLand:self];
    }
    else
    {
        [self explode];
    }
}

- (void) explode
{
    [self.fishSprite setVisible:NO];
    
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"explode.png"];
    [self addChild:spriteSheet];
    
    NSMutableArray *walkAnimFrames = [NSMutableArray arrayWithCapacity:7];
    for (int i = 0; i < 4; ++i)
    {
        NSString *name;
        if( [[CCDirector sharedDirector] contentScaleFactor] >= 2)
        {
            name = [NSString stringWithFormat:@"explode%d-hd.png", i];
        }
        else
        {
            name = [NSString stringWithFormat:@"explode%d.png", i];
        }
        
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: name];
        [walkAnimFrames addObject: frame];
    }
    CCAnimation *walkAnim = [CCAnimation animationWithFrames:walkAnimFrames delay:0.05f];
    
    
    __block CCSprite *walkSprite = [[CCDirector sharedDirector] contentScaleFactor] >= 2
        ? [CCSprite spriteWithSpriteFrameName:@"explode0-hd.png"]
        : [CCSprite spriteWithSpriteFrameName:@"explode0.png"];
    
    CCAnimate *walkAction = [CCAnimate actionWithAnimation:walkAnim restoreOriginalFrame:NO];
    CCCallBlock *actionRemoveSelf = [CCCallBlock actionWithBlock:^{
        [walkSprite removeFromParentAndCleanup:YES];
        [self setUp];
    }];
    
    [walkSprite runAction:[CCSequence actions:walkAction, actionRemoveSelf, nil]];
    [spriteSheet addChild:walkSprite];
}
@end
