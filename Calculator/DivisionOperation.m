//
//  DivisionOperation.m
//  Calculator
//
//  Created by Mauricio Minestrelli on 7/10/14.
//  Copyright (c) 2014 Mercadolibre. All rights reserved.
//

#import "DivisionOperation.h"

@implementation DivisionOperation
-(CGFloat) operate:(CGFloat) ans with: (CGFloat) value{
    return ans/value;
}

-(NSString *) operationString{
    return @"/";
}

@end
