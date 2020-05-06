"
A ChanelCutConditionalBranchesCleanerTest is a test class for testing the behavior of ChanelCutConditionalBranchesCleaner
"
Class {
	#name : #ChanelCutConditionalBranchesCleanerTest,
	#superclass : #ChanelAbstractCleanerTest,
	#category : #'Chanel-Tests'
}

{ #category : #running }
ChanelCutConditionalBranchesCleanerTest >> setUp [
	super setUp.
	class := self createDefaultClass
]

{ #category : #tests }
ChanelCutConditionalBranchesCleanerTest >> testDoesNotReplaceIfItIntroduceAnInfinitLoop [
	| oldMethod |
	class
		compile:
			'ifNotNil: aBlock
  ^self ifNil: [ nil ] ifNotNil: aBlock'.

	oldMethod := class >> #ifNotNil:.

	self runCleaner.

	self
		assert: (class >> #ifNotNil:) sourceCode
		equals:
			'ifNotNil: aBlock
  ^self ifNil: [ nil ] ifNotNil: aBlock'.

	self assert: class >> #ifNotNil: identicalTo: oldMethod
]

{ #category : #tests }
ChanelCutConditionalBranchesCleanerTest >> testIfFalseIfTrue [
	self assert: 'true ifFalse: [ false ] ifTrue: [ true ]' isRewrittenAs: 'true'
]

{ #category : #tests }
ChanelCutConditionalBranchesCleanerTest >> testIfFalseIfTrue2 [
	self assert: 'true ifFalse: [ true ] ifTrue: [ false ]' isRewrittenAs: 'true not'
]

{ #category : #tests }
ChanelCutConditionalBranchesCleanerTest >> testIfNil [
	self assert: '10 ifNil: [ nil ]' isRewrittenAs: '10'
]

{ #category : #tests }
ChanelCutConditionalBranchesCleanerTest >> testIfNil2 [
	self assert: '10 ifNil: nil' isRewrittenAs: '10'
]

{ #category : #tests }
ChanelCutConditionalBranchesCleanerTest >> testIfNilIfNotNil [
	self assert: '10 ifNil: [ nil ] ifNotNil: #even' isRewrittenAs: '10 ifNotNil: #even'
]

{ #category : #tests }
ChanelCutConditionalBranchesCleanerTest >> testIfNilIfNotNil2 [
	self assert: '10 ifNil: nil ifNotNil: #even' isRewrittenAs: '10 ifNotNil: #even'
]

{ #category : #tests }
ChanelCutConditionalBranchesCleanerTest >> testIfNilIfNotNilReturningReceiver [
	self assert: 'self toto ifNil: [ self tata ] ifNotNil: [ self toto ]' isRewrittenAs: 'self toto ifNil: [ self tata ]'
]

{ #category : #tests }
ChanelCutConditionalBranchesCleanerTest >> testIfNotNilIfNil [
	self assert: '10 ifNotNil: #even ifNil: [ nil ]' isRewrittenAs: '10 ifNotNil: #even'
]

{ #category : #tests }
ChanelCutConditionalBranchesCleanerTest >> testIfNotNilIfNil2 [
	self assert: '10 ifNotNil: #even ifNil: nil' isRewrittenAs: '10 ifNotNil: #even'
]

{ #category : #tests }
ChanelCutConditionalBranchesCleanerTest >> testIfNotNilIfNilReturningReceiver [
	self assert: 'self toto ifNotNil: [ self toto ] ifNil: [ self tata ]' isRewrittenAs: 'self toto ifNil: [ self tata ]'
]

{ #category : #tests }
ChanelCutConditionalBranchesCleanerTest >> testIfNotNilReturningReceiver [
	self assert: 'self toto ifNotNil: [ self toto ]' isRewrittenAs: 'self toto'
]

{ #category : #tests }
ChanelCutConditionalBranchesCleanerTest >> testIfTrueIfFalse [
	self assert: 'true ifTrue: [ true ] ifFalse: [ false ]' isRewrittenAs: 'true'
]

{ #category : #tests }
ChanelCutConditionalBranchesCleanerTest >> testIfTrueIfFalse2 [
	self assert: 'true ifTrue: [ false ] ifFalse: [ true ]' isRewrittenAs: 'true not'
]

{ #category : #tests }
ChanelCutConditionalBranchesCleanerTest >> testReplacementDoesNotRemoveExtensions [
	class
		compile:
			('{1}
  {2}' format: {self selector . '10 ifNil: [ nil ]'})
		classified: self extensionProtocol.

	self runCleaner.

	self
		assert: (class >> self selector) sourceCode
		equals:
			('{1}
  {2}' format: {self selector . '10'}).

	self assert: (class >> self selector) protocol equals: self extensionProtocol
]

{ #category : #tests }
ChanelCutConditionalBranchesCleanerTest >> testReplacementInTraits [
	| trait |
	trait := self createDefaultTrait.

	class setTraitComposition: trait.

	trait
		compile:
			('{1}
  {2}' format: {self selector . '10 ifNil: [ nil ]'}).

	self runCleaner.

	self
		assert: (trait >> self selector) sourceCode
		equals:
			('{1}
  {2}' format: {self selector . '10'}).

	self assert: (trait localSelectors includes: self selector).
	self deny: (class localSelectors includes: self selector)
]

{ #category : #tests }
ChanelCutConditionalBranchesCleanerTest >> testReplacementOnClassSide [
	class class
		compile:
			('{1}
  {2}' format: {self selector . '10 ifNil: [ nil ]'}).

	self runCleaner.

	self
		assert: (class class >> self selector) sourceCode
		equals:
			('{1}
  {2}' format: {self selector . '10'})
]

{ #category : #tests }
ChanelCutConditionalBranchesCleanerTest >> testWithNothingToReplace [
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
