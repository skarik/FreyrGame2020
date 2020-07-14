{
    "id": "9f528421-cf3a-4c53-82a3-94c42f4ca95c",
    "modelName": "GMObject",
    "mvc": "1.0",
    "name": "o_livelyLogicRelay_QuestFlag",
    "eventList": [
        {
            "id": "6b6cd8f0-9890-40bf-b0ba-0ec5519bb156",
            "modelName": "GMEvent",
            "mvc": "1.0",
            "IsDnD": false,
            "collisionObjectId": "00000000-0000-0000-0000-000000000000",
            "enumb": 10,
            "eventtype": 7,
            "m_owner": "9f528421-cf3a-4c53-82a3-94c42f4ca95c"
        }
    ],
    "maskSpriteId": "00000000-0000-0000-0000-000000000000",
    "overriddenProperties": null,
    "parentObjectId": "1413c9d3-52e5-4f5f-9d85-256e4db12805",
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
            "id": "7c49d276-f1b5-48f7-bd30-dd7d4e370a92",
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
            "id": "0a1f9ca0-8501-48ff-8d3f-081bf38c1d2c",
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
            "id": "d393d35d-d190-4af0-be85-76310ff5381c",
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
    "spriteId": "c80484be-d912-4357-a78d-d02863d54cf4",
    "visible": false
}