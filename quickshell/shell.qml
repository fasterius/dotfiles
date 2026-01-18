//@ pragma IconTheme Papirus-Dark

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets

Scope {
	id: root

	// Bind the Pipewire node so its volume will be tracked
	PwObjectTracker {
		objects: [ Pipewire.defaultAudioSink ]
	}

	Connections {
		target: Pipewire.defaultAudioSink?.audio

        // Show widget for `hideTimer.interval` milliseconds on volume change
		function onVolumeChanged() {
			root.shouldShowOsd = true;
			hideTimer.restart();
		}
	}

    // Do not show widget by default
	property bool shouldShowOsd: false

    // Specify for how long the widget should be shown
	Timer {
		id: hideTimer
		interval: 1250
		onTriggered: root.shouldShowOsd = false
	}

	// The OSD window will be created and destroyed based on shouldShowOsd.
	// PanelWindow.visible could be set instead of using a loader, but using
	// a loader will reduce the memory overhead when the window isn't open.
	LazyLoader {
		active: root.shouldShowOsd

        // This is the transparent box that contains all of the other elements.
		PanelWindow {
			// Since the panel's screen is unset, it will be picked by the compositor
			// when the window is created. Most compositors pick the current active monitor.

            // Anchors the widget to the bottom of the screen with a margin
			anchors.bottom: true
			margins.bottom: screen.height / 10
			exclusiveZone: 0

			implicitWidth: 400
			implicitHeight: 50
			color: "transparent"

			// An empty click mask prevents the window from blocking mouse events
			mask: Region {}

            // This is the black, rounded-corner box that contains the rest of
            // the elements; note that Quickshell uses Alpha + HEXA rather than
            // HEXA + Alpha, which is how the standard is normally used.
			Rectangle {
				anchors.fill: parent
				radius: height / 2
				color: "#D9000000"

                // This is the final container that contains a row-layout of
                // multiple elements: the icon and the volume bar itself
				RowLayout {
					anchors {
						fill: parent
						leftMargin: 20
						rightMargin: 20
					}

                    // Icon pack is specified at the top of the file with the
                    // `@ pragma IconTheme <icon-theme>` line
					IconImage {
						source: Quickshell.iconPath("audio-volume-high")
						implicitSize: 30
					}

                    // The background of the volume bar, i.e. the "non-filled"
                    // part of the bar
					Rectangle {
						// Stretches to fill all left-over space
						Layout.fillWidth: true

						implicitHeight: 11
						radius: 20
						color: "#50ffffff"

                        // The foreground of the volume bar, i.e. the "filled"
                        // part of the bar
						Rectangle {
							anchors {
								left: parent.left
								top: parent.top
								bottom: parent.bottom
							}
							radius: parent.radius
							implicitWidth: parent.width * (Pipewire.defaultAudioSink?.audio.volume ?? 0)
						}
					}
				}
			}
		}
	}
}
