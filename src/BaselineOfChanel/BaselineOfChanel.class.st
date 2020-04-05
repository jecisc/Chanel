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
				group: 'Tests' with: #('Chanel-Tests') ].

	spec
		for: #'pharo6.x'
		do: [ spec
				package: 'Chanel-Pharo6';
				package: 'Chanel' with: [ spec requires: 'Chanel-Pharo6' ] ]
]

{ #category : #accessing }
BaselineOfChanel >> projectClass [
	^ MetacelloCypressBaselineProject
]
