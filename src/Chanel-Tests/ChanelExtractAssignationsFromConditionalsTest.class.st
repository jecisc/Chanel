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
ChanelExtractAssignationsFromConditionalsTest >> testExtractAssignationFromIfTrueIfFalse [
	class compile: 'method
  self toto ifTrue: [ test :=1 ] ifFalse: [ test := 2 ]'.

	self runCleaner.
	
	self assert: (class >> #method) sourceCode equals: 'method
  test := self toto ifTrue: [ 1 ] ifFalse: [ 2 ]'
]
