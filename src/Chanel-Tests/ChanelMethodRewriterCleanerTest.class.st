"
A ChanelMethodRewriterCleanerTest is a test class for testing the behavior of ChanelMethodRewriterCleaner
"
Class {
	#name : 'ChanelMethodRewriterCleanerTest',
	#superclass : 'ChanelAbstractCleanerTest',
	#category : 'Chanel-Tests',
	#package : 'Chanel-Tests'
}

{ #category : 'testing' }
ChanelMethodRewriterCleanerTest class >> isAbstract [
	^ self = ChanelMethodRewriterCleanerTest
]

{ #category : 'tests' }
ChanelMethodRewriterCleanerTest >> assertReplacementWasDoneIn: trait [
	self assert: (trait >> self selector) sourceCode equals: (self methodBodyFor: self replacementPair value).

	self assert: (trait localSelectors includes: self selector).
	self deny: (class localSelectors includes: self selector)
]

{ #category : 'helpers' }
ChanelMethodRewriterCleanerTest >> deny: original isRewrittenForPharo: anInteger [
	| oldMethod |
	class ifNil: [ self error: 'To use this method you need to setup the class variable' ].

	class compile: (self methodBodyFor: original).

	oldMethod := class >> self selector.

	self runCleanerForPharo: anInteger.

	self assert: class >> self selector identicalTo: oldMethod
]

{ #category : 'tests' }
ChanelMethodRewriterCleanerTest >> denyReplacementWasDoneIn: trait [
	self assert: (trait >> self selector) sourceCode equals: (self methodBodyFor: self replacementPair key).

	self assert: (trait localSelectors includes: self selector).
	self deny: (class localSelectors includes: self selector)
]

{ #category : 'helpers' }
ChanelMethodRewriterCleanerTest >> expressionWithNoReplacement [
	^ self subclassResponsibility
]

{ #category : 'helpers' }
ChanelMethodRewriterCleanerTest >> replaceInTraits [
	"Override and return false if the cleaner should not do the replacements in traits."

	^ true
]

{ #category : 'helpers' }
ChanelMethodRewriterCleanerTest >> replacementPair [
	"Should return an association of a replacement the cleaner should be able to do."

	^ self subclassResponsibility
]

{ #category : 'tests' }
ChanelMethodRewriterCleanerTest >> testReplacementDoesNotRemoveExtensions [
	class compile: (self methodBodyFor: self replacementPair key) classified: self extensionProtocolName.

	self runCleaner.

	self assert: (class >> self selector) sourceCode equals: (self methodBodyFor: self replacementPair value).

	self assert: (class >> self selector) protocolName equals: self extensionProtocolName
]

{ #category : 'tests' }
ChanelMethodRewriterCleanerTest >> testReplacementInTraits [
	| trait |
	trait := self createDefaultTrait.

	class setTraitComposition: trait.

	trait compile: (self methodBodyFor: self replacementPair key).

	self runCleaner.

	self replaceInTraits
		ifTrue: [ self assertReplacementWasDoneIn: trait ]
		ifFalse: [ self denyReplacementWasDoneIn: trait ]
]

{ #category : 'tests' }
ChanelMethodRewriterCleanerTest >> testReplacementOnClassSide [
	class ifNil: [ self error: 'To use this method you need to setup the class variable' ].

	self assert: self replacementPair key isRewrittenAs: self replacementPair value in: class class
]

{ #category : 'tests' }
ChanelMethodRewriterCleanerTest >> testWithNothingToReplace [
	self denyIsRewritten: self expressionWithNoReplacement
]
