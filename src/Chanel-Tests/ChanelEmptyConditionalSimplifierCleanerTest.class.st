"
A ChanelEmptyConditionalSimplifierCleanerTest is a test class for testing the behavior of ChanelEmptyConditionalSimplifierCleaner
"
Class {
	#name : #ChanelEmptyConditionalSimplifierCleanerTest,
	#superclass : #ChanelMethodRewriterCleanerTest,
	#category : #'Chanel-Tests'
}

{ #category : #helpers }
ChanelEmptyConditionalSimplifierCleanerTest >> replacementPair [
	^ '#() isEmpty ifTrue: [ false ]' -> '#() ifEmpty: [ false ]'
]

{ #category : #running }
ChanelEmptyConditionalSimplifierCleanerTest >> setUp [
	super setUp.
	class := self createDefaultClass
]

{ #category : #tests }
ChanelEmptyConditionalSimplifierCleanerTest >> testDoesNotReplaceIfItIntroduceAnInfinitLoop [
	| oldMethod |
	class
		compile:
			'ifEmpty: aBlock
  ^self isEmpty ifTrue: aBlock'.

	oldMethod := class >> #ifEmpty:.

	self runCleaner.

	self
		assert: (class >> #ifEmpty:) sourceCode
		equals:
			'ifEmpty: aBlock
  ^self isEmpty ifTrue: aBlock'.

	self assert: class >> #ifEmpty: identicalTo: oldMethod
]

{ #category : #tests }
ChanelEmptyConditionalSimplifierCleanerTest >> testDoesNotReplaceIfItIntroduceAnInfinitLoop2 [
	| oldMethod |
	class
		compile:
			'ifEmpty: aBlock
  self isEmpty ifTrue: aBlock'.

	oldMethod := class >> #ifEmpty:.

	self runCleaner.

	self
		assert: (class >> #ifEmpty:) sourceCode
		equals:
			'ifEmpty: aBlock
  self isEmpty ifTrue: aBlock'.

	self assert: class >> #ifEmpty: identicalTo: oldMethod
]

{ #category : #tests }
ChanelEmptyConditionalSimplifierCleanerTest >> testIfEmptyIfNotEmpty [
	self assert: '#() ifEmpty: [ true ] ifNotEmpty: [ false ]' isRewrittenAs: '#() isEmpty'
]

{ #category : #tests }
ChanelEmptyConditionalSimplifierCleanerTest >> testIfEmptyIfNotEmpty2 [
	self assert: '#() ifEmpty: [ false ] ifNotEmpty: [ true ]' isRewrittenAs: '#() isNotEmpty'
]

{ #category : #tests }
ChanelEmptyConditionalSimplifierCleanerTest >> testIfNotEmptyIfEmpty [
	self assert: '#() ifNotEmpty: [ false ] ifEmpty: [ true ]' isRewrittenAs: '#() isEmpty'
]

{ #category : #tests }
ChanelEmptyConditionalSimplifierCleanerTest >> testIfNotEmptyIfEmpty2 [
	self assert: '#() ifNotEmpty: [ true ] ifEmpty: [ false ]' isRewrittenAs: '#() isNotEmpty'
]

{ #category : #tests }
ChanelEmptyConditionalSimplifierCleanerTest >> testIsEmptyIfFalse [
	self assert: '#() isEmpty ifFalse: [ 2 ]' isRewrittenAs: '#() ifNotEmpty: [ 2 ]'
]

{ #category : #tests }
ChanelEmptyConditionalSimplifierCleanerTest >> testIsEmptyIfFalseIfTrue [
	self assert: '#() isEmpty ifFalse: [ 2 ] ifTrue: [ 1 ]' isRewrittenAs: '#() ifEmpty: [ 1 ] ifNotEmpty: [ 2 ]'
]

{ #category : #tests }
ChanelEmptyConditionalSimplifierCleanerTest >> testIsEmptyIfFalseIfTrue2 [
	self assert: '#() isEmpty ifFalse: [ false ] ifTrue: [ true ]' isRewrittenAs: '#() isEmpty'
]

{ #category : #tests }
ChanelEmptyConditionalSimplifierCleanerTest >> testIsEmptyIfFalseIfTrue3 [
	self assert: '#() isEmpty ifFalse: [ true ] ifTrue: [ false ]' isRewrittenAs: '#() isNotEmpty'
]

{ #category : #tests }
ChanelEmptyConditionalSimplifierCleanerTest >> testIsEmptyIfTrue [
	self assert: '#() isEmpty ifTrue: [ 2 ]' isRewrittenAs: '#() ifEmpty: [ 2 ]'
]

{ #category : #tests }
ChanelEmptyConditionalSimplifierCleanerTest >> testIsEmptyIfTrueIfFalse [
	self assert: '#() isEmpty ifTrue: [ 1 ] ifFalse: [ 2 ]' isRewrittenAs: '#() ifEmpty: [ 1 ] ifNotEmpty: [ 2 ]'
]

{ #category : #tests }
ChanelEmptyConditionalSimplifierCleanerTest >> testIsEmptyIfTrueIfFalse2 [
	self assert: '#() isEmpty ifTrue: [ true ] ifFalse: [ false ]' isRewrittenAs: '#() isEmpty'
]

{ #category : #tests }
ChanelEmptyConditionalSimplifierCleanerTest >> testIsEmptyIfTrueIfFalse3 [
	self assert: '#() isEmpty ifTrue: [ false ] ifFalse: [ true ]' isRewrittenAs: '#() isNotEmpty'
]

{ #category : #tests }
ChanelEmptyConditionalSimplifierCleanerTest >> testIsNotEmptyIfFalse [
	self assert: '#() isNotEmpty ifFalse: [ 2 ]' isRewrittenAs: '#() ifEmpty: [ 2 ]'
]

{ #category : #tests }
ChanelEmptyConditionalSimplifierCleanerTest >> testIsNotEmptyIfFalseIfTrue [
	self assert: '#() isNotEmpty ifFalse: [ 1 ] ifTrue: [ 2 ]' isRewrittenAs: '#() ifEmpty: [ 1 ] ifNotEmpty: [ 2 ]'
]

{ #category : #tests }
ChanelEmptyConditionalSimplifierCleanerTest >> testIsNotEmptyIfFalseIfTrue2 [
	self assert: '#() isNotEmpty ifFalse: [ true ] ifTrue: [ false ]' isRewrittenAs: '#() isEmpty'
]

{ #category : #tests }
ChanelEmptyConditionalSimplifierCleanerTest >> testIsNotEmptyIfFalseIfTrue3 [
	self assert: '#() isNotEmpty ifFalse: [ false ] ifTrue: [ true ]' isRewrittenAs: '#() isNotEmpty'
]

{ #category : #tests }
ChanelEmptyConditionalSimplifierCleanerTest >> testIsNotEmptyIfTrue [
	self assert: '#() isNotEmpty ifTrue: [ 2 ]' isRewrittenAs: '#() ifNotEmpty: [ 2 ]'
]

{ #category : #tests }
ChanelEmptyConditionalSimplifierCleanerTest >> testIsNotEmptyIfTrueIfFalse [
	self assert: '#() isNotEmpty ifTrue: [ 2 ] ifFalse: [ 1 ]' isRewrittenAs: '#() ifEmpty: [ 1 ] ifNotEmpty: [ 2 ]'
]

{ #category : #tests }
ChanelEmptyConditionalSimplifierCleanerTest >> testIsNotEmptyIfTrueIfFalse2 [
	self assert: '#() isNotEmpty ifTrue: [ false ] ifFalse: [ true ]' isRewrittenAs: '#() isEmpty'
]

{ #category : #tests }
ChanelEmptyConditionalSimplifierCleanerTest >> testIsNotEmptyIfTrueIfFalse3 [
	self assert: '#() isNotEmpty ifTrue: [ true ] ifFalse: [ false ]' isRewrittenAs: '#() isNotEmpty'
]

{ #category : #tests }
ChanelEmptyConditionalSimplifierCleanerTest >> testReplacementInTraits [
	| trait |
	trait := self createDefaultTrait.

	class setTraitComposition: trait.

	trait
		compile:
			('{1}
  {2}' format: {self selector . '#() isEmpty ifTrue: [ false ]'}).

	self runCleaner.

	self
		assert: (trait >> self selector) sourceCode
		equals:
			('{1}
  {2}' format: {self selector . '#() ifEmpty: [ false ]'}).

	self assert: (trait localSelectors includes: self selector).
	self deny: (class localSelectors includes: self selector)
]

{ #category : #tests }
ChanelEmptyConditionalSimplifierCleanerTest >> testWithNothingToReplace [
	self denyIsRewritten: '#() ifEmpty: [ false ]'
]
