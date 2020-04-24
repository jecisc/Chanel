"
Description
--------------------

I am a cleaner renaming each test case ending with ""Tests"" to end with ""Test"" since this is ""a XXTestCase"".
"
Class {
	#name : #ChanelTestCaseNameCleaner,
	#superclass : #ChanelAbstractCleaner,
	#category : #Chanel
}

{ #category : #accessing }
ChanelTestCaseNameCleaner class >> priority [
	^ 4000
]

{ #category : #cleaning }
ChanelTestCaseNameCleaner >> clean [
	self configuration definedTestCases iterator
		| [ :class | class name endsWith: 'Tests' ] selectIt
		| [ :class | self class environment hasClassNamed: class name allButLast ] rejectIt
		> [ :class | self rename: class as: class name allButLast ] doIt
]

{ #category : #cleaning }
ChanelTestCaseNameCleaner >> rename: class as: aString [
	('Renaming ' , class name , ' to ' , aString) record.
	(RBRenameClassRefactoring rename: class to: aString) execute
]
