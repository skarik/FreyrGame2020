{
  "spriteId": {
    "name": "ssy_power",
    "path": "sprites/ssy_power/ssy_power.yy",
  },
  "solid": false,
  "visible": true,
  "spriteMaskId": null,
  "persistent": false,
  "parentObjectId": {
    "name": "ob_livelyPowered",
    "path": "objects/ob_livelyPowered/ob_livelyPowered.yy",
  },
  "physicsObject": false,
  "physicsSensor": false,
  "physicsShape": 1,
  "physicsGroup": 0,
  "physicsDensity": 0.5,
  "physicsRestitution": 0.1,
  "physicsLinearDamping": 0.1,
  "physicsAngularDamping": 0.1,
  "physicsFriction": 0.2,
  "physicsStartAwake": true,
  "physicsKinematic": false,
  "physicsShapePoints": [],
  "eventList": [
    {"isDnD":false,"eventNum":0,"eventType":0,"collisionObjectId":null,"parent":{"name":"o_livelyPoweredPotPlug","path":"objects/o_livelyPoweredPotPlug/o_livelyPoweredPotPlug.yy",},"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMEvent",},
  ],
  "properties": [
    {"varType":5,"value":"null","rangeEnabled":false,"rangeMin":0.0,"rangeMax":10.0,"listItems":null,"multiselect":false,"filters":[
        "GMObject",
      ],"resourceVersion":"1.0","name":"m_pot","tags":[],"resourceType":"GMObjectProperty",},
  ],
  "overriddenProperties": [
    {"propertyId":{"name":"m_powerCallback","path":"objects/ob_livelyPowered/ob_livelyPowered.yy",},"objectId":{"name":"ob_livelyPowered","path":"objects/ob_livelyPowered/ob_livelyPowered.yy",},"value":"powerLogic_PotplugOutput","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
    {"propertyId":{"name":"m_powerInput","path":"objects/ob_livelyPowered/ob_livelyPowered.yy",},"objectId":{"name":"ob_livelyPowered","path":"objects/ob_livelyPowered/ob_livelyPowered.yy",},"value":"1.0","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
    {"propertyId":{"name":"m_voidEnabled","path":"objects/ob_livelyPowered/ob_livelyPowered.yy",},"objectId":{"name":"ob_livelyPowered","path":"objects/ob_livelyPowered/ob_livelyPowered.yy",},"value":"True","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
  ],
  "parent": {
    "name": "Lively",
    "path": "folders/Objects/Gameplay/Lively.yy",
  },
  "resourceVersion": "1.0",
  "name": "o_livelyPoweredPotPlug",
  "tags": [],
  "resourceType": "GMObject",
}