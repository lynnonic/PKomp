//
//  PKComponent.m
//  PKomp
//
//  Created by Peter Kuts on 1/8/14.
//  Copyright (c) 2014 Peter Kuts. All rights reserved.
//

@implementation PKComponent

+ (instancetype)component
{
    return [[[self alloc] init] autorelease];
}

- (void)attachToEntity:(PKEntity*)entity
{
    NSAssert(!_entity, @"Component %@ already attached to entity %@", self, _entity);
    _entity = entity;
}

- (void)detachFromEntity:(PKEntity*)entity
{
    NSAssert(_entity == entity, @"Component %@ not attached to entity %@", self, entity);
    _entity = nil;
}

- (NSString*)description
{
	return [NSString stringWithFormat:@"<%@ = %p>", [self class], self];
}

@end

@implementation PKComponent(PKEvent)

- (void)postEvent:(PKEvent*)event
{
    [_entity postEvent:event];
}

- (void)subscribeForEvent:(PKEventLink*)eventLink
{
    [_entity subscribeForEvent:eventLink];
}

- (PKEventLink*)eventLink:(NSString*)event selector:(SEL)selector
{
    return [PKEventLink eventLinkWithName:event target:self selector:selector];
}

- (PKEventLink*)eventBroadcastLink:(NSString*)event selector:(SEL)selector
{
    return [PKEventBroadcastLink eventLinkWithName:event target:self selector:selector];
}

@end