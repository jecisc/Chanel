"
Description
--------------------

I am a cleaner that removes useless spaces at the end of lines and final dots of methods.
"
Class {
	#name : #ChanelCondenseMethodsCleaner,
	#superclass : #ChanelAbstractCleaner,
	#category : #'Chanel-Pharo11Plus'
}

{ #category : #cleaning }
ChanelCondenseMethodsCleaner >> clean [

	self configuration localMethods do: [ :cm |
		(RBRefactoryChangeFactory instance addMethodSource: (ReMethodSourceCleaner clean: cm sourceCode) in: cm origin) execute ]
]
