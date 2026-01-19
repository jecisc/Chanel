"
A ChanelNilEqualitySimplifierCleanerTest is a test class for testing the behavior of ChanelNilEqualitySimplifierCleaner
"
Class {
	#name : 'ChanelNilEqualitySimplifierCleanerTest',
	#superclass : 'ChanelMethodRewriterCleanerTest',
	#category : 'Chanel-Tests',
	#package : 'Chanel-Tests'
}

{ #category : 'helpers' }
ChanelNilEqualitySimplifierCleanerTest >> expressionWithNoReplacement [
	^ '10 isNil'
]

{ #category : 'helpers' }
ChanelNilEqualitySimplifierCleanerTest >> replacementPair [
	^ '10 = nil' -> '10 isNil'
]

{ #category : 'running' }
ChanelNilEqualitySimplifierCleanerTest >> setUp [
	super setUp.
	class := self createDefaultClass
]

{ #category : 'tests' }
ChanelNilEqualitySimplifierCleanerTest >> testDoesNotReplaceIfItIntroduceAnInfinitLoop [
	| oldMethod |
	class
		compile:
			'isNil
  ^self = nil'.

	oldMethod := class >> #isNil.

	self runCleaner.

	self
		assert: (class >> #isNil) sourceCode
		equals:
			'isNil
  ^self = nil'.

	self assert: class >> #isNil identicalTo: oldMethod
]

{ #category : 'tests' }
ChanelNilEqualitySimplifierCleanerTest >> testEqualsNil [
	self assert: '10 = nil' isRewrittenAs: '10 isNil'
]

{ #category : 'tests' }
ChanelNilEqualitySimplifierCleanerTest >> testIdenticalToNil [
	self assert: '10 == nil' isRewrittenAs: '10 isNil'
]

{ #category : 'tests' }
ChanelNilEqualitySimplifierCleanerTest >> testNotEqualsNil [
	self assert: '10 ~= nil' isRewrittenAs: '10 isNotNil'
]

{ #category : 'tests' }
ChanelNilEqualitySimplifierCleanerTest >> testNotIdenticalToNil [
	self assert: '10 ~~ nil' isRewrittenAs: '10 isNotNil'
]
