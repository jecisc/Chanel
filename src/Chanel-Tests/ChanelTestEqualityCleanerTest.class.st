"
A ChanelTestEqualityCleanerTest is a test class for testing the behavior of ChanelTestEqualityCleaner
"
Class {
	#name : #ChanelTestEqualityCleanerTest,
	#superclass : #ChanelAbstractCleanerTest,
	#category : #'Chanel-Tests'
}

{ #category : #running }
ChanelTestEqualityCleanerTest >> setUp [
	super setUp.
	class := self createDefaultTestClass
]

{ #category : #tests }
ChanelTestEqualityCleanerTest >> testAssertEquals [
	self assert: 'self assert: 3 = 2' isRewrittenAs: 'self assert: 3 equals: 2'
]

{ #category : #tests }
ChanelTestEqualityCleanerTest >> testAssertEqualsFalse [
	self assert: 'self assert: 3 = false' isRewrittenAs: 'self deny: 3'
]

{ #category : #tests }
ChanelTestEqualityCleanerTest >> testAssertEqualsFalse2 [
	self assert: 'self assert: 3 equals: false' isRewrittenAs: 'self deny: 3'
]

{ #category : #tests }
ChanelTestEqualityCleanerTest >> testAssertEqualsTrue [
	self assert: 'self assert: 3 = true' isRewrittenAs: 'self assert: 3'
]

{ #category : #tests }
ChanelTestEqualityCleanerTest >> testAssertEqualsTrue2 [
	self assert: 'self assert: 3 equals: true' isRewrittenAs: 'self assert: 3'
]

{ #category : #tests }
ChanelTestEqualityCleanerTest >> testAssertIdenticalTo [
	self assert: 'self assert: 3 == 2' isRewrittenAs: 'self assert: 3 identicalTo: 2'
]

{ #category : #tests }
ChanelTestEqualityCleanerTest >> testDenyEquals [
	self assert: 'self deny: 3 = 2' isRewrittenAs: 'self deny: 3 equals: 2'
]

{ #category : #tests }
ChanelTestEqualityCleanerTest >> testDenyEqualsFalse [
	self assert: 'self deny: 3 = false' isRewrittenAs: 'self assert: 3'
]

{ #category : #tests }
ChanelTestEqualityCleanerTest >> testDenyEqualsFalse2 [
	self assert: 'self deny: 3 equals: false' isRewrittenAs: 'self assert: 3'
]

{ #category : #tests }
ChanelTestEqualityCleanerTest >> testDenyEqualsTrue [
	self assert: 'self deny: 3 = true' isRewrittenAs: 'self deny: 3'
]

{ #category : #tests }
ChanelTestEqualityCleanerTest >> testDenyEqualsTrue2 [
	self assert: 'self deny: 3 equals: true' isRewrittenAs: 'self deny: 3'
]

{ #category : #tests }
ChanelTestEqualityCleanerTest >> testDenyIdenticalTo [
	self assert: 'self deny: 3 == 2' isRewrittenAs: 'self deny: 3 identicalTo: 2'
]

{ #category : #tests }
ChanelTestEqualityCleanerTest >> testDoesNotRemoveExtensions [
	class
		compile:
			('{1}
  {2}' format: {self selector . 'self assert: 3 = 2'})
		classified: self extensionProtocol.

	self runCleaner.

	self
		assert: (class >> self selector) sourceCode
		equals:
			('{1}
  {2}' format: {self selector . 'self assert: 3 equals: 2'}).

	self assert: (class >> self selector) protocol equals: self extensionProtocol
]

{ #category : #tests }
ChanelTestEqualityCleanerTest >> testDoesNotReplaceInTraits [
	| trait |
	trait := self createDefaultTrait.

	class setTraitComposition: trait.

	trait
		compile:
			('{1}
  {2}' format: {self selector . 'self assert: 3 = 2'}).

	self runCleaner.

	self
		assert: (trait >> self selector) sourceCode
		equals:
			('{1}
  {2}' format: {self selector . 'self assert: 3 = 2'}).

	self assert: (trait localSelectors includes: self selector).
	self deny: (class localSelectors includes: self selector)
]

{ #category : #tests }
ChanelTestEqualityCleanerTest >> testReplacementOnClassSide [
	class class
		compile:
			('{1}
  {2}' format: {self selector . 'self assert: 3 = 2'}).

	self runCleaner.

	self
		assert: (class class >> self selector) sourceCode
		equals:
			('{1}
  {2}' format: {self selector . 'self assert: 3 equals: 2'})
]

{ #category : #tests }
ChanelTestEqualityCleanerTest >> testShouldNotReplaceIfNotATestCase [
	"We only replace the assertion of TestCase because other objects are much poorer in term of assertions."

	class := self createDefaultClass.

	class
		compile:
			('{1}
	{2}' format: {self selector . 'self assert: 3 = 2'}).

	self runCleaner.

	self
		assert: (class >> self selector) sourceCode
		equals:
			('{1}
	{2}' format: {self selector . 'self assert: 3 = 2'})
]

{ #category : #tests }
ChanelTestEqualityCleanerTest >> testWithNothingToReplace [
	| oldMethod |
	class
		compile:
			('{1}
	{2}' format: {self selector . 'self assert: 3 equals: 2'}).

	oldMethod := class >> self selector.
	self runCleaner.

	self
		assert: (class >> self selector) sourceCode
		equals:
			('{1}
	{2}' format: {self selector . 'self assert: 3 equals: 2'}).
	
	self assert: class >> self selector identicalTo: oldMethod
]
