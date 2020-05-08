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

{ #category : #helpers }
ChanelMethodRewriterCleanerTest >> assertClassSide: original isRewrittenAs: expected [
	class ifNil: [ self error: 'To use this method you need to setup the class variable' ].

	self assert: original isRewrittenAs: expected in: class class
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
