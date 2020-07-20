{
    "id": "d36f532b-e138-4b81-b381-814d8bba9863",
    "modelName": "GMObject",
    "mvc": "1.0",
    "name": "o_livelyTriggerRelay",
    "eventList": [
        {
            "id": "3919b48d-546a-4644-8c42-c7ff7419724e",
            "modelName": "GMEvent",
            "mvc": "1.0",
            "IsDnD": false,
            "collisionObjectId": "00000000-0000-0000-0000-000000000000",
            "enumb": 0,
            "eventtype": 0,
            "m_owner": "d36f532b-e138-4b81-b381-814d8bba9863"
        },
        {
            "id": "e6489b6f-9ae3-4a58-8d4b-73381feb64c5",
            "modelName": "GMEvent",
            "mvc": "1.0",
            "IsDnD": false,
            "collisionObjectId": "00000000-0000-0000-0000-000000000000",
            "enumb": 0,
            "eventtype": 3,
            "m_owner": "d36f532b-e138-4b81-b381-814d8bba9863"
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
            "id": "060b1cd7-2987-4fc3-9bf1-98c5238a29d3",
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
            "id": "6563ad6a-206f-43a2-ac4f-045c625e0833",
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