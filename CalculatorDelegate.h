//
//  DrawNotificationDelegate.h
//  Calculator
//
//  Created by Mauricio Minestrelli on 7/18/14.
//  Copyright (c) 2014 Mercadolibre. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CalculatorDelegate <NSObject>
-(void) onValueUpdate:(NSString*) formula withResult:(NSString*)result;
@end
