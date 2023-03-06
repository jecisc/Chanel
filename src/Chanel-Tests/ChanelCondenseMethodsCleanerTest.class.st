Class {
	#name : #ChanelCondenseMethodsCleanerTest,
	#superclass : #ChanelAbstractCleanerTest,
	#category : #'Chanel-Tests'
}

{ #category : #running }
ChanelCondenseMethodsCleanerTest >> setUp [

	super setUp.
	class := self createDefaultClass
]

{ #category : #tests }
ChanelCondenseMethodsCleanerTest >> testCondenseMethodsWithFinalDot [
	self assert: 'self toto
	ifFalse: [ 2 ]
	ifTrue: [ 1 ].' isRewrittenAs: 'self toto
	ifFalse: [ 2 ]
	ifTrue: [ 1 ]'
]

{ #category : #tests }
ChanelCondenseMethodsCleanerTest >> testCondenseMethodsWithSpaces [
	self assert: 'self toto 
	ifFalse: [ 2 ]
	ifTrue: [ 1 ]' isRewrittenAs: 'self toto
	ifFalse: [ 2 ]
	ifTrue: [ 1 ]'
]
