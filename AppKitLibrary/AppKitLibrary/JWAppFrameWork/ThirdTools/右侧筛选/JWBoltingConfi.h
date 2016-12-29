//
//  JWBoltingConfi.h
//  AppKitLibrary
//
//  Created by jinwei on 15/11/26.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#ifndef JWBoltingConfi_h
#define JWBoltingConfi_h

#define JWBoltingRGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define JWBoltingRGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define JWBoltingRGBCOLOR_HEX(hexColor) [UIColor colorWithRed: (((hexColor >> 16) & 0xFF))/255.0f         \
green: (((hexColor >> 8) & 0xFF))/255.0f          \
blue: ((hexColor & 0xFF))/255.0f                 \
alpha: 1]


#define JWBoltingLineColor JWBoltingRGBCOLOR_HEX(0xd8d8d8)

#define JWBoltingTextGrayColor JWBoltingRGBCOLOR(119,119,119)

#define JWBoltingSelectedColor JWBoltingRGBCOLOR_HEX(0xfc0000)

#endif /* JWBoltingConfi_h */
