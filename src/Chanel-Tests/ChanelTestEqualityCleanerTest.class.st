"
A ChanelTestEqualityCleanerTest is a test class for testing the behavior of ChanelTestEqualityCleaner
"
Class {
	#name : #ChanelTestEqualityCleanerTest,
	#superclass : #ChanelAbstractCleanerTest,
	#instVars : [
		'class'
	],
	#category : #'Chanel-Tests'
}

{ #category : #helpers }
ChanelTestEqualityCleanerTest >> assert: original isRewrittenAs: expected [
	class
		compile:
			('{1}
	{2}' format: {self selector . original}).

	self runCleaner.

	self
		assert: (class >> self selector) sourceCode
		equals:
			('{1}
	{2}' format: {self selector . expected})
]

{ #category : #running }
ChanelTestEqualityCleanerTest >> setUp [
	super setUp.
	class := self createTestCaseNamed: #ChanelEqualityTestCase
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
ChanelTestEqualityCleanerTest >> testShouldNotReplaceIfNotATestCase [
	"We only replace the assertion of TestCase because other objects are much poorer in term of assertions."

	class := self createClassNamed: #ChanelEqualityNotTestCase.

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
