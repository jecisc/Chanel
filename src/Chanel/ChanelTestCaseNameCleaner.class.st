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
	self configuration definedTestCases
		do: [ :class |
			(class name endsWith: 'Tests')
				ifTrue: [ (RBRenameClassRefactoring rename: class to: (class name withoutSuffix: 'Tests') , 'Test') execute ] ]
]
