"
A ChanelExtractAssignationsFromConditionalsTest is a test class for testing the behavior of ChanelExtractAssignationsFromConditionals
"
Class {
	#name : #ChanelExtractAssignationsFromConditionalsTest,
	#superclass : #ChanelAbstractCleanerTest,
	#category : #'Chanel-Tests'
}

{ #category : #running }
ChanelExtractAssignationsFromConditionalsTest >> setUp [
	super setUp.
	class := self createDefaultClass
]

{ #category : #tests }
ChanelExtractAssignationsFromConditionalsTest >> testDoesNotExtractAssignationIfABranchIsASymbol [
	self denyIsRewritten: 'self toto ifNil: [ test := 1 ] ifNotNil: #yourself'
]

{ #category : #tests }
ChanelExtractAssignationsFromConditionalsTest >> testDoesNotExtractAssignationIfAlreadyOutside [
	self denyIsRewritten: 'test := self toto ifTrue: [ 1 ] ifFalse: [ 2 ]'
]

{ #category : #tests }
ChanelExtractAssignationsFromConditionalsTest >> testDoesNotExtractAssignationIfAssignationIsNotTheLastStatement [
	self denyIsRewritten: 'self toto ifTrue: [ test := 1 ] ifFalse: [ self foo ifTrue: [ test := 2 ] ]'
]

{ #category : #tests }
ChanelExtractAssignationsFromConditionalsTest >> testDoesNotExtractAssignationIfInACascade [
	self denyIsRewritten: 'self toto ifTrue: [ test := 1 ] ifFalse: [ test := 2 ]; bar'
]

{ #category : #tests }
ChanelExtractAssignationsFromConditionalsTest >> testDoesNotExtractAssignationIfOnBranchDoesNotHaveOne [
	self denyIsRewritten: 'self toto ifTrue: [ test := 1 ] ifFalse: [ 2 ]'
]

{ #category : #tests }
ChanelExtractAssignationsFromConditionalsTest >> testExtractAssignationDoesNotFailForConditonsInConditions [
	self
		assert: 'self toto1 ifTrue: [ self toto2 ifTrue: [ test := 1 ] ifFalse: [ test := 2 ] ] ifFalse: [ 3 ]'
		isRewrittenAs: 'self toto1 ifTrue: [ test := self toto2 ifTrue: [ 1 ] ifFalse: [ 2 ] ] ifFalse: [ 3 ]'
]

{ #category : #tests }
ChanelExtractAssignationsFromConditionalsTest >> testExtractAssignationDoesNotFailIfThereIsAlreadyAAssignation [
	self assert: 'test := self toto ifTrue: [ test := 1 ] ifFalse: [ test := 2 ]' isRewrittenAs: 'test := self toto ifTrue: [ 1 ] ifFalse: [ 2 ]'
]

{ #category : #tests }
ChanelExtractAssignationsFromConditionalsTest >> testExtractAssignationEvenIfMessageIsNotTheLastStatement [
	self
		assert:
			'self toto ifTrue: [ test := 1 ] ifFalse: [ test := 2 ].
  self bar'
		isRewrittenAs:
			'test := self toto ifTrue: [ 1 ] ifFalse: [ 2 ].
  self bar'
]

{ #category : #tests }
ChanelExtractAssignationsFromConditionalsTest >> testExtractAssignationFromIfEmptyIfNotEmpty [
	self assert: 'self toto ifEmpty: [ test := 2 ] ifNotEmpty: [ test := 1 ]' isRewrittenAs: 'test := self toto ifEmpty: [ 2 ] ifNotEmpty: [ 1 ]'
]

{ #category : #tests }
ChanelExtractAssignationsFromConditionalsTest >> testExtractAssignationFromIfExistsIfAbsent [
	self assert: 'self toto ifExists: [ test := 2 ] ifAbsent: [ test := 1 ]' isRewrittenAs: 'test := self toto ifExists: [ 2 ] ifAbsent: [ 1 ]'
]

{ #category : #tests }
ChanelExtractAssignationsFromConditionalsTest >> testExtractAssignationFromIfFalseIfTrue [
	self assert: 'self toto ifFalse: [ test := 2 ] ifTrue: [ test := 1 ]' isRewrittenAs: 'test := self toto ifFalse: [ 2 ] ifTrue: [ 1 ]'
]

{ #category : #tests }
ChanelExtractAssignationsFromConditionalsTest >> testExtractAssignationFromIfNilIfNotNil [
	self assert: 'self toto ifNil: [ test := 2 ] ifNotNil: [ test := 1 ]' isRewrittenAs: 'test := self toto ifNil: [ 2 ] ifNotNil: [ 1 ]'
]

{ #category : #tests }
ChanelExtractAssignationsFromConditionalsTest >> testExtractAssignationFromIfNotEmptyIfEmpty [
	self assert: 'self toto ifNotEmpty: [ test := 2 ] ifEmpty: [ test := 1 ]' isRewrittenAs: 'test := self toto ifNotEmpty: [ 2 ] ifEmpty: [ 1 ]'
]

{ #category : #tests }
ChanelExtractAssignationsFromConditionalsTest >> testExtractAssignationFromIfNotNilIfNil [
	self assert: 'self toto ifNotNil: [ test := 2 ] ifNil: [ test := 1 ]' isRewrittenAs: 'test := self toto ifNotNil: [ 2 ] ifNil: [ 1 ]'
]

{ #category : #tests }
ChanelExtractAssignationsFromConditionalsTest >> testExtractAssignationFromIfTrueIfFalse [
	self assert: 'self toto ifTrue: [ test := 1 ] ifFalse: [ test := 2 ]' isRewrittenAs: 'test := self toto ifTrue: [ 1 ] ifFalse: [ 2 ]'
]

{ #category : #tests }
ChanelExtractAssignationsFromConditionalsTest >> testExtractAssignationFromIfTrueIfFalseWithOtherStatements [
	self assert: 'self toto ifTrue: [ self foo. test := 1 ] ifFalse: [ test := self bar ]' isRewrittenAs: 'test := self toto ifTrue: [ self foo.
        1 ] ifFalse: [ self bar ]'
]

{ #category : #tests }
ChanelExtractAssignationsFromConditionalsTest >> testExtractAssignationIfTheLastStatementOfABlock [
	self
		assert:
			'self foo ifTrue: [ self toto ifTrue: [ test := 1 ] ifFalse: [ test := 2 ] ].
  self bar'
		isRewrittenAs:
			'self foo ifTrue: [ test := self toto ifTrue: [ 1 ] ifFalse: [ 2 ] ].
  self bar'
]

{ #category : #tests }
ChanelExtractAssignationsFromConditionalsTest >> testExtractAssignationInNestedConditions [
	self
		assert: 'self toto1 ifTrue: [ self toto2 ifTrue: [ test := 1 ] ifFalse: [ test := 2 ] ] ifFalse: [ test := 3 ]'
		isRewrittenAs: 'test := self toto1 ifTrue: [ self toto2 ifTrue: [ 1 ] ifFalse: [ 2 ] ] ifFalse: [ 3 ]'
]

{ #category : #tests }
ChanelExtractAssignationsFromConditionalsTest >> testExtractAssignationInTrait [
	| trait |
	trait := self createDefaultTrait.

	class setTraitComposition: trait.

	trait
		compile:
			'method
  self toto ifTrue: [ test := 1 ] ifFalse: [ test := 2 ]'.

	self runCleaner.

	self
		assert: (trait >> #method) sourceCode
		equals:
			'method
  test := self toto ifTrue: [ 1 ] ifFalse: [ 2 ]'.

	self assert: (trait localSelectors includes: #method).
	self deny: (class localSelectors includes: #method)
]

{ #category : #tests }
ChanelExtractAssignationsFromConditionalsTest >> testExtractAssignationOnClassSide [
	self assert: 'self toto ifTrue: [ test := 1 ] ifFalse: [ test := 2 ]' isRewrittenAs: 'test := self toto ifTrue: [ 1 ] ifFalse: [ 2 ]' in: class class
]
