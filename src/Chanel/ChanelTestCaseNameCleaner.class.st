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
	self flag: #pharo10.
	(RBRenameClassRefactoring rename: (SystemVersion current major < 10 ifTrue: [ class ] ifFalse: [ class name ]) to: aString) execute
]
