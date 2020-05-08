"
A ChanelTestEqualityCleanerTest is a test class for testing the behavior of ChanelTestEqualityCleaner
"
Class {
	#name : #ChanelTestEqualityCleanerTest,
	#superclass : #ChanelMethodRewriterCleanerTest,
	#category : #'Chanel-Tests'
}

{ #category : #helpers }
ChanelTestEqualityCleanerTest >> expressionWithNoReplacement [
	^ 'self assert: 3 equals: 2'
]

{ #category : #helpers }
ChanelTestEqualityCleanerTest >> replaceInTraits [
	^ false
]

{ #category : #helpers }
ChanelTestEqualityCleanerTest >> replacementPair [
	^ 'self assert: 3 = 2' -> 'self assert: 3 equals: 2'
]

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
ChanelTestEqualityCleanerTest >> testAssertIdenticalToFalse [
	self assert: 'self assert: 3 == false' isRewrittenAs: 'self deny: 3'
]

{ #category : #tests }
ChanelTestEqualityCleanerTest >> testAssertIdenticalToFalse2 [
	self assert: 'self assert: 3 identicalTo: false' isRewrittenAs: 'self deny: 3'
]

{ #category : #tests }
ChanelTestEqualityCleanerTest >> testAssertIdenticalToNotReplacedForPharo6 [
	self deny: 'self assert: 3 == 2' isRewrittenForPharo: 6
]

{ #category : #tests }
ChanelTestEqualityCleanerTest >> testAssertIdenticalToTrue [
	self assert: 'self assert: 3 == true' isRewrittenAs: 'self assert: 3'
]

{ #category : #tests }
ChanelTestEqualityCleanerTest >> testAssertIdenticalToTrue2 [
	self assert: 'self assert: 3 identicalTo: true' isRewrittenAs: 'self assert: 3'
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
ChanelTestEqualityCleanerTest >> testDenyEqualsNotReplacedForPharo6 [
	self deny: 'self deny: 3 = 2' isRewrittenForPharo: 6
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
ChanelTestEqualityCleanerTest >> testDenyIdenticalToFalse [
	self assert: 'self deny: 3 == false' isRewrittenAs: 'self assert: 3'
]

{ #category : #tests }
ChanelTestEqualityCleanerTest >> testDenyIdenticalToFalse2 [
	self assert: 'self deny: 3 identicalTo: false' isRewrittenAs: 'self assert: 3'
]

{ #category : #tests }
ChanelTestEqualityCleanerTest >> testDenyIdenticalToNotReplacedForPharo6 [
	self deny: 'self deny: 3 == 2' isRewrittenForPharo: 6
]

{ #category : #tests }
ChanelTestEqualityCleanerTest >> testDenyIdenticalToTrue [
	self assert: 'self deny: 3 == true' isRewrittenAs: 'self deny: 3'
]

{ #category : #tests }
ChanelTestEqualityCleanerTest >> testDenyIdenticalToTrue2 [
	self assert: 'self deny: 3 identicalTo: true' isRewrittenAs: 'self deny: 3'
]

{ #category : #tests }
ChanelTestEqualityCleanerTest >> testShouldNotReplaceIfNotATestCase [
	"We only replace the assertion of TestCase because other objects are much poorer in term of assertions."

	class := self createDefaultClass.

	self denyIsRewritten: 'self assert: 3 = 2'
]
