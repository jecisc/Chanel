"
Description
--------------------

I am a cleaner that removes useless spaces at the end of lines and final dots of methods.
"
Class {
	#name : 'ChanelCondenseMethodsCleaner',
	#superclass : 'ChanelAbstractCleaner',
	#category : 'Chanel-Pharo11Plus',
	#package : 'Chanel-Pharo11Plus'
}

{ #category : 'cleaning' }
ChanelCondenseMethodsCleaner >> clean [

	self configuration localMethods do: [ :cm | cm origin compile: (ReMethodSourceCleaner clean: cm sourceCode) ]
]
