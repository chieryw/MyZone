//
//  QWJSONMapping.m
//  QunariPhone
//
//  Created by chieryW on 14/12/1.
//  Copyright (c) 2015年 MyZone.com All rights reserved.
//

#import "MMJSONMapping.h"
#import <objc/runtime.h>

NSString *const QWJSONMAPPING_IGNORE = @"QWJSONMAPPING_IGNORE";

@implementation MMJSONMapping

+ (void)mappingObject:()object withJSON:(NSDictionary *)jsonDictionary
{
    NSArray *allKeys = [jsonDictionary allKeys];
    for (NSString *key in allKeys) {
        NSString *valueType = [MMJSONMapping getPropertyTypeWithName:key forObj:object];
        if ([valueType length] > 0) {
            id subObj = jsonDictionary[key];
            if ([MMJSONMapping isSupportClass:subObj]) {
                [(NSObject *)object setValue:subObj forKey:key];
            }
            else if ([subObj isKindOfClass:[NSArray class]]) {
                if ([MMJSONMapping isSupportClass:[subObj firstObject]]) {
                    [(NSObject *)object setValue:[subObj copy] forKey:key];
                    continue;
                }
                else if([valueType isEqualToString:QWJSONMAPPING_IGNORE]) {
                    continue;
                }
                
                NSMutableArray *subArray = [NSMutableArray array];
                for (id ssubObj in subObj) {
                    id subValue = [[NSClassFromString(valueType) alloc] init];
                    if (subValue) {
                        [MMJSONMapping mappingObject:subValue withJSON:ssubObj];
                        
                        [subArray addObject:subValue];
                    }
                }
                
                [(NSObject *)object setValue:[subArray copy] forKey:key];
            }
            else if ([subObj isKindOfClass:[NSDictionary class]]) {
                id subValue = [[NSClassFromString(valueType) alloc] init];
                [MMJSONMapping mappingObject:subValue withJSON:subObj];
                [(NSObject *)object setValue:subValue forKey:key];
            }
        }
    }
}

+ (NSString *)getPropertyTypeWithName:(NSString *)propertyName forObj:(id)obj
{
    // 从 Class 中获取属性类型
    NSString *pType = nil;
    unsigned int pCount, i;
    Class objClass = [obj class];
    while (objClass && (objClass != [NSObject class])) {
        objc_property_t *properties = class_copyPropertyList(objClass, &pCount);
        
        for (i = 0; i < pCount; i++) {
            objc_property_t property = properties[i];
            NSString *pName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            if (![pName isEqualToString:propertyName]) {
                continue;
            }
            NSString *pAttribute = [[NSString alloc] initWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
            NSString *pTypeAttribute = [pAttribute componentsSeparatedByString:@"\""][1];
            
            NSRange range = [pTypeAttribute rangeOfString:@"<"];
            if (range.location != NSNotFound) {
                if ([pTypeAttribute hasPrefix:@"NSArray"] || [pTypeAttribute hasPrefix:@"NSMutableArray"]) {
                    // 处理多 Protocol
                    NSArray *pProtocolTypes = [[[pTypeAttribute substringFromIndex:range.location + 1] substringToIndex:pTypeAttribute.length - range.location - 1] componentsSeparatedByString:@"<"];
                    for (NSString *pProtocolType in pProtocolTypes) {
                        NSString *pTypeTmp = [pProtocolType substringToIndex:[pProtocolType length] - 1];
                        if ([MMJSONMapping isMappingClass:pTypeTmp]) {
                            pType = pTypeTmp;
                            break;
                        }
                    }
                }
                else {
                    pType = [pTypeAttribute substringToIndex:range.location];
                }
            }
            else {
                if ([pTypeAttribute hasPrefix:@"NSArray"] || [pTypeAttribute hasPrefix:@"NSMutableArray"]) {
                    // 数组类型 但没有指定解析类型 不解析非基础类型
                    pType = QWJSONMAPPING_IGNORE;
                }
                else {
                    pType = pTypeAttribute;
                }
            }
            break;
        }
        
        free(properties);
        // 遍历父类
        if (!pType) {
            objClass = [objClass superclass];
        }
        else {
            break;
        }
    }
    
    return pType;
}

+ (BOOL)isMappingClass:(NSString *)targetClass
{
    return [[[NSClassFromString(targetClass) alloc] init] isKindOfClass:[MMSearchNetResult class]];
}

+ (BOOL)isSupportClass:(id)obj
{
    return [obj isKindOfClass:[NSString class]] ||
    [obj isKindOfClass:[NSNumber class]] ||
    [obj isKindOfClass:[NSDate class]];
}

@end
