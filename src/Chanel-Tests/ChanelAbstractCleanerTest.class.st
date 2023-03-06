"
A ChanelAbstractCleanerTest is a test class for testing the behavior of ChanelAbstractCleaner.

List of special cases to take into account when writing a new cleaner (add tests for them):
- Should it apply on classe side?
- Should it apply on traits? In that case, ensure the methods are not duplicated in the user classes
- Ensure extension methods are not moved of protocol
- When rewriting the content of a method: ensure we do not create an infinit loop by calling self
- If it concern only test cases, test on non test cases
- What should happen if the method is empty?
- Be careful of methods with pragmas which can be special cases. (for example, do not remove empty methods with a pragma)
"
Class {
	#name : #ChanelAbstractCleanerTest,
	#superclass : #ChanelAbstractTest,
	#instVars : [
		'previousFormater',
		'package',
		'class',
		'extensionPackage'
	],
	#category : #'Chanel-Tests'
}

{ #category : #testing }
ChanelAbstractCleanerTest class >> isAbstract [
	^ self = ChanelAbstractCleanerTest
]

{ #category : #accessing }
ChanelAbstractCleanerTest >> actualClass [
	^ self class environment at: (self class name withoutSuffix: 'Test') asSymbol
]

{ #category : #helpers }
ChanelAbstractCleanerTest >> assert: original isRewrittenAs: expected [
	class ifNil: [ self error: 'To use this method you need to setup the class variable' ].

	self assert: original isRewrittenAs: expected in: class
]

{ #category : #helpers }
ChanelAbstractCleanerTest >> assert: original isRewrittenAs: expected in: aClass [
	aClass compile: (self methodBodyFor: original).

	self runCleaner.

	self assert: (aClass >> self selector) sourceCode equals: (self methodBodyFor: expected)
]

{ #category : #helpers }
ChanelAbstractCleanerTest >> createClassNamed: aSymbol [
	^ self createSubclassOf: Object named: aSymbol
]

{ #category : #helpers }
ChanelAbstractCleanerTest >> createDefaultClass [
	^ self createClassNamed: self defaultClassName
]

{ #category : #helpers }
ChanelAbstractCleanerTest >> createDefaultTestClass [
	^ self createTestCaseNamed: self defaultClassName
]

{ #category : #helpers }
ChanelAbstractCleanerTest >> createDefaultTrait [
	^ self createTraitNamed: self defaultTraitName
]

{ #category : #helpers }
ChanelAbstractCleanerTest >> createSubclassOf: aClass named: aSymbol [
	^ aClass
		subclass: aSymbol
		instanceVariableNames: ''
		classVariableNames: ''
		package: package name
]

{ #category : #helpers }
ChanelAbstractCleanerTest >> createTestCaseNamed: aSymbol [
	^ self createSubclassOf: TestCase named: aSymbol
]

{ #category : #helpers }
ChanelAbstractCleanerTest >> createTraitNamed: aSymbol [
	^ Trait named: aSymbol uses: {} package: package name
]

{ #category : #accessing }
ChanelAbstractCleanerTest >> defaultClassName [
	^ (self class name , 'Fake') asSymbol
]

{ #category : #accessing }
ChanelAbstractCleanerTest >> defaultTraitName [
	^ ('T' , self defaultClassName) asSymbol
]

{ #category : #helpers }
ChanelAbstractCleanerTest >> denyIsRewritten: aString [
	| oldMethod |
	class ifNil: [ self error: 'To use this method you need to setup the class variable' ].

	class compile: (self methodBodyFor: aString).

	oldMethod := class >> self selector.
	self runCleaner.

	self assert: (class >> self selector) sourceCode equals: (self methodBodyFor: aString).

	self assert: class >> self selector identicalTo: oldMethod
]

{ #category : #running }
ChanelAbstractCleanerTest >> extensionProtocol [
	^ '*' , extensionPackage name
]

{ #category : #helpers }
ChanelAbstractCleanerTest >> methodBodyFor: aString [
	^ '{1}
  {2}' format: {self selector . aString}
]

{ #category : #running }
ChanelAbstractCleanerTest >> runCleaner [
	Chanel perfume: {package} using: {self actualClass}
]

{ #category : #running }
ChanelAbstractCleanerTest >> runCleanerForPharo: anInteger [
	Chanel perfume: {package} using: {self actualClass} forPharo: anInteger
]

{ #category : #running }
ChanelAbstractCleanerTest >> setUp [
	super setUp.

	package := RPackageOrganizer default createPackageNamed: 'Package-Test-For-Chanel'.
	extensionPackage := RPackageOrganizer default createPackageNamed: 'ExtensionPackage-Test-For-Chanel'.

	"We only save the formatter if it is not the one used in the tests.
	The reason is that, while debugging a test, if it fails and is rerun, the set up is runned twice and the formatter used in tests will be saved in `previousFormatter`.
	With this guard, we avoid this case."
	RBProgramNode formatterClass = RBSimpleFormatter ifTrue: [ ^ self ].

	previousFormater := RBProgramNode formatterClass.
	RBProgramNode formatterClass: RBSimpleFormatter
]

{ #category : #running }
ChanelAbstractCleanerTest >> tearDown [
	"I do not use the #package variable because sometime the tear down fail and I want to relaunch one test to clean the system."

	previousFormater ifNotNil: [ :formatter | RBProgramNode formatterClass: formatter ].
	('Package-Test-For-Chanel' asPackageIfAbsent: [ nil ]) ifNotNil: #removeFromSystem.
	('ExtensionPackage-Test-For-Chanel' asPackageIfAbsent: [ nil ]) ifNotNil: #removeFromSystem.
	super tearDown
]
