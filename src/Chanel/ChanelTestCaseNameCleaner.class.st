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
		select: [ :class | class name endsWith: 'Tests' ]
		thenDo: [ :class | (RBRenameClassRefactoring rename: class to: (class name withoutSuffix: 'Tests') , 'Test') execute ]
]
