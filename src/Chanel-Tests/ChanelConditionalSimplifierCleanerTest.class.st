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
	class := self createTestCaseNamed: #ChanelConditionalSimplifierMock
]
