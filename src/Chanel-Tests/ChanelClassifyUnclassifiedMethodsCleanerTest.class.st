"
A ChanelClassifyUnclassifiedMethodsCleanerTest is a test class for testing the behavior of ChanelClassifyUnclassifiedMethodsCleaner
"
Class {
	#name : 'ChanelClassifyUnclassifiedMethodsCleanerTest',
	#superclass : 'ChanelAbstractCleanerTest',
	#category : 'Chanel-Tests',
	#package : 'Chanel-Tests'
}

{ #category : 'running' }
ChanelClassifyUnclassifiedMethodsCleanerTest >> setUp [
	super setUp.
	class := self createDefaultClass
]

{ #category : 'tests' }
ChanelClassifyUnclassifiedMethodsCleanerTest >> testCannotCategorizeUncategorizedMethodNotPresentInProtocolOrganizer [
	class compile: 'badetitou'.

	self assert: (class >> #badetitou) protocolName equals: 'as yet unclassified'.

	self runCleaner.

	self assert: (class >> #badetitou) protocolName equals: 'as yet unclassified'
]

{ #category : 'tests' }
ChanelClassifyUnclassifiedMethodsCleanerTest >> testCategorizeUncategorizedClassMethod [
	class class compile: 'initialize'.

	self assert: (class class >> #initialize) protocolName equals: 'as yet unclassified'.

	self runCleaner.

	self deny: (class class >> #initialize) protocolName equals: 'as yet unclassified'
]

{ #category : 'tests' }
ChanelClassifyUnclassifiedMethodsCleanerTest >> testCategorizeUncategorizedMethod [
	class compile: 'initialize'.

	self assert: (class >> #initialize) protocolName equals: 'as yet unclassified'.

	self runCleaner.

	self deny: (class >> #initialize) protocolName equals: 'as yet unclassified'
]

{ #category : 'tests' }
ChanelClassifyUnclassifiedMethodsCleanerTest >> testCategorizeUncategorizedMethodFromTrait [
	class := self createDefaultTrait.

	class compile: 'initialize'.

	self assert: (class >> #initialize) protocolName equals: 'as yet unclassified'.

	self runCleaner.

	self deny: (class >> #initialize) protocolName equals: 'as yet unclassified'
]

{ #category : 'tests' }
ChanelClassifyUnclassifiedMethodsCleanerTest >> testDontCategorizeCategorizedMethod [
	class compile: 'initialize' classified: 'peacock'.

	self runCleaner.

	self assert: (class >> #initialize) protocolName equals: 'peacock'
]

{ #category : 'tests' }
ChanelClassifyUnclassifiedMethodsCleanerTest >> testDontCategorizeExtensionMethods [
	class compile: 'initialize' classified: self extensionProtocolName.

	self runCleaner.

	self assert: (class >> #initialize) protocolName equals: self extensionProtocolName
]
