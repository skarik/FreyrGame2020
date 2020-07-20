{
    "id": "91043b8e-a133-4e1e-baf6-7eded2a7fcb6",
    "modelName": "GMObject",
    "mvc": "1.0",
    "name": "ob_usableTriggerCutscene",
    "eventList": [
        {
            "id": "a73bf2bb-4506-479c-854d-e97f1d18660d",
            "modelName": "GMEvent",
            "mvc": "1.0",
            "IsDnD": false,
            "collisionObjectId": "00000000-0000-0000-0000-000000000000",
            "enumb": 0,
            "eventtype": 0,
            "m_owner": "91043b8e-a133-4e1e-baf6-7eded2a7fcb6"
        },
        {
            "id": "60ed6a34-a3dc-4d96-b443-31919f8437df",
            "modelName": "GMEvent",
            "mvc": "1.0",
            "IsDnD": false,
            "collisionObjectId": "00000000-0000-0000-0000-000000000000",
            "enumb": 10,
            "eventtype": 7,
            "m_owner": "91043b8e-a133-4e1e-baf6-7eded2a7fcb6"
        }
    ],
    "maskSpriteId": "00000000-0000-0000-0000-000000000000",
    "overriddenProperties": null,
    "parentObjectId": "e78376aa-a4f5-4296-a5c7-e9195679b750",
    "persistent": false,
    "physicsAngularDamping": 0.1,
    "physicsDensity": 0.5,
    "physicsFriction": 0.2,
    "physicsGroup": 0,
    "physicsKinematic": false,
    "physicsLinearDamping": 0.1,
    "physicsObject": false,
    "physicsRestitution": 0.1,
    "physicsSensor": false,
    "physicsShape": 1,
    "physicsShapePoints": null,
    "physicsStartAwake": true,
    "properties": [
        {
            "id": "3f75fc49-ea6a-4c21-ac29-308a5a1b392a",
            "modelName": "GMObjectProperty",
            "mvc": "1.0",
            "listItems": null,
            "multiselect": false,
            "rangeEnabled": false,
            "rangeMax": 10,
            "rangeMin": 0,
            "resourceFilter": 1023,
            "value": "\"Usable Trigger\"",
            "varName": "m_usableName",
            "varType": 2
        },
        {
            "id": "b697f1e7-50e3-42ef-b89b-f0b1122e8b4d",
            "modelName": "GMObjectProperty",
            "mvc": "1.0",
            "listItems": null,
            "multiselect": false,
            "rangeEnabled": false,
            "rangeMax": 10,
            "rangeMin": 0,
            "resourceFilter": 1023,
            "value": "\"Use\"",
            "varName": "m_usableAction",
            "varType": 2
        },
        {
            "id": "cf01d1f9-75e5-4502-8841-f8f9bfcf281c",
            "modelName": "GMObjectProperty",
            "mvc": "1.0",
            "listItems": [
                "kTriggerReusable",
                "kTriggerOncePerRoomload",
                "kTriggerOncePerPlaythrough"
            ],
            "multiselect": false,
            "rangeEnabled": false,
            "rangeMax": 10,
            "rangeMin": 0,
            "resourceFilter": 1023,
            "value": "kTriggerReusable",
            "varName": "m_triggerMode",
            "varType": 6
        },
        {
            "id": "c206aeaa-f04b-4cd1-aa09-73916e2d9034",
            "modelName": "GMObjectProperty",
            "mvc": "1.0",
            "listItems": null,
            "multiselect": false,
            "rangeEnabled": false,
            "rangeMax": 10,
            "rangeMin": 0,
            "resourceFilter": 1023,
            "value": "\"inspect\/flm\/example.txt\"",
            "varName": "m_cutsceneFile",
            "varType": 2
        }
    ],
    "solid": false,
    "spriteId": "4ad5ac7a-7b66-428a-9fa1-c98b32eb7f05",
    "visible": false
}