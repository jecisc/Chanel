"
A ChanelRemoveAssigmentWithoutEffectCleanerTest is a test class for testing the behavior of ChanelRemoveAssigmentWithoutEffectCleaner
"
Class {
	#name : #ChanelRemoveAssigmentWithoutEffectCleanerTest,
	#superclass : #ChanelMethodRewriterCleanerTest,
	#category : #'Chanel-Tests'
}

{ #category : #running }
ChanelRemoveAssigmentWithoutEffectCleanerTest >> setUp [
	super setUp.
	class := self createDefaultClass
]

{ #category : #tests }
ChanelRemoveAssigmentWithoutEffectCleanerTest >> testRemoveUnecessaryAssigment [
	self assert: 'test := test' isRewrittenAs: ''
]

{ #category : #tests }
ChanelRemoveAssigmentWithoutEffectCleanerTest >> testRemoveUnecessaryAssigmentInDeeperScope [
	self assert: 'true ifTrue: [ test := test ]' isRewrittenAs: 'true ifTrue: [  ]'
]

{ #category : #tests }
ChanelRemoveAssigmentWithoutEffectCleanerTest >> testReplacementDoesNotRemoveExtensions [
	class
		compile:
			('{1}
  {2}' format: {self selector . 'test := test'})
		classified: self extensionProtocol.

	self runCleaner.

	self
		assert: (class >> self selector) sourceCode
		equals:
			('{1}
  {2}' format: {self selector . ''}).

	self assert: (class >> self selector) protocol equals: self extensionProtocol
]

{ #category : #tests }
ChanelRemoveAssigmentWithoutEffectCleanerTest >> testReplacementInTraits [
	| trait |
	trait := self createDefaultTrait.

	class setTraitComposition: trait.

	trait
		compile:
			('{1}
  {2}' format: {self selector . 'test := test'}).

	self runCleaner.

	self
		assert: (trait >> self selector) sourceCode
		equals:
			('{1}
  {2}' format: {self selector . ''}).

	self assert: (trait localSelectors includes: self selector).
	self deny: (class localSelectors includes: self selector)
]

{ #category : #tests }
ChanelRemoveAssigmentWithoutEffectCleanerTest >> testReplacementOnClassSide [
	class class
		compile:
			('{1}
  {2}' format: {self selector . 'test := test'}).

	self runCleaner.

	self
		assert: (class class >> self selector) sourceCode
		equals:
			('{1}
  {2}' format: {self selector . ''})
]

{ #category : #tests }
ChanelRemoveAssigmentWithoutEffectCleanerTest >> testWithNothingToReplace [
	self denyIsRewritten: 'test := test foo'
]

{ #category : #tests }
ChanelRemoveAssigmentWithoutEffectCleanerTest >> testWithNothingToReplace2 [
	self denyIsRewritten: 'test := 3'
]
