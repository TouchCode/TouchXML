(load "TouchXML")

(class TestXML is NuTestCase
     (- testBasicXMLTest is
        (set theXMLDocument ((CXMLDocument alloc) initWithXMLString:"<foo/>"
                             options:0 error:(set theError ((NuReference alloc) init))))
        (assert_not_equal nil theXMLDocument)
        (assert_equal nil (theError value))
        (assert_not_equal nil (theXMLDocument rootElement))
        
        (assert_equal (theXMLDocument rootElement) (theXMLDocument rootElement))
        (assert_equal "foo" ((theXMLDocument rootElement) name)))
     
     (- testBadXMLTest is
        (set theXMLDocument ((CXMLDocument alloc) initWithXMLString:"This is invalid XML."
                             options:0 error:(set theError ((NuReference alloc) init))))
        (assert_equal nil theXMLDocument)
        (assert_not_equal nil (theError value)))
     
     (- testNodeNavigation is
        (set theXML "<root><node_1/><node_2/><node_3/></root>")
        (set theXMLDocument ((CXMLDocument alloc) initWithXMLString:theXML
                             options:0 error:(set theError ((NuReference alloc) init))))
        (assert_not_equal nil theXMLDocument)
        (assert_equal 3 ((theXMLDocument rootElement) childCount))
        
        (set theArray (theXMLDocument nodesForXPath:"/root/*" error:theError))
        (assert_not_equal nil theArray)
        (assert_equal 3 (theArray count))
        (theArray each:
             (do (theNode)
                 (assert_equal (theNode index) (theArray indexOfObject:theNode))
                 (assert_equal 2 (theNode level))))
        
        (assert_equal ((theXMLDocument rootElement) childAtIndex:0) (theArray 0))
        (assert_equal ((theXMLDocument rootElement) childAtIndex:1) (theArray 1))
        (assert_equal ((theXMLDocument rootElement) childAtIndex:2) (theArray 2))
        
        (assert_equal "node_1" ((theArray 0) name))
        (assert_equal "node_2" ((theArray 1) name))
        (assert_equal "node_3" ((theArray 2) name))
        
        (assert_equal (theArray 1) ((theArray 0) nextSibling))
        (assert_equal (theArray 2) ((theArray 1) nextSibling))
        (assert_equal nil ((theArray 2) nextSibling))
        
        (assert_equal nil ((theArray 0) previousSibling))
        (assert_equal (theArray 0) ((theArray 1) previousSibling))
        (assert_equal (theArray 1) ((theArray 2) previousSibling)))
     
     (- testBasic is
        (set theData ("<outer x='foo'><inner y='bar'/></outer>"
                              dataUsingEncoding:NSUTF8StringEncoding))
        (set theDocument ((CXMLDocument alloc) initWithData:theData
                          options:0 error:(set theError ((NuReference alloc) init))))
        
        (assert_equal nil ((theDocument rootElement) stringValue))
        (assert_equal 1 (((theDocument rootElement) children) count))
        (assert_equal (theDocument rootElement)
             ((((theDocument rootElement) children) 0) parent))
        
        (assert_equal nil (theDocument parent))
        
        (set nodes (theDocument nodesForXPath:"/outer/inner" error:nil))
        (assert_equal 1 (nodes count))
        (assert_equal "bar" (((nodes 0) attributeForName:"y") stringValue))
        
        (set nodes (theDocument nodesForXPath:"/outer/inner/@y" error:nil))
        (assert_equal 1 (nodes count))
        (assert_equal "bar" ((nodes 0) stringValue))
        
        (assert_equal "foo" (((theDocument rootElement)
                              attributeForName:"x") stringValue))
        (assert_equal "bar" (((((theDocument rootElement) elementsForName:"inner") 0)
                              attributeForName:"y") stringValue)))
          
     (- testAttributes is
        (set theXML <<-END
<root>
	<node_1/>
	<node_2 attribute_1='value_1' />
	<node_3 attribute_1='value_1' attribute_2='value_2' />
</root>
END)
        (set theXMLDocument ((CXMLDocument alloc) initWithXMLString:theXML
                             options:0 error:(set theError ((NuReference alloc) init))))
        (assert_not_equal nil theXMLDocument)
        
        (set theNodes ((theXMLDocument rootElement) elementsForName:"node_1"))
        (assert_equal 1 (theNodes count))
        (set theElement (theNodes lastObject))
        (assert_equal YES (theElement isKindOfClass:CXMLElement))
        (assert_not_equal nil (theElement attributes))
        (assert_equal 0 ((theElement attributes) count))
        
        (set theNodes ((theXMLDocument rootElement) elementsForName:"node_2"))
        (assert_equal 1 (theNodes count))
        (set theElement (theNodes lastObject))
        (assert_equal YES (theElement isKindOfClass:CXMLElement))
        (assert_not_equal nil (theElement attributes))
        (assert_equal 1 ((theElement attributes) count))
        (assert_equal ((theElement attributes) 0) (theElement attributeForName:"attribute_1"))
        (assert_equal "value_1" ((theElement attributeForName:"attribute_1") stringValue))
        
        (set theNodes ((theXMLDocument rootElement) elementsForName:"node_3"))
        (assert_equal 1 (theNodes count))
        (set theElement (theNodes lastObject))
        (assert_equal YES ((theElement isKindOfClass:CXMLElement)))
        (assert_not_equal nil (theElement attributes))
        (assert_equal 2 ((theElement attributes) count))
        (assert_equal ((theElement attributes) 0) (theElement attributeForName:"attribute_1"))
        (assert_equal ((theElement attributes) 1) (theElement attributeForName:"attribute_2"))
        (assert_equal "value_1" ((theElement attributeForName:"attribute_1") stringValue))
        (assert_equal "value_2" ((theElement attributeForName:"attribute_2") stringValue)))
     
     (- testRSS is
        (set theData (NSData dataWithContentsOfFile:"NuTests/ycombinator.rss"))
        (set theDocument ((CXMLDocument alloc) initWithData:theData
                          options:0
                          error:(set theError ((NuReference alloc) init))))
        (assert_equal "rss" ((theDocument rootElement) name))
        
        (set titles (theDocument nodesForXPath:"/rss/channel/title" error:nil))
        (assert_equal 1 (titles count))
        (assert_equal "Hacker News" ((titles 0) stringValue))
        
        (set links (theDocument nodesForXPath:"/rss/channel/link" error:nil))
        (assert_equal 1 (links count))
        (assert_equal "http://news.ycombinator.com/" ((links 0) stringValue))
        
        (set items (theDocument nodesForXPath:"/rss/channel/item" error:nil))
        (assert_equal 25 (items count))
        
        (set item (items 5))
        (assert_equal 4 ((item children) count))
        ((item children) each:
         (do (child)
             (case ((child name) stringValue)
                   ("title" (assert_equal "Should a senior in Comp Sci know what a .tar file is?"
                                 (child stringValue)))
                   ("link"  (assert_equal "http://news.ycombinator.com/item?id=131668"
                                 (child stringValue)))
                   (else nil))))))

