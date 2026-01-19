"
A ChanelEnsureSuperIsCalledCleanerTest is a test class for testing the behavior of ChanelEnsureSuperIsCalledCleaner
"
Class {
	#name : 'ChanelEnsureSuperIsCalledCleanerTest',
	#superclass : 'ChanelAbstractCleanerTest',
	#instVars : [
		'oldMethod'
	],
	#category : 'Chanel-Tests',
	#package : 'Chanel-Tests'
}

{ #category : 'running' }
ChanelEnsureSuperIsCalledCleanerTest >> setUp [
	super setUp.
	class := self createDefaultTestClass
]

{ #category : 'tests - initialize' }
ChanelEnsureSuperIsCalledCleanerTest >> testAddSuperInitialize [
	class compile: 'initialize
  self assert: true'.

	oldMethod := class >> #initialize.

	self runCleaner.

	self
		assert: (class >> #initialize) sourceCode
		equals: 'initialize
  super initialize.
  self assert: true'.

	"The old method should not be the current one since it was recompiled."
	self deny: oldMethod identicalTo: class >> #initialize
]

{ #category : 'tests - initialize' }
ChanelEnsureSuperIsCalledCleanerTest >> testAddSuperInitializeInTrait [
	| trait |
	trait := self createDefaultTrait.

	class setTraitComposition: trait.

	trait
		compile:
			'initialize
  self assert: true'.

	oldMethod := trait >> #initialize.

	self runCleaner.

	self
		assert: (trait >> #initialize) sourceCode
		equals:
			'initialize
  super initialize.
  self assert: true'.

	self assert: (trait localSelectors includes: #initialize).
	self deny: (class localSelectors includes: #initialize)
]

{ #category : 'tests - setup' }
ChanelEnsureSuperIsCalledCleanerTest >> testAddSuperSetUp [
	class compile: 'setUp
  self assert: true'.

	oldMethod := class >> #setUp.

	self runCleaner.

	self
		assert: (class >> #setUp) sourceCode
		equals: 'setUp
  super setUp.
  self assert: true'.

	"The old method should not be the current one since it was recompiled."
	self deny: oldMethod identicalTo: class >> #setUp
]

{ #category : 'tests - teardown' }
ChanelEnsureSuperIsCalledCleanerTest >> testAddSuperTearDown [
	class compile: 'tearDown
  self assert: true'.

	oldMethod := class >> #tearDown.

	self runCleaner.

	self
		assert: (class >> #tearDown) sourceCode
		equals: 'tearDown
  self assert: true.
  super tearDown'.

	"The old method should not be the current one since it was recompiled."
	self deny: oldMethod identicalTo: class >> #tearDown
]

{ #category : 'tests - initialize' }
ChanelEnsureSuperIsCalledCleanerTest >> testDoesNotAddSuperInitializeOnClassSide [
	class class compile: 'initialize
	self assert: true'.

	oldMethod := class class >> #initialize.

	self runCleaner.

	"We should not add super initialize on the class side."
	self
		assert: (class class>> #initialize) sourceCode
		equals: 'initialize
	self assert: true'.

	"In case there is nothing to change, we should *not* recompile the method, thus it should be identical."
	self assert: oldMethod identicalTo: class class >> #initialize
]

{ #category : 'tests - initialize' }
ChanelEnsureSuperIsCalledCleanerTest >> testDoesNotAddSuperInitializeWhenAlreadyThere [
	class compile: 'initialize
	super initialize.
	self assert: true'.

	oldMethod := class >> #initialize.

	self runCleaner.

	self
		assert: (class >> #initialize) sourceCode
		equals: 'initialize
	super initialize.
	self assert: true'.

	"In case there is nothing to change, we should *not* recompile the method, thus it should be identical."
	self assert: oldMethod identicalTo: class >> #initialize
]

{ #category : 'tests - setup' }
ChanelEnsureSuperIsCalledCleanerTest >> testDoesNotAddSuperSetUpIfClassIsNotATestCase [
	class := self createDefaultClass.

	class compile: 'setUp
	self assert: true'.

	oldMethod := class >> #setUp.

	self runCleaner.

	"Do not add super setUp we are not in a test case."
	self
		assert: (class >> #setUp) sourceCode
		equals: 'setUp
	self assert: true'.

	"In case there is nothing to change, we should *not* recompile the method, thus it should be identical."
	self assert: oldMethod identicalTo: class >> #setUp
]

{ #category : 'tests - setup' }
ChanelEnsureSuperIsCalledCleanerTest >> testDoesNotAddSuperSetUpIfEmptyMethod [
	class compile: 'setUp
'.

	oldMethod := class >> #setUp.

	self runCleaner.

	"Do not add super setUp if it is empty. It might be here to prevent the super."
	self
		assert: (class >> #setUp) sourceCode
		equals: 'setUp
'.

	"In case there is nothing to change, we should *not* recompile the method, thus it should be identical."
	self assert: oldMethod identicalTo: class >> #setUp
]

{ #category : 'tests - setup' }
ChanelEnsureSuperIsCalledCleanerTest >> testDoesNotAddSuperSetUpInTrait [
	| trait |
	trait := self createDefaultTrait.

	class setTraitComposition: trait.

	trait compile: 'setUp
  self assert: true'.

	oldMethod := trait >> #setUp.

	self runCleaner.

	self
		assert: (trait >> #setUp) sourceCode
		equals: 'setUp
  self assert: true'.

	self assert: (trait localSelectors includes: #setUp).
	self deny: (class localSelectors includes: #setUp)
]

{ #category : 'tests - setup' }
ChanelEnsureSuperIsCalledCleanerTest >> testDoesNotAddSuperSetUpOnClassSide [
	class class compile: 'setUp
	self assert: true'.

	oldMethod := class class>> #setUp.

	self runCleaner.

	self
		assert: (class class>> #setUp) sourceCode
		equals: 'setUp
	self assert: true'.

	"In case there is nothing to change, we should *not* recompile the method, thus it should be identical."
	self assert: oldMethod identicalTo: class class>> #setUp
]

{ #category : 'tests - setup' }
ChanelEnsureSuperIsCalledCleanerTest >> testDoesNotAddSuperSetUpWhenAlreadyThere [
	class compile: 'setUp
	super setUp.
	self assert: true'.

	oldMethod := class >> #setUp.

	self runCleaner.

	self
		assert: (class >> #setUp) sourceCode
		equals: 'setUp
	super setUp.
	self assert: true'.

	"In case there is nothing to change, we should *not* recompile the method, thus it should be identical."
	self assert: oldMethod identicalTo: class >> #setUp
]

{ #category : 'tests - teardown' }
ChanelEnsureSuperIsCalledCleanerTest >> testDoesNotAddSuperTearDownIfClassIsNotATestCase [
	class := self createDefaultClass.

	class compile: 'tearDown
	self assert: true'.

	oldMethod := class >> #tearDown.

	self runCleaner.

	"Do not add super tearDown we are not in a test case."
	self
		assert: (class >> #tearDown) sourceCode
		equals: 'tearDown
	self assert: true'.

	"In case there is nothing to change, we should *not* recompile the method, thus it should be identical."
	self assert: oldMethod identicalTo: class >> #tearDown
]

{ #category : 'tests - teardown' }
ChanelEnsureSuperIsCalledCleanerTest >> testDoesNotAddSuperTearDownIfEmptyMethod [
	class compile: 'tearDown
'.

	oldMethod := class >> #tearDown.

	self runCleaner.

	"Do not add super tearDown if it is empty. It might be here to prevent the super."
	self
		assert: (class >> #tearDown) sourceCode
		equals: 'tearDown
'.

	"In case there is nothing to change, we should *not* recompile the method, thus it should be identical."
	self assert: oldMethod identicalTo: class >> #tearDown
]

{ #category : 'tests - teardown' }
ChanelEnsureSuperIsCalledCleanerTest >> testDoesNotAddSuperTearDownInTrait [
	| trait |
	trait := self createDefaultTrait.

	class setTraitComposition: trait.

	trait compile: 'tearDown
  self assert: true'.

	oldMethod := trait >> #tearDown.

	self runCleaner.

	self
		assert: (trait >> #tearDown) sourceCode
		equals: 'tearDown
  self assert: true'.

	self assert: (trait localSelectors includes: #tearDown).
	self deny: (class localSelectors includes: #tearDown)
]

{ #category : 'tests - teardown' }
ChanelEnsureSuperIsCalledCleanerTest >> testDoesNotAddSuperTearDownOnClassSide [
	class class compile: 'tearDown
	self assert: true'.

	oldMethod := class class>> #tearDown.

	self runCleaner.

	self
		assert: (class class>> #tearDown) sourceCode
		equals: 'tearDown
	self assert: true'.

	"In case there is nothing to change, we should *not* recompile the method, thus it should be identical."
	self assert: oldMethod identicalTo: class class>> #tearDown
]

{ #category : 'tests - teardown' }
ChanelEnsureSuperIsCalledCleanerTest >> testDoesNotAddSuperTearDownWhenAlreadyThere [
	class compile: 'tearDown
	self assert: true.
	super tearDown'.

	oldMethod := class >> #tearDown.

	self runCleaner.

	self
		assert: (class >> #tearDown) sourceCode
		equals: 'tearDown
	self assert: true.
	super tearDown'.

	"In case there is nothing to change, we should *not* recompile the method, thus it should be identical."
	self assert: oldMethod identicalTo: class >> #tearDown
]

{ #category : 'tests - initialize' }
ChanelEnsureSuperIsCalledCleanerTest >> testDoesNotCreateSuperInitializeInEmptyMethod [
	class compile: 'initialize
'.

	oldMethod := class >> #initialize.

	self runCleaner.

	"If a an initialize method is empty we do want to create a super initialize because it is probably there to prevent the super method."
	self
		assert: (class >> #initialize) sourceCode
		equals: 'initialize
'.

	"In case there is nothing to change, we should *not* recompile the method, thus it should be identical."
	self assert: oldMethod identicalTo: class >> #initialize
]

{ #category : 'tests - initialize' }
ChanelEnsureSuperIsCalledCleanerTest >> testDoesNotMoveSuperInitializeIfNotTheFirstStatement [
	class compile: 'initialize
	self assert: true.
	super initialize'.

	oldMethod := class >> #initialize.

	self runCleaner.

	"If a super initialize is present but not the first statement, we *do not want* to move it. It might be because we need to initialize something before our superclass."
	self
		assert: (class >> #initialize) sourceCode
		equals: 'initialize
	self assert: true.
	super initialize'.

	"In case there is nothing to change, we should *not* recompile the method, thus it should be identical."
	self assert: oldMethod identicalTo: class >> #initialize
]

{ #category : 'tests - setup' }
ChanelEnsureSuperIsCalledCleanerTest >> testMoveSuperSetUpIfNotFirstStatement [
	class compile: 'setUp
  self assert: true.
  super setUp'.

	oldMethod := class >> #setUp.

	self runCleaner.

	"The super setUp should almost always be the first statement."
	self
		assert: (class >> #setUp) sourceCode
		equals: 'setUp
  super setUp.
  self assert: true'.

	"The old method should not be the current one since it was recompiled."
	self deny: oldMethod identicalTo: class >> #setUp
]

{ #category : 'tests - teardown' }
ChanelEnsureSuperIsCalledCleanerTest >> testMoveSuperTearDownIfNotLastStatement [
	class compile: 'tearDown
  super tearDown.
  self assert: true'.

	oldMethod := class >> #tearDown.

	self runCleaner.

	"The super tearDown should almost always be the last statement."
	self
		assert: (class >> #tearDown) sourceCode
		equals: 'tearDown
  self assert: true.
  super tearDown'.

	"The old method should not be the current one since it was recompiled."
	self deny: oldMethod identicalTo: class >> #tearDown
]
