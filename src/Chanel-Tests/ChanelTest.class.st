"
A ChanelTest is a test class for testing the behavior of Chanel
"
Class {
	#name : #ChanelTest,
	#superclass : #TestCase,
	#category : #'Chanel-Tests'
}

{ #category : #tests }
ChanelTest >> testSmokeTest [
	self
		shouldnt: [ Chanel
				perfume:
					(((IceRepository registry select: [ :e | e name beginsWith: 'Chanel' ])
						flatCollect: [ :e | e workingCopy packageNames collect: [ :s | s asPackageIfAbsent: [ nil ] ] ]) reject: #isNil) ]
		raise: Error
]
