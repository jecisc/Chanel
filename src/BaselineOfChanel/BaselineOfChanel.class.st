"
I am a baseline to define the structure and dependencies of the Chanel project.
"
Class {
	#name : #BaselineOfChanel,
	#superclass : #BaselineOf,
	#category : #BaselineOfChanel
}

{ #category : #baseline }
BaselineOfChanel >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
				package: 'Chanel';
				package: 'Chanel-Tests' with: [ spec requires: 'Chanel' ].

			spec
				group: 'Core' with: #('Chanel');
				group: 'Tests' with: #('Chanel-Tests') ]
]

{ #category : #accessing }
BaselineOfChanel >> projectClass [
	^ MetacelloCypressBaselineProject
]
