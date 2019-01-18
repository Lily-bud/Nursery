//
//  NUFruit.m
//  Nursery
//
//  Created by Akifumi Takata on 2019/01/16.
//  Copyright © 2019年 Nursery-Framework. All rights reserved.
//

#import "NUFruit.h"

@implementation NUFruit

+ (id)Fruit
{
    return [self fruit];
}

+ (id)fruit
{
    return [[self alloc] init];
}

- (id)Fruit
{
    return self;
}

- (id)fruit
{
    return self;
}

@end

@implementation NUIs

+ (id)Is
{
    return [self is];
}

+ (id)is
{
    return [[self new] autorelease];
}

- (id)Is
{
    return self;
}

- (id)is
{
    return self;
}

@end

@implementation NUA

+ (id)A
{
    return [self class];
}

+ (id)a
{
    return [[self new] autorelease];
}

- (id)A
{
    return self;
}

- (id)a
{
    return self;
}

@end

@implementation NUThen

+ (id)Then
{
    return [self then];
}

+ (id)then
{
    return [[self new] autorelease];
}

- (id)Then
{
    return self;
}

- (id)then
{
    return self;
}

@end

@implementation NUFruit (No)

+ (id)No
{
    return [self class];
}

+ (id)no
{
    return [self class];
}

- (id)No
{
    return self;
}

- (id)no
{
    return self;
}

@end

@implementation NUFruit (Do)

- (id)do
{
    return self;
}

@end

@implementation NUFruit (Serially)

- (id)serially
{
    return self;
}

@end

@implementation NUFruit (DoInSerial)

//+ (id)DoInSerial;
- (id)doInSerial
{
    return self;
}

@end
