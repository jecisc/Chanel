"
A ChanelTestEqualityCleanerTest is a test class for testing the behavior of ChanelTestEqualityCleaner
"
Class {
	#name : #ChanelTestEqualityCleanerTest,
	#superclass : #ChanelAbstractCleanerTest,
	#instVars : [
		'class'
	],
	#category : #'Chanel-Tests'
}

{ #category : #helpers }
ChanelTestEqualityCleanerTest >> assert: original isRewrittenAs: expected [
	class
		compile:
			('{1}
	{2}' format: {self selector . original}).

	self runCleaner.

	self
		assert: (class >> self selector) sourceCode
		equals:
			('{1}
	{2}' format: {self selector . expected})
]

{ #category : #running }
ChanelTestEqualityCleanerTest >> setUp [
	super setUp.
	class := TestCase subclass: #ChanelEqualityTestCase
		instanceVariableNames: ''
		classVariableNames: ''
		poolDictionaries: ''
		package: package name
]

{ #category : #running }
ChanelTestEqualityCleanerTest >> tearDown [
	class removeFromSystem.
	super tearDown
]

{ #category : #tests }
ChanelTestEqualityCleanerTest >> testAssertEquals [
	self assert: 'self assert: 1 = 1' isRewrittenAs: 'self assert: 1 equals: 1'
]

{ #category : #tests }
ChanelTestEqualityCleanerTest >> testDenyEquals [
	self assert: 'self deny: 1 = 1' isRewrittenAs: 'self deny: 1 equals: 1'
]
