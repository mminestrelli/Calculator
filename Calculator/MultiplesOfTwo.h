//
//  MultiplesOfTwo.h
//  Calculator
//
//  Created by Mauricio Minestrelli on 7/2/14.
//  Copyright (c) 2014 Mercadolibre. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MultiplesOfTwo <NSObject>

-(NSMutableArray *) MultiplesOfTwo;
-(void) onMultipleOfTwoOperationFinished:(NSArray*) numbers;
@end
