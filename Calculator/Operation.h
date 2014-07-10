//
//  Operation.h
//  Calculator
//
//  Created by Mauricio Minestrelli on 7/10/14.
//  Copyright (c) 2014 Mercadolibre. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Operation <NSObject>

-(CGFloat) operate:(CGFloat) ans with: (CGFloat) value;
@end
