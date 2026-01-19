"
A ChanelRemoveAssigmentWithoutEffectCleanerTest is a test class for testing the behavior of ChanelRemoveAssigmentWithoutEffectCleaner
"
Class {
	#name : 'ChanelRemoveAssigmentWithoutEffectCleanerTest',
	#superclass : 'ChanelMethodRewriterCleanerTest',
	#category : 'Chanel-Tests',
	#package : 'Chanel-Tests'
}

{ #category : 'helpers' }
ChanelRemoveAssigmentWithoutEffectCleanerTest >> expressionWithNoReplacement [
	^ '| test |
test := test foo'
]

{ #category : 'helpers' }
ChanelRemoveAssigmentWithoutEffectCleanerTest >> replacementPair [
	 ^ 'test := test' -> ''
]

{ #category : 'running' }
ChanelRemoveAssigmentWithoutEffectCleanerTest >> setUp [
	super setUp.
	class := self createDefaultClass
]

{ #category : 'tests' }
ChanelRemoveAssigmentWithoutEffectCleanerTest >> testRemoveUnecessaryAssigment [
	self assert: 'test := test' isRewrittenAs: ''
]

{ #category : 'tests' }
ChanelRemoveAssigmentWithoutEffectCleanerTest >> testRemoveUnecessaryAssigmentInDeeperScope [
	self assert: 'true ifTrue: [ test := test ]' isRewrittenAs: 'true ifTrue: [  ]'
]

{ #category : 'tests' }
ChanelRemoveAssigmentWithoutEffectCleanerTest >> testWithNothingToReplace2 [
	self denyIsRewritten: '| test |
test := 3'
]
