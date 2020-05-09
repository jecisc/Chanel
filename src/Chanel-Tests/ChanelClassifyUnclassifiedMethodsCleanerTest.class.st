"
A ChanelClassifyUnclassifiedMethodsCleanerTest is a test class for testing the behavior of ChanelClassifyUnclassifiedMethodsCleaner
"
Class {
	#name : #ChanelClassifyUnclassifiedMethodsCleanerTest,
	#superclass : #ChanelAbstractCleanerTest,
	#category : #'Chanel-Tests'
}

{ #category : #running }
ChanelClassifyUnclassifiedMethodsCleanerTest >> setUp [
	super setUp.
	class := self createDefaultClass
]

{ #category : #running }
ChanelClassifyUnclassifiedMethodsCleanerTest >> testCannotCategorizeUncategorizedMethodNotPresentInProtocolOrganizer [
	class compile: 'badetitou'. 
	
	self assert: (class >> #badetitou) protocol equals: 'as yet unclassified'.
	
	self runCleaner.
	
	self assert: (class >> #badetitou) protocol equals: 'as yet unclassified'
]

{ #category : #running }
ChanelClassifyUnclassifiedMethodsCleanerTest >> testCategorizeUncategorizedClassMethod [
	class class compile: 'initialize'. 
	
	self assert: (class class >> #initialize) protocol equals: 'as yet unclassified'.
	
	self runCleaner.
	
	self deny: (class class >> #initialize) protocol equals: 'as yet unclassified'
]

{ #category : #running }
ChanelClassifyUnclassifiedMethodsCleanerTest >> testCategorizeUncategorizedMethod [
	class compile: 'initialize'. 
	
	self assert: (class >> #initialize) protocol equals: 'as yet unclassified'.
	
	self runCleaner.
	
	self deny: (class >> #initialize) protocol equals: 'as yet unclassified'
]

{ #category : #running }
ChanelClassifyUnclassifiedMethodsCleanerTest >> testCategorizeUncategorizedMethodFromTrait [
	class := self createDefaultTrait.

	class compile: 'initialize'. 
	
	self assert: (class >> #initialize) protocol equals: 'as yet unclassified'.
	
	self runCleaner.
	
	self deny: (class >> #initialize) protocol equals: 'as yet unclassified'
]

{ #category : #running }
ChanelClassifyUnclassifiedMethodsCleanerTest >> testDontCategorizeCategorizedMethod [
	class compile: 'initialize' classified: 'peacock'. 
	
	self runCleaner.
	
	self assert: (class >> #initialize) protocol equals: 'peacock'
]

{ #category : #running }
ChanelClassifyUnclassifiedMethodsCleanerTest >> testDontCategorizeExtensionMethods [
	class compile: 'initialize' classified: self extensionProtocol. 
	
	self runCleaner.
	
	self assert: (class >> #initialize) protocol equals: self extensionProtocol
]

{ #category : #tests }
ChanelClassifyUnclassifiedMethodsCleanerTest >> testRemoveUselessBlock [
	class compile: 'method
  self toto ifTrue: [ ^ 1 ] ifFalse: [ ^ 2 ]'.

	self runCleaner.
	
	self assert: (class >> #method) sourceCode equals: 'method
  ^1'
]
