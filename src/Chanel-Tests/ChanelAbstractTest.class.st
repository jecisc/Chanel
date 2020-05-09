Class {
	#name : #ChanelAbstractTest,
	#superclass : #TestCase,
	#category : #'Chanel-Tests'
}

{ #category : #testing }
ChanelAbstractTest class >> isAbstract [
	^ self = ChanelAbstractTest
]

{ #category : #testing }
ChanelAbstractTest class >> shouldInheritSelectors [
	^ true
]

{ #category : #running }
ChanelAbstractTest >> runCase [
	EpMonitor disableDuring: [ super runCase ]
]
