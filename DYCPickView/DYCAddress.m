//
//  DYCAddress.m
//  DYCPickView
//
//  Created by DYC on 15/9/10.
//  Copyright (c) 2015年 DYC. All rights reserved.
//
#import "Address.h"
#import "DYCAddress.h"
@interface DYCAddress()<NSXMLParserDelegate>
@property (strong,nonatomic) Address *address;
@property (strong,nonatomic) NSMutableArray *array;
@property (assign,nonatomic) BOOL bAreaId;
@property (assign,nonatomic) BOOL bName;
@property (assign,nonatomic) BOOL bIndexChar;
@property (assign,nonatomic) BOOL bLevel;
@property (assign,nonatomic) BOOL bHot;
@property (assign,nonatomic) BOOL bCommend;
@property (assign,nonatomic) BOOL bPostCode;
@property (assign,nonatomic) BOOL bParentId;
@property (assign,nonatomic) BOOL bAreaCode;
@property (assign,nonatomic) BOOL bFatherCode;
@end
@implementation DYCAddress
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(BOOL)handlerAddress
{
    _array = [NSMutableArray array];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"SYS_AREA" ofType:@"xml"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:data];
    xmlParser.delegate = self;
    return [xmlParser parse];
}
-(void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"start parse");
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"RECORD"]) {
        _address = [[Address alloc] init];
    }
    if ([elementName isEqualToString:@"AREA_ID"]) {
        _bAreaId = YES;
    }
    if ([elementName isEqualToString:@"NAME"]) {
        _bName = YES;
    }
    if ([elementName isEqualToString:@"INDEX_CHAR"]) {
        _bIndexChar = YES;
    }
    if ([elementName isEqualToString:@"LEVEL"]) {
        _bLevel = YES;
    }
    if ([elementName isEqualToString:@"HOT"]) {
        _bHot = YES;
    }
    if ([elementName isEqualToString:@"COMMEND"]) {
        _bCommend = YES;
    }
    if ([elementName isEqualToString:@"POST_CODE"]) {
        _bPostCode = YES;
    }
    if ([elementName isEqualToString:@"PARENT_ID"]) {
        _bParentId = YES;
    }
    if ([elementName isEqualToString:@"AREA_CODE"]) {
        _bAreaCode = YES;
    }
    if ([elementName isEqualToString:@"FATHER_CODE"]) {
        _bFatherCode = YES;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
//    NSLog(@"%@",NSStringFromSelector(_cmd) );
    _address.areaId = _bAreaId?[string integerValue]:_address.areaId;
    _address.name = _bName?string:_address.name;
    _address.indexChar = _bIndexChar?string:_address.indexChar;
    _address.level = _bLevel?[string integerValue]:_address.level;
    _address.hot = _bLevel?[string integerValue]:_address.hot;
    _address.commend = _bCommend?[string integerValue]:_address.commend;
    _address.postCode = _bPostCode?[string integerValue]:_address.postCode;
    _address.parentId = _bParentId?[string integerValue]:_address.parentId;
    _address.areaCode = _bAreaCode?[string integerValue]:_address.areaCode;
    _address.fatherCode = _bFatherCode?[string integerValue]:_address.fatherCode;
}

//step 4 ：解析完当前节点
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
//    NSLog(@"%@",NSStringFromSelector(_cmd) );
    if ([elementName isEqualToString:@"RECORD"]) {
        switch (_address.level) {
            case 2:
            {
                [_array addObject:_address];
            }
                break;
            case 3:
            {
                for (__weak Address *parentAddress in _array) {
                    if (parentAddress.areaId == _address.parentId) {
                        [parentAddress.sonAddress addObject:_address];
                    }
                }
            }
                break;
            case 4:
            {
                for (__weak Address *parentAddress  in _array) {
                    for (__weak Address *grandAddress in parentAddress.sonAddress) {
                        if (grandAddress.areaId == _address.parentId) {
                            [grandAddress.sonAddress addObject:_address];
                        }
                    }
                }
            }
                break;
            default:
                break;
        }
        _address = nil;
    }
    if ([elementName isEqualToString:@"AREA_ID"]) {
        _bAreaId = NO;
    }
    if ([elementName isEqualToString:@"NAME"]) {
        _bName = NO;
    }
    if ([elementName isEqualToString:@"INDEX_CHAR"]) {
        _bIndexChar = NO;
    }
    if ([elementName isEqualToString:@"LEVEL"]) {
        _bLevel = NO;
    }
    if ([elementName isEqualToString:@"HOT"]) {
        _bHot = NO;
    }
    if ([elementName isEqualToString:@"COMMEND"]) {
        _bCommend = NO;
    }
    if ([elementName isEqualToString:@"POST_CODE"]) {
        _bPostCode = NO;
    }
    if ([elementName isEqualToString:@"PARENT_ID"]) {
        _bParentId = NO;
    }
    if ([elementName isEqualToString:@"AREA_CODE"]) {
        _bAreaCode = NO;
    }
    if ([elementName isEqualToString:@"FATHER_CODE"]) {
        _bFatherCode = NO;
    }
}

//step 5；解析结束
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    //    NSLog(@"%@",NSStringFromSelector(_cmd) );
    if (_dataDelegate) {
        [_dataDelegate addressList:_array];
    }
}
//获取cdata块数据
- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock
{
    //    NSLog(@"%@",NSStringFromSelector(_cmd) );
}
@end
