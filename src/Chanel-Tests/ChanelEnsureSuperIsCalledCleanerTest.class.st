"
A ChanelEnsureSuperIsCalledCleanerTest is a test class for testing the behavior of ChanelEnsureSuperIsCalledCleaner
"
Class {
	#name : #ChanelEnsureSuperIsCalledCleanerTest,
	#superclass : #ChanelAbstractCleanerTest,
	#instVars : [
		'oldMethod'
	],
	#category : #'Chanel-Tests'
}

{ #category : #'tests - initialize' }
ChanelEnsureSuperIsCalledCleanerTest >> testAddSuperInitialize [
	class := self createClassNamed: #ChanelTestClass.

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

{ #category : #'tests - setup' }
ChanelEnsureSuperIsCalledCleanerTest >> testAddSuperSetUp [
	class := self createTestCaseNamed: #ChanelTestClass.

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

{ #category : #'tests - teardown' }
ChanelEnsureSuperIsCalledCleanerTest >> testAddSuperTearDown [
	class := self createTestCaseNamed: #ChanelTestClass.

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

{ #category : #'tests - initialize' }
ChanelEnsureSuperIsCalledCleanerTest >> testDoesNotAddSuperInitializeOnClassSide [
	class := self createClassNamed: #ChanelTestClass.

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

{ #category : #'tests - initialize' }
ChanelEnsureSuperIsCalledCleanerTest >> testDoesNotAddSuperInitializeWhenAlreadyThere [
	class := self createClassNamed: #ChanelTestClass.

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

{ #category : #'tests - setup' }
ChanelEnsureSuperIsCalledCleanerTest >> testDoesNotAddSuperSetUpIfClassIsNotATestCase [
	class := self createClassNamed: #ChanelTestClass.

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

{ #category : #'tests - setup' }
ChanelEnsureSuperIsCalledCleanerTest >> testDoesNotAddSuperSetUpIfEmptyMethod [
	class := self createTestCaseNamed: #ChanelTestClass.

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

{ #category : #'tests - setup' }
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

{ #category : #'tests - setup' }
ChanelEnsureSuperIsCalledCleanerTest >> testDoesNotAddSuperSetUpWhenAlreadyThere [
	class := self createTestCaseNamed: #ChanelTestClass.

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

{ #category : #'tests - teardown' }
ChanelEnsureSuperIsCalledCleanerTest >> testDoesNotAddSuperTearDownIfClassIsNotATestCase [
	class := self createClassNamed: #ChanelTestClass.

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

{ #category : #'tests - teardown' }
ChanelEnsureSuperIsCalledCleanerTest >> testDoesNotAddSuperTearDownIfEmptyMethod [
	class := self createTestCaseNamed: #ChanelTestClass.

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

{ #category : #'tests - teardown' }
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

{ #category : #'tests - teardown' }
ChanelEnsureSuperIsCalledCleanerTest >> testDoesNotAddSuperTearDownWhenAlreadyThere [
	class := self createTestCaseNamed: #ChanelTestClass.

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

{ #category : #'tests - initialize' }
ChanelEnsureSuperIsCalledCleanerTest >> testDoesNotCreateSuperInitializeInEmptyMethod [
	class := self createClassNamed: #ChanelTestClass.

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

{ #category : #'tests - initialize' }
ChanelEnsureSuperIsCalledCleanerTest >> testDoesNotMoveSuperInitializeIfNotTheFirstStatement [
	class := self createClassNamed: #ChanelTestClass.

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

{ #category : #'tests - setup' }
ChanelEnsureSuperIsCalledCleanerTest >> testMoveSuperSetUpIfNotFirstStatement [
	class := self createTestCaseNamed: #ChanelTestClass.

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

{ #category : #'tests - teardown' }
ChanelEnsureSuperIsCalledCleanerTest >> testMoveSuperTearDownIfNotLastStatement [
	class := self createTestCaseNamed: #ChanelTestClass.

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
