//
//  XMLParser.m
//  Authentic Horoscope
//
//  Created by Max Davila on 1/17/15.
//  Copyright (c) 2015 Max Davila. All rights reserved.
//

#import "XMLParser.h"

@implementation XMLParser

+ (NSDictionary *)getParsedResponse:(id)response {
    return [[[XMLParser alloc] init] getParsedResponse:response];
}

- (NSDictionary *)getParsedResponse:(NSData *)response {
    self.xmlParser = [[NSXMLParser alloc] initWithData:response];
    self.xmlParser.delegate = self;
    
    // Initialize the mutable string that we'll use during parsing.
    self.foundValue = [[NSMutableString alloc] init];
    
    // Start parsing.
    [self.xmlParser parse];
    
    return self.dataStorage;

}

#pragma mark - xml parser

-(void)parserDidStartDocument:(NSXMLParser *)parser {
    // Initialize the result dict.
    self.dataStorage = [[NSMutableDictionary alloc] init];
    
}

-(void)parserDidEndDocument:(NSXMLParser *)parser {
    //    NSLog(@"Result dict %@", self.dataStorage);
    //    NSLog(@"Virgo: %@", [self.dataStorage objectForKey:@"Virgo"]);
}

-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"Parse Error: %@", [parseError localizedDescription]);
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    // If the current element name is equal to "item" then initialize the temporary dictionary.
    if ([elementName isEqualToString:@"item"]) {
        self.tempDataStorage = [[NSMutableDictionary alloc] init];
    }
    
    // Keep the current element.
    self.currentElement = elementName;
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    // Add tempDatastorage to resultArray when the desired tag closing bracked has been reached
    if ([elementName isEqualToString:@"item"]) {
        NSString *title = [self.tempDataStorage objectForKey:@"title"];
        
        NSArray *array = [title componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        array = [array filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ''"]];
        title = [array objectAtIndex:0];
        
        NSString *description = [self.tempDataStorage objectForKey:@"description"];
        
        [self.dataStorage setObject:description forKey:title];
    }
    // Add title to tempDataStorage dict.
    else if ([elementName isEqualToString:@"title"]) {
        [self.tempDataStorage setObject:[NSString stringWithString:self.foundValue] forKey:@"title"];
    }
    // Add description to tempDataStorage dict.
    else if ([elementName isEqualToString:@"description"]) {
        [self.tempDataStorage setObject:[NSString stringWithString:self.foundValue] forKey:@"description"];
    }
    
    // Clear the mutable string.
    [self.foundValue setString:@""];
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    // Stream the current string if we found the desired element.
    if ([self.currentElement isEqualToString:@"title"] ||
        [self.currentElement isEqualToString:@"description"]) {
        
        if (![string isEqualToString:@"\n"]) {
            [self.foundValue appendString:string];
        }
    }
}
@end
