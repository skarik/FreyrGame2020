{
    "id": "3d9e4094-0494-43b7-a772-d273cc6aa534",
    "modelName": "GMObject",
    "mvc": "1.0",
    "name": "o_livelyTriggerCtsTriggeredGoto",
    "eventList": [
        {
            "id": "0d78f803-417f-47fd-b9cf-317289b2e717",
            "modelName": "GMEvent",
            "mvc": "1.0",
            "IsDnD": false,
            "collisionObjectId": "00000000-0000-0000-0000-000000000000",
            "enumb": 0,
            "eventtype": 0,
            "m_owner": "3d9e4094-0494-43b7-a772-d273cc6aa534"
        },
        {
            "id": "516847a9-ffaf-45a0-81c5-41c56bdf3390",
            "modelName": "GMEvent",
            "mvc": "1.0",
            "IsDnD": false,
            "collisionObjectId": "00000000-0000-0000-0000-000000000000",
            "enumb": 0,
            "eventtype": 3,
            "m_owner": "3d9e4094-0494-43b7-a772-d273cc6aa534"
        },
        {
            "id": "108f2bb0-c7d9-4f83-a739-b90e02ef82ce",
            "modelName": "GMEvent",
            "mvc": "1.0",
            "IsDnD": false,
            "collisionObjectId": "00000000-0000-0000-0000-000000000000",
            "enumb": 10,
            "eventtype": 7,
            "m_owner": "3d9e4094-0494-43b7-a772-d273cc6aa534"
        }
    ],
    "maskSpriteId": "00000000-0000-0000-0000-000000000000",
    "overriddenProperties": null,
    "parentObjectId": "e23108ba-d822-4ce7-b642-e96b4451e6cf",
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
            "id": "e9aea25d-01f4-44ad-bcd0-412a0d424727",
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
            "id": "66d163f7-2d64-4ead-9681-51cbb1071fad",
            "modelName": "GMObjectProperty",
            "mvc": "1.0",
            "listItems": [
                "kTriggerByPlayer",
                "kTriggerByParty",
                "kTriggerByEnemy",
                "kTriggerByProjectile"
            ],
            "multiselect": false,
            "rangeEnabled": false,
            "rangeMax": 10,
            "rangeMin": 0,
            "resourceFilter": 1023,
            "value": "kTriggerByPlayer",
            "varName": "m_triggerBy",
            "varType": 6
        },
        {
            "id": "8cf21e35-2d58-4dd9-b5af-77a0f5f8d9f7",
            "modelName": "GMObjectProperty",
            "mvc": "1.0",
            "listItems": null,
            "multiselect": false,
            "rangeEnabled": false,
            "rangeMax": 10,
            "rangeMin": 0,
            "resourceFilter": 1023,
            "value": "2.0",
            "varName": "m_retriggerDelay",
            "varType": 0
        },
        {
            "id": "f4c102bc-367b-4e90-8fff-dd7cc02f1f79",
            "modelName": "GMObjectProperty",
            "mvc": "1.0",
            "listItems": null,
            "multiselect": false,
            "rangeEnabled": false,
            "rangeMax": 10,
            "rangeMin": 0,
            "resourceFilter": 1023,
            "value": "0",
            "varName": "m_flagComparisonEnabled",
            "varType": 3
        },
        {
            "id": "873d9495-3524-4c31-aac4-e57e691d3407",
            "modelName": "GMObjectProperty",
            "mvc": "1.0",
            "listItems": null,
            "multiselect": false,
            "rangeEnabled": false,
            "rangeMax": 10,
            "rangeMin": 0,
            "resourceFilter": 1023,
            "value": "kQidIntroSequence",
            "varName": "m_flagId",
            "varType": 4
        },
        {
            "id": "3b380aa5-1bb0-46c5-a230-fe21b66ce778",
            "modelName": "GMObjectProperty",
            "mvc": "1.0",
            "listItems": [
                "kCompareOpLess",
                "kCompareOpEqual",
                "kCompareOpGreater"
            ],
            "multiselect": false,
            "rangeEnabled": false,
            "rangeMax": 10,
            "rangeMin": 0,
            "resourceFilter": 1023,
            "value": "kCompareOpGreater",
            "varName": "m_flagCompareIdToValue",
            "varType": 6
        },
        {
            "id": "583a4ca4-0073-4980-94dd-af1a022dd458",
            "modelName": "GMObjectProperty",
            "mvc": "1.0",
            "listItems": null,
            "multiselect": false,
            "rangeEnabled": false,
            "rangeMax": 10,
            "rangeMin": 0,
            "resourceFilter": 1023,
            "value": "10",
            "varName": "m_flagValue",
            "varType": 1
        }
    ],
    "solid": false,
    "spriteId": "98e2c97a-1d2e-4c3a-8353-4c9b795c7196",
    "visible": false
}