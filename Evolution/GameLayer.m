//
//  GameLayer.m
//  Evolution
//
//  Created by Richard Adem on 26/08/12.
//
//

#import "GameLayer.h"
#import "Fish.h"
#import "Man.h"

@interface GameLayer()
@property (nonatomic, retain) NSMutableArray *fishes;
@property (nonatomic, retain) NSMutableArray *men;
@end

CGFloat WIDTH, HEIGHT;

@implementation GameLayer

+ (CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLayer *layer = [GameLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (id) init
{
    self = [super init];
	if (self)
    {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        WIDTH = winSize.width;
        HEIGHT = winSize.height;
        
        [self schedule:@selector(update:)];
        
        CCLayerColor *layerColour = [CCLayerColor layerWithColor:ccc4(0, 96, 128, 255)];
        [self addChild:layerColour];
        
        CCLabelTTF *title = [CCLabelTTF labelWithString:@"Evolution" fontName:@"Helvetica" fontSize:24];
		title.position = ccp(WIDTH /2 , HEIGHT - 70.0);
        title.color = (ccColor3B){255, 255, 255};
		[self addChild: title];
        
        [title runAction:[CCMoveTo actionWithDuration:2.0 position:ccp(WIDTH /2 , HEIGHT + 70.0)]];
        
        const int fishCount = 10;
        self.fishes = [NSMutableArray arrayWithCapacity:fishCount];
        for (int i = 0; i < fishCount; ++i)
        {
            [self makeAFish];
        }
        
        const int menCount = 2;
        self.men = [NSMutableArray arrayWithCapacity:menCount];
        for (int i = 0; i < menCount; ++i)
        {
            [self makeAMan];
        }
        
        
    }
    return self;
}

- (void) update:(ccTime) deltaTime
{
    for (Fish *f in self.fishes)
    {
        CGFloat addTo = deltaTime * f.speed;
        if (f.position.x + addTo >= WIDTH + f.textureRect.size.width)
        {
            [f setPosition:ccp(- f.textureRect.size.width + addTo, f.position.y)];
        }
        else
        {
            [f setPosition:ccp(f.position.x + addTo, f.position.y)];
        }
    }
    
    for (Man *man in self.men)
    {
        CGFloat addTo = deltaTime * man.speed;
        if (man.position.x + addTo >= WIDTH + 100)
        {
            [man setPosition:ccp(- 100 + addTo, man.position.y)];
        }
        else
        {
            [man setPosition:ccp(man.position.x + addTo, man.position.y)];
        }
    }
}



- (void) makeAFish
{
    Fish *f = [Fish spriteWithFile:@"fish.png"];

    [f setScale:0.5];
    [f setPosition:ccp((arc4random()%(int)WIDTH) - WIDTH
                          , arc4random()%(int)(HEIGHT * 0.35))];
    f.speed = 100 + ((float)(arc4random()%100));
    [self addChild:f];
    
    [self.fishes addObject:f];
}

- (void) makeAMan
{
    Man *man = [Man node];
    [man setPosition:ccp((arc4random()%(int)WIDTH) - WIDTH
                       , arc4random()%(int)(HEIGHT * 0.4) + (HEIGHT /2) )];
    
    man.speed = 100 + ((float)(arc4random()%100));
    [self addChild:man];
    [self.men addObject:man];
}

- (void) dealloc
{
    [_fishes release];
    [super dealloc];
}

@end
