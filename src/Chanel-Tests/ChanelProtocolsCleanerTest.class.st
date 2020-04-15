"
A ChanelProtocolsCleanerTest is a test class for testing the behavior of ChanelProtocolsCleaner
"
Class {
	#name : #ChanelProtocolsCleanerTest,
	#superclass : #ChanelAbstractCleanerTest,
	#category : #'Chanel-Tests'
}

{ #category : #running }
ChanelProtocolsCleanerTest >> setUp [
	super setUp.
	class := self createClassNamed: #ChanelProtocolsFake
]

{ #category : #tests }
ChanelProtocolsCleanerTest >> testDoesNotUpdateCloseProtocolIfAlreadyRight [
	class compile: 'method' classified: 'instance creation'.
	
	self runCleaner.
	
	self assert: (class >> #method) protocol equals: 'instance creation'
]

{ #category : #tests }
ChanelProtocolsCleanerTest >> testMethodInSpecificProtocol [
	class compile: 'initialize' classified: 'random'.
	
	self runCleaner.
	
	self assert: (class >> #initialize) protocol equals: 'initialization'
]

{ #category : #tests }
ChanelProtocolsCleanerTest >> testMethodInSpecificProtocolNotUpdateIfExtension [
	class compile: 'initialize' classified: self extensionProtocol.
	
	self runCleaner.
	
	self assert: (class >> #initialize) protocol equals: self extensionProtocol
]

{ #category : #tests }
ChanelProtocolsCleanerTest >> testMethodInSpecificProtocolNotUpdateIfNotInTheList [
	class compile: 'initialize2' classified: 'random'.
	
	self runCleaner.
	
	self assert: (class >> #initialize2) protocol equals: 'random'
]

{ #category : #tests }
ChanelProtocolsCleanerTest >> testMethodInSpecificProtocolOnClassSide [
	class class compile: 'initialize' classified: 'random'.
	
	self runCleaner.
	
	self assert: (class class>> #initialize) protocol equals: 'initialization'
]

{ #category : #tests }
ChanelProtocolsCleanerTest >> testTestMethodInSpecificProtocol [
	class := self createTestCaseNamed: #ChanelProtocolsFake.
	class compile: 'setUp' classified: 'random'.
	
	self runCleaner.
	
	self assert: (class >> #setUp) protocol equals: 'running'
]

{ #category : #tests }
ChanelProtocolsCleanerTest >> testTestMethodInSpecificProtocolNotUpdatedIfExtension [
	class := self createTestCaseNamed: #ChanelProtocolsFake.
	class compile: 'setUp' classified: self extensionProtocol.

	self runCleaner.

	self assert: (class >> #setUp) protocol equals: self extensionProtocol
]

{ #category : #tests }
ChanelProtocolsCleanerTest >> testTestMethodInSpecificProtocolNotUpdatedIfNotInTestCase [
	class compile: 'setUp' classified: 'random'.
	
	self runCleaner.
	
	self assert: (class >> #setUp) protocol equals: 'random'
]

{ #category : #tests }
ChanelProtocolsCleanerTest >> testTestMethodInSpecificProtocolNotUpdatedIfNotInTheList [
	class := self createTestCaseNamed: #ChanelProtocolsFake.
	class compile: 'toto' classified: 'random'.

	self runCleaner.

	self assert: (class >> #toto) protocol equals: 'random'
]

{ #category : #tests }
ChanelProtocolsCleanerTest >> testTestMethodsAreInRightProtocol [
	class := self createTestCaseNamed: #ChanelProtocolsFake.
	class compile: 'testMethod' classified: 'not a test'.
	
	self runCleaner.
	
	self assert: (class >> #testMethod) protocol equals: 'tests'
]

{ #category : #tests }
ChanelProtocolsCleanerTest >> testTestMethodsProtocolAreNotUpdateIfExtension [
	class := self createTestCaseNamed: #ChanelProtocolsFake.
	class compile: 'testMethod' classified: self extensionProtocol.
	
	self runCleaner.
	
	self assert: (class >> #testMethod) protocol equals: self extensionProtocol
]

{ #category : #tests }
ChanelProtocolsCleanerTest >> testTestMethodsProtocolAreNotUpdateIfNotInTestCase [
	class compile: 'testMethod' classified: 'not a test'.
	
	self runCleaner.
	
	self assert: (class >> #testMethod) protocol equals: 'not a test'
]

{ #category : #tests }
ChanelProtocolsCleanerTest >> testTestMethodsProtocolAreNotUpdateIfStartingByTest [
	class := self createTestCaseNamed: #ChanelProtocolsFake.
	class compile: 'testMethod' classified: 'test - protocols'.
	
	self runCleaner.
	
	self assert: (class >> #testMethod) protocol equals: 'test - protocols'
]

{ #category : #tests }
ChanelProtocolsCleanerTest >> testUpdateCloseProtocol [
	class compile: 'method' classified: 'instance-creation'.
	
	self runCleaner.
	
	self assert: (class >> #method) protocol equals: 'instance creation'
]

{ #category : #tests }
ChanelProtocolsCleanerTest >> testUpdateCloseProtocolOnClassSide [
	class class compile: 'method' classified: 'instance-creation'.
	
	self runCleaner.
	
	self assert: (class class>> #method) protocol equals: 'instance creation'
]
