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
	self shouldnt: [ Chanel perfume: ((#('Chanel-Tests' 'BaselineOfChanel' 'Chanel') collect: [ :s | s asPackageIfAbsent: [ nil ] ]) reject: #isNil) ] raise: Error
]
