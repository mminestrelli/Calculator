//
//  Calculator.h
//  Calculator
//
//  Created by Mauricio Minestrelli on 7/2/14.
//  Copyright (c) 2014 Mercadolibre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MultiplesOfTwo.h"
#import "Operation.h"


@interface Calculator : NSObject

@property (nonatomic,retain) NSNumber * ans;
@property (nonatomic,assign) id<MultiplesOfTwo> delegate;


-(void)reset;

-(void) executeOperation:(id<Operation>) operation withValue: (CGFloat) value;

-(void) startCalculatingMultiple2;
@end
