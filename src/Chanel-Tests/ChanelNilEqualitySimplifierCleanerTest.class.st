"
A ChanelNilEqualitySimplifierCleanerTest is a test class for testing the behavior of ChanelNilEqualitySimplifierCleaner
"
Class {
	#name : #ChanelNilEqualitySimplifierCleanerTest,
	#superclass : #ChanelMethodRewriterCleanerTest,
	#category : #'Chanel-Tests'
}

{ #category : #running }
ChanelNilEqualitySimplifierCleanerTest >> setUp [
	super setUp.
	class := self createDefaultClass
]

{ #category : #tests }
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

{ #category : #tests }
ChanelNilEqualitySimplifierCleanerTest >> testEqualsNil [
	self assert: '10 = nil' isRewrittenAs: '10 isNil'
]

{ #category : #tests }
ChanelNilEqualitySimplifierCleanerTest >> testIdenticalToNil [
	self assert: '10 == nil' isRewrittenAs: '10 isNil'
]

{ #category : #tests }
ChanelNilEqualitySimplifierCleanerTest >> testNotEqualsNil [
	self assert: '10 ~= nil' isRewrittenAs: '10 isNotNil'
]

{ #category : #tests }
ChanelNilEqualitySimplifierCleanerTest >> testNotIdenticalToNil [
	self assert: '10 ~~ nil' isRewrittenAs: '10 isNotNil'
]

{ #category : #tests }
ChanelNilEqualitySimplifierCleanerTest >> testReplacementDoesNotRemoveExtensions [
	class
		compile:
			('{1}
  {2}' format: {self selector . '10 = nil'})
		classified: self extensionProtocol.

	self runCleaner.

	self
		assert: (class >> self selector) sourceCode
		equals:
			('{1}
  {2}' format: {self selector . '10 isNil'}).

	self assert: (class >> self selector) protocol equals: self extensionProtocol
]

{ #category : #tests }
ChanelNilEqualitySimplifierCleanerTest >> testReplacementInTraits [
	| trait |
	trait := self createDefaultTrait.

	class setTraitComposition: trait.

	trait
		compile:
			('{1}
  {2}' format: {self selector . '10 = nil'}).

	self runCleaner.

	self
		assert: (trait >> self selector) sourceCode
		equals:
			('{1}
  {2}' format: {self selector . '10 isNil'}).

	self assert: (trait localSelectors includes: self selector).
	self deny: (class localSelectors includes: self selector)
]

{ #category : #tests }
ChanelNilEqualitySimplifierCleanerTest >> testReplacementOnClassSide [
	class class
		compile:
			('{1}
  {2}' format: {self selector . '10 = nil'}).

	self runCleaner.

	self
		assert: (class class >> self selector) sourceCode
		equals:
			('{1}
  {2}' format: {self selector . '10 isNil'})
]

{ #category : #tests }
ChanelNilEqualitySimplifierCleanerTest >> testWithNothingToReplace [
	| oldMethod |
	class
		compile:
			('{1}
	{2}' format: {self selector . '10 isNil'}).

	oldMethod := class >> self selector.
	self runCleaner.

	self
		assert: (class >> self selector) sourceCode
		equals:
			('{1}
	{2}' format: {self selector . '10 isNil'}).
	
	self assert: class >> self selector identicalTo: oldMethod
]
