"
A ChanelConditionalSimplifierCleanerTest is a test class for testing the behavior of ChanelConditionalSimplifierCleaner
"
Class {
	#name : #ChanelConditionalSimplifierCleanerTest,
	#superclass : #ChanelAbstractCleanerTest,
	#category : #'Chanel-Tests'
}

{ #category : #running }
ChanelConditionalSimplifierCleanerTest >> setUp [
	super setUp.
	class := self createDefaultTestClass
]

{ #category : #tests }
ChanelConditionalSimplifierCleanerTest >> testIsNilIfFalse [
	self assert: '10 isNil ifFalse: [ false ]' isRewrittenAs: '10 ifNotNil: [ false ]'
]

{ #category : #tests }
ChanelConditionalSimplifierCleanerTest >> testIsNilIfFalseIfTrue [
	self assert: '10 isNil ifFalse: [ false ] ifTrue: [ true ]' isRewrittenAs: '10 ifNil: [ true ] ifNotNil: [ false ]'
]

{ #category : #tests }
ChanelConditionalSimplifierCleanerTest >> testIsNilIfTrue [
	self assert: '10 isNil ifTrue: [ false ]' isRewrittenAs: '10 ifNil: [ false ]'
]

{ #category : #tests }
ChanelConditionalSimplifierCleanerTest >> testIsNilIfTrueIfFalse [
	self assert: '10 isNil ifTrue: [ false ] ifFalse: [ true ]' isRewrittenAs: '10 ifNil: [ false ] ifNotNil: [ true ]'
]

{ #category : #tests }
ChanelConditionalSimplifierCleanerTest >> testIsNotNilIfFalse [
	self assert: '10 isNotNil ifFalse: [ false ]' isRewrittenAs: '10 ifNil: [ false ]'
]

{ #category : #tests }
ChanelConditionalSimplifierCleanerTest >> testIsNotNilIfFalseIfTrue [
	self assert: '10 isNotNil ifFalse: [ false ] ifTrue: [ true ]' isRewrittenAs: '10 ifNil: [ false ] ifNotNil: [ true ]'
]

{ #category : #tests }
ChanelConditionalSimplifierCleanerTest >> testIsNotNilIfTrue [
	self assert: '10 isNotNil ifTrue: [ false ]' isRewrittenAs: '10 ifNotNil: [ false ]'
]

{ #category : #tests }
ChanelConditionalSimplifierCleanerTest >> testIsNotNilIfTrueIfFalse [
	self assert: '10 isNotNil ifTrue: [ false ] ifFalse: [ true ]' isRewrittenAs: '10 ifNil: [ true ] ifNotNil: [ false ]'
]

{ #category : #tests }
ChanelConditionalSimplifierCleanerTest >> testReplacementDoesNotRemoveExtensions [
	class
		compile:
			('{1}
  {2}' format: {self selector . '10 isNil ifFalse: [ false ]'})
		classified: self extensionProtocol.

	self runCleaner.

	self
		assert: (class >> self selector) sourceCode
		equals:
			('{1}
  {2}' format: {self selector . '10 ifNotNil: [ false ]'}).

	self assert: (class >> self selector) protocol equals: self extensionProtocol
]

{ #category : #tests }
ChanelConditionalSimplifierCleanerTest >> testReplacementInTraits [
	| trait |
	trait := self createDefaultTrait.

	class setTraitComposition: trait.

	trait
		compile:
			('{1}
  {2}' format: {self selector . '10 isNil ifFalse: [ false ]'}).

	self runCleaner.

	self
		assert: (trait >> self selector) sourceCode
		equals:
			('{1}
  {2}' format: {self selector . '10 ifNotNil: [ false ]'}).

	self assert: (trait localSelectors includes: self selector).
	self deny: (class localSelectors includes: self selector)
]

{ #category : #tests }
ChanelConditionalSimplifierCleanerTest >> testReplacementOnClassSide [
	class class
		compile:
			('{1}
  {2}' format: {self selector . '10 isNil ifFalse: [ false ]'}).

	self runCleaner.

	self
		assert: (class class >> self selector) sourceCode
		equals:
			('{1}
  {2}' format: {self selector . '10 ifNotNil: [ false ]'})
]

{ #category : #tests }
ChanelConditionalSimplifierCleanerTest >> testWithNothingToReplace [
	| oldMethod |
	class
		compile:
			('{1}
	{2}' format: {self selector . '10 ifNotNil: [ false ]'}).

	oldMethod := class >> self selector.
	self runCleaner.

	self
		assert: (class >> self selector) sourceCode
		equals:
			('{1}
	{2}' format: {self selector . '10 ifNotNil: [ false ]'}).
	
	self assert: class >> self selector identicalTo: oldMethod
]
