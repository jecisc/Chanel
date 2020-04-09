"
A ChanelAbstractCleanerTest is a test class for testing the behavior of ChanelAbstractCleaner
"
Class {
	#name : #ChanelAbstractCleanerTest,
	#superclass : #TestCase,
	#instVars : [
		'package',
		'class'
	],
	#category : #'Chanel-Tests'
}

{ #category : #accessing }
ChanelAbstractCleanerTest >> actualClass [
	^ self class environment at: (self class name withoutSuffix: 'Test') asSymbol
]

{ #category : #helpers }
ChanelAbstractCleanerTest >> assert: original isRewrittenAs: expected [
	class ifNil: [ self error: 'To use this method you need to setup the class variable' ].

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

{ #category : #helpers }
ChanelAbstractCleanerTest >> createClassNamed: aSymbol [
	^ Object subclass: aSymbol
		instanceVariableNames: ''
		classVariableNames: ''
		package: package name
]

{ #category : #helpers }
ChanelAbstractCleanerTest >> createTestCaseNamed: aSymbol [
	^ TestCase subclass: aSymbol
		instanceVariableNames: ''
		classVariableNames: ''
		package: package name
]

{ #category : #running }
ChanelAbstractCleanerTest >> runCleaner [
	(self actualClass configuration: (Chanel new packages: {package})) clean
]

{ #category : #running }
ChanelAbstractCleanerTest >> setUp [
	super setUp.
	package := RPackageOrganizer default createPackageNamed: 'Package-Test-For-Chanel'
]

{ #category : #running }
ChanelAbstractCleanerTest >> tearDown [
	"I do not use the #package variable because sometime the tear down fail and I want to relaunch one test to clean the system."
	('Package-Test-For-Chanel' asPackageIfAbsent: [ nil ])  ifNotNil: #removeFromSystem.
	super tearDown
]
