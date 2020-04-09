"
A ChanelTestCaseNameCleanerTest is a test class for testing the behavior of ChanelTestCaseNameCleaner
"
Class {
	#name : #ChanelTestCaseNameCleanerTest,
	#superclass : #ChanelAbstractCleanerTest,
	#category : #'Chanel-Tests'
}

{ #category : #tests }
ChanelTestCaseNameCleanerTest >> testRenameTestCaseEndingWithTests [
	"/!\ /!\ We use #asSymbol instead of writing symbols because the renaming will update the references in the image, thus, it will rename the symbols in the test. /!\ /!\ "

	self createTestCaseNamed: 'ChanelMockTests' asSymbol.

	self runCleaner.

	self class environment at: 'ChanelMockTests' asSymbol ifPresent: [ :class | self fail ].
	self class environment at: 'ChanelMockTest' asSymbol ifAbsent: [ self fail ]
]

{ #category : #tests }
ChanelTestCaseNameCleanerTest >> testRenameTestCaseEndingWithTestsUpdateReferences [
	"/!\ /!\ We use #asSymbol instead of writing symbols because the renaming will update the references in the image, thus, it will rename the symbols in the test. /!\ /!\ "

	self createTestCaseNamed: 'ChanelMockTests' asSymbol.

	(self class environment at: 'ChanelMockTests' asSymbol)
		compile:
			'test1
	^ ChanelMockTests';
		compile:
			'test2
	^ #ChanelMockTests'.

	self runCleaner.

	self class environment
		at: 'ChanelMockTest' asSymbol
		ifPresent: [ :class | 
			self
				assert: (class >> #test1) sourceCode
				equals:
					'test1
	^ ChanelMockTest'.

			self
				assert: (class >> #test2) sourceCode
				equals:
					'test2
	^ #ChanelMockTest' ]
		ifAbsent: [ self fail ]
]

{ #category : #tests }
ChanelTestCaseNameCleanerTest >> testShouldNotRenameNonTestCaseEndingWithTest [
	"/!\ /!\ We use #asSymbol instead of writing symbols because the renaming will update the references in the image, thus, it will rename the symbols in the test. /!\ /!\ "

	self createClassNamed: 'ChanelMockTest' asSymbol.

	self runCleaner.

	"The class should not be renamed since it already ends with Test."
	self class environment at: 'ChanelMockTest' asSymbol ifAbsent: [ self fail ]
]

{ #category : #tests }
ChanelTestCaseNameCleanerTest >> testShouldNotRenameNonTestCaseEndingWithTests [
	"/!\ /!\ We use #asSymbol instead of writing symbols because the renaming will update the references in the image, thus, it will rename the symbols in the test. /!\ /!\ "

	self createClassNamed: 'ChanelMockTests' asSymbol.

	self runCleaner.

	"The class should not be renamed since it inherits from Object and not TestCase."
	self class environment at: 'ChanelMockTests' asSymbol ifAbsent: [ self fail ].
	self class environment at: 'ChanelMockTest' asSymbol ifPresent: [ :class | self fail ]
]

{ #category : #tests }
ChanelTestCaseNameCleanerTest >> testShouldNotRenameTestCaseEndingWithTest [
	"/!\ /!\ We use #asSymbol instead of writing symbols because the renaming will update the references in the image, thus, it will rename the symbols in the test. /!\ /!\ "

	self createTestCaseNamed: 'ChanelMockTest' asSymbol.

	self runCleaner.

	"The class should not be renamed since it inherits from Object and not TestCase and also because it already ends with Test."
	self class environment at: 'ChanelMockTest' asSymbol ifAbsent: [ self fail ]
]
