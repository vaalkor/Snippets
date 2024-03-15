const NodeType = {
    ELEMENT: 1,
    ATTRIBUTE: 2,
    TEXT: 3,
    CDATA_SECTION: 4,
    ENTITY_REFERENCE: 5, // Deprecated
    ENTITY: 6, // Deprecated
    PROCESSING_INSTRUCTION: 7,
    COMMENT: 8,
    DOCUMENT: 9,
    DOCUMENT_TYPE: 10,
    DOCUMENT_FRAGMENT: 11,
    NOTATION: 12 // Deprecated
  };
  
  
function $e(t='div', ...args){
    args = args.flatMap(x => x).filter(x => x);
    let props = {};
    let children = args;
    if(args.length){
      if(!args.slice(1).every(x => (typeof(x) === 'object' && x.nodeType !== undefined) || typeof(x) !== 'object'))
        { console.error('All child objects must be DOM nodes. An optional properties object can be provided as the FIRST argument after the tag.'); return; }
      if(typeof(args[0]) === 'object' && args[0].nodeType === undefined){
        props = args[0];
        children = args.slice(1);
      }
    }
  
    let newElement = document.createElement(t);
    Object.assign(newElement, props);
    newElement.append(...children);
    return newElement;
}
  
/// TESTS ///

function testFunc(){};

// Test1: Test basic functionality
let el1 = $e('div', {onclick: testFunc, checked: true}, 'Wanker', 'Noodles');
console.assert(el1.childNodes.length === 2, 'There must be 2 child nodes');
console.assert(new Array(...el1.childNodes).every(x => x.nodeType === NodeType.TEXT), 'All child nodes must be text nodes');
console.assert(el1.onclick === testFunc, 'The onclick property must be set correctly.');
console.assert(el1.checked === true, 'The checked propery must be set correctly');
console.assert(el1.tagName === 'DIV', 'The tagname must be set correctly')

// Test2: Only the first element can be a properties object, the rest have to be dom nodes or primitives.
let test2Result = $e('div', $e('p', 'someText'), {prop1: 'someValue'}, $e('p', 'someText'));
console.assert(test2Result === undefined, 'Test 2 should fail because the properties object is provided after the first argument. It can only be the first.')

// Test full functionality...
let el2 = $e('div', {randomProp1: 'test', randomProp2: 666}, 1, 'Noodles', undefined, $e('p', 'chungus'), [1, null,2], $e('p', 'mungus'))
console.assert(el2.childNodes.length === 6)