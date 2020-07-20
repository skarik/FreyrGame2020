{
    "id": "18636bc2-3be9-4f95-90b4-488532457ee7",
    "modelName": "GMObject",
    "mvc": "1.0",
    "name": "o_livelyTriggerRelay_QuestFlag",
    "eventList": [
        {
            "id": "18139a93-a5ad-40c8-b1c8-8203d923cf96",
            "modelName": "GMEvent",
            "mvc": "1.0",
            "IsDnD": false,
            "collisionObjectId": "00000000-0000-0000-0000-000000000000",
            "enumb": 0,
            "eventtype": 0,
            "m_owner": "18636bc2-3be9-4f95-90b4-488532457ee7"
        },
        {
            "id": "4e767bb6-2e17-4339-b859-af18a003f2b6",
            "modelName": "GMEvent",
            "mvc": "1.0",
            "IsDnD": false,
            "collisionObjectId": "00000000-0000-0000-0000-000000000000",
            "enumb": 0,
            "eventtype": 3,
            "m_owner": "18636bc2-3be9-4f95-90b4-488532457ee7"
        }
    ],
    "maskSpriteId": "00000000-0000-0000-0000-000000000000",
    "overriddenProperties": null,
    "parentObjectId": "9f528421-cf3a-4c53-82a3-94c42f4ca95c",
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
            "id": "d764da46-ac26-462d-8b5c-259c6827af2b",
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
            "id": "5395d426-c4a9-48dc-8af5-80069a793bb6",
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
        }
    ],
    "solid": false,
    "spriteId": "04ba85f0-8b0b-4de6-8eb3-1d2d945c630f",
    "visible": false
}