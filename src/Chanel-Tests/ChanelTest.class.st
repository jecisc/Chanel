"
A ChanelTest is a test class for testing the behavior of Chanel
"
Class {
	#name : 'ChanelTest',
	#superclass : 'ChanelAbstractTest',
	#category : 'Chanel-Tests',
	#package : 'Chanel-Tests'
}

{ #category : 'tests' }
ChanelTest >> testSmokeTest [
	self shouldnt: [ Chanel perfume: (#('Chanel-Tests' 'BaselineOfChanel' 'Chanel') collect: #asPackage) ] raise: Error
]
