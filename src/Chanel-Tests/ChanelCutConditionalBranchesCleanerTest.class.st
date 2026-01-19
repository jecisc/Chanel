"
A ChanelCutConditionalBranchesCleanerTest is a test class for testing the behavior of ChanelCutConditionalBranchesCleaner
"
Class {
	#name : 'ChanelCutConditionalBranchesCleanerTest',
	#superclass : 'ChanelMethodRewriterCleanerTest',
	#category : 'Chanel-Tests',
	#package : 'Chanel-Tests'
}

{ #category : 'helpers' }
ChanelCutConditionalBranchesCleanerTest >> expressionWithNoReplacement [
	^ '10 ifNotNil: [ false ]'
]

{ #category : 'helpers' }
ChanelCutConditionalBranchesCleanerTest >> replacementPair [
	^ '10 ifNil: [ nil ]' -> '10'
]

{ #category : 'running' }
ChanelCutConditionalBranchesCleanerTest >> setUp [
	super setUp.
	class := self createDefaultClass
]

{ #category : 'tests' }
ChanelCutConditionalBranchesCleanerTest >> testAtIfPresentIfAbsent [
	self assert: 'self toto at: 2 ifPresent: [ :e | e ] ifAbsent: [ 3 ]' isRewrittenAs: 'self toto at: 2 ifAbsent: [ 3 ]'
]

{ #category : 'tests' }
ChanelCutConditionalBranchesCleanerTest >> testAtIfPresentIfAbsent2 [
	self assert: 'self toto at: 2 ifPresent: [ :e | self toto at: 2 ] ifAbsent: [ 3 ]' isRewrittenAs: 'self toto at: 2 ifAbsent: [ 3 ]'
]

{ #category : 'tests' }
ChanelCutConditionalBranchesCleanerTest >> testAtIfPresentIfAbsent3 [
	self assert: 'self toto at: 2 ifPresent: [ self toto at: 2 ] ifAbsent: [ 3 ]' isRewrittenAs: 'self toto at: 2 ifAbsent: [ 3 ]'
]

{ #category : 'tests' }
ChanelCutConditionalBranchesCleanerTest >> testDetectIfFoundIfNone [
	self assert: '#() detect: #odd ifFound: [ :e | e ] ifNone: [ self toto ]' isRewrittenAs: '#() detect: #odd ifNone: [ self toto ]'
]

{ #category : 'tests' }
ChanelCutConditionalBranchesCleanerTest >> testDetectIfFoundIfNoneNotReplacedIfThereIsAReturn [
	self denyIsRewritten: '#() detect: #odd ifFound: [ :e | ^ e ] ifNone: [ self toto ]'
]

{ #category : 'tests' }
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

{ #category : 'tests' }
ChanelCutConditionalBranchesCleanerTest >> testIfEmptyIfNotEmpty [
	self assert: 'self toto ifEmpty: [ false ] ifNotEmpty: [ self toto ]' isRewrittenAs: 'self toto ifEmpty: [ false ]'
]

{ #category : 'tests' }
ChanelCutConditionalBranchesCleanerTest >> testIfEmptyIfNotEmpty2 [
	self assert: 'self toto ifEmpty: [ false ] ifNotEmpty: [ :e | e ]' isRewrittenAs: 'self toto ifEmpty: [ false ]'
]

{ #category : 'tests' }
ChanelCutConditionalBranchesCleanerTest >> testIfFalseIfTrue [
	self assert: 'true ifFalse: [ false ] ifTrue: [ true ]' isRewrittenAs: 'true'
]

{ #category : 'tests' }
ChanelCutConditionalBranchesCleanerTest >> testIfFalseIfTrue2 [
	self assert: 'true ifFalse: [ true ] ifTrue: [ false ]' isRewrittenAs: 'true not'
]

{ #category : 'tests' }
ChanelCutConditionalBranchesCleanerTest >> testIfNil [
	self assert: '10 ifNil: [ nil ]' isRewrittenAs: '10'
]

{ #category : 'tests' }
ChanelCutConditionalBranchesCleanerTest >> testIfNil2 [
	self assert: '10 ifNil: nil' isRewrittenAs: '10'
]

{ #category : 'tests' }
ChanelCutConditionalBranchesCleanerTest >> testIfNilIfNotNil [
	self assert: '10 ifNil: [ nil ] ifNotNil: #even' isRewrittenAs: '10 ifNotNil: #even'
]

{ #category : 'tests' }
ChanelCutConditionalBranchesCleanerTest >> testIfNilIfNotNil2 [
	self assert: '10 ifNil: nil ifNotNil: #even' isRewrittenAs: '10 ifNotNil: #even'
]

{ #category : 'tests' }
ChanelCutConditionalBranchesCleanerTest >> testIfNilIfNotNilReturningReceiver [
	self assert: 'self toto ifNil: [ self tata ] ifNotNil: [ self toto ]' isRewrittenAs: 'self toto ifNil: [ self tata ]'
]

{ #category : 'tests' }
ChanelCutConditionalBranchesCleanerTest >> testIfNilIfNotNilReturningReceiver2 [
	self assert: 'self toto ifNil: [ self tata ] ifNotNil: [ :e | e ]' isRewrittenAs: 'self toto ifNil: [ self tata ]'
]

{ #category : 'tests' }
ChanelCutConditionalBranchesCleanerTest >> testIfNotEmptyIfEmpty [
	self assert: 'self toto ifNotEmpty: [ self toto ] ifEmpty: [ false ]' isRewrittenAs: 'self toto ifEmpty: [ false ]'
]

{ #category : 'tests' }
ChanelCutConditionalBranchesCleanerTest >> testIfNotEmptyIfEmpty2 [
	self assert: 'self toto ifNotEmpty: [ :e | e ] ifEmpty: [ false ]' isRewrittenAs: 'self toto ifEmpty: [ false ]'
]

{ #category : 'tests' }
ChanelCutConditionalBranchesCleanerTest >> testIfNotNilIfNil [
	self assert: '10 ifNotNil: #even ifNil: [ nil ]' isRewrittenAs: '10 ifNotNil: #even'
]

{ #category : 'tests' }
ChanelCutConditionalBranchesCleanerTest >> testIfNotNilIfNil2 [
	self assert: '10 ifNotNil: #even ifNil: nil' isRewrittenAs: '10 ifNotNil: #even'
]

{ #category : 'tests' }
ChanelCutConditionalBranchesCleanerTest >> testIfNotNilIfNilReturningReceiver [
	self assert: 'self toto ifNotNil: [ self toto ] ifNil: [ self tata ]' isRewrittenAs: 'self toto ifNil: [ self tata ]'
]

{ #category : 'tests' }
ChanelCutConditionalBranchesCleanerTest >> testIfNotNilIfNilReturningReceiver2 [
	self assert: 'self toto ifNotNil: [ :e | e ] ifNil: [ self tata ]' isRewrittenAs: 'self toto ifNil: [ self tata ]'
]

{ #category : 'tests' }
ChanelCutConditionalBranchesCleanerTest >> testIfNotNilReturningReceiver [
	self assert: 'self toto ifNotNil: [ self toto ]' isRewrittenAs: 'self toto'
]

{ #category : 'tests' }
ChanelCutConditionalBranchesCleanerTest >> testIfTrueIfFalse [
	self assert: 'true ifTrue: [ true ] ifFalse: [ false ]' isRewrittenAs: 'true'
]

{ #category : 'tests' }
ChanelCutConditionalBranchesCleanerTest >> testIfTrueIfFalse2 [
	self assert: 'true ifTrue: [ false ] ifFalse: [ true ]' isRewrittenAs: 'true not'
]
