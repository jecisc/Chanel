"
A ChanelConditionalSimplifierCleanerTest is a test class for testing the behavior of ChanelConditionalSimplifierCleaner
"
Class {
	#name : #ChanelNilConditionalSimplifierCleanerTest,
	#superclass : #ChanelAbstractCleanerTest,
	#category : #'Chanel-Tests'
}

{ #category : #running }
ChanelNilConditionalSimplifierCleanerTest >> setUp [
	super setUp.
	class := self createDefaultClass
]

{ #category : #tests }
ChanelNilConditionalSimplifierCleanerTest >> testDoesNotReplaceIfItIntroduceAnInfinitLoop [
	| oldMethod |
	class
		compile:
			'ifNotNil: aBlock
  ^self isNil ifFalse: aBlock'.

	oldMethod := class >> #ifNotNil:.

	self runCleaner.

	self
		assert: (class >> #ifNotNil:) sourceCode
		equals:
			'ifNotNil: aBlock
  ^self isNil ifFalse: aBlock'.

	self assert: class >> #ifNotNil: identicalTo: oldMethod
]

{ #category : #tests }
ChanelNilConditionalSimplifierCleanerTest >> testDoesNotReplaceIfItIntroduceAnInfinitLoop2 [
	| oldMethod |
	class
		compile:
			'ifNotNil: aBlock
  self isNil ifFalse: aBlock'.

	oldMethod := class >> #ifNotNil:.

	self runCleaner.

	self
		assert: (class >> #ifNotNil:) sourceCode
		equals:
			'ifNotNil: aBlock
  self isNil ifFalse: aBlock'.

	self assert: class >> #ifNotNil: identicalTo: oldMethod
]

{ #category : #tests }
ChanelNilConditionalSimplifierCleanerTest >> testIsNilIfFalse [
	self assert: '10 isNil ifFalse: [ false ]' isRewrittenAs: '10 ifNotNil: [ false ]'
]

{ #category : #tests }
ChanelNilConditionalSimplifierCleanerTest >> testIsNilIfFalseIfTrue [
	self assert: '10 isNil ifFalse: [ false ] ifTrue: [ true ]' isRewrittenAs: '10 ifNil: [ true ] ifNotNil: [ false ]'
]

{ #category : #tests }
ChanelNilConditionalSimplifierCleanerTest >> testIsNilIfTrue [
	self assert: '10 isNil ifTrue: [ false ]' isRewrittenAs: '10 ifNil: [ false ]'
]

{ #category : #tests }
ChanelNilConditionalSimplifierCleanerTest >> testIsNilIfTrueIfFalse [
	self assert: '10 isNil ifTrue: [ false ] ifFalse: [ true ]' isRewrittenAs: '10 ifNil: [ false ] ifNotNil: [ true ]'
]

{ #category : #tests }
ChanelNilConditionalSimplifierCleanerTest >> testIsNotNilIfFalse [
	self assert: '10 isNotNil ifFalse: [ false ]' isRewrittenAs: '10 ifNil: [ false ]'
]

{ #category : #tests }
ChanelNilConditionalSimplifierCleanerTest >> testIsNotNilIfFalseIfTrue [
	self assert: '10 isNotNil ifFalse: [ false ] ifTrue: [ true ]' isRewrittenAs: '10 ifNil: [ false ] ifNotNil: [ true ]'
]

{ #category : #tests }
ChanelNilConditionalSimplifierCleanerTest >> testIsNotNilIfTrue [
	self assert: '10 isNotNil ifTrue: [ false ]' isRewrittenAs: '10 ifNotNil: [ false ]'
]

{ #category : #tests }
ChanelNilConditionalSimplifierCleanerTest >> testIsNotNilIfTrueIfFalse [
	self assert: '10 isNotNil ifTrue: [ false ] ifFalse: [ true ]' isRewrittenAs: '10 ifNil: [ true ] ifNotNil: [ false ]'
]

{ #category : #tests }
ChanelNilConditionalSimplifierCleanerTest >> testReplacementDoesNotRemoveExtensions [
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
ChanelNilConditionalSimplifierCleanerTest >> testReplacementInTraits [
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
ChanelNilConditionalSimplifierCleanerTest >> testReplacementOnClassSide [
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
ChanelNilConditionalSimplifierCleanerTest >> testWithNothingToReplace [
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
