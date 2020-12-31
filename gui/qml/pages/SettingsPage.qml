import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Dialogs 1.3

import "../controls"

Item{
    Rectangle {
        id: settingsContainer

        color: "#323741"
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0

        // Select the item and the island that the item is farmed in.
        ComboBox {
            id: itemComboBox

            width: 200
            anchors.left: parent.left
            anchors.top: combatScriptTextField.bottom
            enabled: false
            anchors.topMargin: 50
            anchors.leftMargin: 20

            displayText: qsTr("Please select a item to farm.")

            currentIndex: 0
            textRole: "text"
            
            delegate: ItemDelegate {
                width: itemComboBox.width
                text: modelData.text

                font.weight: itemComboBox.currentIndex === index ? Font.DemiBold : Font.Normal
                highlighted: ListView.isCurrentItem

                enabled: modelData.enabled
            }

            model: [
                // Port Breeze Archipelago
                { text: "Port Breeze Archipelago", enabled: false },
                { text: "Satin Feather", map: "Port Breeze Archipelago", enabled: true },
                { text: "Zephyr Feather", map: "Port Breeze Archipelago", enabled: true },
                { text: "Flying Sprout", map: "Port Breeze Archipelago", enabled: true },

                // Valtz Duchy
                { text: "Valtz Duchy", enabled: false },
                { text: "Fine Sand Bottle", map: "Valtz Duchy", enabled: true },
                { text: "Untamed Flame", map: "Valtz Duchy", enabled: true },
                { text: "Blistering Ore", map: "Valtz Duchy", enabled: true },

                // Auguste Isles
                { text: "Auguste Isles", enabled: false },
                { text: "Fresh Water Jug", map: "Auguste Isles", enabled: true },
                { text: "Soothing Splash", map: "Auguste Isles", enabled: true },
                { text: "Glowing Coral", map: "Auguste Isles", enabled: true },

                // Lumacie Archipelago
                { text: "Lumacie Archipelago", enabled: false },
                { text: "Rough Stone", map: "Lumacie Archipelago", enabled: true },
                { text: "Coarse Alluvium", map: "Lumacie Archipelago", enabled: true },
                { text: "Swirling Amber", map: "Lumacie Archipelago", enabled: true },

                // Albion Citadel
                { text: "Albion Citadel", enabled: false },
                { text: "Falcon Feather", map: "Albion Citadel", enabled: true },
                { text: "Spring Water Jug", map: "Albion Citadel", enabled: true },
                { text: "Vermilion Stone", map: "Albion Citadel", enabled: true },

                // Mist-Shrouded Isle
                { text: "Mist-Shrouded Isle", enabled: false },
                { text: "Slimy Shroom", map: "Mist-Shrouded Isle", enabled: true },
                { text: "Hollow Soul", map: "Mist-Shrouded Isle", enabled: true },
                { text: "Lacrimosa", map: "Mist-Shrouded Isle", enabled: true },

                // Golonzo Island
                { text: "Golonzo Island", enabled: false },
                { text: "Wheat Stalk", map: "Golonzo Island", enabled: true },
                { text: "Iron Cluster", map: "Golonzo Island", enabled: true },
                { text: "Olea Plant", map: "Golonzo Island", enabled: true },

                // Amalthea Island
                { text: "Amalthea Island", enabled: false },
                { text: "Indigo Fruit", map: "Amalthea Island", enabled: true },
                { text: "Foreboding Clover", map: "Amalthea Island", enabled: true },
                { text: "Blood Amber", map: "Amalthea Island", enabled: true },

                // Former Capital Mephorash
                { text: "Former Capital Mephorash", enabled: false },
                { text: "Sand Brick", map: "Former Capital Mephorash", enabled: true },
                { text: "Native Reed", map: "Former Capital Mephorash", enabled: true },
                { text: "Antique Cloth", map: "Former Capital Mephorash", enabled: true },

                // Agastia
                { text: "Agastia", enabled: false },
                { text: "Prosperity Flame", map: "Agastia", enabled: true },
                { text: "Explosive Material", map: "Agastia", enabled: true },
                { text: "Steel Liquid", map: "Agastia", enabled: true },
            ]

            onCurrentIndexChanged: {
                itemComboBox.displayText = qsTr(itemComboBox.model[currentIndex].text)
                logTextArea.append("\nIsland selected: " + itemComboBox.model[currentIndex].map)
                logTextArea.append("Item selected: " + itemComboBox.model[currentIndex].text)

                // Enable the mission ComboBox.
                missionComboBox.enabled = true

                // Update the contents of the mission ComboBox with the appropriate mission(s).
                missionComboBox.currentIndex = 0
                if(itemComboBox.displayText == "Satin Feather" || itemComboBox.displayText == "Zephyr Feather" || itemComboBox.displayText == "Flying Sprout"){
                    missionComboBox.model = [
                        { text: "Port Breeze Archipelago", enabled: false },
                        { text: "Scattered Cargo", enabled: true },
                    ]
                } else if(itemComboBox.displayText == "Fine Sand Bottle"){
                    missionComboBox.model = [
                        { text: "Valtz Duchy", enabled: false },
                        { text: "Lucky Charm Hunt", enabled: true },
                    ]
                } else if(itemComboBox.displayText == "Untamed Flame"){
                    missionComboBox.model = [
                        { text: "Valtz Duchy", enabled: false },
                        { text: "Special Op's Request", enabled: true },
                    ]
                } else if(itemComboBox.displayText == "Blistering Ore"){
                    missionComboBox.model = [
                        { text: "Valtz Duchy", enabled: false },
                        { text: "Lucky Charm Hunt", enabled: true },
                        { text: "Special Op's Request", enabled: true },
                    ]
                } else if(itemComboBox.displayText == "Fresh Water Jug" || itemComboBox.displayText == "Soothing Splash" || itemComboBox.displayText == "Glowing Coral"){
                    missionComboBox.model = [
                        { text: "Auguste Isles", enabled: false },
                        { text: "Threat to the Fisheries", enabled: true },
                    ]
                } else if(itemComboBox.displayText == "Rough Stone" || itemComboBox.displayText == "Swirling Amber"){
                    missionComboBox.model = [
                        { text: "Lumacie Archipelago", enabled: false },
                        { text: "The Fruit of Lumacie", enabled: true },
                    ]
                } else if(itemComboBox.displayText == "Coarse Alluvium"){
                    missionComboBox.model = [
                        { text: "Lumacie Archipelago", enabled: false },
                        { text: "Whiff of Danger", enabled: true },
                    ]
                } else if(itemComboBox.displayText == "Falcon Feather" || itemComboBox.displayText == "Spring Water Jug" || itemComboBox.displayText == "Vermilion Stone"){
                    missionComboBox.model = [
                        { text: "Albion Citadel", enabled: false },
                        { text: "I Challenge You!", enabled: true },
                    ]
                } else if(itemComboBox.displayText == "Slimy Shroom" || itemComboBox.displayText == "Hollow Soul" || itemComboBox.displayText == "Lacrimosa"){
                    missionComboBox.model = [
                        { text: "Mist-Shrouded Isle", enabled: false },
                        { text: "For Whom the Bell Tolls", enabled: true },
                    ]
                } else if(itemComboBox.displayText == "Wheat Stalk" || itemComboBox.displayText == "Iron Cluster" || itemComboBox.displayText == "Olea Plant"){
                    missionComboBox.model = [
                        { text: "Golonzo Island", enabled: false },
                        { text: "Golonzo's Battle of Old", enabled: true },
                    ]
                } else if(itemComboBox.displayText == "Indigo Fruit" || itemComboBox.displayText == "Foreboding Clover" || itemComboBox.displayText == "Blood Amber"){
                    missionComboBox.model = [
                        { text: "Amalthea Island", enabled: false },
                        { text: "The Dungeon Diet", enabled: true },
                    ]
                } else if(itemComboBox.displayText == "Sand Brick" || itemComboBox.displayText == "Native Reed"){
                    missionComboBox.model = [
                        { text: "Former Capital Mephorash", enabled: false },
                        { text: "Trust Busting Dustup", enabled: true },
                    ]
                } else if(itemComboBox.displayText == "Antique Cloth"){
                    missionComboBox.model = [
                        { text: "Former Capital Mephorash", enabled: false },
                        { text: "Trust Busting Dustup", enabled: true },
                        { text: "Erste Kingdom Episode 4", enabled: true },
                    ]
                } else if(itemComboBox.displayText == "Prosperity Flame" || itemComboBox.displayText == "Explosive Material" || itemComboBox.displayText == "Steel Liquid"){
                    missionComboBox.model = [
                        { text: "Agastia", enabled: false },
                        { text: "Imperial Wanderer's Soul", enabled: true },
                    ]
                }

                // Reset the mission ComboBox back to default.
                missionComboBox.currentIndex = 0
                missionComboBox.displayText = qsTr("Please select a mission.")
            }

            onPressedChanged: {
                itemComboBox.popup.height = 300
            }
        }

        // Select mission(s) specific to each item.
        ComboBox {
            id: missionComboBox

            width: 200
            anchors.left: parent.left
            anchors.top: itemComboBox.bottom
            enabled: false
            anchors.topMargin: 50
            anchors.leftMargin: 20

            displayText: qsTr("Please select a mission.")

            currentIndex: 0
            textRole: "text"

            delegate: ItemDelegate {
                width: missionComboBox.width
                text: modelData.text

                font.weight: missionComboBox.currentIndex === index ? Font.DemiBold : Font.Normal
                highlighted: ListView.isCurrentItem

                enabled: modelData.enabled
            }

            model: []

            onCurrentIndexChanged: {
                missionComboBox.displayText = qsTr(missionComboBox.model[currentIndex].text)
                logTextArea.append("\nMission selected: " + missionComboBox.model[currentIndex].text)
            }

            onDisplayTextChanged: backend.check_bot_ready(missionComboBox.displayText)
        }

        CustomButton{
            id: buttonOpenFile
            y: 20

            text: qsTr("Open")
            anchors.left: combatScriptTextField.right
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.leftMargin: 20

            height: 40

            onPressed: {
                fileOpen.open()
            }

            FileDialog{
                id: fileOpen

                title: "Please choose a combat script file"

                // Dialog will default to the /scripts/ folder in the root of the bot directory.
                folder: "../../../scripts/"
                selectMultiple: false
                nameFilters: ["Text File (*.txt)"]

                onAccepted: {
                    backend.open_file(fileOpen.fileUrl)
                }
            }

        }

        CustomCheckBox {
            id: debugModeCheckBox

            text: "Debug Mode"
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            anchors.leftMargin: 20

            onClicked: {
                if(debugModeCheckBox.checked){
                    backend.update_debug_mode(true)
                    logTextArea.append("\nDebug Mode turned ON. You will now see debugging messages in the log.")
                }else{
                    backend.update_debug_mode(false)
                    logTextArea.append("\nDebug Mode turned OFF. You will no longer see debugging messages in the log.")
                }
            }
        }

        TextField {
            id: combatScriptTextField
            anchors.left: parent.left
            anchors.top: parent.top
            horizontalAlignment: Text.AlignHCenter
            anchors.topMargin: 20
            anchors.leftMargin: 20

            readOnly: true

            placeholderText: qsTr("Combat Script: None selected")
        }

        Label {
            id: combatScriptTextFieldLabel
            x: 20
            width: 200
            height: 13
            color: "#00ff00"
            text: qsTr("Combat script loaded successfully")
            anchors.top: combatScriptTextField.bottom
            anchors.topMargin: 5

            visible: false
        }
    }

    Connections{
        target: backend

        // Retrieve the name of the opened script file back from backend.
        function onOpenFile(scriptName){
            combatScriptTextField.text = qsTr(scriptName)
            combatScriptTextFieldLabel.visible = true
            logTextArea.append("\nCombat script selected: " + scriptName)

            // Enable the item selection combobox.
            itemComboBox.enabled = true
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:2;height:453;width:300}
}
##^##*/
