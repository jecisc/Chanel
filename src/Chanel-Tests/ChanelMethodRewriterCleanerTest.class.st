"
A ChanelMethodRewriterCleanerTest is a test class for testing the behavior of ChanelMethodRewriterCleaner
"
Class {
	#name : #ChanelMethodRewriterCleanerTest,
	#superclass : #ChanelAbstractCleanerTest,
	#category : #'Chanel-Tests'
}

{ #category : #testing }
ChanelMethodRewriterCleanerTest class >> isAbstract [
	^ self = ChanelMethodRewriterCleanerTest
]

{ #category : #helpers }
ChanelMethodRewriterCleanerTest >> assert: original isRewrittenAs: expected [
	class ifNil: [ self error: 'To use this method you need to setup the class variable' ].

	self assert: original isRewrittenAs: expected in: class
]

{ #category : #helpers }
ChanelMethodRewriterCleanerTest >> assert: original isRewrittenAs: expected in: aClass [
	aClass
		compile:
			('{1}
  {2}' format: {self selector . original}).

	self runCleaner.

	self
		assert: (aClass >> self selector) sourceCode
		equals:
			('{1}
  {2}' format: {self selector . expected})
]

{ #category : #tests }
ChanelMethodRewriterCleanerTest >> assertReplacementIn: aSelector wasDoneIn: trait [
	self
		assert: (trait >> aSelector) sourceCode
		equals:
			('{1}
  {2}' format: {aSelector . self replacementPair value}).

	self assert: (trait localSelectors includes: aSelector).
	self deny: (class localSelectors includes: aSelector)
]

{ #category : #helpers }
ChanelMethodRewriterCleanerTest >> deny: original isRewrittenForPharo: anInteger [
	| oldMethod |
	class ifNil: [ self error: 'To use this method you need to setup the class variable' ].

	class
		compile:
			('{1}
  {2}' format: {self selector . original}).

	oldMethod := class >> self selector.

	self runCleanerForPharo: anInteger.

	self assert: class >> self selector identicalTo: oldMethod
]

{ #category : #helpers }
ChanelMethodRewriterCleanerTest >> denyIsRewritten: aString [
	| oldMethod |
	class ifNil: [ self error: 'To use this method you need to setup the class variable' ].

	class
		compile:
			('{1}
	{2}' format: {self selector . aString}).

	oldMethod := class >> self selector.
	self runCleaner.

	self
		assert: (class >> self selector) sourceCode
		equals:
			('{1}
	{2}' format: {self selector . aString}).

	self assert: class >> self selector identicalTo: oldMethod
]

{ #category : #tests }
ChanelMethodRewriterCleanerTest >> denyReplacementIn: aSelector wasDoneIn: trait [
	self
		assert: (trait >> aSelector) sourceCode
		equals:
			('{1}
  {2}' format: {self selector . self replacementPair key}).

	self assert: (trait localSelectors includes: self selector).
	self deny: (class localSelectors includes: self selector)
]

{ #category : #helpers }
ChanelMethodRewriterCleanerTest >> expressionWithNoReplacement [
	^ self subclassResponsibility
]

{ #category : #helpers }
ChanelMethodRewriterCleanerTest >> replaceInTraits [
	"Override and return false if the cleaner should not do the replacements in traits."

	^ true
]

{ #category : #helpers }
ChanelMethodRewriterCleanerTest >> replacementPair [
	"Should return an association of a replacement the cleaner should be able to do."

	^ self subclassResponsibility
]

{ #category : #tests }
ChanelMethodRewriterCleanerTest >> testReplacementDoesNotRemoveExtensions [
	class
		compile:
			('{1}
  {2}' format: {self selector . self replacementPair key})
		classified: self extensionProtocol.

	self runCleaner.

	self
		assert: (class >> self selector) sourceCode
		equals:
			('{1}
  {2}' format: {self selector . self replacementPair value}).

	self assert: (class >> self selector) protocol equals: self extensionProtocol
]

{ #category : #tests }
ChanelMethodRewriterCleanerTest >> testReplacementInTraits [
	| trait |
	trait := self createDefaultTrait.

	class setTraitComposition: trait.

	trait
		compile:
			('{1}
  {2}' format: {self selector . self replacementPair key}).

	self runCleaner.

	self replaceInTraits
		ifTrue: [ self assertReplacementIn: self selector wasDoneIn: trait ]
		ifFalse: [ self denyReplacementIn: self selector wasDoneIn: trait ]
]

{ #category : #tests }
ChanelMethodRewriterCleanerTest >> testReplacementOnClassSide [
	class ifNil: [ self error: 'To use this method you need to setup the class variable' ].

	self assert: self replacementPair key isRewrittenAs: self replacementPair value in: class class
]

{ #category : #tests }
ChanelMethodRewriterCleanerTest >> testWithNothingToReplace [
	self denyIsRewritten: self expressionWithNoReplacement
]
